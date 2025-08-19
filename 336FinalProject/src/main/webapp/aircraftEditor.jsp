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
	String aircraftID = request.getParameter("aircraftID");
	String aircraftIDData = "";
	int seats = -1;
	

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		PreparedStatement aircraftInfoPs = con.prepareStatement(
		"SELECT Aircraft_ID, Seats FROM Aircraft WHERE Aircraft_ID = ?");

		aircraftInfoPs.setString(1, aircraftID);
		ResultSet aircraftInfoRs = aircraftInfoPs.executeQuery();

		if (!aircraftInfoRs.next()){
			out.println("Aircraft Does Not Exist");
		}
		else {
			aircraftIDData = aircraftInfoRs.getString("Aircraft_ID");
			seats = aircraftInfoRs.getInt("Seats");
		
	%>
	<form action="processEditAircraft.jsp" method="POST">
		Aircraft ID: <%=aircraftIDData%></br> 
		Seats: <input type="text" name="seats" value="<%=seats%>" required></br> 
		<input type="hidden" name="aircraftID" value="<%=aircraftID%>">
		<input type="submit" value="Confirm">
	</form>
	
							<br/>
		<a href = "repEditAircraft.jsp">Back To Edit Aircraft</a>




	<%
		}
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>


</body>
</html>