<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Questions</title>
</head>
<body>
    <h2>Search Questions by Keyword</h2>
    <form action="processQuestionSearch.jsp" method="get">
        Keyword: <input type="text" name="keyword" required>
        <input type="submit" value="Search">
    </form>
    <br/>
    	<a href = "customerQA.jsp">Back To Question Dashboard</a>
    
</body>
</html>
