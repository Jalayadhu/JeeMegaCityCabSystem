@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String regNo = request.getParameter("registrationNumber");
        
        try {
            CustomerDAO customerDAO = new CustomerDAO();
            customerDAO.deleteCustomer(regNo);
            response.sendRedirect("index.jsp?message=Customer Deleted Successfully");
        } catch (SQLException | ClassNotFoundException e) {
            response.sendRedirect("delete.jsp?error=" + e.getMessage());
        }
    }
}
