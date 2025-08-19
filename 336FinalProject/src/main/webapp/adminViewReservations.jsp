<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>View Reservations</h2>
	<form action="reservationByFlightNumber.jsp" method="get">
		Flight Number: <input type="text" name="flightNumber"><br />
		<button type="submit">View By Flight Number</button>
	</form>
	<form action="reservationByName.jsp" method="get">
		<br /> First Name: <input type="text" name="firstName"><br />
		Last Name: <input type="text" name="lastName"><br />

		<button type="submit">View By Customer Name</button>
	</form>
	
			<br/>
	<a href = "adminHome.jsp">Back To Dashboard</a>
		


</body>
</html>