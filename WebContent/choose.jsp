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
<%-- <script type="text/javascript">
	function getTitle(){
		var message = document.getElementById('show_message');
		message.innerHTML = "á à ả";
	
	}
</script>

	<p style="color: red" id="show_message"></p>
--%>
	<jsp:include page="header.jsp"></jsp:include>
	<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<%	
		List<Subject> listSubject = (List<Subject>)request.getAttribute("listSubject"); // lấy danh sách đề thi		
		List<String> listSchoolYear = (List<String>)request.getAttribute("listSchoolYear"); // lấy danh sách đề thi	
		List<String> listTitle = (List<String>)request.getAttribute("listTitle"); // lấy danh sách đề thi		
	%>
	<div class="container"> 
	<form action="ExamServlet" method="post">
	<span><h3>Môn học:</h3> </span>
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
		<span><h3>Năm học:</h3> </span> 
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
			<span><h3>Đề thi:</h3> </span>
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
		<center><input class="btn btn-default btn-lg" type="submit" value="Bắt đầu làm bài" name="submit" style="margin-top:20px;margin-bottom:20px"></center>
	</form>
	</div>
</body>
</html>