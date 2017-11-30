<%@page import="javafx.scene.control.Alert"%>
<%@page import="model.Title"%>
<%@page import="model.Answer"%>
<%@page import="model.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Subject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<title>Sửa đề thi</title>
<script language="javascript">
            function validateForm()
            {
            	if(confirm("Xác nhận thay đổi") == true){
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
<br>
<form action="ManageExam" method="post" onsubmit="return validateForm()">
<table>
<%
	ArrayList<Subject> listSubject = (ArrayList<Subject>)request.getAttribute("listSubject");
	ArrayList<Answer> listAnswer = (ArrayList<Answer>)request.getAttribute("listAnswer");
	Title title = (Title)request.getAttribute("title");
	if (title != null && listAnswer != null && listAnswer.size() > 0){
		out.print("<tr><td>Môn: </td><td><select name='newSubjectID'>");
		for (Subject s : listSubject){
			if (s.getSubjectName().equals(title.getSubjectName()))
				out.print("<option selected='selected' value='"+s.getSubjectID()+"'>"+s.getSubjectName()+"</option>");
			else
				out.print("<option value='"+s.getSubjectID()+"'>"+s.getSubjectName()+"</option>");
		}
		out.print("</select></td></tr><input type='hidden' name='titleID' value='"+title.getTitleID()+"'>");
		out.print("<tr><td>Mã đề: </td><td><input type='text' name='newTitleName' value='"+title.getTitleName()+"'></td></tr>");
		out.print("<tr><td>Năm học: </td><td><input type='text' name='newSchoolYear' value='"+title.getSchoolYear()+"'></td></tr>");
		out.print("<tr><td>Thời gian làm bài: </td><td><input type='text' name='newTime' value='"+title.getTime()+"'></td></tr>");
		out.print("<input type='hidden' name='numberOfQuestion' value='"+ listAnswer.size() +"'>");
		for (int i = 0; i < listAnswer.size(); i++){
			out.print("<input type='hidden' name='questionID"+ i +"' value='"+ listAnswer.get(i).getQuestionID() +"'>");
			out.print("<tr><td>Câu "+ (i + 1) +": </td><td><input type='text' name='newQuestionContent"+ i +"' value='"+listAnswer.get(i).getQuestionContent()+"'></td></tr>");
			out.print("<tr><td>A: </td><td><input type='text' name='newAnswerA"+ i +"' value='"+listAnswer.get(i).getAnswerA()+"'></td></tr>");
			out.print("<tr><td>B: </td><td><input type='text' name='newAnswerB"+ i +"' value='"+listAnswer.get(i).getAnswerB()+"'></td></tr>");
			out.print("<tr><td>C: </td><td><input type='text' name='newAnswerC"+ i +"' value='"+listAnswer.get(i).getAnswerC()+"'></td></tr>");
			out.print("<tr><td>D: </td><td><input type='text' name='newAnswerD"+ i +"' value='"+listAnswer.get(i).getAnswerD()+"'></td></tr>");
			out.print("<tr><td>Đáp án đúng: </td><td><select name='correctAnswer"+ i +"'>");
			if(listAnswer.get(i).getCorrectAnswer().equals("A"))
				out.print("<option selected='selected' value='A'>A</option>");
			else
				out.print("<option value='A'>A</option>");
			if(listAnswer.get(i).getCorrectAnswer().equals("B"))
				out.print("<option selected='selected' value='B'>B</option>");
			else
				out.print("<option value='B'>B</option>");
			if(listAnswer.get(i).getCorrectAnswer().equals("C"))
				out.print("<option selected='selected' value='C'>C</option>");
			else
				out.print("<option value='C'>C</option>");
			if(listAnswer.get(i).getCorrectAnswer().equals("D"))
				out.print("<option selected='selected' value='D'>D</option>");
			else
				out.print("<option value='D'>D</option>");
			out.print("</select></td></tr><tr><td>&nbsp;</td></tr>");
		}
	}
	else
		out.print("Yêu cầu không hợp lệ!");
%>
<tr><td>&nbsp;</td><td><input type="submit" name="commandT" value="Thay đổi"></td></tr>
</table>
</form>
</body>
</html>