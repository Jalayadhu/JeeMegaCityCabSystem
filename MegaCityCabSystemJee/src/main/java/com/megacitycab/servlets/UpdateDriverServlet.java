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

@WebServlet(name = "UpdateDriverServlet", urlPatterns = {"/UpdateDriverServlet"})
public class UpdateDriverServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/megacitycab";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String driverId = request.getParameter("DriverIDJ");
        String firstName = request.getParameter("FirstNameJ");
        String lastName = request.getParameter("LastNameJ");
        String dob = request.getParameter("DobJ");
        String nicNo = request.getParameter("NICNoJ");
        String licenseNumber = request.getParameter("LicenseNumberJ");
        String address = request.getParameter("AddressJ");
        String telephone = request.getParameter("TelephoneJ");
        String email = request.getParameter("EmailJ");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            String sql = "UPDATE driveersjee SET FirstNameJ=?, LastNameJ=?, DobJ=?, NICNoJ=?, LicenseNumberJ=?, AddressJ=?, TelephoneJ=?, EmailJ=? WHERE DriverIDJ=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, dob);
            stmt.setString(4, nicNo);
            stmt.setString(5, licenseNumber);
            stmt.setString(6, address);
            stmt.setString(7, telephone);
            stmt.setString(8, email);
            stmt.setString(9, driverId);
            
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("success.jsp?msg=Driver update successful!");
            } else {
                response.sendRedirect("DriverUpdate.jsp?msg=Driver update failed!");
            }
            
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("DriverUpdate.jsp?msg=Database error: " + e.getMessage());
        }
    }
}
