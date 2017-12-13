<%@page import="model.Title"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="header.jsp"></jsp:include>
 <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" media="all" href="css2/login.css" debug="false">
    <!-- thanh menu-->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/menu.css" type="text/css">
    <!--table css-->
    <link rel="stylesheet" type="text/css"  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css"  href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css">

        <!-- jQuery library -->
        <script type="text/javascript"  src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <!-- Latest compiled JavaScript -->
       
        
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
        
        
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script>
       
        <script type="text/javascript">
        $(document).ready(function(){
            $('#myTable1').dataTable();
        })
        </script>
<title>Insert title here</title>
</head>
<body>

 <div class="container" > 
        <div class="row" style="margin: 20px 0px;">
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
<div class="row" style="margin: 20px 0px;">
            <form action="SearchServlet" method="post">
                <div class="row">
                    <div class="col-sm-1">
                        Tìm theo:
                    </div>
                    <div class="col-sm-3">
                        <select name="type">
                            <option value="subject">Môn học</option>
                            <option value="title">Tên đề</option>
                            <option value="schoolyear">Năm học</option>
                        </select>
                    </div>
                    <div class="col-sm-6">
                        <input type="text" name="keyWord">
                    </div>
                    <div class="col-sm-2">
                        <input class="btn btn-default btn-lg" type="submit" value="Tìm">
                    </div>
                </div>
            </form>
        </div>


<table border="1" class="table table-striped table-bordered" cellspacing="0" width="100%"  >
<tr><td>Môn thi</td><td>Năm học</td><td>Mã đề</td><td>Thời gian làm bài</td><td>Thao tác</td></tr>
<c:forEach items="${listTitle}" var="title">
<tr>
<td>${title.subjectName}</td>
<td>${title.schoolYear}</td>
<td>${title.titleName}</td>
<td>${title.time}</td>
<td><a href="">Xem chi tiết</a></td>
<tr>
 </c:forEach>
</table>
<br>
<button onclick="location='./index.jsp'">Quay lại</button>
</center>
</div></div>
</body>
<jsp:include page="./footer.jsp"></jsp:include>
</html>