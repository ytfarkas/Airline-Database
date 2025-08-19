<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Aircraft</title>
</head>
<body>
	<h2>Edit Aircraft Information</h2>
	<form action="aircraftEditor.jsp" method="POST">
		Aircraft ID: <input type="text" name="aircraftID" required><br />
		<input type="submit" value="Edit">
	</form>
					<br/>
		<a href = "repEditInfo.jsp">Back To Edit Info Dashboard</a>
		


</body>
</html>