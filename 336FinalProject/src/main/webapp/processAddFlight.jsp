<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String flightNumber = request.getParameter("flightNumber");
String airlineID = request.getParameter("airlineID");
String departureAirport = request.getParameter("depAirport");
String departureTime = request.getParameter("depTime");
String arrivalAirport = request.getParameter("arrAirport");
String arrivalTime = request.getParameter("arrTime");

String[] oppDays = request.getParameterValues("day");

String[] flightDate = request.getParameterValues("flightDate");
String aircraftID = request.getParameter("aircraftID");
String basePrice = request.getParameter("basePrice");

try {
	Class.forName("com.mysql.jdbc.Driver");

	String connectionRoot = "root";
	String connectionPassword = "mysqlpassword";

	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot, connectionPassword);
	
	String flightScheduleSql = "INSERT INTO Flight_Schedule "
	+ "(Flight_Number, Airline_ID, Departure_Airport_ID, Departure_Time, Arrival_Airport_ID, Arrival_Time) "
			+ "VALUES (?, ?, ?, ?, ?, ?)";
	
	
	PreparedStatement flightSchedulePS = con.prepareStatement(flightScheduleSql);
	
	flightSchedulePS.setString(1, flightNumber);
	flightSchedulePS.setString(2, airlineID);	
	flightSchedulePS.setString(3, departureAirport);
	flightSchedulePS.setString(4, departureTime);	
	flightSchedulePS.setString(5, arrivalAirport);	
	flightSchedulePS.setString(6, arrivalTime);	
	flightSchedulePS.executeUpdate();
	
	String operationDaysSql = "INSERT INTO Flight_Operating_Days (Flight_Number, Day_Of_Week) VALUES (?, ?)";
	
	PreparedStatement operationDaysPs = con.prepareStatement(operationDaysSql);
	
	for (int i = 0; i < oppDays.length; i++){
		operationDaysPs.setString(1, flightNumber);
		operationDaysPs.setString(2, oppDays[i]);
		operationDaysPs.executeUpdate();

	}
	
	String flightAvalibilitySql  = "INSERT INTO Flight_Avalibility " 
	+ "(Flight_Number, Flight_Date, Aircraft_ID, Base_Price, Seats_Available) "
	+ "SELECT ?, ?, ?, ?, a.Seats FROM Aircraft a WHERE a.Aircraft_ID = ?";
	
	PreparedStatement flightAvalibilityPs = con.prepareStatement(flightAvalibilitySql);
	
	for (int i = 0; i < flightDate.length; i++){
		if (flightDate[i] != null && !flightDate[i].trim().isEmpty()){
			flightAvalibilityPs.setString(1, flightNumber);
			flightAvalibilityPs.setString(2, flightDate[i]);
			flightAvalibilityPs.setString(3, aircraftID);
			flightAvalibilityPs.setString(4, basePrice);
			flightAvalibilityPs.setString(5, aircraftID);
			flightAvalibilityPs.executeUpdate();
		}
	}
	
	con.close();
	response.sendRedirect("repEditInfo.jsp");

	
	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>