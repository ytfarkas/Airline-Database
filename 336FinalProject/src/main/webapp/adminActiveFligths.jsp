<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>View Most Active Flights</h2>
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String mostTicketsSoldSql = "SELECT fa.Flight_Number, COUNT(*) AS Tickets_Sold " + "FROM Ticket t "
		+ "JOIN Flight_Avalibility fa ON t.Instance_ID = fa.Instance_ID " + "GROUP BY fa.Flight_Number "
		+ "ORDER BY Tickets_Sold DESC;";

		PreparedStatement mostTicketSoldPs = con.prepareStatement(mostTicketsSoldSql);
		ResultSet mostTicketsSoldRs = mostTicketSoldPs.executeQuery();

		while (mostTicketsSoldRs.next()) {

			String flightNumber = mostTicketsSoldRs.getString("Flight_Number");
			int ticketsSold = mostTicketsSoldRs.getInt("Tickets_Sold");
	%>
	<b>Flight Number: </b>
	<%=flightNumber%>
	<b> Tickets Sold: </b>
	<%=ticketsSold%> <br/>
	
					<br/>
	<%
	}
	%>
			<a href = "adminHome.jsp">Back To Dashboard</a>
	<%	
		

	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>
</body>
</html>