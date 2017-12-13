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
	<link rel="stylesheet" type="text/css"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<div class="container">
		<div style="margin-top: 50px; margin-bottom: 50px;">
			<%
				String sent = request.getParameter("sent");
				if ("1".equals(sent)) {
					out.println("<div class=\"alert-box success\">Ý kiến đóng góp đã được gửi!</div>");
				}
			%>
			<form action="CommentServlet" method="post">
				<div class="row">
					<div class="col-sm-3">
						<h1>Tiêu đề :</h1>
					</div>
					<div class="col-sm-12">
						<input type="text" name="title">
					</div>
					<div class="col-sm-3">
						<h1>Nội dung:</h1>
					</div>
					<div class="col-sm-12"></div>
					<br>
					<textarea rows="3" cols="70" name="content"></textarea>
				</div>
				<div class="col-sm-12 text-center" style="margin-top: 20px;">
					<input class="btn btn-default btn-lg" type="submit" value="Gửi">
					<input class="btn btn-default btn-lg" type="reset" value="Làm mới" />
			</form>
		</div>
	</div>
	<jsp:include page="./footer.jsp"></jsp:include>
</body>
</html>