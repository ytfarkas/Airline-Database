<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Airport</title>
</head>
<body>
	<h2>Edit Airport Information</h2>
	<form action="airportEditor.jsp" method="POST">
		Airport ID: <input type="text" name="airportID" required><br />
		<input type="submit" value="Edit">
	</form>
					<br/>
		<a href = "repEditInfo.jsp">Back To Edit Info Dashboard</a>

</body>
</html>