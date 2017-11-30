<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.Answer"%>
<%@ page import="java.util.ArrayList"%>
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
		out.println("<h1>Vui lòng <a href='login.jsp'>đăng nhập</a>!</h1>");
	else {	// đã đăng nhập
		String exam = (String)request.getAttribute("exam");
		if (exam != null && !exam.equals("")){
			ArrayList<Answer> listAnswer = (ArrayList<Answer>)request.getAttribute("listAnswer");	// lấy nội dung bài thi
			ArrayList<String> listSelectedAnswer = (ArrayList<String>)request.getAttribute("listSelectedAnswer");
			if(listAnswer != null && listAnswer.size() > 0){	// kiểm nội dung bài thi tồn tại
				
				if (exam.equals("start")){	// bắt đầu làm bài thi
					for (int i = 0; i < listAnswer.size(); i++){
						out.println("Câu " + (i + 1) + ". "+listAnswer.get(i).getQuestionContent() + "<br>");
						if (listAnswer.get(i).getImage() != null && 
								!listAnswer.get(i).getImage().trim().equals("") && 
								!listAnswer.get(i).getImage().trim().equals("null") &&
								!listAnswer.get(i).getImage().trim().equals("Không")){
							// trường hợp câu hỏi có hình ảnh
							out.println("<img src=\"./images/question/cho1.jpg\"><br>");
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"A\">A" + ". "+ listAnswer.get(i).getAnswerA() + "<br>");
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"B\">B" + ". "+ listAnswer.get(i).getAnswerB() + "<br>");
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"C\">C" + ". "+ listAnswer.get(i).getAnswerC() + "<br>");
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"D\">D" + ". "+ listAnswer.get(i).getAnswerD() + "<br>");
							out.println("<br>");
						}
						else {
							// trường hợp câu hỏi không có hình ảnh
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"A\">A" + ". "+ listAnswer.get(i).getAnswerA() + "<br>");
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"B\">B" + ". "+ listAnswer.get(i).getAnswerB() + "<br>");
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"C\">C" + ". "+ listAnswer.get(i).getAnswerC() + "<br>");
							out.println("<input type=\"radio\" name=\"question"+ (i + 1) +"\" value=\"D\">D" + ". "+ listAnswer.get(i).getAnswerD() + "<br>");
							out.println("<br>");
						}
					}
					out.println("<input type='hidden' value='"+ userName +"' name='userName'>");
					out.println("<input type=\"hidden\" value=\""+ listAnswer.size() +"\" name=\"numberOfQuestion\">");
					out.println("<input type=\"hidden\" value=\"submit\" name=\"command\">");
					out.println("<input type=\"submit\" value=\"Nộp bài\">");
				}
			
				if (exam.equals("submit")){ // đã nộp bài
					float score = (float)request.getAttribute("score");
					//if (score != null && !score.equals("")) 
						out.print("<h1>Điểm số: "+ score +"</h1>");
					for (int i = 0; i < listAnswer.size(); i++){
						out.println("Câu " + (i + 1) + ". "+listAnswer.get(i).getQuestionContent() + "<br>");
						if (listAnswer.get(i).getCorrectAnswer().equals(listSelectedAnswer.get(i))){	// câu đúng
							if (listAnswer.get(i).getCorrectAnswer().equals("A"))
								out.println("<font color='green'>A. "+ listAnswer.get(i).getAnswerA() + "</font><br>");
							else
								out.println("<font color='black'>A. "+ listAnswer.get(i).getAnswerA() + "</font><br>");
							if (listAnswer.get(i).getCorrectAnswer().equals("B"))
								out.println("<font color='green'>B. "+ listAnswer.get(i).getAnswerB() + "</font><br>");
							else
								out.println("<font color='black'>B. "+ listAnswer.get(i).getAnswerB() + "</font><br>");
							if (listAnswer.get(i).getCorrectAnswer().equals("C"))
								out.println("<font color='green'>C. "+ listAnswer.get(i).getAnswerC() + "</font><br>");
							else
								out.println("<font color='black'>C. "+ listAnswer.get(i).getAnswerC() + "</font><br>");
							if (listAnswer.get(i).getCorrectAnswer().equals("D"))
								out.println("<font color='green'>D. "+ listAnswer.get(i).getAnswerD() + "</font><br>");
							else
								out.println("<font color='black'>D. "+ listAnswer.get(i).getAnswerD() + "</font><br>");
							out.println("<br>");
						}
						else {	// câu sai -- đáp án đúng màu xanh lá, đáp án sai màu đỏ
							// A
							if (listAnswer.get(i).getCorrectAnswer().equals("A"))	// đáp án đúng
								out.println("<font color='green'>A. "+ listAnswer.get(i).getAnswerA() + "</font><br>");
							else {
								if (listSelectedAnswer.get(i).equals("A"))	// đáp án chọn
									out.println("<font color='red'>A. "+ listAnswer.get(i).getAnswerA() + "</font><br>");
								else	// đáp án không chọn
									out.println("<font color='black'>A. "+ listAnswer.get(i).getAnswerA() + "</font><br>");
							}
							// B
							if (listAnswer.get(i).getCorrectAnswer().equals("B"))	// đáp án đúng
								out.println("<font color='green'>B. "+ listAnswer.get(i).getAnswerB() + "</font><br>");
							else {
								if (listSelectedAnswer.get(i).equals("B"))	// đáp án chọn
									out.println("<font color='red'>B. "+ listAnswer.get(i).getAnswerB() + "</font><br>");
								else	// đáp án không chọn
									out.println("<font color='black'>B. "+ listAnswer.get(i).getAnswerB() + "</font><br>");
							}
							// C
							if (listAnswer.get(i).getCorrectAnswer().equals("C"))	// đáp án đúng
								out.println("<font color='green'>C. "+ listAnswer.get(i).getAnswerC() + "</font><br>");
							else {
								if (listSelectedAnswer.get(i).equals("C"))	// đáp án chọn
									out.println("<font color='red'>C. "+ listAnswer.get(i).getAnswerC() + "</font><br>");
								else	// đáp án không chọn
									out.println("<font color='black'>C. "+ listAnswer.get(i).getAnswerC() + "</font><br>");
							}
							// D
							if (listAnswer.get(i).getCorrectAnswer().equals("D"))	// đáp án đúng
								out.println("<font color='green'>D. "+ listAnswer.get(i).getAnswerD() + "</font><br>");
							else {
								if (listSelectedAnswer.get(i).equals("D"))	// đáp án chọn
									out.println("<font color='red'>D. "+ listAnswer.get(i).getAnswerD() + "</font><br>");
								else	// đáp án không chọn
									out.println("<font color='black'>D. "+ listAnswer.get(i).getAnswerD() + "</font><br>");
							}
						}
					}
				}
			}
			else // không có bài thi do chưa chọn
				out.println("<h1>Vui lòng chọn đề thi!</h1>");
		}
	}
%>
</form>
</body>
</html>