<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String subject = request.getParameter("subject");
String question = request.getParameter("question");
Integer accountNumber = (Integer) session.getAttribute("user");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/336AirlineProject", "root", "mysqlpassword");

    String sql = "INSERT INTO Question (Account_Number, Subject_Text, Question_Text) VALUES (?, ?, ?)";
    PreparedStatement ps = con.prepareStatement(sql);


    ps.setInt(1, accountNumber);
    ps.setString(2, subject);
    ps.setString(3, question);

    ps.executeUpdate();
    con.close();

    response.sendRedirect("customerQA.jsp");

	} catch (Exception e) {
		out.println(e.getMessage());
	}
%>