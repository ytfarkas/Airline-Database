<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Booking</title>
</head>
<body>
<h2>Edit Booking</h2>

<%
String bookingID = request.getParameter("editBooking");
String location = request.getParameter("location");
String currentClass = "";



try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

    PreparedStatement editBookingPs = con.prepareStatement("SELECT Class FROM Bookings WHERE Booking_ID = ?");
    editBookingPs.setString(1, bookingID);
    ResultSet rs = editBookingPs.executeQuery();

    if (rs.next()) {
        currentClass = rs.getString("Class");
    } else {
        out.println("Booking not found.");
        return;
    }

%>

<form action="processEditBooking.jsp" method="POST">
    <p>Current Class: <%= currentClass %></p>
    <label for="newClass">Select New Class:</label>
    <select name="newClass" required>
        <option value="Economy" <%= currentClass.equals("Economy") ? "selected" : "" %>>Economy</option>
        <option value="Business" <%= currentClass.equals("Business") ? "selected" : "" %>>Business</option>
        <option value="First" <%= currentClass.equals("First") ? "selected" : "" %>>First</option>
    </select><br/><br/>

    <input type="hidden" name="bookingID" value="<%= bookingID %>">
    <input type="hidden" name= "location" value = "<%=location%>">
    
    <input type="submit" value="Confirm Change">
</form>

<%
    con.close();
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
</body>
</html>
