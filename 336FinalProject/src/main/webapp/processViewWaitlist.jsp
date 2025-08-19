<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

		String viewWaitlistSql = "SELECT a.First_Name, a.Last_Name FROM Waitlist w "
				+ "JOIN Account a ON w.Account_Number = a.Account_Number "
				+ "JOIN Flight_Avalibility fa ON w.Instance_ID = fa.Instance_ID "
				+ "WHERE fa.Flight_Number = ?";

		PreparedStatement viewWaitlistPs = con.prepareStatement(viewWaitlistSql);
		viewWaitlistPs.setString(1, flightNumber);
		ResultSet viewWaitlistRs = viewWaitlistPs.executeQuery();
		%>
		<h2>Customers Names on Waitlist of Flight <%=flightNumber%></h2>
		<%
		while (viewWaitlistRs.next()){
			String firstName = viewWaitlistRs.getString("First_Name");
			String lastName = viewWaitlistRs.getString("Last_Name");
		
		%>

	<p><%=firstName%> <%=lastName%>
	<%
		}
		con.close();
		} catch (Exception e) {
		out.println(e.getMessage());
		}
		%>
		
						<br/>
		<a href = "repViewWaitlist.jsp">Back To Waitlist Search</a>
	
	</body>
</html>