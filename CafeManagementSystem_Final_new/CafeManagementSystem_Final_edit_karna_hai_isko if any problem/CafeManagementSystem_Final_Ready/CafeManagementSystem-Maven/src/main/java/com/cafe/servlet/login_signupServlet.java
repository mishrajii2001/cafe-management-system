package com.cafe.servlet;

import com.cafe.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login_signupServlet")
public class login_signupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equalsIgnoreCase(action)) {
            handleLogin(request, response);
        } else if ("register".equalsIgnoreCase(action)) {
            handleRegister(request, response);
        } else {
            response.sendRedirect("login_register.jsp?error=InvalidAction");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.getWriter().println("Database connection failed!");
                return;
            }

            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", rs.getString("name"));
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("login_register.jsp?error=Invalid credentials");
            }
        } catch (SQLException e) {
            response.getWriter().println("Error during login: " + e.getMessage());
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                response.getWriter().println("Database connection is null. Check your settings.");
                return;
            }

            String query = "INSERT INTO users (name, email, phone, password, role) VALUES (?, ?, ?, ?, 'customer')";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, phone);
            pst.setString(4, password);

            int result = pst.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login_register.jsp?success=Registered successfully");
            } else {
                response.sendRedirect("login_register.jsp?error=Registration failed");
            }
        } catch (SQLException e) {
            response.getWriter().println("Error processing registration: " + e.getMessage());
        }
    }
}
