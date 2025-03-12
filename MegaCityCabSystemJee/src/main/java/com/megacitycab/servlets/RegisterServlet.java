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

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})

public class RegisterServlet extends HttpServlet {
     private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Abc");
        String username = request.getParameter("UserNameJ");
        String password = request.getParameter("PasswordJ");
        String firstName = request.getParameter("FirstNameJ");
        String lastName = request.getParameter("LastNameJ");
        String email = request.getParameter("GmailJ");
        String phone = request.getParameter("PhoneJ");
  
            
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
           // Connection conn = DBConnection.getConnection();
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO loginjee (UserNameJ, PasswordJ, FirstNameJ, LastNameJ, GmailJ, PhoneJ) VALUES (?, ?, ?, ?, ?, ?)");
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, firstName);
            stmt.setString(4, lastName);
            stmt.setString(5, email);
            stmt.setString(6, phone);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("login.jsp?msg=Registration successful!");
            } else {
                response.sendRedirect("register.jsp?msg=Registration failed!");
            }
        
         
    }catch (IOException | ClassNotFoundException | SQLException e) {
    e.printStackTrace(); // This will print the error in the server logs
    response.sendRedirect("register.jsp?msg=Database error: " + e.getMessage());
}

    }
}
    
