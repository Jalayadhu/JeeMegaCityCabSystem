package com.megacitycab.servlets;

import com.megacitycab.dao.CustomerDAO;
import com.megacitycab.models.Customer;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterCustomerServlet")
public class RegisterCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String regNo = request.getParameter("registrationNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phone = request.getParameter("telephone");
        String email = request.getParameter("email");

        Customer customer = new Customer(regNo, name, address, nic, phone, email);
        
        try {
            CustomerDAO customerDAO = new CustomerDAO();
            customerDAO.registerCustomer(customer);
            response.sendRedirect("index.jsp?message=Customer Registered Successfully");
        } catch (SQLException | ClassNotFoundException e) {
            response.sendRedirect("register.jsp?error=" + e.getMessage());
        }
    }
}
