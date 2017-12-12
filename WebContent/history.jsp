<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=UTF-8">

<title>Lịch sử thi</title>
	 <jsp:include page="header.jsp"/>
 
 
  		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css">
        <!-- jQuery library -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <!-- Latest compiled JavaScript -->
       
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
        
        
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script>
       
        <script type="text/javascript">
        $(document).ready(function(){
            $('#myTable1').dataTable();
        })
        </script>
</head>
<body>

	<%
		Cookie[] listCookie = request.getCookies();
		boolean login = false;
		String userName = "";
		if (listCookie != null)
			for (int k = 0; k < listCookie.length; k++) {
				if (listCookie[k].getName().equals("username")) { // đã đăng nhập
					userName = listCookie[k].getValue(); // lưu lại username
					login = true; 
					break; 
				}
			}
		if (!login) // chưa đăng nhập
			response.sendRedirect("./login.jsp");
	%>
	<div class="container">
		<!--table-->
		<table id="myTable1" class="table table-striped table-bordered"
			cellspacing="0" width="100%">
			<thead>
				<tr> 
					<th>Môn thi</th>
					<th>Năm học</th>
					<th>Tên đề</th>
					<th>Điểm</th>
					<th>Thời gian</th>
					<th>Thao tác</th>
				</tr>
			</thead>

			<c:forEach items="${listResult}" var="result">
				<tr>
					<td>${result.subjectName}</td>
					<td>${result.schoolYear}</td>
					<td>${result.titleName}</td>
					<td>${result.score}</td>
					<td>${result.date}</td>
					<td><a href="HistoryServlet?ResultID=${result.resultID}">Xem
							chi tiết</a></td>
				</tr>
			</c:forEach>

		</table>
		<br>
		<button onclick="location='./index.jsp'">Quay lại</button>
	</div>
	
	
	
	
</body>
</html>