<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Revenue By Airline</title>
</head>
<body>
	<%
	String airlineID = request.getParameter("airlineID");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String revenueByAirlineSql = "SELECT SUM(b.Total_Charge) AS Airline_Revenue, ac.Airline_Name FROM Bookings b "
		+ "JOIN Ticket t ON b.Booking_ID = t.Ticket_ID "
		+ "JOIN Flight_Avalibility fa ON t.Instance_ID = fa.Instance_ID "
		+ "JOIN Flight_Schedule fs ON fa.Flight_Number = fs.Flight_Number " 
		+ "JOIN Airline_Company ac ON ac.Airline_ID = fs.Airline_ID "
		+ "WHERE fs.Airline_ID = ?";
		PreparedStatement revenueByAirlinePs = con.prepareStatement(revenueByAirlineSql);

		revenueByAirlinePs.setString(1, airlineID);
		ResultSet revenueByAirlineRs = revenueByAirlinePs.executeQuery();

		double revenueByAirline = 0.00;
		String airlineName = "";
		while (revenueByAirlineRs.next()) {
			revenueByAirline = revenueByAirlineRs.getDouble("Airline_Revenue");
			airlineName = revenueByAirlineRs.getString("Airline_Name");
		}
	%>
	<h2>
		Revenue For 
		<%=airlineName%></h2>
	<br />
	<p>
		Revenue Generated:
		<%=revenueByAirline%>
	</p>
				<br/>
		<a href = "revenueByAirline.jsp">Back To Revenue By Airline Search</a>
	<%
	con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>