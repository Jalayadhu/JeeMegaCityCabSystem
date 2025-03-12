<!DOCTYPE html>
<html>
<head>
    <title>Register - MegaCityCab</title>
</head>
<body>
    <h2>Car Registration</h2>
    
    <!-- Display messages from the servlet (if any) -->
    <% 
        String message = request.getParameter("msg");
        if (message != null) {
    %>
        <p style="color: red;"><%= message %></p>
    <% } %>

    <form action="/MegaCityCabSystemJee/RegisterCarServlet" method="post">

        Username: <input type="text" name="UserNameJ" required><br>
        Password: <input type="password" name="PasswordJ" required><br>
        First Name: <input type="text" name="FirstNameJ" ><br>
        Last Name: <input type="text" name="LastNameJ" <br>
        Email: <input type="email" name="GmailJ" ><br>
        Phone: <input type="text" name="PhoneJ" ><br>
        <input type="submit" value="Register">
    </form>
</body>
</html>
