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
<%
	Cookie[] listCookie = request.getCookies();
	boolean login = false;
	String userName = "";
	if(listCookie != null)							
		for(int k = 0; k < listCookie.length; k++){
			if(listCookie[k].getName().equals("username")){	// đã đăng nhập
				userName = listCookie[k].getValue();	// lưu lại username
				login = true;
				break;
			}
		}
	if (!login)	// chưa đăng nhập
		response.sendRedirect("./login.jsp");
%>
<% 
	String sent = request.getParameter("sent");
	if("1".equals(sent)) {
		out.println("<div class=\"alert-box success\">Ý kiến đóng góp đã được gửi!</div>");
	}
%>
<form action="CommentServlet" method="post">
Tiêu đề: <br><input type="text" name="title"><br>
Nội dung: <br><textarea rows="3" cols="70" name="content"></textarea><br><br>
<input type="submit" value="Gửi"><input type="reset" value="Làm mới" /><br><br>
<button onclick="location='./index.jsp'">Quay lại</button>
</form>
</body>
</html>