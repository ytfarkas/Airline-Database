<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Flight</title>
</head>
<body>
	<h2>Edit Flight Information</h2>
	<form action="flightEditor.jsp" method="POST">
		Flight Number: <input type="text" name="flightNumber" required><br />
		<input type="submit" value="Edit">
	</form>
	
					<br/>
		<a href = "repEditInfo.jsp">Back To Edit Info Dashboard</a>

</body>
</html>