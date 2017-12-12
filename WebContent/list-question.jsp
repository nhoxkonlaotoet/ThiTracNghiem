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
<form action="AddExam" method="post">
<table>
<tr><td>Tìm kiếm <input type="text" name="keyWord"> <input type="submit" name="command" value="Tìm"> 
<input type="submit" name="command" value="Quay lại"></td></tr>
<tr><td align="center">Nội dung câu hỏi</td><td align="center">Thao tác</td></tr>

<c:forEach items="${ listQuestion }" var="question">
	<form action="AddExam" method="post">
	<tr><td>${ question.getContent() }</td><td align="center">
	<input type="hidden" name="questionID" value="${ question.getQuestionID() }">
	<input type="hidden" name="questionContent" value="${ question.getContent() }">
	<input type="hidden" name="questionImage" value="${ question.getImage() }">
	<input type="submit" name="command" value="Thêm"></td></tr>
	</form>
</c:forEach>
</table>
</form>
</body>
</html>