<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Flight</title>
</head>
<body>
	<h2>Delete Flight</h2>
	<form action="processDeleteFlight.jsp" method="POST">
		Flight Number: <input type="text" name="flightNumber" required><br />
		<input type="submit" value="Delete Flight">
	</form>
					<br/>
		<a href = "repEditInfo.jsp">Back To Edit Info Dashboard</a>


</body>
</html>