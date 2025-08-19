<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight Details</title>
</head>
<body>
	<h2>Flight Details</h2>


	<%
	String location = request.getParameter("location");
	String bookingID = request.getParameter("flights");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String flightDetailSql = "SELECT fa.Flight_Date, ac.Airline_Name, fs.Flight_Number, fs.Departure_Time, "
		+ "fs.Departure_Airport_ID, fs.Arrival_Airport_ID, fs.Arrival_Time, t.Seat_Number, b.Class, "
		+ "a.Account_Number, a.First_Name, a.Last_Name, b.Price, b.Purchase_Date, b.Booking_Fee " + "FROM Ticket t "
		+ "JOIN Bookings b ON t.Ticket_ID = b.Booking_ID "
		+ "JOIN Account a ON a.Account_Number = b.Account_Number "
		+ "JOIN Flight_Avalibility fa ON t.Instance_ID = fa.Instance_ID "
		+ "JOIN Flight_Schedule fs ON fa.Flight_Number = fs.Flight_Number "
		+ "JOIN Airline_Company ac ON fs.Airline_ID = ac.Airline_ID " + "WHERE t.Ticket_ID = ?";

		PreparedStatement ps = con.prepareStatement(flightDetailSql);
		ps.setString(1, bookingID);
		ResultSet rs = ps.executeQuery();
	%>

	<%
	double totalPrice = 0.00;
	double bookingFee = 0.00;
	String flightClass = null;
	while (rs.next()) {
		String flightDate = rs.getString("Flight_Date");
		String airlineName = rs.getString("Airline_Name");
		String flightNumber = rs.getString("Flight_Number");
		String depTime = rs.getString("Departure_Time");
		String depAirportID = rs.getString("Departure_Airport_ID");
		String arrAirportID = rs.getString("Arrival_Airport_ID");
		String arrTime = rs.getString("Arrival_Time");
		String seatNumber = rs.getString("Seat_Number");
		flightClass = rs.getString("Class");
		int accountNumber = rs.getInt("Account_Number");
		String firstName = rs.getString("First_Name");
		String lastName = rs.getString("Last_Name");
		String purchaseDate = rs.getString("Purchase_Date");
		totalPrice = rs.getDouble("Price");
		bookingFee = rs.getDouble("Booking_Fee");
	%>

	<p>
		<b>-------------------------------------------</b><br /> <b>Flight
			Information</b><br /> Airline Name:
		<%=airlineName%>
		<br /> Flight Number:
		<%=flightNumber%>
		<br /> Flight Date:
		<%=flightDate%>
		<br /> Depart Time:
		<%=depTime%>
		<br /> Destination Info:
		<%=depAirportID%>
		-->
		<%=arrAirportID%>
		<br /> Seat Number:
		<%=seatNumber%>
		<br /> Class:
		<%=flightClass%>
		<br /> <br /> <b> PASSENGER INFORMATION</b><br /> Account Number:
		<%=accountNumber%>
		<br /> First Name:
		<%=firstName%>
		<br /> Last Name:
		<%=lastName%>
		<br /> Purchase Date:
		<%=purchaseDate%>
	</p>

	<%
	}
	%>
	<b>Amount Paid = <%=totalPrice + bookingFee%></b>
	<br />
	<br />

	<%
	if (location.equals("customerUpcomingFlights") || location.equals("rep")) {
		if (flightClass.equals("Economy")) {
	%>
	<p>
		<b>*Note: Any changes/cancellations will result in a $50.00 Fee</b>
	</p>
	<%
	}
	%>
	<form action="cancelBooking.jsp" method="get">
		<input type="hidden" name="cancelBookingID" value="<%=bookingID%>">
		<input type="hidden" name="location" value="<%=location%>">
		
		<button type="submit">Cancel Flight</button>
	</form>
	<form action="editBooking.jsp" method="get">
		<input type="hidden" name="editBooking" value="<%=bookingID%>">
		<input type="hidden" name= "location" value = "<%=location%>">
		<button type="submit">Edit Flight</button>
	</form>
	<%
	} else if (location.equals("admin")){
		%>
		<br/>
		<a href = "adminViewReservations.jsp">Back To View Reservations</a>
		<%
		
		
	}
	con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>