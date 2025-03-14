package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.megacitycab.dao.DBConnection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.sql.DriverManager;
import java.sql.ResultSet;
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})

public class LoginServlet extends HttpServlet {
    
         private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("usernameJ");
        String password = request.getParameter("passwordJ");
 
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
           // Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM loginjee WHERE UserNameJ = ? AND PasswordJ = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
           

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Login successful
                response.sendRedirect("dashboard.jsp");  // Redirect to dashboard or homepage after successful login
            } else {
                  System.out.println(username);
      System.out.println(password);
                // Invalid credentials
                response.sendRedirect("login.jsp?msg=Invalid username or password Jee.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=Database error.");
        }
    }
}
