<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Answer"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Examination</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<h1><center><b>BÀI THI TRẮC NGHIỆM</b></center></h1>

<form action="ExamServlet" method="post">
<div class="container">
<c:if test="${ userName eq '' }"><c:redirect url=".login.jsp"/></c:if>
<c:if test="${ userName ne '' }">
	<% int i = 1; %>
	<c:if test="${ exam eq 'start' }">
		<c:forEach items="${ listAnswer }" var="ans">
			<div class="col-sm-12" style="font-size: 15pt;text-align: justify; "><b>Câu <%=i%>. ${ ans.getQuestionContent() }</b><br>
			<c:if test="${ ans.getImage().trim() ne 'Không' }">
				<img src="./images/question/cho1.jpg"><br>
				<input type="radio" name="question<%=i%>" value="A">A. ${ ans.getAnswerA() } <br>
				<input type="radio" name="question<%=i%>" value="B">B. ${ ans.getAnswerB() } <br>
				<input type="radio" name="question<%=i%>" value="C">C. ${ ans.getAnswerC() } <br>
				<input type="radio" name="question<%=i++%>" value="D">D. ${ ans.getAnswerD() } <br><br>
			</c:if>
			
			<c:if test="${ ans.getImage().trim() eq 'Không' or ans.getImage() eq '' or empty ans.getImage() }">
				<input type="radio" name="question<%=i%>" value="A">A. ${ ans.getAnswerA() } <br>
				<input type="radio" name="question<%=i%>" value="B">B. ${ ans.getAnswerB() } <br>
				<input type="radio" name="question<%=i%>" value="C">C. ${ ans.getAnswerC() } <br>
				<input type="radio" name="question<%=i++%>" value="D">D. ${ ans.getAnswerD() } <br><br>
			</c:if>
			</div>
		</c:forEach>
			<input type="hidden" name="userName" value="${ userName }">
		<input type="hidden" name="numberOfQuestion" value="${ listAnswer.size() }">
		<input type="hidden" name="command" value="submit">
		<div class="col-sm-12 text-center" style="margin-top: 20px; margin-bottom:20px;">
		<input class="btn btn-default btn-lg" style="padding-left:50px;padding-right:50px" type="submit" value="Nộp bài">
		</div>
		
		
		
	</c:if>
	<%-- <c:if test="${ exam eq 'submit' }">
		<h1>Điểm số: ${ score }</h1>
	</c:if> --%>
</c:if>

<%
	String exam = (String)request.getAttribute("exam");
	if (exam != null && !exam.equals("")){
		ArrayList<Answer> listAnswer = (ArrayList<Answer>)request.getAttribute("listAnswer");	// lấy nội dung bài thi
		ArrayList<String> listSelectedAnswer = (ArrayList<String>)request.getAttribute("listSelectedAnswer");
		if(listAnswer != null && listAnswer.size() > 0){	// kiểm nội dung bài thi tồn tại
			if (exam.equals("submit")){ // đã nộp bài
				float score = (float)request.getAttribute("score");
				//if (score != null && !score.equals("")) 
					out.print("<h1>Điểm số: "+ score +"</h1>");
					out.print("<div class=\"col-sm-12\" style=\"font-size: 15pt;text-align: justify; \">");
				for (int i = 0; i < listAnswer.size(); i++){
					out.println("Câu " + (i + 1) + ". "+listAnswer.get(i).getQuestionContent() + "<br>");
					if (listAnswer.get(i).getCorrectAnswer().equals(listSelectedAnswer.get(i))){	// câu đúng
						if (listAnswer.get(i).getCorrectAnswer().equals("A"))
							out.println("<font color='blue'><b>A. "+ listAnswer.get(i).getAnswerA() + "</b></font><br>");
						else
							out.println("<font color='black'>A. "+ listAnswer.get(i).getAnswerA() + "</font><br>");
						if (listAnswer.get(i).getCorrectAnswer().equals("B"))
							out.println("<font color='blue'><b>B. "+ listAnswer.get(i).getAnswerB() + "</b></font><br>");
						else
							out.println("<font color='black'>B. "+ listAnswer.get(i).getAnswerB() + "</font><br>");
						if (listAnswer.get(i).getCorrectAnswer().equals("C"))
							out.println("<font color='blue'><b>C. "+ listAnswer.get(i).getAnswerC() + "</b></font><br>");
						else
							out.println("<font color='black'>C. "+ listAnswer.get(i).getAnswerC() + "</font><br>");
						if (listAnswer.get(i).getCorrectAnswer().equals("D"))
							out.println("<font color='blue'><b>D. "+ listAnswer.get(i).getAnswerD() + "</b></font><br>");
						else
							out.println("<font color='black'>D. "+ listAnswer.get(i).getAnswerD() + "</font><br>");
						out.println("<br>");
					}
					else {	// câu sai -- đáp án đúng màu xanh lá, đáp án sai màu đỏ
						// A
						if (listAnswer.get(i).getCorrectAnswer().equals("A"))	// đáp án đúng
							out.println("<font color='blue'><b>A. "+ listAnswer.get(i).getAnswerA() + "</b></font><br>");
						else {
							if (listSelectedAnswer.get(i).equals("A"))	// đáp án chọn
								out.println("<font color='red'><b>A. "+ listAnswer.get(i).getAnswerA() + "</b></font><br>");
							else	// đáp án không chọn
								out.println("<font color='black'>A. "+ listAnswer.get(i).getAnswerA() + "</font><br>");
						}
						// B
						if (listAnswer.get(i).getCorrectAnswer().equals("B"))	// đáp án đúng
							out.println("<font color='blue'><b>B. "+ listAnswer.get(i).getAnswerB() + "</b></font><br>");
						else {
							if (listSelectedAnswer.get(i).equals("B"))	// đáp án chọn
								out.println("<font color='red'><b>B. "+ listAnswer.get(i).getAnswerB() + "</b></font><br>");
							else	// đáp án không chọn
								out.println("<font color='black'>B. "+ listAnswer.get(i).getAnswerB() + "</font><br>");
						}
						// C
						if (listAnswer.get(i).getCorrectAnswer().equals("C"))	// đáp án đúng
							out.println("<font color='blue'><b>C. "+ listAnswer.get(i).getAnswerC() + "</b></font><br>");
						else {
							if (listSelectedAnswer.get(i).equals("C"))	// đáp án chọn
								out.println("<font color='red'><b>C. "+ listAnswer.get(i).getAnswerC() + "</b></font><br>");
							else	// đáp án không chọn
								out.println("<font color='black'>C. "+ listAnswer.get(i).getAnswerC() + "</font><br>");
						}
						// D
						if (listAnswer.get(i).getCorrectAnswer().equals("D"))	// đáp án đúng
							out.println("<font color='blue'><b>D. "+ listAnswer.get(i).getAnswerD() + "</b></font><br>");
						else {
							if (listSelectedAnswer.get(i).equals("D"))	// đáp án chọn
								out.println("<font color='red'><b>D. "+ listAnswer.get(i).getAnswerD() + "</b></font><br>");
							else	// đáp án không chọn
								out.println("<font color='black'>D. "+ listAnswer.get(i).getAnswerD() + "</font><br>");
						}
					}
				}
				out.print("</div>");
			}
		}
		else // không có bài thi do chưa chọn
			out.println("<h1>Vui lòng chọn đề thi!</h1>");
	}
%>
</form>
  <!-- <br><button  onclick="location='./ExamServlet'">Quay lại</button>   -->
	<input class="btn btn-default btn-lg" style="padding-left:50px;padding-right:50px;  margin-bottom:20px" type="submit" value="Quay lại"  onclick="location='./ExamServlet'">
	</div>
</body>
<jsp:include page="./footer.jsp"></jsp:include>
</html>