package com.cafe.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get session if exists
        if (session != null) {
            session.invalidate(); // Clear all session data
        }
        response.sendRedirect("login_register.jsp?success=Logged out successfully");
    }
}
