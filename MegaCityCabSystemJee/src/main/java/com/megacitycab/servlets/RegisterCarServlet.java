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

@WebServlet(name = "RegisterCarServlet", urlPatterns = {"/RegisterCarServlet"})
public class RegisterCarServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Abc");
        String car_id = request.getParameter("CarIDJ");
        String registration_number = request.getParameter("RegistrationNumberJ");
        String model = request.getParameter("modelJ");
        String TYPE = request.getParameter("TypeJ");
        String capacity = request.getParameter("CapasityJ");
        String availability = request.getParameter("AvailabilityJ");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO cars (car_id, registration_number, model, TYPE, capacity, availability) VALUES (?, ?, ?, ?, ?, ?)");
            stmt.setString(1, car_id);
            stmt.setString(2, registration_number);
            stmt.setString(3, model);
            stmt.setString(4, TYPE);
            stmt.setString(5, capacity);
            stmt.setString(6, availability);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("login.jsp?msg=Car Registration successful!");
            } else {
                response.sendRedirect("register.jsp?msg=Registration failed!");
            }
        } catch (IOException | ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // This will print the error in the server logs
            response.sendRedirect("register.jsp?msg=Database error: " + e.getMessage());
        }
    }
}