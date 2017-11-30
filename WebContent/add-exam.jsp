<%@page import="java.util.ArrayList"%>
<%@page import="model.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<title>Thêm đề thi</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<br>
<form action="ManageExam" method="post">
<table>
<%
String err = (String)request.getAttribute("success");
	if ("1".equals(err)) {
		out.println("<tr><td><center><div class=\"alert-box success\"><span></span>Thêm đề thi thành công!</div></center></td></tr>"); 
	}
%>
<tr><td>Tên môn:</td>
<td>
<%
	ArrayList<Subject> listSubject = (ArrayList<Subject>)request.getAttribute("listSubject");
	String subjectName = (String)request.getAttribute("subjectName");
	int subjectID = -1;
	if (listSubject != null && listSubject.size() > 0){
		out.print("<select name='subjectName'>");
		if(subjectName != null && !subjectName.equals("")){	// đã chọn 1 môn
			for (Subject s : listSubject){
				if (s.getSubjectName().equals(subjectName)){
					subjectID = s.getSubjectID();
					out.print("<option selected='selected'>"+ s.getSubjectName() +"</option>");
				}
				else 
					out.print("<option>"+ s.getSubjectName() +"</option>");
			}
		}
		else{
			out.print("<option>Chọn môn học</option>");
			for (Subject s : listSubject){
				out.print("<option>"+ s.getSubjectName() +"</option>");
			}
		}
		out.print("</select>");
		if(subjectID != -1)	// có môn chọn
			out.print("<input type='hidden' name='subjectID' value='"+ subjectID +"'>");
	}
	else
		out.print("Chưa có môn học nào. Vui lòng thêm môn học trước!");
	String titleName = (String)request.getAttribute("titleName");
	if (titleName.equals(null))
		titleName = "";
	String schoolYear = (String)request.getAttribute("schoolYear");
	if (schoolYear.equals(null))
		schoolYear = "";
	String time = (String)request.getAttribute("time");
	if (time.equals(null))
		time = "";
%>
</td></tr>
<tr><td>Tên đề:</td><td><input type="text" name="titleName" value='<%=titleName%>'></td></tr>
<%
	if ("0".equals(err)) {
		out.println("<tr><td><center><div class=\"alert-box error\"><span>error: </span>Tên đề thi đã tồn tại!</div></center></td></tr>"); 
	}
%>

<tr><td>Năm học:</td><td><input type="text" name="schoolYear" value='<%=schoolYear%>'></td></tr>
<tr><td>Thời gian làm bài:</td><td><input type="text" name="time" value='<%=time%>'></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>Câu hỏi và đáp án:</td></tr>
<tr><td>Số câu hỏi: </td><td><input type="text" name="numberOfQuestion" value='<%=(int)request.getAttribute("numberOfQuestion") %>'></td><td><input type="submit" name="commandA" value="Xác nhận"></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>Nội dung:</td></tr>
<% 
	int num = (int)request.getAttribute("numberOfQuestion");	// số câu hỏi
	if(num > 0){
		for (int i = 1; i <= num; i++){
			out.print("<tr><td>Câu hỏi "+ i +": </td><td><input type='text' name='question"+ i +"'></td></tr>"
				+ "<tr><td>Đáp án A: </td><td><input type='text' name='answerA"+ i +"'></td></tr>"
				+ "<tr><td>Đáp án B: </td><td><input type='text' name='answerB"+ i +"'></td></tr>"
				+ "<tr><td>Đáp án C: </td><td><input type='text' name='answerC"+ i +"'></td></tr>"
				+ "<tr><td>Đáp án D: </td><td><input type='text' name='answerD"+ i +"'></td></tr>"
				+ "<tr><td>Đáp án đúng: </td><td><select name='correctAnswer"+ i +"'>"
				+ "<option value='A'>A</option><option value='B'>B</option><option value='C'>C</option><option value='D'>D</option>"
				+ "</select></td></tr><tr><td>&nbsp;</td></tr>");
		}
	}
	else
		out.print("<tr><td> Chưa nhập số câu hỏi! </td><td>");
%>
<tr><td><input type="submit" name="commandA" value="Thêm"></td></tr>
</table>
</form>
</body>
</html>