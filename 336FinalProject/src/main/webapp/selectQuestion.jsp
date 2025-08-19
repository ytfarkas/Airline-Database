<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Questions</title>
</head>
<body>
	<h2>Questions</h2>
	<%
	String questionID = request.getParameter("questionSelected");
	String location = request.getParameter("location");

	try {
		Class.forName("com.mysql.jdbc.Driver");

		String connectionRoot = "root";
		String connectionPassword = "mysqlpassword";

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", connectionRoot,
		connectionPassword);

		PreparedStatement questionPs = con
		.prepareStatement("SELECT q.Question_ID, q.Subject_Text, q.Question_Text, q.Post_Date, "
				+ "a.Answer_ID, a.Rep_Account, a.Answer_Text, a.Answer_Date " + "FROM Question q "
				+ "LEFT JOIN Answer a ON a.Question_ID = q.Question_ID " + "WHERE q.Question_ID = ?");

		questionPs.setString(1, questionID);
		ResultSet rs = questionPs.executeQuery();
	%>
	<h3>Q&A</h3>
	<%
	while (rs.next()) {
		String questionIdent = rs.getString("Question_ID");
		String subject = rs.getString("Subject_Text");
		String question = rs.getString("Question_Text");
		String postDate = rs.getString("Post_Date");
		String answerID = rs.getString("Answer_ID");
		String repAccount = rs.getString("Rep_Account");
		String answer = rs.getString("Answer_Text");
		String answerDate = rs.getString("Answer_Date");
	%>
	<p>
		<b>Subject:</b>
		<%=subject%><br />
		------------------------------------------------------------------------------<br />
		<b>Question:</b>
		<%=question%><br /> <br /> Posted on:
		<%=postDate%>
	</p>
	<%
	if (answerID != null) {
	%>
	<b>Answer:</b>
	<%=answer%><br />
	<br /> Posted on:
	<%=answerDate%>
	</p>

	<%
	} else if (location.equals("rep")) {
	out.println("<p>Please Provide Answer:</p>");
	%>
	<form action="processAnswerSubmit.jsp" method="post">
		<textarea name="answer" rows="5" cols="60" required></textarea>
		<br />
		<br /> <input type="hidden" name="questionID" value="<%=questionID%>">
		<input type="submit" value="Submit Answer">
	</form>


	<%
	} else {
	out.println("<p><i> No Answer Yet</i></p>");
	}

	}

	if (location.equals("customer")) {
	%>
	<a href="customerQA.jsp">Back to Q&A</a>
	<%
	} else if (location.equals("rep")) {
	%>
	<br />
	<a href="repAnswerQuestions.jsp">Back To Answer Questions</a>
	<%
	}
	con.close();
	} catch (Exception e) {
	out.println(e.getMessage());
	}
	%>
</body>
</html>


