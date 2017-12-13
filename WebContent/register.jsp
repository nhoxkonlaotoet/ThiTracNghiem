<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>

	<div class="container">
		<div class="content_wrapper">
			<div id="header-wrapper"></div>
			<section class="main_body">
			<div class="site-width">
				<article class="site_login"> <header
					style="text-align: center">
				<h1>Đăng kí</h1>

				</header> <c:if test="${ Acc eq '0' }">
					<div class="alert-box error">
						<span>error: </span>Bạn chưa điền tên tài khoản!
					</div>
				</c:if> <c:if test="${ Acc eq '1' }">
					<div class="alert-box error">
						<span>error: </span>Tài khoản đã được sử dụng!
					</div>
				</c:if> <c:if test="${ Acc eq '2' }">
					<div class="alert-box success">
						Đăng ký thành công! Click vào <a href="./login.jsp"><b>đây</b></a>
						để đăng nhập.
					</div>
				</c:if> <c:if test="${ Ema eq '0' }">
					<div class="alert-box error">
						<span>error: </span>Bạn chưa điền email!
					</div>
				</c:if> <c:if test="${ Ema eq '1' }">
					<div class="alert-box error">
						<span>error: </span>Email đã được sử dụng!
					</div>
				</c:if> <c:if test="${ Pas eq '1' }">
					<div class="alert-box error">
						<span>error: </span>Mật khẩu không hợp lệ!
					</div>
				</c:if>

				<form action="UserServlet" method="post">
					<h3>
						<label> Tên tài khoản:&nbsp; </label>
					</h3>
					<input type="text" placeholder="Tài khoản" name="username" value="${ username }"> <br>
					<h3>
						<label> Mật khẩu:&nbsp; </label>
					</h3>
					<input type="password"  placeholder="Mật khẩu" name="password" value="${ password }">
					<br>
					<h3>
						<label> Email:&nbsp; </label>
					</h3>
					<input type="text"  placeholder="Email" name="email" value="${ email }"> <br>
					<h3>
						<label> Họ & tên:&nbsp; </label>
					</h3>
					<input type="text"  placeholder="Họ tên" name="fullname" value="${ fullname }"> <br>
					<h3>
						<label> Sinh nhật:&nbsp; </label>
					</h3>
					<input type="text"  placeholder="Ngày sinh"birthday" value="${ birthday }"> <br>
					<h3> 
						<label>  Quê quán:&nbsp; </label>
					</h3>
					<input type="text"  placeholder="Nơi sinh" name="country" value="${ country }"> <br>
					<label>&nbsp; </label> <input type="hidden" value="register"
						name="command">
					<center>
						<input type="submit" value="Đăng ký" name="submit">
					</center>
				</form>
				</article>
			</div>
			</section>
		</div>
	</div>
</body>
<jsp:include page="./footer.jsp"></jsp:include>
</html>