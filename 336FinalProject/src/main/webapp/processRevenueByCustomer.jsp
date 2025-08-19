<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Revenue By Customer</title>
</head>
<body>
	<%
	String accountNumber = request.getParameter("accountNumber");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String revenueByCustomerSql = "SELECT SUM(b.Total_Charge) AS Customer_Revenue, a.First_Name, a.Last_Name "
		+ "FROM Bookings b "
		+ "JOIN Account a ON b.Account_Number = a.Account_Number "
		+ "WHERE a.Account_Number = ? "
		+ "GROUP BY a.First_Name, a.Last_Name ";
		PreparedStatement revenueByCustomerPs = con.prepareStatement(revenueByCustomerSql);

		revenueByCustomerPs.setString(1, accountNumber);
		ResultSet revenueByCustomerRs = revenueByCustomerPs.executeQuery();

		double revenueByCustomer = 0.00;
		String firstName = "";
		String lastName = "";
		while (revenueByCustomerRs.next()) {
			revenueByCustomer = revenueByCustomerRs.getDouble("Customer_Revenue");
			firstName = revenueByCustomerRs.getString("First_Name");
			lastName = revenueByCustomerRs.getString("Last_Name");

		}
	%>
	<h2>
		Revenue For 
		<%=firstName%> <%=lastName%></h2>
	<br />
	<p>
		Revenue Generated:
		<%=revenueByCustomer%>
	</p>
	
		<br/>
		<a href = "revenueByCustomer.jsp">Back To Revenue by Customer</a>
	<%
	con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>