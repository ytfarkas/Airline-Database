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
	String airportID = request.getParameter("airportID");
	

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		PreparedStatement airportInfoPs = con.prepareStatement(
		"SELECT Airport_ID, City, State FROM Airport WHERE Airport_ID = ?");

		airportInfoPs.setString(1, airportID);
		ResultSet airportInfoRs = airportInfoPs.executeQuery();

		if (!airportInfoRs.next()){
			out.println("Airport Does Not Exist");
		}
		else {
			airportID = airportInfoRs.getString("Airport_ID");
			String city = airportInfoRs.getString("City");
			String state = airportInfoRs.getString("State");
		
	%>
	<form action="processEditAirport.jsp" method="POST">
		Airport ID: <%=airportID%></br> 
		City: <input type="text" name="city" value="<%=city%>" required></br> 
		State: <input type="text" name="state" value="<%=state%>" required></br> 
		<input type="hidden" name="airportID" value="<%=airportID%>">
		<input type="submit" value="Confirm">
	</form>

						<br/>
		<a href = "repEditAirport.jsp">Back To Edit Airport</a>



	<%
		}
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>


</body>
</html>