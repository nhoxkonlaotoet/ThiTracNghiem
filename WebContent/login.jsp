<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<title>Đăng nhập</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>


	<div class="container">
		<div class="content_wrapper">
			<div id="header-wrapper"></div>
			<section class="main_body">
			<div class="site-width">
				<article class="site_login"> <br>

				<br>
				<h1>Đăng nhập</h1>
				<c:if test="${ err eq '1' }">
					<center>
						<div class="alert-box error">
							<span>error: </span>Tên tài khoản hoặc mật khẩu chưa chính xác!
						</div>
					</center>
				</c:if>
				<form action="UserServlet" method="post"
					class="new_new_session ng-pristine ng-invalid ng-invalid-required">
					<h3>
						<label> Tài khoản:&nbsp; </label>
					</h3>
					<input type="text" name="username" value="${ username }" class="ng-invalid ng-touched">
					<br>
					<h3>
						<label> Mật khẩu:&nbsp; </label>
					</h3>
					<input type="password" class="ng-untouched ng-invalid "
						name="password"> <br> <label>&nbsp; </label> <input
						type="hidden" value="login" name="command">
					<center>
						<button type="submit" value="Đăng nhập" name="submit">
							Đăng nhập</button>
					</center>
				</form>
				<footer>
				<p class="join-member">
					<span>Bạn chưa có tài khoản? </span><span><a
						href="register.jsp">Đăng kí</a></span>
				</p>
				</footer> </article>
			</div>
			</section>
		</div>
		<footer class="minimal_footer container" class="" id="footer">
		<p class="copyright">
			©2017 Web Developer. <span>This's a new design for Junior UTE.</span>
		</p>
		</footer>
	</div>
</body>
</html>