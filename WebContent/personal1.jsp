<%@page import="model.Information"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <?xml version="1.0" encoding="UTF-8"?>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Personal</title>
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
<div class="container"> <div style="margin: 20px 0px">
<c:if test="${ not empty info}">
	<div class= "row "> 
		<div class= "col-sm-2 ">
			Họ tên: 
		</div>
		<c:if test="${ empty changename }">
			<c:if test="${ changename eq '1' }">
				<div class= "col-sm-10  ">
					<form class= "col-sm-10 " action= "InformationServlet " method= "post ">
						<div class="col-sm-8">
							<input type= "text " name= "name " value= "${info.getFullname()}">
							<input type= "hidden " value= "ooo " name= "type ">
							<input type= "hidden " value= ""+ info.getUsername() +" " name= "username ">						
							<input type= "hidden " value= "changename " name= "change ">
						</div>
						<div class="col-sm-2">
							<input class= "btn btn-default btn-sm " type= "submit " value= "Đồng ý ">
						</div>
					</form>
				</div>
			</c:if>
		</c:if>
		<c:if test="${ not empty changename }">
		<div class= "col-sm-10 ">
					<form class= "col-sm-10" action= "InformationServlet " method= "post ">
						<div class="col-sm-8">
							${info.getFullname()}
							<input type= "hidden " value= "name " name= "type ">
						</div>
						<div class="col-sm-2">
							<input class= "btn btn-default btn-sm " type= "submit " value= "Thay đổi ">
						</div>
					</form>
				</div>
		</c:if>
		
		<div class="col-sm-2">
			Chức vụ :
		</div>
		<div class="col-sm-10">
			${info.getRole() }
		</div>
		
		<c:if test="${ not empty changepassword }">
			<c:if test="${ changepassword eq '1' }">
				<div class=  "col-sm-10   ">
					<form  class= "col-sm-10 "  action=  "InformationServlet  " method=  "post  ">
					<div class="col-sm-8">
						<input type=  "password  " name=  "password  " value=  "${ info.getPassword()} "">
						<input type=  "hidden  " value=  "ooo  " name=  "type  ">
						<input type=  "hidden  " value=  "${info.getUsername()  }" name=  "username  ">
						<input type=  "hidden  " value=  "changepassword  " name=  "change  ">
					</div>
					<div class="col-sm-2">
						<input class=  "btn btn-default btn-sm  " type=  "submit  " value=  "Đồng ý  ">
					</div>
					</form>
				</div>
			</c:if>
		</c:if>
		<c:if test="${ empty changepassword }">
			<div class= "col-sm-10 ">
					<form action= "InformationServlet " method= "post ">
					<div class="col-sm-8">
						***********
						<input type= "hidden " value= "password " name= "type ">
					</div>
					<div class="col-sm-2">
						<input class= "btn btn-default btn-sm " type= "submit " value= "Thay đổi ">
					</div>
					</form>
					
				</div>
		</c:if>
		
		<div class="col-sm-2">
			Email :
		</div>
		<div class="col-sm-10">
			${info.getEmail() }
		</div>
		
		<c:if test="${ not empty changecountry }">
			<c:if test="${ changecountry eq '1' }">
				<div class= "col-sm-10  ">
					<form class= "col-sm-10 "  action= "InformationServlet " method= "post ">
						<div class="col-sm-8">
							<input type= "text " name= "country " value= "${ info.getCountry()}">
							<input type= "hidden " value= "ooo " name= "type ">
							<input type= "hidden " value= "${ info.getUsername() } " name= "username ">
							<input type= "hidden " value= "changecountry " name= "change ">
						</div>
						<div class="col-sm-2">
							<input class= "btn btn-default btn-sm " type= "submit " value= "Đồng ý ">
						</div>
					</form> 
				</div>       
			</c:if>
		</c:if>
		<c:if test="${ empty changecountry }">
			<div class= "col-sm-10 ">
					<form action= "InformationServlet " method= "post ">
					<div class="col-sm-8">
						${info.getCountry()}
						<input type= "hidden " value= "country " name= "type ">
					</div>
					<div class="col-sm-2">
						<input class= "btn btn-default btn-sm " type= "submit " value= "Thay đổi ">
					</div>
					</form>
					
				</div>
		</c:if>
	</div>
</c:if>

<%
	/* request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	//request.getCharacterEncoding();
	Information info = (Information)request.getAttribute("info");
	String isChangeName = (String)request.getAttribute("changename");
	String isChangePassword = (String)request.getAttribute("changepassword");
	String isChangeCountry = (String)request.getAttribute("changecountry");
	out.println("<div class=\"container\"> <div style=\"margin: 20px 0px\">");
	if (info != null){
		out.println("<div class=\"row\"> <div class=\"col-sm-2\">Họ tên: </div><div class=\"col-sm-8\"> "+ info.getFullname() + "</div>");	
		if(isChangeName != null){	// đã ấn change
			if(isChangeName.equals("1")){	// Name being changed				
				out.println("<div class=\"col-sm-12 \"><form class=\"col-sm-12\" action=\"InformationServlet\" method=\"post\"><input type=\"text\" name=\"name\" value=\""+ info.getFullname() +
				"\"><input type=\"hidden\" value=\"ooo\" name=\"type\"><input type=\"hidden\" value=\""+ info.getUsername() +"\" name=\"username\"><input type=\"hidden\" value=\"changename\" name=\"change\"><input class=\"btn btn-default btn-sm\" type=\"submit\" value=\"Đồng ý\"></form></div>");
			}   
		}
		else	//chưa ấn change
			out.println("<div class=\"col-sm-2 \"><form action=\"InformationServlet\" method=\"post\"><input type=\"hidden\" value=\"name\" name=\"type\"><input class=\"btn btn-default btn-sm\" type=\"submit\" value=\"Thay đổi\"></form></div>");
		out.println("<div class=\"col-sm-2\">Chức vụ: </div><div class=\"col-sm-10\"> " + info.getRole() + "</div>");
		out.println("<div class=\"col-sm-2\">Mật khẩu: </div><div class=\"col-sm-8\"> ****** </div>");	
		if(isChangePassword != null){	// đã ấn change
			if(isChangePassword.equals("1")){	// Password being changed
				out.println("<div class=\"col-sm-12 \"><form action=\"InformationServlet\" method=\"post\"><input type=\"password\" name=\"password\" value=\""+ info.getPassword() +
				"\"><input type=\"hidden\" value=\"ooo\" name=\"type\"><input type=\"hidden\" value=\""+ info.getUsername() +"\" name=\"username\"><input type=\"hidden\" value=\"changepassword\" name=\"change\"><input class=\"btn btn-default btn-sm\" type=\"submit\" value=\"Đồng ý\"></form></div>");
			}
		}
		else	//chưa ấn change
			out.println("<div class=\"col-sm-2 \"><form action=\"InformationServlet\" method=\"post\"><input type=\"hidden\" value=\"password\" name=\"type\"><input class=\"btn btn-default btn-sm\" type=\"submit\" value=\"Thay đổi\"></form></div>");
		
		out.println("<div class=\"col-sm-2\">Email: </div><div class=\"col-sm-10\">"+ info.getEmail() + "</div>");	
		
		out.println("<div class=\"col-sm-2\">Quê quán: </div><div class=\"col-sm-8\">"+ info.getCountry()+ "</div>");	
		if(isChangeCountry != null){	// đã ấn change
			if(isChangeCountry.equals("1")){	// Country being changed
				out.println("<div class=\"col-sm-12 \"><form action=\"InformationServlet\" method=\"post\"><input type=\"text\" name=\"country\" value=\""+ info.getCountry() +
				"\"><input type=\"hidden\" value=\"ooo\" name=\"type\"><input type=\"hidden\" value=\""+ info.getUsername() +"\" name=\"username\"><input type=\"hidden\" value=\"changecountry\" name=\"change\"><input class=\"btn btn-default btn-sm\" type=\"submit\" value=\"Đồng ý\"></form> </div>          </div>");
			}
		}
		else	//chưa ấn change
			out.println("<div class=\"col-sm-2 \"><form action=\"InformationServlet\" method=\"post\"><input type=\"hidden\" value=\"country\" name=\"type\"><input class=\"btn btn-default btn-sm\" type=\"submit\" value=\"Thay đổi\"></form><div>           </div>");
	}
	else
		out.print("Vui lòng đăng nhập! </div>"); */
%>
   
</body>

</html>