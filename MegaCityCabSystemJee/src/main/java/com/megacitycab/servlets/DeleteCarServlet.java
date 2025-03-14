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


@WebServlet(name = "DeleteCarServlet", urlPatterns = {"/DeleteCarServlet"})
public class DeleteCarServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String carRegistrationNumber = request.getParameter("RegistrationNumberJ");

        // Debugging output
        System.out.println("Received Car Registration Number: " + carRegistrationNumber);

        if (carRegistrationNumber == null || carRegistrationNumber.trim().isEmpty()) {
            response.sendRedirect("CarDelete.jsp?msg=Car Registration Number is required!");
            return;
        }

        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare SQL delete statement
            String sql = "DELETE FROM cars WHERE registration_number= ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, carRegistrationNumber);

            // Execute delete
            int rowsDeleted = stmt.executeUpdate();
            System.out.println("Rows Deleted: " + rowsDeleted);

            if (rowsDeleted > 0) {
                response.sendRedirect("success.jsp?msg=Car deleted successfully!");
            } else {
                response.sendRedirect("CarDelete.jsp?msg=Car not found or deletion failed!");
            }

            // Close resources
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("CarDelete.jsp?msg=Database error: " + e.getMessage());
        }
    }
}
