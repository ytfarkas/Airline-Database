<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upcoming Flights</title>
</head>
<body>
	<h2>Upcoming Flights</h2>


	<%
	int accountNumber = (Integer) session.getAttribute("user");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String sql = "SELECT b.Booking_ID, b.Account_Number, MIN(fa.Flight_Date) AS Flight_Date, b.Flight_Type, "
		+ "(SELECT fs.Departure_Airport_ID " + "FROM Ticket t2 "
		+ "JOIN Flight_Avalibility fa2 ON t2.Instance_ID = fa2.Instance_ID "
		+ "JOIN Flight_Schedule fs ON fa2.Flight_Number = fs.Flight_Number " + "WHERE t2.Ticket_Status = 'Active' "
		+ "AND t2.Ticket_ID = b.Booking_ID " + "ORDER BY fa2.Flight_Date ASC "
		+ "LIMIT 1) AS Departure_Airport_ID, " + "(SELECT fs.Arrival_Airport_ID " + "FROM Ticket t2 "
		+ "JOIN Flight_Avalibility fa2 ON t2.Instance_ID = fa2.Instance_ID "
		+ "JOIN Flight_Schedule fs ON fa2.Flight_Number = fs.Flight_Number " + "WHERE t2.Ticket_Status = 'Active' "
		+ "AND t2.Ticket_ID = b.Booking_ID " + "ORDER BY fa2.Flight_Date ASC " + "LIMIT 1) AS Arrival_Airport_ID "
		+ "FROM Bookings b " + "JOIN Ticket t ON b.Booking_ID = t.Ticket_ID "
		+ "JOIN Flight_Avalibility fa ON t.Instance_ID = fa.Instance_ID " + "WHERE fa.Flight_Date <= CURDATE() "
		+ "AND b.Account_Number = ? AND b.Booking_Status = 'Active' AND t.Ticket_Status = 'Active' "
		+ "GROUP BY b.Booking_ID, b.Account_Number, b.Flight_Type";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, accountNumber);
		ResultSet rs = ps.executeQuery();
	%>
	<form action="viewFlightDetails.jsp" method="post">
		<h2>Select Flight To View Details</h2>
		<%
		while (rs.next()) {
			int bookingID = rs.getInt("Booking_ID");
			String flightType = rs.getString("Flight_Type");
			String flightDate = rs.getString("Flight_Date");
			String departAirportID = rs.getString("Departure_Airport_ID");
			String arrivalAirportID = rs.getString("Arrival_Airport_ID");
		%>

		<input type="radio" name="flights" value="<%=bookingID%>">
		Flight Type:
		<%=flightType%>
		Date:
		<%=flightDate%>
		From:
		<%=departAirportID%>
		To:
		<%=arrivalAirportID%>

		</label><br />
		<%
		}
		%>
		<input type="hidden" name="location" value="customerPastFlights">
		<input type="submit" value="View Flight Details">
	</form>
	<br/>
	<a href = "customerHome.jsp">Back To Dashboard</a>
	
	<%
	con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>