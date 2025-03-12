
@WebServlet(name = "UpdateCustomerServlet", urlPatterns = {"/UpdateCustomerServlet"})
@WebServlet("/UpdateCustomerServlet")
public class UpdateCustomerServlet extends HttpServlet {
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
            customerDAO.updateCustomer(customer);
            response.sendRedirect("index.jsp?message=Customer Updated Successfully");
        } catch (SQLException | ClassNotFoundException e) {
            response.sendRedirect("update.jsp?error=" + e.getMessage());
        }
    }
}


