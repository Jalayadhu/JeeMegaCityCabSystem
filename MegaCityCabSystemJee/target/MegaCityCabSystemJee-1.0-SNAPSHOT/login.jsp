<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
   <% 
        String message = request.getParameter("msg");
        if (message != null) {
    %>
        <p style="color: red;"><%= message %></p>
    <% } %>

 
    
    <form action="/MegaCityCabSystemJee/LoginServlet" method="post">
        <label>Username:</label> <input type="text" name="usernameJ" required><br>
        <label>Password:</label> <input type="password" name="passwordJ" required><br>
        <button type="submit">Login</button>
    </form>
</body>
</html>
