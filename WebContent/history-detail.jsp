<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chi tiết bài thi</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<br>
<c:if test="${ empty listHistory }">
	<h1>Đề thi không tại hoặc đã bị xóa!!!</h1>
</c:if>
<c:if test="${ not empty listHistory }">
	<% int i = 1; %>
	<c:forEach items="${ listHistory }" var="history">
		<b>Câu <%= i++ %>: ${ history.questionContent } </b><br>
		Đáp án chọn: ${ history.chosenAnswer } và đáp án đúng: ${ history.correctAnswer } <br>
		<%-- Hình: ${ history.image } <br> --%>
		<c:if test="${ history.image.trim() eq 'Không' }"> không có hình <br></c:if>
		<c:if test="${ history.image.trim() ne 'Không' }"> <img src="./images/question/${ history.image }"> <br> </c:if>
		
		<!-- Câu đúng-->
		<c:if test="${ history.chosenAnswer.trim() eq history.correctAnswer.trim() }">
			<!-- Đáp án chọn là A -->
			<c:if test="${ history.chosenAnswer.trim() eq 'A' }">
				<font color="blue"><b>A. ${ history.answerA } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'A' }">
				<font color="black">A. ${ history.answerA } </font><br>
			</c:if>
			<!-- Đáp án chọn là B -->
			<c:if test="${ history.chosenAnswer.trim() eq 'B' }">
				<font color="blue"><b>B. ${ history.answerB } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'B' }">
				<font color="black">B. ${ history.answerB } </font><br>
			</c:if>
			<!-- Đáp án chọn là C -->
			<c:if test="${ history.chosenAnswer.trim() eq 'C' }">
				<font color="blue"><b>C. ${ history.answerC } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'C' }">
				<font color="black">C. ${ history.answerC } </font><br>
			</c:if>
			<!-- Đáp án chọn là D -->
			<c:if test="${ history.chosenAnswer.trim() eq 'D' }">
				<font color="blue"><b>D. ${ history.answerD } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'D' }">
				<font color="black">D. ${ history.answerD } </font><br>
			</c:if>
		</c:if>
		<!-- Câu sai -->
		<c:if test="${ history.chosenAnswer.trim() ne history.correctAnswer.trim() }">
			<!-- Đáp án A -->
			<c:if test="${ history.chosenAnswer.trim() eq 'A' }">
				<font color="red"><b>A. ${ history.answerA } </b></font><br>
			</c:if>
			<c:if test="${ history.correctAnswer.trim() eq 'A' }">
				<font color="blue"><b>A. ${ history.answerA } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'A' and history.correctAnswer.trim() ne 'A' }">
				<font color="black">A. ${ history.answerA } </font><br>
			</c:if>
			
			<!-- Đáp án B -->
			<c:if test="${ history.chosenAnswer.trim() eq 'B' }">
				<font color="red"><b>B. ${ history.answerB } </b></font><br>
			</c:if>
			<c:if test="${ history.correctAnswer.trim() eq 'B' }">
				<font color="blue"><b>B. ${ history.answerB } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'B' and history.correctAnswer.trim() ne 'B' }">
				<font color="black">B. ${ history.answerB } </font><br>
			</c:if>
			
			<!-- Đáp án C -->
			<c:if test="${ history.chosenAnswer.trim() eq 'C' }">
				<font color="red"><b>C. ${ history.answerC } </b></font><br>
			</c:if>
			<c:if test="${ history.correctAnswer.trim() eq 'C' }">
				<font color="blue"><b>C. ${ history.answerC } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'C' and history.correctAnswer.trim() ne 'C' }">
				<font color="black">C. ${ history.answerC } </font><br>
			</c:if>
			
			<!-- Đáp án D -->
			<c:if test="${ history.chosenAnswer.trim() eq 'D' }">
				<font color="red"><b>D. ${ history.answerD } </b></font><br>
			</c:if>
			<c:if test="${ history.correctAnswer.trim() eq 'D' }">
				<font color="blue"><b>D. ${ history.answerD } </b></font><br>
			</c:if>
			<c:if test="${ history.chosenAnswer.trim() ne 'D' and history.correctAnswer.trim() ne 'D' }">
				<font color="black">D. ${ history.answerD } </font><br>
			</c:if>
		</c:if>
		<br>
	</c:forEach>
</c:if>
<input type="button" value="Quay lại" onclick="location.href='./HistoryServlet'">

</body>
</html>