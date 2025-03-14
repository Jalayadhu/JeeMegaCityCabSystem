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

@WebServlet("/RegisterCustomersServlet")
public class RegisterCustomersServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String registrationNumber = request.getParameter("registration_number");
        String name = request.getParameter("NAME");
        String address = request.getParameter("address");
        String nic = request.getParameter("NIC");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");

        // Validate required fields
        if (registrationNumber == null || registrationNumber.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            address == null || address.trim().isEmpty() ||
            nic == null || nic.trim().isEmpty()) {
            response.sendRedirect("CustomerRegister.jsp?msg=All required fields must be filled!");
            return; // Stop further execution
        }

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare the SQL query
            String sql = "INSERT INTO customers (registration_number, NAME, address, NIC, telephone, email) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set parameters for the query
            stmt.setString(1, registrationNumber);
            stmt.setString(2, name);
            stmt.setString(3, address);
            stmt.setString(4, nic);
            stmt.setString(5, telephone);
            stmt.setString(6, email);

            // Execute the query
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("success.jsp?msg=Customer registration successful!");
            } else {
                response.sendRedirect("CustomerRegister.jsp?msg=Customer registration failed!");
            }

            // Close resources
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("CustomerRegister.jsp?msg=Database error: " + e.getMessage());
        }
    }
}