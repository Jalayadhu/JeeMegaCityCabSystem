package com.megacitycab.dao;

import java.sql.*;

public class CustomerDAO {
    private final Connection connection;

    public CustomerDAO() throws SQLException, ClassNotFoundException {
        this.connection = DBConnection.getConnection();  // Assuming DBConnection is handling connection pool or closing the connection
    }

    // Register a new customer
    public void registerCustomer(Customer customer) throws SQLException {
        String qu 
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.getRegistrationNumber());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getNic());
            stmt.setString(5, customer.getTelephone());
            stmt.setString(6, customer.getEmail());
            stmt.executeUpdate();
        }
    }
  nic=?, telephone=?, email=? WHERE registration_number=?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getNic());
            stmt.setString(4, customer.getTelephone());
            stmt.setString(5, customer.getEmail());
            stmt.setString(6, customer.getRegistrationNumber());
            stmt.executeUpdate();
        }
    }

    // Delete a customer from the database
    public void deleteCustomer(String registrationNumber) throws SQLException {
        String query = "DELETE FROM customers WHERE registration_number=?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, registrationNumber);
            stmt.executeUpdate();
        }
    }
}
