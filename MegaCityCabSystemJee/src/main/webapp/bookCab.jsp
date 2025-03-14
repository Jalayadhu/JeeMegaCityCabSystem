<%@ page import="java.sql.*" %>
<%
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacityjee", "root", "password");
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM locations");
%>

<h2>Saved Locations</h2>
<table border="1">
    <tr><th>Address</th><th>Latitude</th><th>Longitude</th></tr>
    <%
        while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("address") %></td>
        <td><%= rs.getString("latitude") %></td>
        <td><%= rs.getString("longitude") %></td>
    </tr>
    <%
        }
        rs.close();
        stmt.close();
        con.close();
    %>
</table>
