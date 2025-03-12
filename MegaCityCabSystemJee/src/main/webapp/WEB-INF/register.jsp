<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register Customer</title>
</head>
<body>
    <h2>Register Customer</h2>
    <form action="RegisterCustomerServlet" method="post">
        Registration Number: <input type="text" name="registrationNumber" required><br>
        Name: <input type="text" name="name" required><br>
        Address: <input type="text" name="address" required><br>
        NIC: <input type="text" name="nic" required><br>
        Telephone: <input type="text" name="telephone" required><br>
        Email: <input type="email" name="email"><br>
        <input type="submit" value="Register">
    </form>
</body>
</html>
