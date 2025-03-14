package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateCarServlet", urlPatterns = {"/UpdateCarServlet"})
public class UpdateCarServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String car_id = request.getParameter("CarIDJ");
        String registration_number = request.getParameter("RegistrationNumberJ");
        String model = request.getParameter("modelJ");
        String type = request.getParameter("TypeJ");
        String capacity = request.getParameter("CapasityJ");
        String availability = request.getParameter("AvailabilityJ");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String updateQuery = "UPDATE cars SET registration_number=?, model=?, TYPE=?, capacity=?, availability=? WHERE car_id=?";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, registration_number);
            stmt.setString(2, model);
            stmt.setString(3, type);
            stmt.setString(4, capacity);
            stmt.setString(5, availability);
            stmt.setString(6, car_id);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
               response.sendRedirect("success.jsp?msg=Car Updated registration successful!");
            } else {
               response.sendRedirect("CarUpdate.jsp?msg=Car Updated failed!");
            }

            conn.close();
        } catch (IOException | ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("carUpdate.jsp?msg=Database error: " + e.getMessage());
        }
    }
}
