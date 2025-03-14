package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet(name = "RegisterDriverServlet", urlPatterns = {"/RegisterDriverServlet"})
public class RegisterDriverServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form data
        String firstName = request.getParameter("FirstNameJ");
        String lastName = request.getParameter("LastNameJ");
        String dob = request.getParameter("DobJ");
        String nicNo = request.getParameter("NICNoJ");
        String licenseNumber = request.getParameter("LicenseNumberJ");
        String address = request.getParameter("AddressJ");
        String telephone = request.getParameter("TelephoneJ");
        String email = request.getParameter("EmailJ");

        // Validate required fields
        if (firstName == null || firstName.trim().isEmpty()) {
            response.sendRedirect("Driver.jsp?msg=First Name is required!");
            return; // Stop further execution
        }

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare the SQL query
            String sql = "INSERT INTO driveersjee (FirstNameJ, LastNameJ, DobJ, NICNoJ, LicenseNumberJ, AddressJ, TelephoneJ, EmailJ) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set parameters for the query
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, dob);
            stmt.setString(4, nicNo);
            stmt.setString(5, licenseNumber);
            stmt.setString(6, address);
            stmt.setString(7, telephone);
            stmt.setString(8, email);

            // Execute the query
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("success.jsp?msg=Driver registration successful!");
            } else {
                response.sendRedirect("Driver.jsp?msg=Driver registration failed!");
            }

            // Close resources
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Driver.jsp?msg=Database error: " + e.getMessage());
        }
    }
}