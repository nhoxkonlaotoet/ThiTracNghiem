<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

 <meta content="text/html; charset=UTF-8">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" media="all" href="css2/login.css" debug="false">
    <link rel="stylesheet" type="text/css" href="css2/home.css">
    <link rel="stylesheet" href="css/menu.css" type="text/css">
<div class="container"> 
	<div id="header-top" style="background-image:  url(image-home/Back-To-School.jpg); width: 100%;height: 300px; background-size: cover">
		<div class="header-login">
			<p class="p-login">

			<%
			Cookie[] listCookie = request.getCookies();
				if(listCookie != null){				
					boolean f = false;
					String username = "";
					for(int i = 0; i < listCookie.length; i++){
						if(listCookie[i].getName().equals("username")){
							username = listCookie[i].getValue();
							f = true;
							break; 
						}
					} 
					if (f){
						out.println(" <font color=\"white\"> Chào, </font> <font color=\"blue\" size=\"5\">"+ username + "</font><br>");
						out.println("<a class=\"lnk-logout under popup-login\" rel=\"#overlay-login\"><a href=\"./LoginController?login=0\"></>Đăng xuất</a></a>");
					}
					else{
						out.println("<a class=\"lnk-logout under popup-login\" rel=\"#overlay-login\"><a href=\"./login.jsp\"></>Đăng nhập</a></a> &nbsp;|&nbsp; <a class=\"lnk-user under\"><a href=\"./register.jsp\"></>Đăng ký </a></a>");
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
            <a class="lnk-hm-home menu_active" href="./index.jsp"></a>
            <ul class="ul-menu-header">
                <li class="li-menu-header"><a href="ExamServlet" class="lnk-menu-header">THI TRẮC NGHIỆM</a>
                </li>
                <li class="li-menu-header"><a href="search.jsp" class="lnk-menu-header ">TRA CỨU</a>
                </li>
                <li class="li-menu-header"><a href="help.jsp" class="lnk-menu-header ">HƯỚNG DẪN</a>
                </li>
                <li class="li-menu-header"><a href="comment.jsp" class="lnk-menu-header ">ĐÓNG GÓP Ý KIẾN</a>
                </li>
                <li class="li-menu-header"><a href="HistoryServlet" class="lnk-menu-header ">LỊCH SỬ THI</a>
                </li>
                <li class="li-menu-header"><a href="InformationServlet" class="lnk-menu-header ">TRANG CÁ NHÂN</a>
               <% 
 	if(listCookie != null) 
 		for (int i = 0; i < listCookie.length; i++) 
 			if (listCookie[i].getName().equals("role")) 
 				if(listCookie[i].getValue().equals("manager") || listCookie[i].getValue().equals("admin"))
 					out.print("<li class=\"li-menu-header\"><a href=\"manager.jsp\" class=\"lnk-menu-header\"><font color=\"yellow\">QUẢN LÍ</font></a></li>");     
 		
 %>
            </ul>
        </div>
    </div>

	</ul>							
	</div>
</div>  
</html>