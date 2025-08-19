<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String airportID = request.getParameter("airportID");
String city = request.getParameter("city");
String state = request.getParameter("state");


try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	PreparedStatement airportEditSql = con.prepareStatement("UPDATE Airport SET City = ?, State = ? " + 
	"WHERE Airport_ID = ?");
	
	airportEditSql.setString(1, city);	
	airportEditSql.setString(2, state);
	airportEditSql.setString(3, airportID);

	
	airportEditSql.executeUpdate();
	
	con.close();
	
	response.sendRedirect("repHome.jsp");

	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>