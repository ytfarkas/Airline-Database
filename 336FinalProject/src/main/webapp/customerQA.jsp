<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
</head>
<body>
	<h1>What Would You Like To Do?</h1>
	<form action="questionBrowse.jsp" method="get">
		<button type="submit">Browse Questions</button>
	</form>
	<form action="questionSearch.jsp" method="get">
		<button type="submit">Search Questions by Keyword</button>
	</form>
	<form action="questionSubmit.jsp" method="get">
		<button type="submit">Submit a Question</button>
	</form>
		<br/>
	<a href = "customerHome.jsp">Back To Dashboard</a>


</body>
</html>