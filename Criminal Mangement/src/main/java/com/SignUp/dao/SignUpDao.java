package com.SignUp.dao;

import com.SignUp.model.User;
import com.login.dao.DbConnectionLog;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Data Access Object for user registration
 */
public class SignUpDao {
    
    private static final String DB_URL = "jdbc:mysql://localhost:3306/management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Ayush@25";
    
    /**
     * Get database connection
     */
    private Connection getConnection() throws ClassNotFoundException, SQLException {
        DbConnectionLog.logConnectionLifecycleOnce();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        return conn;
    }

    // In-memory fallback storage for beginners (no DB required).
    // Keyed by username.
    private static final Map<String, User> IN_MEMORY_USERS = new ConcurrentHashMap<>();
    
    /**
     * Check if username already exists
     */
    public boolean usernameExists(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            // DB not available — check in-memory users instead
            // This allows beginners to run the app without MySQL configured.
            // Note: in-memory users are lost when the app restarts.
            // Keep the print for debugging.
            e.printStackTrace();
            return IN_MEMORY_USERS.containsKey(username);
        }
        
        return false;
    }
    
    /**
     * Check if email already exists
     */
    public boolean emailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (ClassNotFoundException | SQLException e) {
            // DB not available — check in-memory users
            e.printStackTrace();
            return IN_MEMORY_USERS.values().stream().anyMatch(u -> email.equals(u.getEmail()));
        }
        
        return false;
    }
    
    /**
     * Register a new user
     */
    public boolean registerUser(User user) {
        String query = "INSERT INTO users (username, age, email, password, phone) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setInt(2, user.getAge());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getPhone());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (ClassNotFoundException | SQLException e) {
            // DB not available — register in in-memory store for demo purposes
            e.printStackTrace();
            IN_MEMORY_USERS.put(user.getUsername(), user);
            return true;
        }
    }
}
