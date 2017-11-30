<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="./css/common.css" type="text/css">
<title>Website thi trắc nghiệm online</title>
<div id="header">
	<div id="header-top">
		<div class="header-login">
			<p class="p-login">

			<%
			Cookie[] listCookie = request.getCookies();
				if(listCookie != null){								
					for(int i = 0; i < listCookie.length; i++){
						if(listCookie[i].getName().equals("username")){
							out.println("Chào, <font color=\"blue\" size=\"5\">"+ listCookie[i].getValue() + "</font><br>");
							out.println("<a class=\"lnk-logout under popup-login\" rel=\"#overlay-login\"><a href=\"./LoginController?login=0\"></>Đăng xuất</a></a>");
							break;
						}
						else{
							out.println("<a class=\"lnk-logout under popup-login\" rel=\"#overlay-login\"><a href=\"./login.jsp\"></>Đăng nhập</a></a> &nbsp;|&nbsp; <a class=\"lnk-user under\"><a href=\"./register.jsp\"></>Đăng ký </a></a>");
						}
					}
				}
				else{
					out.println("<a class=\"lnk-logout under popup-login\" rel=\"#overlay-login\"><a href=\"./login.jsp\"></>Đăng nhập</a></a> &nbsp;|&nbsp; <a class=\"lnk-user under\"><a href=\"./register.jsp\"></>Đăng ký </a></a>");
				}
			%>

								
			</p>
		</div>
	</div>
	<div id="header-menu" style="background: rgb(0, 183, 178);">
		<a class="lnk-hm-home menu_active"
			href="./index.jsp"></a>
		<ul class="ul-menu-header">
			<li class="li-menu-header"><a href="ExamServlet" class="lnk-menu-header">THI TRẮC NGHIỆM</a></li>
			<li class="li-menu-header"><a href= "SearchServlet" class="lnk-menu-header ">TRA CỨU</a></li>
			<li class="li-menu-header"><a href="help.jsp" class="lnk-menu-header ">HƯỚNG DẪN</a></li>
			<li class="li-menu-header"><a href="comment.jsp" class="lnk-menu-header ">ĐÓNG GÓP Ý KIẾN</a></li>
			<li class="li-menu-header"><a href="HistoryServlet" class="lnk-menu-header ">LỊCH SỬ THI</a></li>	
			<li class="li-menu-header"><a href="InformationServlet" class="lnk-menu-header ">TRANG CÁ NHÂN</a></li> 
<%
 	if(listCookie != null) {
 		for (int i = 0; i < listCookie.length; i++) {
 			if (listCookie[i].getName().equals("role")) {
 				if(listCookie[i].getValue().equals("manager") || listCookie[i].getValue().equals("admin")){
 					out.print("<li class=\"li-menu-header\"><a href=\"manager.jsp\" class=\"lnk-menu-header\"><font color=\"yellow\">MANAGER</font></a></li>");
 				}
 			}
 		}
 	}
 %>
	</ul>							
	</div>
</div>
</html>