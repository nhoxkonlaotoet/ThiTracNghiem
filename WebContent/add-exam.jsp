<%@page import="model.Title"%>
<%@page import="model.NewQuestion"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<br>
<form action="AddExam" method="post">
<c:if test="${success eq '1'}">
	<div class="alert-box success"><span></span>Thêm đề thi thành công! Bấm vào <a href="AddExam"><b>đây </b></a>để tiếp tục thêm hoặc về <a href="./index.jsp"><b>trang chủ</b></a>
	</div>
</c:if>	
<c:if test="${success eq '0'}">
	<div class="alert-box error"><span></span>Đề thi đã tồn tại! Bấm vào <a href="AddExam"><b>đây </b></a>để tiếp tục thêm hoặc về <a href="./index.jsp"><b>trang chủ</b></a>
	</div>
</c:if>	
<table>
	<tr><td>Tên môn: </td>
	<td>
	<select name="subjectID">
		<c:if test="${ empty listSubject }">Không có môn học nào</c:if>
		
		<c:if test="${ not empty listSubject }">
			<option>Chọn môn học</option>
			<c:forEach items="${ listSubject }" var="subject">
				<c:if test="${ titleDetail ne null }">
					<c:if test="${ titleDetail.getSubjectID() eq subject.getSubjectID() }">
						<option selected="selected" value="${ subject.getSubjectID() }">${ subject.getSubjectName() }</option>
					</c:if>
					<c:if test="${ title.getSubjectID() ne subject.getSubjectID() }">
						<option value="${ subject.getSubjectID() }">${ subject.getSubjectName() }</option>
					</c:if>
				</c:if>
				<c:if test="${ titleDetail eq null }">
						<option value="${ subject.getSubjectID() }">${ subject.getSubjectName() }</option>
				</c:if>
			</c:forEach>
		</c:if>
	</select>
	</td></tr>
	
	<c:if test="${ titleDetail ne null }">
		<tr><td>Tên đề:</td><td><input type="text" name="titleName" value="${ titleDetail.getTitleName() }"></td></tr>
		<c:if test="${ err eq '0' }">
			<tr><td><center><div class=\"alert-box error\"><span>error: </span>Tên đề thi đã tồn tại!</div></center></td></tr>
		</c:if>
		<tr><td>Năm học: </td><td><input type="text" name="schoolYear" value="${ titleDetail.getSchoolYear() }"></td></tr>
		<tr><td>Thời gian làm bài:</td><td><input type="text" name="time" value="${ titleDetail.getTime() }"></td></tr>
	</c:if>
	
	<c:if test="${ titleDetail eq null }">
		<tr><td>Tên đề:</td><td><input type="text" name="titleName" value=""></td></tr>
		<c:if test="${ err eq '0' }">
			<tr><td><center><div class=\"alert-box error\"><span>error: </span>Tên đề thi đã tồn tại!</div></center></td></tr>
		</c:if>
		<tr><td>Năm học: </td><td><input type="text" name="schoolYear" value=""></td></tr>
		<tr><td>Thời gian làm bài:</td><td><input type="text" name="time" value=""></td></tr>
	</c:if>
	<tr><td>&nbsp;</td></tr>
	<tr><td>Câu hỏi và đáp án:</td></tr>
	<tr><td>Nội dung:</td></tr>
	<% 
		int i = 1;
	%>

	<c:if test="${ not empty listNewQuestion }">
		<c:forEach items="${ listNewQuestion }" var="q">
				<input type="hidden" name="questionID<%=i%>" value="${q.getQuestionID()}">
				<input type="hidden" name="isNew<%=i%>" value="${q.getIsNew()}">
				<c:if test="${ q.getIsNew() eq 'false' }">
					<input type="hidden" name="questionContent<%=i%>" value="${q.getContent()}">
					<input type="hidden" name="answerA<%=i%>" value="${q.getAnswerA()}">
					<input type="hidden" name="answerB<%=i%>" value="${q.getAnswerB()}">
					<input type="hidden" name="answerC<%=i%>" value="${q.getAnswerC()}">
					<input type="hidden" name="answerD<%=i%>" value="${q.getAnswerD()}">
					<input type="hidden" name="correctAnswer<%=i%>" value="${q.getCorrectAnswer()}">
					<tr><td>Câu hỏi <%=i++%>: </td></tr>
					<tr><td>Nội dung: </td><td>${q.getContent()}</td></tr>
					<tr><td>Đáp án A: </td><td>${q.getAnswerA()}</td></tr>
					<tr><td>Đáp án B: </td><td>${q.getAnswerB()}</td></tr>
					<tr><td>Đáp án C: </td><td>${q.getAnswerC()}</td></tr>
					<tr><td>Đáp án D: </td><td>${q.getAnswerD()}</td></tr>
					<tr><td>Đáp án đúng: </td><td>${q.getCorrectAnswer()}</td></tr>
					<tr><td>
						<form action="AddExam" method="post">
							<input type="hidden" name="questionIDSelected" value="${q.getQuestionID()}">
							<input type="submit" name="command" value="Xóa">
						</form>
					</td></tr>
					<tr><td>&nbsp;</td></tr>		
				</c:if> 
				<c:if test="${ q.getIsNew() eq 'true' }">
					<tr><td>Câu hỏi <%=i%>: </td></tr>
					<tr><td>Nội dung: </td><td><input type="text" name ="questionContent<%=i%>" value ="${q.getContent()}"></td></tr>
					<tr><td>Đáp án A: </td><td><input type="text" name ="answerA<%=i%>" value ="${q.getAnswerA()}"></td></tr>
					<tr><td>Đáp án B: </td><td><input type="text" name ="answerB<%=i%>" value ="${q.getAnswerB()}"></td></tr>
					<tr><td>Đáp án C: </td><td><input type="text" name ="answerC<%=i%>" value ="${q.getAnswerC()}"></td></tr>
					<tr><td>Đáp án D: </td><td><input type="text" name ="answerD<%=i%>" value ="${q.getAnswerD()}"></td></tr>
					<tr><td>Đáp án đúng: </td><td>
					<c:if test="${q.getCorrectAnswer() eq 'A'}">
						<select name="correctAnswer<%=i++%>"><option selected="selected" value='A'>A</option><option value='B'>B</option><option value='C'>C</option><option value='D'>D</option></select>
					</c:if>
					<c:if test="${q.getCorrectAnswer() eq 'B'}">
						<select><option value='A'>A</option><option selected="selected" value='B'>B</option><option value='C'>C</option><option value='D'>D</option></select>
					</c:if>
					<c:if test="${q.getCorrectAnswer() eq 'C'}">
						<select><option value='A'>A</option><option value='B'>B</option><option selected="selected" value='C'>C</option><option value='D'>D</option></select>
					</c:if>
					<c:if test="${q.getCorrectAnswer() eq 'D'}">
						<select><option value='A'>A</option><option value='B'>B</option><option value='C'>C</option><option selected="selected" value='D'>D</option></select>
					</c:if>
					</td></tr>
					</select></td></tr>
					<!-- <input type="hidden" name="" value=""> -->
					<tr><td>
						<form action="AddExam" method="post">
							<input type="hidden" name="questionIDSelected" value="${q.getQuestionID()}">
							<input type="submit" name="command" value="Xóa">
						</form>
					</td></tr>
					<tr><td>&nbsp;</td></tr>		
				</c:if>
			
		</c:forEach>
	</c:if>
	<c:if test="${ newQuestion eq '1' }">
		<input type="hidden" name="questionID<%=i%>" value="new<%=i%>">
		<input type="hidden" name="newQuestion" value="1">
		<input type="hidden" name="isNew<%=i%>" value="true">
		<tr><td>Câu hỏi <%=i%>: </td></tr>
		<tr><td>Nội dung: </td><td><input type="text" name="questionContent<%=i%>"></td></tr>
		<tr><td>Đáp án A: </td><td><input type="text" name="answerA<%=i%>"></td></tr>
		<tr><td>Đáp án B: </td><td><input type="text" name="answerB<%=i%>"></td></tr>
		<tr><td>Đáp án C: </td><td><input type="text" name="answerC<%=i%>"></td></tr>
		<tr><td>Đáp án D: </td><td><input type="text" name="answerD<%=i%>"></td></tr>
		<tr><td>Đáp án đúng: </td><td><select name="correctAnswer<%=i++%>">
		<option value='A'>A</option><option value='B'>B</option><option value='C'>C</option><option value='D'>D</option>
		</select></td></tr><tr><td>&nbsp;</td></tr>		
	</c:if>
	<input type="hidden" name="numberOfQuestion" value="<%=i%>">
	<tr><td><input type="submit" value="Thêm câu hỏi đã có" name="command"></td></tr>
	<tr><td><input type="submit" value="Thêm câu hỏi mới" name="command"></td></tr>
	<tr><td><input type="submit" value="Cập nhật" name="command"></td></tr>
	<tr><td><input type="submit" value="Thêm đề thi" name="command"></td></tr>
</table>
</form>
</body>
</html>