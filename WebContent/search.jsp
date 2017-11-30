<%@page import="model.Title"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<%
	Cookie[] listCookie = request.getCookies();
	String role = "manager";
	if (listCookie != null){
		for (Cookie c : listCookie){
			if (c.getName().equals("role"))
				role = c.getValue();
		}
		if (role.equals("member"))
			response.sendRedirect("index.jsp");		
	}
%>
<center>
<form action="SearchServlet" method="post">
Tìm theo: 
<select name="type">
<option value="subject">Môn học</option>
<option value="title">Tên đề</option>
<option value="schoolyear">Năm học</option>
</select>
<input type="text" name="keyWord">
<input type="submit" value="Tìm">
</form>

<table border="1" width="60%">
<tr><td>Môn thi</td><td>Năm học</td><td>Mã đề</td><td>Thời gian làm bài</td><td>Thao tác</td></tr>
<c:forEach items="${listTitle}" var="title">
<tr>
<td>${title.subjectName}</td>
<td>${title.schoolYear}</td>
<td>${title.titleName}</td>
<td>${title.time}</td>
<td><a href="">Xem chi tiết</a></td>
<tr>
 </c:forEach>
</table>
</center>
</body>
</html>