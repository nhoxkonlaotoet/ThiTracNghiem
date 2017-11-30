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

<center>
<table border="1" width="60%">
<tr><td>Môn thi</td><td>Năm học</td><td>Tên đề</td><td>Score</td><td>Thời gian</td><td>Thao tác</td></tr>
<c:forEach items="${listResult}" var="result">
<tr>
<td>${result.subjectName}</td>
<td>${result.schoolYear}</td>
<td>${result.titleName}</td>
<td>${result.score}</td>
<td>${result.date}</td>
<td><a href="HistoryServlet?ResultID=${result.resultID}">Xem chi tiết</a></td>
</tr>
</c:forEach>

</table>
</center>
</body>
</html>