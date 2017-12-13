<%@page import="model.Title"%>
<%@page import="model.Subject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript">
            function validateForm()
            {
            	if(confirm("Việc xóa môn học sẽ làm mất tất cả các đề thi liên quan?") == true){
                    return true;
                }
            	else{
                    return false;
                }
            }
        </script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
<br><center>

<%
	String err = (String)request.getAttribute("err");
	if (err != null && !err.equals(""))	// có lỗi xảy ra
		if (err.equals("1")){
			out.print("<script type=\"text/javascript\"> alert('Thao tác xóa không thành công! Vui lòng chọn 1 môn học'); </script>");
		} 
	String success = (String)request.getAttribute("success");
	if (success != null && !success.equals(""))
		if (success.equals("1")){
			out.print("<script type=\"text/javascript\"> alert('Xóa môn học thành công!'); </script>");
		} 
%>
 <h3>Môn học</h3>
<%
	ArrayList<Subject> listSubject = (ArrayList<Subject>)request.getAttribute("listSubject");
	String commandS = (String)request.getAttribute("commandS");	
	String subject = (String)request.getAttribute("sub");	// môn học chọn
	String editSubject = (String)request.getAttribute("editSubject");	// tên môn học sửa
	//int subjectIDSelected = -1;
	String subjectSelected = "";
	if(listSubject != null && listSubject.size() > 0){
		out.print("<form action='ManageExam' method='post'>");
		out.print("<select onchange='location=options[selectedIndex].value;'>");
		if(subject == null){
			subjectSelected = "Tất cả";
			out.print("<option selected='selected' value='ManageExam'>Tất cả</option>");
			for(int i = 0; i < listSubject.size(); i++)
					out.print("<option value=ManageExam?sub="+ i +">"+ listSubject.get(i).getSubjectName() +"</option>");	
			out.print("</select>");			
		}
		else { // subject != null
			out.print("<option value='ManageExam'>Tất cả</option>");
			for(int i = 0; i < listSubject.size(); i++){
					if(subject.equals(Integer.toString(i))){
						subjectSelected = listSubject.get(i).getSubjectName();
						out.print("<option selected='selected' value=ManageExam?sub="+ i +">"+ listSubject.get(i).getSubjectName() +"</option>");
					}
					else
						out.print("<option value=ManageExam?sub="+ i +">"+ listSubject.get(i).getSubjectName() +"</option>");
			}
			out.print("</select>");
			for(int j = 0; j < listSubject.size(); j++){
				if(subject.equals(Integer.toString(j))){
					//subjectSelected = listSubject.get(j).getSubjectID();
					out.print("<input type='hidden' name='subjectSelected' value='"+ listSubject.get(j).getSubjectName() +"'>");	// lưu lại tên môn chọn
					break;
				}
			}
		}
	}
	if (commandS == null || (!commandS.equals("Thêm") && !commandS.equals("Sửa"))){
		out.print("<input class=\"btn btn-default btn-lg\" type='submit' value='Thêm' name='commandS'><input  class=\"btn btn-default btn-lg\" type='submit' value='Sửa' name='commandS'></form>"
				+ "<form action'ManageExam' method='post' onsubmit='return validateForm()'>"
				+ "<input  type='hidden' name='subjectDelete' value='"+ subjectSelected +"'>"
				+ "<input class=\"btn btn-default btn-lg\" type='submit' value='Xóa' name='commandS'></form>");
	}
	if (commandS != null){	
		if (commandS.equals("Thêm"))
			out.print("<label>Tên môn:</label><input type='text' name='subjectName'><input type='submit' name='commandS' value='Thêm môn học'>");
		if (commandS.equals("Sửa"))
			out.print("<label>Tên môn mới:</label><input type='hidden' name='oldSubjectName' value='"+ editSubject +"'>"
				+ "<input type='text' name='newSubjectName' value='"+ editSubject +"'><input type='submit' name='commandS' value='Sửa môn học'>");
		out.print("</form>");
	}
%>
</center>
<center>

<table border="1" bordercolor="blue" width="60%" id="myTable1" class="table table-striped table-bordered">
<caption><h3>Danh sách đề thi</h3></caption>
<tr><td align="center">Tên môn</td>
<td align="center">Mã đề</td>
<td align="center">Năm học</td>
<td align="center">Thời gian làm bài(phút)</td></tr>
<%
	ArrayList<Title> listTitle = (ArrayList<Title>)request.getAttribute("listTitle");
	if(listTitle != null && listTitle.size() > 0){
		for(Title title : listTitle){
			out.print("<form action='ManageExam' method='post'>");
			out.print("<tr><td>"+ title.getSubjectName() +"</td>"
					+ "<td>"+ title.getTitleName() +"</td>"
					+ "<td>"+ title.getSchoolYear() +"</td>"
					+ "<td>"+ title.getTime() +"</td>"
					+ "<input type='hidden' name='titleID' value='"+title.getTitleID()+"'>"
					+ "<td align='center'><input type='submit' name='commandT' value='Xóa'></td></tr>");
			out.print("</form>");  
		}
	}
	else
		out.print("<tr><td colspan='4'>Không có đề thi</td></tr>");
%>
</table>
<br>
<form action="ManageExam" method="post">
<input class="btn btn-default btn-lg"type="submit" name="commandT" value="Thêm đề thi"><br><br>
</form>
</center>     

</div></div>
</body>
<jsp:include page="./footer.jsp"></jsp:include>
</html>