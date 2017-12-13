<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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

 <div class="container">
        <div style="margin-top: 50px; margin-bottom: 50px;">
       

<form action="ManageQuestion" method="post">
 <div class="col-sm-10">
                      <input type="text" name="keyWord" value="${ keyWord }" >
                    </div>
    <div class="col-sm-1">
                        <input type="submit" class="btn btn-default btn-lg" name="command" value="Tìm"> 
                    </div> 
  <div class="col-sm-12 text-center" style="margin-bottom: 20px;">
 <input type="submit" name="command" value="Thêm câu hỏi"  class="btn btn-default btn-lg">
<input type="submit" name="command" value="Quay lại"  class="btn btn-default btn-lg">
  </div>



<c:if test="${ empty listQuestion }">Không có câu hỏi nào</c:if>
<c:if test="${ not empty listQuestion }">
	<table id="myTable1" class="table table-striped table-bordered" cellspacing="0" width="100%">
	<tr><td align="center">Nội dung câu hỏi</td><td align="center">Thao tác</td></tr>
	<c:forEach items="${ listQuestion }" var="q">
		<c:if test="${ not empty questionIDSelected }">
			<c:if test="${ questionIDSelected eq q.getQuestionID() }">
				<form action="ManageQuestion" method="post">
			
				<tr><td><input type="text" name="questionContent" value="${ q.getQuestionContent() }"></td>
				<td align="center">
				<input type="hidden" name="questionID" value="${ q.getQuestionID() }">
				<input type="submit" name="command" value="Xác nhận"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerA() }"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerB() }"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerC() }"></td></tr>
				<tr><td><input type="text" name="answerA" value="${ q.getAnswerD() }"></td></tr>
				<tr><td><select name="correctAnswer">
				<c:if test="${ q.getCorrectAnswer() eq 'A'}">
					<option selected="selected">A</option><option>B</option><option>C</option><option>D</option>
				</c:if>
				<c:if test="${ q.getCorrectAnswer() eq 'B'}">
					<option>A</option><option selected="selected">B</option><option>C</option><option>D</option>
				</c:if>
				<c:if test="${ q.getCorrectAnswer() eq 'C'}">
					<option>A</option><option>B</option><option selected="selected">C</option><option>D</option>
				</c:if>
				<c:if test="${ q.getCorrectAnswer() eq 'D'}">
					<option>A</option><option>B</option><option>C</option><option selected="selected">D</option>
				</c:if>
					<option>  </option>
				</select></td></tr>
				<tr><td></td></tr>
				</form>
			</c:if>
			<c:if test="${ questionIDSelected ne q.getQuestionID() }">
				<form action="ManageQuestion" method="post">
				<tr><td>Mã câu hỏi: ${q.getQuestionID() }<br><b> ${ q.getQuestionContent() }</b></td>
				<td align="center">   
				<input type="hidden" name="questionID" value="${ q.getQuestionID() }">
				<input type="submit" name="command" value="Sửa"></td></tr>
				<tr><td>A. ${ q.getAnswerA() }</td></tr>
				<tr><td>B. ${ q.getAnswerB() }</td></tr>
				<tr><td>C. ${ q.getAnswerC() }</td></tr>
				<tr><td>D. ${ q.getAnswerD() }</td></tr>
				<tr><td>Đáp án đúng: <font color="green"><b> ${ q.getCorrectAnswer() }</b></font></td></tr>
				<tr><td></td></tr>
				</form>
			</c:if>
		</c:if>
		<c:if test="${ empty questionIDSelected }">
			<form action="ManageQuestion" method="post">
			<tr><td>Mã câu hỏi: ${q.getQuestionID() }<br><b> ${ q.getQuestionContent() }</b></td>
			<td align="center">
			<input type="hidden" name="questionID" value="${ q.getQuestionID() }">
			<input type="submit" name="command" value="Sửa"></td></tr>
			<tr><td>A. ${ q.getAnswerA() }</td></tr>
			<tr><td>B. ${ q.getAnswerB() }</td></tr>
			<tr><td>C. ${ q.getAnswerC() }</td></tr>
			<tr><td>D. ${ q.getAnswerD() }</td></tr> 
			<tr><td>Đáp án đúng: <font color="green"><b> ${ q.getCorrectAnswer() }</b></font></td></tr>
			<tr><td></td></tr>
			</form>
		</c:if>
	</c:forEach>
	</table>
</c:if>

</form>
</div>
</div>
</body>
<jsp:include page="./footer.jsp"></jsp:include>
</html>