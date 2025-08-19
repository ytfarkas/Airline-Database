<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Aircraft</title>
</head>
<body>
	<h2>Delete Aircraft</h2>
	<form action="processDeleteAircraft.jsp" method="POST">
		Aircraft ID: <input type="text" name="aircraftID" required><br />
		<input type="submit" value="Delete Aircraft">
	</form>
					<br/>
		<a href = "repEditInfo.jsp">Back To Edit Info Dashboard</a>


</body>
</html>