<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Reservation</title>
</head>
<body>
	<h2>Edit Reservation Information</h2>
	<form action="repViewFlights.jsp" method="POST">
		Account Number: <input type="text" name="accountNumber" required><br />
		<input type="hidden" name= "location" value = "rep">
		
		<input type="submit" value="Edit">
	</form>
	
					<br/>
		<a href = "repHome.jsp">Back To Dashboard</a>

</body>
</html>