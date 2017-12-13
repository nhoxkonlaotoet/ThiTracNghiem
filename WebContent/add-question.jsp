<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
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
<c:if test="${error eq '0'}">
	<div class="alert-box success"><span></span>Thêm câu hỏi thành công! Bấm vào <a href="add-question.jsp"><b>đây </b></a>để tiếp tục
	</div>
</c:if>	
<c:if test="${error eq '1'}">
	<div class="alert-box error"><span></span>Câu hỏi đã tồn tại!</div>
</c:if>	
<c:if test="${error eq '2'}">
	<div class="alert-box error"><span></span>Chưa nhập đầy đủ thông tin!</div>
</c:if>	
<form action="ManageQuestion" method="post">
	<table>
		<tr><td>Nội dung: </td><td><input type="text" name="content" value="${ content }"></td></tr>
		<tr><td>Đáp án A: </td><td><input type="text" name="answerA" value="${ answerA }"></td></tr>
		<tr><td>Đáp án B: </td><td><input type="text" name="answerB" value="${ answerB }"></td></tr>
		<tr><td>Đáp án C: </td><td><input type="text" name="answerC" value="${ answerC }"></td></tr>
		<tr><td>Đáp án D: </td><td><input type="text" name="answerD" value="${ answerD }"></td></tr>
		<tr><td>Đáp án đúng: </td><td>
			<c:if test="${ empty correctAnswer }">
				<select name="correctAnswer"><option>A</option><option>B</option><option>C</option><option>D</option></select>
			</c:if>
			<c:if test="${ not empty correctAnswer }">
				<c:if test="${ correctAnswer eq 'A' }">
					<select name="correctAnswer"><option selected="selected">A</option><option>B</option><option>C</option><option>D</option></select>
				</c:if>
				<c:if test="${ correctAnswer eq 'B' }">
					<select name="correctAnswer"><option>A</option><option selected="selected">B</option><option>C</option><option>D</option></select>
				</c:if>
				<c:if test="${ correctAnswer eq 'C' }">
					<select name="correctAnswer"><option>A</option><option>B</option><option selected="selected">C</option><option>D</option></select>
				</c:if>
				<c:if test="${ correctAnswer eq 'D' }">
					<select name="correctAnswer"><option>A</option><option>B</option><option>C</option><option selected="selected">D</option></select>
				</c:if>
			</c:if>
		</td></tr>
		<tr><td><input type="submit" name="commandA" value="Thêm"></td><td><input type="submit" name="commandA" value="Làm mới"></td></tr>
		<tr><td><input type="submit" name="commandA" value="Quay lại"></td></tr>
	</table>
</form>
<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>
