package com.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import com.login.dao.LoginDao;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * Handle POST from login form.
	 *
	 * The `LoginDao.check` method now encapsulates database access and
	 * will fall back to an in-memory demo user if the DB is unavailable.
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");

		LoginDao dao = new LoginDao();
		try {
			if (dao.check(username, password)) {
				HttpSession session = req.getSession();
				session.setAttribute("username", username);
				res.sendRedirect(req.getContextPath() + "/UserDashboard");
			} else {
				res.sendRedirect("Login.jsp?error=1");
			}
		} catch (Exception e) {
			// If something unexpected happens, log and send error
			e.printStackTrace();
			res.sendRedirect("Login.jsp?error=1");
		}
	}
	  
		
	}

