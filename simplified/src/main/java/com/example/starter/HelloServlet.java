package com.example.starter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Very small, beginner-friendly servlet example.
 * Handles GET to show a simple form and POST to echo the submitted name.
 */
@WebServlet(name = "HelloServlet", urlPatterns = {"/hello"})
public class HelloServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            out.println("<html><head><title>Hello</title></head><body>");
            out.println("<h2>Starter: simple servlet + JSP</h2>");
            out.println("<form method=post action=hello>");
            out.println("Name: <input name=name /> <button type=submit>Say hello</button>");
            out.println("</form>");
            out.println("<p>Or open <a href=./index.jsp>index.jsp</a></p>");
            out.println("</body></html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) name = "World";
        resp.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = resp.getWriter()) {
            out.println("<html><head><title>Hello</title></head><body>");
            out.println("<h2>Hello, " + escapeHtml(name) + "!</h2>");
            out.println("<p><a href=hello>Back</a></p>");
            out.println("</body></html>");
        }
    }

    private String escapeHtml(String s) {
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
}
