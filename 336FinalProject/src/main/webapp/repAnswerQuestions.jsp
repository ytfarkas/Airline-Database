<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse Questions</title>
</head>
<body>
	<h2>Unanswered Questions</h2>

	<%
	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		PreparedStatement questionPs = con.prepareStatement("SELECT q.Question_ID, q.Subject_Text "
				+ "FROM Question q LEFT JOIN Answer a ON a.Question_ID = q.Question_ID WHERE Answer_ID IS NULL");
		
	%>
	<form action="selectQuestion.jsp" method="post">
		<h3>Q&A</h3>
		<%
		ResultSet rs = questionPs.executeQuery();
		while (rs.next()) {
			String questionID = rs.getString("Question_ID");
			String subject = rs.getString("Subject_Text");
		%>
		<label> <input type="radio" name="questionSelected"
			value="<%=questionID%>"> 
			<b>Subject:</b> <%=subject%>
		</label></br>
		
		<%
		}
		%>
	<input type="hidden" name = "location" value= "rep">
	<input type="submit" value="Confirm Selection">
	</form>
	
					<br/>
		<a href = "repHome.jsp">Back To Dashboard</a>
		
		<%
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>
</body>
</html>


