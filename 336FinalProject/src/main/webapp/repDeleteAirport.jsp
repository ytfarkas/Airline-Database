<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Airport</title>
</head>
<body>
	<h2>Delete Airport</h2>
	<form action="processDeleteAirport.jsp" method="POST">
		Airport ID: <input type="text" name="airportID" required><br />
		<input type="submit" value="Delete Airport">
	</form>
					<br/>
		<a href = "repEditInfo.jsp">Back To Edit Info Dashboard</a>


</body>
</html>