<%@page import="com.demo.jspservlet.model.Student"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body bgcolor="lightBlue">

	<%
	Student st = (Student) request.getAttribute("student");
		out.println(st);
	%>
</body>
</html>