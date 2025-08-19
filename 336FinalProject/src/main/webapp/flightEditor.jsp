<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Flight</title>
</head>
<body>
<%
String flightNumber = request.getParameter("flightNumber");
String airlineID = "";
String depAirport = "";
String depTime = "";
String arrAirport = "";
String arrTime = "";
List<String> operatingDays = new ArrayList<>();
List<String> availabilityDates = new ArrayList<>();
String aircraftID = "";
double basePrice = 0.00;

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

    PreparedStatement flightInfoPs = con.prepareStatement(
        "SELECT * FROM Flight_Schedule WHERE Flight_Number = ?"
    );
    flightInfoPs.setString(1, flightNumber);
    ResultSet flightInfoRs = flightInfoPs.executeQuery();

    if (!flightInfoRs.next()) {
        out.println("Flight does not exist.");
    } else {
        airlineID = flightInfoRs.getString("Airline_ID");
        depAirport = flightInfoRs.getString("Departure_Airport_ID");
        depTime = flightInfoRs.getString("Departure_Time");
        arrAirport = flightInfoRs.getString("Arrival_Airport_ID");
        arrTime = flightInfoRs.getString("Arrival_Time");

        PreparedStatement opDayPs = con.prepareStatement(
            "SELECT Day_Of_Week FROM Flight_Operating_Days WHERE Flight_Number = ?"
        );
        opDayPs.setString(1, flightNumber);
        ResultSet opRs = opDayPs.executeQuery();
        while (opRs.next()) {
            operatingDays.add(opRs.getString("Day_Of_Week"));
        }

        PreparedStatement availPs = con.prepareStatement(
            "SELECT Flight_Date, Aircraft_ID, Base_Price FROM Flight_Avalibility WHERE Flight_Number = ?"
        );
        availPs.setString(1, flightNumber);
        ResultSet availRs = availPs.executeQuery();
        while (availRs.next()) {
            availabilityDates.add(availRs.getString("Flight_Date"));
            aircraftID = availRs.getString("Aircraft_ID");
            basePrice = availRs.getDouble("Base_Price");
        }
%>

<h2>Edit Flight: <%=flightNumber%></h2>
<form action="processEditFlight.jsp" method="POST">
    Airline ID: <input type="text" name="airlineID" value="<%=airlineID%>" required><br/>
    Departure Airport: <input type="text" name="depAirport" value="<%=depAirport%>" required><br/>
    Departure Time: <input type="time" name="depTime" value="<%=depTime%>" required step="1"><br/>
    Arrival Airport: <input type="text" name="arrAirport" value="<%=arrAirport%>" required><br/>
    Arrival Time: <input type="time" name="arrTime" value="<%=arrTime%>" required step="1"><br/>

    <h3>Operating Days</h3>
    <% String[] days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
       for(String day : days) { %>
        <input type="checkbox" name="day" value="<%=day%>"
            <%= operatingDays.contains(day) ? "checked" : "" %> > <%=day%><br/>
    <% } %>

    <h3>Availability Dates</h3>
    <% for (int i = 0; i < 5; i++) {
        String val = (i < availabilityDates.size()) ? availabilityDates.get(i) : "";
    %>
        <input type="date" name="flightDate" value="<%= val %>"><br/>
    <% } %>

    Aircraft ID: <input type="text" name="aircraftID" value="<%=aircraftID%>"><br/>
    Base Price: <input type="number" name="basePrice" value="<%=basePrice%>"><br/>

    <input type="hidden" name="flightNumber" value="<%= flightNumber %>">
    <input type="submit" value="Confirm Changes">
</form>

						<br/>
		<a href = "repEditFlight.jsp">Back To Edit Flight</a>

<%
    }
    con.close();
} catch (Exception e) {
    out.println(e.getMessage());
}
%>
</body>
</html>
