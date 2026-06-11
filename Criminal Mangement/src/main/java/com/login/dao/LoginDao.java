package com.login.dao;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class LoginDao {

	// In-memory demo users for beginners — keeps things runnable without DB.
	private static final Map<String, String> DEMO_USERS = new HashMap<>();
	static {
		DEMO_USERS.put("demo", "demo");
	}

	public boolean check(String username, String password) {
		DbConnectionLog.logConnectionLifecycleOnce();

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC",
					"root",
					"Ayush@25")) {

				String sql = "SELECT 1 FROM users WHERE username=? AND password=?";
				try (PreparedStatement st = con.prepareStatement(sql)) {
					st.setString(1, username);
					st.setString(2, password);
					try (ResultSet rs = st.executeQuery()) {
						return rs.next();
					}
				}
			}
		} catch (ClassNotFoundException | SQLException e) {
			// DB not available or misconfigured — fall back to in-memory demo users.
			e.printStackTrace();
			return inMemoryCheck(username, password);
		}
	}

	private boolean inMemoryCheck(String username, String password) {
		if (username == null || password == null) return false;
		String expected = DEMO_USERS.get(username);
		return expected != null && expected.equals(password);
	}

}