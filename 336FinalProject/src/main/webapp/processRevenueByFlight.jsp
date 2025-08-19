<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Revenue By Flight</title>
</head>
<body>
	<%
	String flightNumber = request.getParameter("flightNumber");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String revenueByFlightSql = "SELECT SUM(b.Total_Charge) AS Flight_Revenue FROM Bookings b "
		+ "JOIN Ticket t ON b.Booking_ID = t.Ticket_ID "
		+ "JOIN Flight_Avalibility fa ON t.Instance_ID = fa.Instance_ID "
		+ "JOIN Flight_Schedule fs ON fa.Flight_Number = fs.Flight_Number " + "WHERE fs.Flight_Number = ?";
		PreparedStatement revenueByFlightPs = con.prepareStatement(revenueByFlightSql);

		revenueByFlightPs.setString(1, flightNumber);
		ResultSet revenueByFlightRs = revenueByFlightPs.executeQuery();

		double revenueByFlight = 0.00;
		while (revenueByFlightRs.next()) {
			revenueByFlight = revenueByFlightRs.getDouble("Flight_Revenue");
		}
	%>
	<h2>
		Revenue For Flight Number
		<%=flightNumber%></h2>
	<br />
	<p>
		Revenue Generated:
		<%=revenueByFlight%>
	</p>
				<br/>
		<a href = "revenueByFlight.jsp">Back To Revenue By Flight Search</a>
	<%
	con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>