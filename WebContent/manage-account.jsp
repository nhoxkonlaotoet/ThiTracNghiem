<%@page import="java.util.ArrayList"%>
<%@ page import="model.Account" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
   <div class="container">
        <div style="margin-top: 50px; margin-bottom: 50px;">
<%
	Cookie[] listCookie = request.getCookies();
	String role = "manager";
	if (listCookie != null){
		for (Cookie c : listCookie){
			if (c.getName().equals("role"))
				role = c.getValue();
		}
		if (role.equals("member"))
			response.sendRedirect("index.jsp");		
	}
%>
<center>
<table border="1" bordercolor="green" width="80%" height="80" class="table table-striped table-bordered" cellspacing="0" width="100%">
<caption><h3>Danh sách tài khoản</h3></caption>
<tr>
<td align="center">Tên tài khoản</td>
<td align="center">Cấp bậc</td>
<td align="center">Email</td>
<td align="center">Họ & tên</td>
<td align="center">Tình trạng</td>
<td align="center">Thao tác</td>
<% 	if (role.equals("admin")) out.print("<td align=\"center\">Cấp bậc</td><td align=\"center\">Thông tin</td>");
	else out.print("<td></td>");%>
</tr>
<% //<input type=\"button\" value=\"Khóa\" class=\"button\" onclick=\"location.href='index.jsp'\">
	ArrayList<Account> listAccount = (ArrayList<Account>)request.getAttribute("listAccount");
	String isChanging = (String)request.getAttribute("username");	// chuỗi lưu Username đang thay đổi
	
	if (listAccount != null || listAccount.size() == 0){
		for (Account a : listAccount){	
			out.print("<form action=\"ManageAccount\" method=\"post\">");
			
			if (isChanging != null && !isChanging.trim().equals("")){	// có user đang thay đổi
				out.print("<input type=\"hidden\" name=\"username\" value=\""+ a.getUsername() +"\">");
				if (a.getUsername().equals(isChanging)){	// hàng của User đang thay đổi thông tin
					out.print("<tr><td>"+ a.getUsername() +"</td>"
							+ "<td>"	+ a.getRole() +"</td>"
							+ "<td><input type=\"text\" name=\"newemail\" value=\""+ a.getEmail() +"\"</td>"
							+ "<td><input type=\"text\" name=\"newfullname\" value=\""+ a.getFullname() +"\"</td>");
					if (a.getRole().equals("admin"))
						out.print("<td align=\"center\">Hoạt động</td><td></td>");
					else {
						if(a.isStatus())
							out.print("<td align=\"center\">Hoạt động</td>");
						else
							out.print("<td align=\"center\">Bị khóa</td>");
						out.print("<td></td>");
					}
					if (role.equals("admin"))
						out.print("<td></td><td><center><input type=\"submit\" name=\"command\" value=\"Xác nhận\">&nbsp;"
								+ "<input type=\"submit\" name=\"command\" value=\"Hủy\"></td></center></tr>");
					else
						out.print("<td><center><input type=\"submit\" name=\"command\" value=\"Xác nhận\">&nbsp;"
								+ "<input type=\"submit\" name=\"command\" value=\"Hủy\"></td></center></tr>");
				}
				else {	// các hàng còn lại
					out.print("<tr><td>"+ a.getUsername() +"</td><td>"+ a.getRole() +"</td><td>"+ a.getEmail() +"</td><td>"+ a.getFullname() +"</td>");								
						if (a.isStatus())
							if (a.getRole().equals("admin"))
								out.print("<td align=\"center\">Hoạt động</td><td></td>");
							else
								out.print("<td align=\"center\">Hoạt động</td><td><center>"
								+ "<input type=\"submit\" name=\"command\" value=\"Khóa\"></center></td>");
						else
							out.print("<td align=\"center\"><strike>Hoạt động</strike></td><td><center>"
							+ "<input type=\"submit\" name=\"command\" value=\"Mở khóa\"></center></td>");					
					if (role.equals("admin")) {	// admin có thể thay đổi phân quyền, thay đổi thông tin
						if (a.getRole().equals("admin"))
							out.print("<td></td>");
						if (a.getRole().equals("manager"))
							out.print("<td><center><input type=\"submit\" name=\"command\" value=\"-\"></center></td>");
						if (a.getRole().equals("member"))
							out.print("<td><center><input type=\"submit\" name=\"command\" value=\"+\"></center></td>");
						out.print("<td><center><input type=\"submit\" name=\"command\" value=\"Thay đổi\"></center></td></tr>");
					}
					if (role.equals("manager")) {	// manager chỉ được thay đổi thông tin
						if (a.getRole().equals("admin"))
							out.print("<td></td>");
						else
							out.print("<td><center><input type=\"submit\" name=\"command\" value=\"Thay đổi\"></center></td></tr>");
					}
				}
			}	
			
			else {	// không có hàng nào đang thay đổi
				out.print("<form action=\"ManageAccount\" method=\"post\">");
				out.print("<input type=\"hidden\" name=\"username\" value=\""+ a.getUsername() +"\">");
				out.print("<tr><td>"+ a.getUsername() +"</td><td>"+ a.getRole() +"</td><td>"+ a.getEmail() +"</td><td>"+ a.getFullname() +"</td>");
				if (a.getRole().equals("admin")){
					out.print("<td align=\"center\">Hoạt động</td>");
					if (role.equals("admin"))	// nếu không phải là admin thì sẽ ẩn cột này đi
						out.print("<td></td>");
				}
				else {
					if (a.isStatus())
						out.print("<td align=\"center\">Hoạt động</td><td><center>"
						+ "<input type=\"submit\" name=\"command\" value=\"Khóa\"></center></td>");
					else
						out.print("<td align=\"center\"><strike>Hoạt động</strike></td><td><center>"
						+ "<input type=\"submit\" name=\"command\" value=\"Mở khóa\"></center></td>");
				}
				if (role.equals("admin")) {	// admin có thể thay đổi phân quyền, thay đổi thông tin
					if (a.getRole().equals("admin"))
						out.print("<td></td>");
					if (a.getRole().equals("manager"))
						out.print("<td><center><input type=\"submit\" name=\"command\" value=\"-\"></center></td>");
					if (a.getRole().equals("member"))
						out.print("<td><center><input type=\"submit\" name=\"command\" value=\"+\"></center></td>");
					out.print("<td><center><input type=\"submit\" name=\"command\" value=\"Thay đổi\"></center></td></tr>");
				}
				if (role.equals("manager")) {	// manager chỉ được thay đổi thông tin
					if (a.getRole().equals("admin"))
						out.print("<td></td><td></td></tr>");
					else
						out.print("<td><center><input type=\"submit\" name=\"command\" value=\"Thay đổi\"></center></td></tr>");
				}
			}
			out.print("</form>");
		}
	}
%> 

</div>
</div>

</body> 
 
</html>