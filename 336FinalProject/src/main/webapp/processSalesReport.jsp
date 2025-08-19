<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>processSalesReport</title>
</head>
<body>
	<%
	String monthString = request.getParameter("month");
	String yearString = request.getParameter("year");
	int month = Integer.parseInt(monthString);
	int year = Integer.parseInt(yearString);

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String salesReportSql = "SELECT SUM(Total_Charge) AS Monthly_Revenue FROM Bookings WHERE YEAR(Purchase_Date) = ? AND MONTH(Purchase_Date) = ?";
		PreparedStatement salesPs = con.prepareStatement(salesReportSql);

		salesPs.setInt(1, year);
		salesPs.setInt(2, month);
		ResultSet salesRs = salesPs.executeQuery();

		double sales = 0.00;
		while (salesRs.next()) {
			sales = salesRs.getDouble("Monthly_Revenue");
		}
	%>
	<h2>
		Sales Report For
		<%=month%>/<%=year%></h2>
	<br />
	<p>
		Revenue Generated:
		<%=sales%>
	</p>
	
				<br/>
	<a href = "adminSalesReport.jsp">Back To Sales Report by Month</a>
		
	<%
	con.close();

	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>

</body>
</html>