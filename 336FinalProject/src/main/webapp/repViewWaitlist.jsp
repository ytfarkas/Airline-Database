<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>View All the Passengers On Waitlist</h2>
	<form action="processViewWaitlist.jsp" method="POST">
		Flight Number: <input type="text" name="flightNumber"><br />
		<input type="submit" value="View Waitlist">
	</form>
			<br/>
		<a href = "repHome.jsp">Back To Dashboard</a>

</body>
</html>