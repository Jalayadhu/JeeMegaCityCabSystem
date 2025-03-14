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

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the driver's NIC number from the form
        String nicNo = request.getParameter("NICNoJ");

        // Validate input
        if (nicNo == null || nicNo.trim().isEmpty()) {
            response.sendRedirect("DriverDelete.jsp?msg=Please enter a valid NIC number!");
            return;
        }

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Prepare SQL DELETE statement
            String sql = "DELETE FROM driveersjee WHERE NICNoJ = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nicNo);

            // Execute update
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("DriverDelete.jsp?msg=Driver deleted successfully!");
            } else {
                response.sendRedirect("DriverDelete.jsp?msg=Driver not found!");
            }

            // Close resources
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("DriverDelete.jsp?msg=Database error: " + e.getMessage());
        }
    }
}
