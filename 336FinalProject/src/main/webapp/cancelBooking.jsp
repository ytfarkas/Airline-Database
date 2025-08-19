<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%

String bookingID = request.getParameter("cancelBookingID");
String location = request.getParameter("location");

try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	
	PreparedStatement cancelBookingPs = con.prepareStatement("UPDATE Bookings SET Booking_Status = 'Canceled', "
			+ "Total_Charge = Total_Charge + Change_Fee "
			+ "WHERE Booking_ID = ?");
	
	cancelBookingPs.setString(1, bookingID);
	cancelBookingPs.executeUpdate();
	
	PreparedStatement cancelTicketPs = con.prepareStatement("UPDATE Ticket SET Ticket_Status = 'Canceled' WHERE Ticket_ID = ?");
	
	cancelTicketPs.setString(1, bookingID);
	cancelTicketPs.executeUpdate();
	con.close();
	
	%>
	<h3>Booking Canceled</h3>
	<%
	if ("rep".equals(location)) {
	%>
	<a href="repHome.jsp">Return to Dashboard</a>

	<%
	} else if ("customer".equals(location)) {
	%>
	<a href="customerHome.jsp">Return to Dashboard</a>

	<%
	}
	
	con.close();
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>