<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String aircraftID = request.getParameter("aircraftID");


try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	PreparedStatement ps = con.prepareStatement("DELETE FROM Aircraft WHERE Aircraft_ID = ?");
	
	ps.setString(1, aircraftID);
	ps.executeUpdate();
	
	con.close();
	
	response.sendRedirect("repHome.jsp");
	
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>