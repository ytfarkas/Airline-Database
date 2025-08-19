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
<%
	String departInstanceID = request.getParameter("selectedDepartFlight");
	String departPrice = request.getParameter("departSelectedPrice");

	String returnInstanceID = request.getParameter("selectedReturnFlight");
	String returnPrice = request.getParameter("returnSelectedPrice");


	
	String selectedClass = request.getParameter("selectedClass");
	String totalPriceStr = request.getParameter("totalPrice");
	
	double totalPrice = Double.parseDouble(totalPriceStr);
	
	String location = request.getParameter("location");
	
	int accountNumber = -1;
	if (location.equals("representative")) {
		accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
		
	}else {
		accountNumber = (Integer) session.getAttribute("user");

	}
	
	
	
	
	

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);
		
		double bookingFee = 50.00;
		double totalCharge = bookingFee + totalPrice;
		double changeFee = 0.00;
		if (selectedClass.equals("Economy")){
			changeFee = 50.00;
		}
		
		String checkSeatsSql = "SELECT Seats_Available FROM Flight_Avalibility WHERE Instance_ID = ?";
		PreparedStatement seatCheckPs = con.prepareStatement(checkSeatsSql);
		seatCheckPs.setString(1, departInstanceID);
		ResultSet seatRs = seatCheckPs.executeQuery();
		
		boolean depFlightFull = false;
		if (seatRs.next()){
			int seatsAvailable = seatRs.getInt("Seats_Available");
			if (seatsAvailable <=0){
				depFlightFull = true;
			}
		}
		
		boolean retFlightFull = false;
		if (returnInstanceID != null){
			seatCheckPs.setString(1, returnInstanceID);
			seatRs = seatCheckPs.executeQuery();
			if (seatRs.next()){
				int seatsAvailable = seatRs.getInt("Seats_Available");
				if (seatsAvailable <= 0){
					retFlightFull = true;
				}
			}
		}
		
		if (depFlightFull || retFlightFull){
			String waitlistSql = "INSERT INTO Waitlist (Instance_ID, Account_Number) VALUES (?, ?)";
			PreparedStatement waitlistPs = con.prepareStatement(waitlistSql);
		
		
		if (depFlightFull){
			waitlistPs.setInt(1, Integer.parseInt(departInstanceID));
			waitlistPs.setInt(2, accountNumber);
			waitlistPs.executeUpdate();
		}
		if (retFlightFull && returnInstanceID != null){
			waitlistPs.setInt(1, Integer.parseInt(returnInstanceID));
			waitlistPs.setInt(2, accountNumber);
			waitlistPs.executeUpdate();
		}
		
		out.println("<h2>Added Flight(s) to Waitlist</h2>");
		
		if (location.equals("customer")){
		%>
		<a href = "customerHome.jsp">Back To Dashboard</a>
		
		<%
		}
		con.close();
		return;
		
		}
		
		
		String flightBookingSql = "INSERT INTO Bookings (Account_Number, Class, Price, Booking_Fee, Change_Fee, Total_Charge, Flight_Type) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		PreparedStatement bookingPs = con.prepareStatement(flightBookingSql, Statement.RETURN_GENERATED_KEYS);
		bookingPs.setInt(1, accountNumber);
		bookingPs.setString(2, selectedClass);
		bookingPs.setDouble(3, totalPrice);
		bookingPs.setDouble(4, bookingFee);
		bookingPs.setDouble(5, changeFee);
		bookingPs.setDouble(6, totalCharge);
		if (returnInstanceID != null){
			bookingPs.setString(7, "Round Trip");
		} else {
			bookingPs.setString(7, "One Way");
		}
		bookingPs.executeUpdate();
		
		
		ResultSet bookingID = bookingPs.getGeneratedKeys();
		int ticketID = -1;
		if (bookingID.next()){
			ticketID = bookingID.getInt(1);
		}
		
		String ticketSql = "INSERT INTO Ticket (Ticket_ID, Instance_ID, Seat_Number) VALUES (?, ?, ?)";
		PreparedStatement ticketPs = con.prepareStatement(ticketSql);
		ticketPs.setInt(1, ticketID);
		ticketPs.setInt(2, Integer.parseInt(departInstanceID));
		ticketPs.setString(3, "A1");
		ticketPs.executeUpdate();
		
		if (returnInstanceID != null){
			ticketPs.setInt(1, ticketID);
			ticketPs.setInt(2, Integer.parseInt(returnInstanceID));
			ticketPs.setString(3, "A2");
			ticketPs.executeUpdate();
		}
		
		String updateSeatsSql = "UPDATE Flight_Avalibility SET Seats_Available = Seats_Available - 1 WHERE Instance_ID = ?";
		PreparedStatement updateSeatsPs = con.prepareStatement(updateSeatsSql);

		updateSeatsPs.setInt(1, Integer.parseInt(departInstanceID));
		updateSeatsPs.executeUpdate();

		if (returnInstanceID != null) {
		    updateSeatsPs.setInt(1, Integer.parseInt(returnInstanceID));
		    updateSeatsPs.executeUpdate();
		}
		
		if (location.equals("representative")) {
			%>
			<h1>Booking Confirmed for Customer <%=accountNumber%></h1>
			<a href="repHome.jsp">Click Here To Return To Customer Representative Dashboard</a>
			
			<%
			
		}else {
			accountNumber = (Integer) session.getAttribute("user");

		
		
			
		%>
		<h1> Booking Confirmed</h1>
		<a href="customerUpcomingFlight.jsp">Click Here To View Upcoming Flights</a>
		<p> Or </p>
		<a href="customerPastFlights.jsp">Click Here To View Past Flights</a>
		<p> Or </p>
		<a href = "customerHome.jsp">Back To Dashboard</a>
		
		
		<%
		}
		
		
		
		
	con.close();
	} catch (Exception e) {
		out.println(e.getMessage());
		}
%>

</body>
</html>