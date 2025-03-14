package com.megacitycab.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingsRegisterServlet", urlPatterns = {"/BookingsRegisterServlet"})
public class BookingsRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("GET method is not supported for this operation. Please use POST.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerID = request.getParameter("customer_id");
        String pickupLocation = request.getParameter("current_location");
        String destination = request.getParameter("Distance");
        String whereToGo = request.getParameter("destination");

        // Get current date and time
        LocalDate currentDate = LocalDate.now();
        LocalTime currentTime = LocalTime.now();

        // Format time to a user-friendly format
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String formattedTime = currentTime.format(timeFormatter);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO bookings (booking_number, customer_id, pickup_location, destination, booking_date, booking_time, status, WhereToGo) VALUES (UUID(), ?, ?, ?, ?, ?, 'pending', ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(customerID));
            stmt.setString(2, pickupLocation);
            stmt.setString(3, destination);
            stmt.setString(4, currentDate.toString());
            stmt.setString(5, formattedTime);
            stmt.setString(6, whereToGo);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("success.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("success.jsp");
        }
    }
}
