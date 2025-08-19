<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Results</title>
</head>
<body>
    <h2>Search Results</h2>
<%
    String keywordData = request.getParameter("keyword");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

        String keywordSearchSql = "SELECT q.Question_ID, q.Subject_Text, q.Question_Text, q.Post_Date, " +
                     "a.Answer_Text, a.Answer_Date " +
                     "FROM Question q " +
                     "LEFT JOIN Answer a ON q.Question_ID = a.Question_ID " +
                     "WHERE q.Question_Text LIKE ? OR q.Subject_Text LIKE ? OR a.Answer_Text LIKE ?";

        PreparedStatement ps = con.prepareStatement(keywordSearchSql);
        String keyword = "%" + keywordData + "%";
        ps.setString(1, keyword);
        ps.setString(2, keyword);
        ps.setString(3, keyword);

        ResultSet rs = ps.executeQuery();

        boolean found = false;
        
        while (rs.next()) {
            found = true;
			String questionID = rs.getString("Question_ID");
			String subject = rs.getString("Subject_Text");
%>
		<form action="selectQuestion.jsp" method="post">
		<label> <input type="radio" name="questionSelected"
			value="<%=questionID%>"> 
			<b>Subject:</b> <%=subject%>
		</label></br>
		
<%

        }

        if (!found) {
            out.println("<p>No results for <b>" + keywordData + "</b></p>");
            		
            %>
            	<a href = "questionSearch.jsp">Back To Question Search</a>
            		
         	<%
        }else{
        	%>
        	<br/>
        	<input type="hidden" name = "location" value= "customer">
			<input type="submit" value="Confirm Selection">
			</form>
			<br/>
			<a href = "questionSearch.jsp">Back To Question Search</a>
			
        	<%
        }

        con.close();
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>
</body>
</html>
