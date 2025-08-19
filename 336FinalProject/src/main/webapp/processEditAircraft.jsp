<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String newAircraftID = request.getParameter("newAircraftID");
String aircraftID = request.getParameter("aircraftID");

int seats = Integer.parseInt(request.getParameter("seats"));



try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	PreparedStatement aircraftEditSql = con.prepareStatement("UPDATE Aircraft SET Seats = ? " + 
	"WHERE Aircraft_ID = ?");
	
	aircraftEditSql.setInt(1, seats);	
	aircraftEditSql.setString(2, aircraftID);
	
	aircraftEditSql.executeUpdate();
	
	con.close();
	
	response.sendRedirect("repHome.jsp");

	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>