<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String airportID = request.getParameter("airportID");


try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	PreparedStatement ps = con.prepareStatement("DELETE FROM Airport WHERE Airport_ID = ?");
	
	ps.setString(1, airportID);
	ps.executeUpdate();
	
	con.close();
	
	response.sendRedirect("repHome.jsp");
	
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>