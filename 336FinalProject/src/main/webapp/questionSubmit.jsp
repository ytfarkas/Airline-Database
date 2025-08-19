<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submit a Question</title>
</head>
<body>
    <h2>Submit a Question</h2>

    <form action="processQuestionSubmit.jsp" method="post">
    <b>Subject</b><br/>
    	<textarea name="subject" rows="1" cols="60" required></textarea><br/><br/>
    	<b>Question</b><br/>
        <textarea name="question" rows="5" cols="60" required></textarea><br/><br/>
        <input type="submit" value="Submit Question">
    </form>
    <br/>
    	<a href = "customerQA.jsp">Back To Question Dashboard</a>
    

</body>
</html>