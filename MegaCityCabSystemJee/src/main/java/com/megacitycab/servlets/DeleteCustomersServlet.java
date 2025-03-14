package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomersServlet")
public class DeleteCustomersServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the customer registration number from the form
        String registrationNumber = request.getParameter("registration_number");

        // Validate input
        if (registrationNumber == null || registrationNumber.trim().isEmpty()) {
            response.sendRedirect("CustomerDelete.jsp?msg=Please enter a valid registration number!");
            return;
        }

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare SQL DELETE statement
            String sql = "DELETE FROM customers WHERE registration_number = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, registrationNumber);

            // Execute update
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("CustomerDelete.jsp?msg=Customer deleted successfully!");
            } else {
                response.sendRedirect("CustomerDelete.jsp?msg=Customer not found!");
            }

            // Close resources
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("CustomerDelete.jsp?msg=Database error: " + e.getMessage());
        }
    }
}
