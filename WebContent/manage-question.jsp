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
<form action="ManageQuestion" method="post">
<table>
<tr><td>Tìm kiếm <input type="text" name="keyWord" value="${ keyWord }"> <input type="submit" name="command" value="Tìm"> 
<input type="submit" name="command" value="Thêm câu hỏi">
<input type="submit" name="command" value="Quay lại"></td></tr>
<tr><td align="center">Nội dung câu hỏi</td><td align="center">Thao tác</td></tr>
<c:if test="${ empty listQuestion }">Không có câu hỏi nào</c:if>
<c:if test="${ not empty listQuestion }">
	<c:forEach items="${ listQuestion }" var="q">
		<c:if test="${ not empty questionIDSelected }">
			<c:if test="${ questionIDSelected eq q.getQuestionID() }">
				<form action="ManageQuestion" method="post">
				<tr><td><input type="text" name="questionContent" value="${ q.getQuestionContent() }"></td>
				<td align="center">
				<input type="hidden" name="questionID" value="${ q.getQuestionID() }">
				<input type="submit" name="command" value="Xác nhận"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerA() }"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerB() }"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerC() }"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerD() }"></td></tr>
				<tr><td></td></tr>
				</form>
			</c:if>
			<c:if test="${ questionIDSelected ne q.getQuestionID() }">
				<form action="ManageQuestion" method="post">
				<tr><td>${ q.getQuestionContent() }</td>
				<td align="center">
				<input type="hidden" name="questionID" value="${ q.getQuestionID() }">
				<input type="submit" name="command" value="Sửa"></td></tr>
				<tr><td>${ q.getAnswerA() }</td></tr>
				<tr><td>${ q.getAnswerB() }</td></tr>
				<tr><td>${ q.getAnswerC() }</td></tr>
				<tr><td>${ q.getAnswerD() }</td></tr>
				<tr><td></td></tr>
				</form>
			</c:if>
		</c:if>
		<c:if test="${ empty questionIDSelected }">
			<form action="ManageQuestion" method="post">
			<tr><td>${ q.getQuestionContent() }</td>
			<td align="center">
			<input type="hidden" name="questionID" value="${ q.getQuestionID() }">
			<input type="submit" name="command" value="Sửa"></td></tr>
			<tr><td>${ q.getAnswerA() }</td></tr>
			<tr><td>${ q.getAnswerB() }</td></tr>
			<tr><td>${ q.getAnswerC() }</td></tr>
			<tr><td>${ q.getAnswerD() }</td></tr>
			<tr><td></td></tr>
			</form>
		</c:if>
	</c:forEach>
</c:if>
</table>
</form>
</body>
</html>