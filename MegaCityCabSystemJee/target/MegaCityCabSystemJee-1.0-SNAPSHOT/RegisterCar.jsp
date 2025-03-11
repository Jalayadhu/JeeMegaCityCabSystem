<%-- 
    Document   : RegisterCar
    Created on : Mar 10, 2025, 11:29:23 PM
    Author     : YADHU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car Registration Jee</title>
    </head>
    <body>
       <form action="/MegaCityCabSystemJee/RegisterCarServlet" method="post">
 Car Registration Jee
        Car ID: <input type="CarID" name="CarIDJ" required><br>
        Registration Number: <input type="RegistrationNumber" name="RegistrationNumberJ" required><br>
        Model: <input type="Model" name="modelJ" ><br>
        Type: <input type="Type" name="TypeJ" <br>
        Capasity: <input type="Capasity" name="CapasityJ" ><br>
        Availability: <input type="Availability" name="AvailabilityJ" ><br>
        <input type="submit" value="Register Car">
    </body>
</html>
