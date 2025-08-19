<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*, java.time.LocalDate, java.time.format.TextStyle, java.util.*"%>
<%


String flightNumber = request.getParameter("flightNumber");
String airlineID = request.getParameter("airlineID");
String depAirport = request.getParameter("depAirport");
String depTime = request.getParameter("depTime");
String arrAirport = request.getParameter("arrAirport");
String arrTime = request.getParameter("arrTime");

String[] oppDays = request.getParameterValues("day");
String[] flightDates = request.getParameterValues("flightDate");
String aircraftID = request.getParameter("aircraftID");
String basePrice = request.getParameter("basePrice");

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root",
	"mysqlpassword");

	
	
	PreparedStatement updateFlight = con.prepareStatement("UPDATE Flight_Schedule "
			+ "SET Airline_ID = ?, Departure_Airport_ID = ?, Departure_Time = ?, Arrival_Airport_ID = ?, Arrival_Time = ? "
			+ "WHERE Flight_Number = ?");
	
	updateFlight.setString(1, airlineID);
	updateFlight.setString(2, depAirport);
	updateFlight.setString(3, depTime);
	updateFlight.setString(4, arrAirport);
	updateFlight.setString(5, arrTime);
	updateFlight.setString(6, flightNumber);
	updateFlight.executeUpdate();


	PreparedStatement deleteOpDays = con.prepareStatement("DELETE FROM Flight_Operating_Days WHERE Flight_Number = ?");
	deleteOpDays.setString(1, flightNumber);
	deleteOpDays.executeUpdate();

	if (oppDays != null) {
		PreparedStatement insertOpDay = con
		.prepareStatement("INSERT INTO Flight_Operating_Days (Flight_Number, Day_Of_Week) VALUES (?, ?)");
		for (String day : oppDays) {
	insertOpDay.setString(1, flightNumber);
	insertOpDay.setString(2, day);
	insertOpDay.executeUpdate();
		}
	}


	PreparedStatement deleteFlightAvail = con.prepareStatement("DELETE FROM Flight_Avalibility WHERE Flight_Number = ?");
	deleteFlightAvail.setString(1, flightNumber);
	deleteFlightAvail.executeUpdate();

	PreparedStatement insertAvail = con.prepareStatement(
	"INSERT INTO Flight_Avalibility (Flight_Number, Flight_Date, Aircraft_ID, Base_Price, Seats_Available) "
			+ "SELECT ?, ?, ?, ?, a.Seats FROM Aircraft a WHERE a.Aircraft_ID = ?");

	if (flightDates != null) {
	    for (String dateStr : flightDates) {
	        if (!dateStr.isEmpty()) {
	            insertAvail.setString(1, flightNumber);
	            insertAvail.setString(2, dateStr);
	            insertAvail.setString(3, aircraftID);
	            insertAvail.setString(4, basePrice);
	            insertAvail.setString(5, aircraftID);
	            insertAvail.executeUpdate();
	        }
	    }
	}
		
	

	con.close();
	response.sendRedirect("repHome.jsp");

} catch (Exception e) {
	out.println("Error: " + e.getMessage());
}
%>
