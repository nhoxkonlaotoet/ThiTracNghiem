<%@page import="model.Subject"%>
<%@page import="java.util.List"%>
<%@page import="model.Title"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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
	<jsp:include page="header.jsp"></jsp:include>
	<%	
		List<Subject> listSubject = (List<Subject>)request.getAttribute("listSubject"); // lấy danh sách đề thi		
		List<String> listSchoolYear = (List<String>)request.getAttribute("listSchoolYear"); // lấy danh sách đề thi	
		List<String> listTitle = (List<String>)request.getAttribute("listTitle"); // lấy danh sách đề thi		
	%>
	<center>
	<form action="ExamServlet" method="post">
	<span>Môn học: </span>
		<select name="subjectSelection" onchange="location=options[selectedIndex].value;">
		<option disabled="disabled" selected="selected">Chọn môn thi</option>
			<%
				if (listSubject != null)
						for(Subject s : listSubject){
							if (request.getParameter("subject") != null && Integer.parseInt(request.getParameter("subject")) == s.getSubjectID())
								out.println("<option selected=\"selected\" value=\"ExamServlet?subject=" + s.getSubjectID() + "\">" + s.getSubjectName() + "</option>");
							//ex: ExamServlet?subject=physics&schoolyear=2017						
							else
								out.println("<option value=\"ExamServlet?subject=" + s.getSubjectID() + "\">" + s.getSubjectName() + "</option>");
					}
				//else
				//	out.println("<option>Chọn môn thi</option>");
			%>
		</select> 
		<span>Năm học: </span> 
		<select name="schoolyearSelection" onchange="location=options[selectedIndex].value;">
		<option disabled="disabled" selected="selected">Chọn năm học</option>
		<%
			if (listSchoolYear != null)
				for(String s : listSchoolYear){
					if (request.getParameter("schoolyear") != null && request.getParameter("schoolyear").equals(s))
						out.println("<option selected=\"selected\" value=\"ExamServlet?subject="+ request.getParameter("subject") +"&schoolyear=" + s +"\">" + s + "</option>");	
					//ex: ExamServlet?subject=physics&schoolyear=2017
					else
						out.println("<option value=\"ExamServlet?subject="+ request.getParameter("subject") +"&schoolyear=" + s +"\">" + s + "</option>");	
				}
			//else 
			//	out.println("<option>Chọn năm học</option>");
		%>
		</select>
			<span>Đề thi: </span>
			<select name="titleSelection"  onchange="location=options[selectedIndex].value;">
			<option disabled="disabled" selected="selected">Chọn đề thi</option>
				<%
			if (listTitle != null)
				for(String t : listTitle){
					if (request.getParameter("title") != null && request.getParameter("title").equals(t))
					out.println("<option selected=\"selected\" value=\"ExamServlet?subject="+ request.getParameter("subject") +"&schoolyear=" + request.getParameter("schoolyear") + "&title=" + t +"\">" + t + "</option>");
					//ex: ExamServlet?subject=physics&schoolyear=2017&title=123
					else
						out.println("<option value=\"ExamServlet?subject="+ request.getParameter("subject") +"&schoolyear=" + request.getParameter("schoolyear") + "&title=" + t +"\">" + t + "</option>");
				}
			//else 
			//	out.println("<option>Chọn đề thi</option>");
		%>
		</select>
		<input type="hidden" value="completeselection" name="command">
		<input type="submit" value="Bắt đầu làm bài" name="submit">
	</form>
	<br><button onclick="location='./index.jsp'">Quay lại</button>
	</center>
</body>
</html>