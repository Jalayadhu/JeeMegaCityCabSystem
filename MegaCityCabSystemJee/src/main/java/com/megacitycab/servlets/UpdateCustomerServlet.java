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


@WebServlet(name = "UpdateCustomerServlet", urlPatterns = {"/UpdateCustomerServlet"})
public class UpdateCustomerServlet extends HttpServlet {
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
        if (registrationNumber == null || registrationNumber.trim().isEmpty()) {
            response.sendRedirect("CustomerUpdate.jsp?msg=Registration Number is required!");
            return; // Stop further execution
        }

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Construct SQL query dynamically
            StringBuilder sql = new StringBuilder("UPDATE customers SET ");
            boolean hasUpdates = false;

            if (name != null && !name.trim().isEmpty()) {
                sql.append("NAME = ?, ");
                hasUpdates = true;
            }
            if (address != null && !address.trim().isEmpty()) {
                sql.append("address = ?, ");
                hasUpdates = true;
            }
            if (nic != null && !nic.trim().isEmpty()) {
                sql.append("NIC = ?, ");
                hasUpdates = true;
            }
            if (telephone != null && !telephone.trim().isEmpty()) {
                sql.append("telephone = ?, ");
                hasUpdates = true;
            }
            if (email != null && !email.trim().isEmpty()) {
                sql.append("email = ?, ");
                hasUpdates = true;
            }

            if (!hasUpdates) {
                response.sendRedirect("CustomerUpdate.jsp?msg=No fields to update!");
                return;
            }

            // Remove last comma and add WHERE condition
            sql.setLength(sql.length() - 2);
            sql.append(" WHERE registration_number = ?");

            // Prepare the SQL query
            PreparedStatement stmt = conn.prepareStatement(sql.toString());

            int paramIndex = 1;
            if (name != null && !name.trim().isEmpty()) stmt.setString(paramIndex++, name);
            if (address != null && !address.trim().isEmpty()) stmt.setString(paramIndex++, address);
            if (nic != null && !nic.trim().isEmpty()) stmt.setString(paramIndex++, nic);
            if (telephone != null && !telephone.trim().isEmpty()) stmt.setString(paramIndex++, telephone);
            if (email != null && !email.trim().isEmpty()) stmt.setString(paramIndex++, email);

            stmt.setString(paramIndex, registrationNumber);

            // Execute the update query
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("success.jsp?msg=Customer update successful!");
            } else {
                response.sendRedirect("CustomerUpdate.jsp?msg=Customer update failed!");
            }

            // Close resources
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("CustomerUpdate.jsp?msg=Database error: " + e.getMessage());
        }
    }
}
