<%@page import="java.util.ArrayList"%>
<%@ page import="model.Comment" %> 
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
<br>
<center>
<table border="1" bordercolor="green" width="80%">
<caption><h3>Danh sách ý kiến đóng góp</h3></caption>
<tr><td align="center">Người gửi</td>
<td align="center">Tiêu đề</td>
<td align="center">Nội dung</td>
<td align="center">Trạng thái</td></tr>

<c:forEach items="${ listComment }" var="comment">
	<form action="ManageComment" method="post">
		<tr>
			<td>${ comment.username }</td>
			<td>${ comment.title }</td>
			<td>${ comment.content }</td>
		
			<c:if test="${ comment.status }">
				<td align="center">Đã duyệt</td>
			</c:if>
		
			<c:if test="${ !comment.status }">
				<td align="center"><input type="hidden" name="commentID" value="${ comment.commentID }">
				<input type="submit" value="Duyệt"></td>
			</c:if>
		</tr>
	</form>
</c:forEach>
</table><br>
<button onclick="location='./manager.jsp'">Quay lại</button></center>
</body>
</html>