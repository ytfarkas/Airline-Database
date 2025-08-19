<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top Customer</title>
</head>
<body>
	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String topCustomerSql = "SELECT SUM(b.Total_Charge) AS Top_Customer, a.First_Name, a.Last_Name "
		+ "FROM Bookings b "
		+ "JOIN Account a ON b.Account_Number = a.Account_Number "
		+ "GROUP BY a.First_Name, a.Last_Name "
		+ "ORDER BY Top_Customer DESC LIMIT 1";
		PreparedStatement topCustomerPs = con.prepareStatement(topCustomerSql);

		ResultSet topCustomerRs = topCustomerPs.executeQuery();

		double topCustomer = 0.00;
		String firstName = "";
		String lastName = "";
		while (topCustomerRs.next()) {
			topCustomer = topCustomerRs.getDouble("Top_Customer");
			firstName = topCustomerRs.getString("First_Name");
			lastName = topCustomerRs.getString("Last_Name");

		}
	%>
	<h2>
		Top Customer
		<%=firstName%> <%=lastName%></h2>
	<br />
	<p>
		Revenue Generated:
		<%=topCustomer%>
	</p>
	
		<br/>
		<a href = "adminHome.jsp">Back To Dashboard</a>
	<%
	con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>