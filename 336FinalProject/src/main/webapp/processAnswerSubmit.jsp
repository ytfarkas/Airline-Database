<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String questionID = request.getParameter("questionID");
Integer accountNumber = (Integer) session.getAttribute("user");
String answer = request.getParameter("answer");


try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

    String sql = "INSERT INTO Answer (Question_ID, Rep_Account, Answer_Text) VALUES (?, ?, ?)";
    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, questionID);
    ps.setInt(2, accountNumber);
    ps.setString(3, answer);

    ps.executeUpdate();
    con.close();

    response.sendRedirect("repAnswerQuestions.jsp");

	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>