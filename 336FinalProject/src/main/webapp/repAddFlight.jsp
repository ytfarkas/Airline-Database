<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Flight</title>
</head>
<body>
	<h2>Add Flight</h2>
	<h3>Flight Schedule</h3>
	<form action="processAddFlight.jsp" method="POST">
		Flight Number: <input type="text" name="flightNumber" required><br />
		Airline ID: <input type="text" name="airlineID" required><br />
		Departure Airport: <input type="text" name="depAirport" required><br />
		Departure Time: <input type="time" name="depTime" required step="1"><br />
		Arrival Airport: <input type="text" name="arrAirport" required><br />
		Arrival Time: <input type="time" name="arrTime" placeholder="HH:MM:SS" required step="1"><br />
		
		<h3>Operating Days</h3>
		<input type="checkbox" name="day" value="Sunday"> Sunday<br>
		<input type="checkbox" name="day" value="Monday"> Monday<br>
		<input type="checkbox" name="day" value="Tuesday"> Tuesday<br>
		<input type="checkbox" name="day" value="Wednesday"> Wednesday<br>
		<input type="checkbox" name="day" value="Thursday"> Thursday<br>
		<input type="checkbox" name="day" value="Friday"> Friday<br>
		<input type="checkbox" name="day" value="Saturday"> Saturday<br>
		
		
		<h3>Flight Availability</h3>
		
		Enter up to 5 dates for Flight (must match operating days):<br />
		<input type="date" name="flightDate"><br />
		<input type="date" name="flightDate"><br />
		<input type="date" name="flightDate"><br />
		<input type="date" name="flightDate"><br />
		<input type="date" name="flightDate"><br />		
		Aircraft ID: <input type="text" name="aircraftID" required><br />
		Base Price: $<input type="number" name="basePrice" required><br />
		
		<input type="submit" value="Add Flight">
	</form>
					<br/>
		<a href = "repEditInfo.jsp">Back To Edit Info Dashboard</a>


</body>
</html>