<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<title>Login page</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<br>
	<div class="body-form-login">
		<br><h1>Đăng nhập</h1>
		<% 
		String err = request.getParameter("err");
		if ("1".equals(err)) {
		out.println("<center><div class=\"alert-box error\"><span>error: </span>Tên tài khoản hoặc mật khẩu chưa chính xác!</div></center>"); 
		}
		else
			out.println("<br>");
		%>
	<form action="UserServlet" method="post">
		<h3><label> Tài khoản:&nbsp; </label></h3> <input type="text" name="username">
		<br><h3><label> Mật khẩu:&nbsp; </label></h3> <input type="password"
			name="password"> <br> <label>&nbsp; </label> 
		<input type="hidden" value="login" name="command">
			<center><input type="submit" value="Đăng nhập" name="submit"></center>
	</form>
	</div>
</body>
</html>