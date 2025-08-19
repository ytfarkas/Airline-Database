<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Customer</title>
</head>
<body>
	<h1>What Would You Like To Do?</h1>
	<form action="customerFlightSearch.jsp" method="get">
		<button type="submit">Search For Flights</button>
	</form>
	<form action="customerUpcomingFlight.jsp" method="get">
		<button type="submit">Your Upcoming Flights</button>
	</form>
	<form action="customerPastFlights.jsp" method="get">
		<button type="submit">View Past Flights</button>
	</form>
	<form action="customerQA.jsp" method="get">
		<button type="submit">Browse, Send, Or Search Questions</button>
	</form>
	<form action="viewAccountInformation.jsp" method="get">
		<button type="submit">View Account Information</button>
	</form>

	<a href='logout.jsp'>Log Out</a>

</body>
</html>