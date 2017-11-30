<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="header.jsp"></jsp:include>

<div class="body-form-login">
<br><h1>Đăng ký</h1>
		<% 
		String acc = request.getParameter("Acc");
		String ema = request.getParameter("Ema");
		String pas = request.getParameter("Pas");
		if (acc != null){
			if ("0".equals(acc))
				out.println("<div class=\"alert-box error\"><span>error: </span>Bạn chưa điền tên tài khoản!</div>");
			if ("1".equals(acc)) 
				out.println("<div class=\"alert-box error\"><span>error: </span>Tài khoản đã được sử dụng!</div>"); 
			if ("2".equals(acc))
				out.println("<div class=\"alert-box success\">Đăng ký thành công! Click vào <a href=\""+ request.getContextPath() +"/login.jsp\"><b>đây</b></a> để đăng nhập.</div>");
		}
		if (ema != null){
			if ("0".equals(ema))
				out.println("<div class=\"alert-box error\"><span>error: </span>Bạn chưa điền email!</div>");
			if ("1".equals(ema)) 
				out.println("<div class=\"alert-box error\"><span>error: </span>Email đã được sử dụng!</div>"); 
		}
		if (pas != null){
			if ("1".equals(pas))
				out.println("<div class=\"alert-box error\"><span>error: </span>Mật khẩu không hợp lệ!</div>"); 
		}
		%>
	<form action="UserServlet" method="post">
		<h3><label> Tên tài khoản:&nbsp; </label></h3> <input type="text" name="username"><img src="<%=request.getContextPath()%>/images/success.png">
		<br><h3><label> Mật khẩu:&nbsp; </label></h3> <input type="password" name="password">
		<br><h3><label> Email:&nbsp; </label></h3> <input type="text" name="email">		
		<br><h3><label> Họ & tên:&nbsp; </label></h3> <input type="text" name="fullname">
		<br><h3><label> Sinh nhật:&nbsp; </label></h3> <input type="text" name="birthday">
		<br><h3><label> Quê quán:&nbsp; </label></h3> <input type="text" name="country">
		 <br> <label>&nbsp; </label> 
		
		<input type="hidden" value="register" name="command">
		<center><input type="submit" value="Đăng ký" name="submit"></center>
	</form>
	</div>
</body>
</html>