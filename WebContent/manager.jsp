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


  <div class="container">
        <div style="margin-top: 50px; margin-bottom: 50px;">
            <div class="row ">    
            <div class="col-sm-3" style="text-align: center">
                <a href="ManageAccount">
                            <div>
                                <img alt="" src="images/446_315.jpg" style="width: 280px;height: 250px;background-size: cover">
                            </div>
                            <h5>Quản lí tài khoản</h5>
                        </a>
            </div>
            
            <div class="col-sm-3" style="text-align: center">
                <a href="ManageExam">
                            <div>
                                <img alt="" src="images/446_315.jpg" style="width: 280px;height: 250px;background-size: cover">
                            </div>
                            <h5>Quản lí bài thi</h5>
                        </a>
            </div>
                <div class="col-sm-3" style="text-align: center">
                <a href="ManageQuestion">
                            <div>
                                <img alt="" src="images/446_315.jpg" style="width: 280px;height: 250px;background-size: cover">
                            </div>
                            <h5>Ngân hàng câu hỏi</h5>
                        </a>
            </div> 
                <div class="col-sm-3" style="text-align: center">
                <a href="ManageComment">
                            <div>
                                <img alt="" src="images/446_315.jpg" style="width: 280px;height: 250px;background-size: cover">
                            </div>
                            <h5>Danh sách góp ý</h5>
                        </a>
            </div>
        </div>
        </div>
    <button onclick="location='./index.jsp'">Quay lại</button>
    </div>


</body>
   <jsp:include page="./footer.jsp"></jsp:include>  
</html>
