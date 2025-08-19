<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Processing Edit</title>
</head>
<body>
	<%
	String bookingID = request.getParameter("bookingID");
	String newClass = request.getParameter("newClass");
	String location = request.getParameter("location");

	double basePrice = 0.0;
	double newTotal = 0.0;
	double changeFee = 0.0;
	double bookingFee = 0.0;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root",
		"mysqlpassword");

		PreparedStatement getBookingSql = con
		.prepareStatement("SELECT Price, Booking_Fee FROM Bookings WHERE Booking_ID = ?");
		getBookingSql.setString(1, bookingID);
		ResultSet getBookingRs = getBookingSql.executeQuery();

		if (getBookingRs.next()) {
			basePrice = getBookingRs.getDouble("Price");
			bookingFee = getBookingRs.getDouble("Booking_Fee");
		}

		double newClassPrice = 0.0;
		if ("Business".equals(newClass)) {
			newClassPrice = 50.0;
		} else if ("First".equals(newClass)) {
			newClassPrice = 100.0;
		}

		if ("Economy".equals(newClass)) {
			changeFee = 50.0;
		}

		newTotal = basePrice + bookingFee + newClassPrice;

		PreparedStatement updateBooking = con
		.prepareStatement("UPDATE Bookings SET Class = ?, Total_Charge = ?, Change_Fee = ? WHERE Booking_ID = ?");
		updateBooking.setString(1, newClass);
		updateBooking.setDouble(2, newTotal);
		updateBooking.setDouble(3, changeFee);
		updateBooking.setString(4, bookingID);

		updateBooking.executeUpdate();

		con.close();
	%>
	<h3>Booking Updated</h3>
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

	} catch (Exception e) {
	out.println("Error: " + e.getMessage());
	}
	%>
</body>
</html>
