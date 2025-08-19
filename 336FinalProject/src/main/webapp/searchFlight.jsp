<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Select A Flight</h2>

	<%
	String oneWay_roundTrip = request.getParameter("oneWay/RoundTrip");
	String depart = request.getParameter("depart");
	String arrive = request.getParameter("arrive");
	String departDate = request.getParameter("departDate");
	String returnDate = request.getParameter("returnDate");
	Boolean flexibility = request.getParameter("flexibility") != null;
	String location = request.getParameter("location");
	String sort = request.getParameter("sort");
	String airlineFilter = request.getParameter("filterAirline");
	String maxPrice = request.getParameter("maxPrice");


	int accountNumber = -1;
	if (location.equals("representative")) {
		accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
	}

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		String depSql = "SELECT fa.Instance_ID, fs.Flight_Number, fs.Airline_ID, fa.Flight_Date, fs.Departure_Airport_ID, fs.Departure_Time, "
		+ "fs.Arrival_Airport_ID, fs.Arrival_Time, fa.Seats_Available, fa.Base_Price " + "FROM Flight_Schedule fs "
		+ "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number "
		+ "WHERE fs.Departure_Airport_ID = ? " + "AND fs.Arrival_Airport_ID = ? ";

		if (flexibility) {
			depSql += "AND fa.Flight_Date BETWEEN DATE_SUB(?, INTERVAL 3 DAY) AND DATE_ADD(?, INTERVAL 3 DAY)";
		} else {
			depSql += "AND fa.Flight_Date = ? ";
		}

		if (airlineFilter != null && !airlineFilter.isEmpty()) {
			depSql += "AND fs.Airline_ID = ? ";
		}
		if (maxPrice != null && !maxPrice.isEmpty()) {
			depSql += "AND fa.Base_Price <= ? ";
		}
		if (sort != null && !sort.trim().equals("")) {
			depSql += "ORDER BY " + sort;
		}

		PreparedStatement depPs = con.prepareStatement(depSql);

		int depIndex = 1;
		depPs.setString(depIndex++, depart);
		depPs.setString(depIndex++, arrive);

		if (flexibility) {
			depPs.setString(depIndex++, departDate);
			depPs.setString(depIndex++, departDate);

		} else {
			depPs.setString(depIndex++, departDate);
		}
		if (airlineFilter != null && !airlineFilter.isEmpty()) {
			depPs.setString(depIndex++, airlineFilter);
		}
		if (maxPrice != null && !maxPrice.isEmpty()) {
			double maxPriceDouble = Double.parseDouble(maxPrice);
			depPs.setDouble(depIndex++, maxPriceDouble);
		}

		String returnSql = "";
		PreparedStatement retPs = null;
		if (oneWay_roundTrip.equals("round trip")) {
			returnSql = "SELECT fa.Instance_ID, fs.Flight_Number, fs.Airline_ID, fa.Flight_Date, fs.Departure_Airport_ID, fs.Departure_Time, "
			+ "fs.Arrival_Airport_ID, fs.Arrival_Time, fa.Seats_Available, fa.Base_Price "
			+ "FROM Flight_Schedule fs " + "JOIN Flight_Avalibility fa ON fs.Flight_Number = fa.Flight_Number "
			+ "WHERE fs.Departure_Airport_ID = ? " + "AND fs.Arrival_Airport_ID = ? ";

			if (flexibility) {
		returnSql += "AND fa.Flight_Date BETWEEN DATE_SUB(?, INTERVAL 3 DAY) AND DATE_ADD(?, INTERVAL 3 DAY)";
			} else {
		returnSql += "AND fa.Flight_Date = ? ";
			}

			if (airlineFilter != null && !airlineFilter.isEmpty()) {
		returnSql += "AND fs.Airline_ID = ? ";
			}
			if (maxPrice != null && !maxPrice.isEmpty()) {
		returnSql += "AND fa.Base_Price <= ? ";
			}
			if (sort != null && !sort.trim().equals("")) {
		returnSql += "ORDER BY " + sort;
			}

			retPs = con.prepareStatement(returnSql);

			int retIndex = 1;
			retPs.setString(retIndex++, arrive);
			retPs.setString(retIndex++, depart);

			if (flexibility) {
		retPs.setString(retIndex++, returnDate);
		retPs.setString(retIndex++, returnDate);

			} else {
		retPs.setString(retIndex++, returnDate);
			}

			if (airlineFilter != null && !airlineFilter.isEmpty()) {
		retPs.setString(retIndex++, airlineFilter);
			}
			if (maxPrice != null && !maxPrice.isEmpty()) {
		double maxPriceDouble = Double.parseDouble(maxPrice);
		retPs.setDouble(retIndex++, maxPriceDouble);
			}

		}
	%>
	<form action="bookFlight.jsp" method="post">
		<h3>Departing Flights</h3>
		<%
		ResultSet rs = depPs.executeQuery();
		while (rs.next()) {
			String instanceID = rs.getString("Instance_ID");
			String flightNumber = rs.getString("Flight_Number");
			String airlineID = rs.getString("Airline_ID");
			String flightDate = rs.getString("Flight_Date");
			String departAirportID = rs.getString("Departure_Airport_ID");
			String departTime = rs.getString("Departure_Time");
			String arrivalAirportID = rs.getString("Arrival_Airport_ID");
			String arrivalTime = rs.getString("Arrival_Time");
			int seatsAvailable = rs.getInt("Seats_Available");
			Double basePrice = rs.getDouble("Base_Price");
		%>
		<label> <input type="radio" name="selectedDepartFlight"
			value="<%=instanceID%>-<%=basePrice%>"> Flight: <%=flightNumber%>
			Airline: <%=airlineID%> Date: <%=flightDate%> From: <%=departAirportID%>
			Depart Time: <%=departTime%> To: <%=arrivalAirportID%> Arrival Time:
			<%=arrivalTime%> Price: $<%=basePrice%>
		</label></br>



		<%
		}
		ResultSet retRs = null;
		if (oneWay_roundTrip.equals("round trip")) {
		%><h3>Return Flights</h3>
		<%
		retRs = retPs.executeQuery();
		while (retRs.next()) {
			String instanceID = retRs.getString("Instance_ID");
			String returnFlightNumber = retRs.getString("Flight_Number");
			String returnAirlineID = retRs.getString("Airline_ID");
			String returnFlightDate = retRs.getString("Flight_Date");
			String returnDepartAirportID = retRs.getString("Departure_Airport_ID");
			String returnDepartTime = retRs.getString("Departure_Time");
			String returnArrivalAirportID = retRs.getString("Arrival_Airport_ID");
			String returnArrivalTime = retRs.getString("Arrival_Time");
			int returnSeatsAvailable = retRs.getInt("Seats_Available");
			Double basePrice = retRs.getDouble("Base_Price");
		%>
		<label> <input type="radio" name="selectedReturnFlight"
			value="<%=instanceID%>-<%=basePrice%>"> Flight: <%=returnFlightNumber%>
			Airline: <%=returnAirlineID%> Date: <%=returnFlightDate%> From: <%=returnDepartAirportID%>
			Depart Time: <%=returnDepartTime%> To: <%=returnArrivalAirportID%>
			Arrival Time: <%=returnArrivalTime%> Price: $<%=basePrice%>
		</label></br>




		<%
		}

		}
		%>
		<h4>Select Class</h4>
		Class: <select name="flightClass" required>
			<option value="Economy">Economy (+ $0)</option>
			<option value="Business">Business (+ $50)</option>
			<option value="First">First (+ $100)</option>
		</select><br /> <input type="hidden" name="location" value="<%=location%>">
		<input type="hidden" name="accountNumber" value="<%=accountNumber%>">
		<input type="submit" value="Confirm Selection">
	</form>
	<%
	
	if (location.equals("customer")){
	%>
	<br/>
	<a href = "customerFlightSearch.jsp">Back to Flight Search</a>
	<%
	} else if (location.equals("representative")){
		%>
	<br/>
	<a href = "repFlightSearch.jsp">Back to Flight Search</a>
		<%
	}
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>
</body>
</html>


