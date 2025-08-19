<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String flightNumber = request.getParameter("flightNumber");


try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	PreparedStatement ps = con.prepareStatement("DELETE FROM Flight_Schedule WHERE Flight_Number = ?");
	
	ps.setString(1, flightNumber);
	ps.executeUpdate();
	
	con.close();
	
	response.sendRedirect("repHome.jsp");
	
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>