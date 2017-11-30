package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect.DeleteDB;
import connect.InsertDB;
import connect.SelectDB;
import connect.UpdateDB;
import model.Answer;
import model.Question;
import model.Subject;
import model.Title;

@WebServlet("/ManageExam")
public class ManageExam extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ManageExam() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Subject> listSubject = getListSubject();
		request.setAttribute("listSubject", getListSubject());
		String sub = request.getParameter("sub");
		if(sub == null) {	// không có chọn môn nào
			request.setAttribute("listTitle", getListTitle(null));			
		}
		else {
			ArrayList<Title> listTitle = getListTitle(listSubject.get(Integer.parseInt(sub)).getSubjectName());
			request.setAttribute("listTitle", listTitle);
			request.setAttribute("sub", sub);
		}
		request.setAttribute("commandS", null);
		RequestDispatcher rd = request.getRequestDispatcher("manage-exam.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		request.setAttribute("listSubject", getListSubject());
		request.setAttribute("listTitle", getListTitle(null));
		String commandS = request.getParameter("commandS");	// thao tác với môn thi
		String commandT = request.getParameter("commandT");	// thao tác với đề thi
		String commandA = request.getParameter("commandA");	// thao tác với trang thêm đề thi\
		if (commandS != null) {
			switch(commandS) {
			case "Thêm":
				request.setAttribute("commandS", commandS);
				break;
			case "Thêm môn học":
				String subjectName = request.getParameter("subjectName");
				if (subjectName != null)
					if (!existSubject(subjectName)) {	// kiểm tra xem môn học đã tồn tại chưa
						InsertDB.InsertSubject(subjectName);	// thêm môn học vào csdl
						request.setAttribute("listSubject", getListSubject());	// cập nhật lại danh sách môn học
					}
				request.setAttribute("commandS", null);
				break;
			case "Sửa":
				String subjectSelected = request.getParameter("subjectSelected");
				request.setAttribute("commandS", commandS);
				request.setAttribute("editSubject", subjectSelected);
				break;
			case "Sửa môn học":
				String newSubjectName = request.getParameter("newSubjectName");
				if (!existSubject(newSubjectName)) {	// kiểm tra xem môn học có bị trùng không
					UpdateDB.UpdateSubject(request.getParameter("oldSubjectName"), newSubjectName);	// cập nhật lại tên môn học
					request.setAttribute("listSubject", getListSubject());	// cập nhật lại danh sách môn học
					request.setAttribute("listTitle", getListTitle(null));	// cập nhật lại danh sách đề thi
				}
				request.setAttribute("commandS", null);
				break;
			case "Xóa":	// CHƯA XONG Xóa môn học
				String subject = request.getParameter("subjectDelete");
				if(subject == null || subject.equals("") || subject.equals("Tất cả")) {
					request.setAttribute("success", "1");
				}
				else {
					DeleteDB.DeleteSubject(subject);
					request.setAttribute("sub", null);
					request.setAttribute("listSubject", getListSubject());	// cập nhật lại danh sách môn học
					request.setAttribute("listTitle", getListTitle(null));	// cập nhật lại danh sách đề thi
					request.setAttribute("commandS", null);
					RequestDispatcher rd = request.getRequestDispatcher("manage-exam.jsp");
					rd.forward(request, response);
				}
			}
			RequestDispatcher rd = request.getRequestDispatcher("manage-exam.jsp");
			rd.forward(request, response);
		}
		if (commandT != null) {
			switch(commandT) {
			case "Thêm đề thi":
				request.setAttribute("numberOfQuestion", 0);
				request.setAttribute("titleName", "");
				request.setAttribute("schoolYear", "");
				request.setAttribute("time", "");
				break;
			case "Sửa":
				request.setAttribute("listSubject", getListSubject());
				String strTitleID = request.getParameter("titleID");
				if(strTitleID != null && !strTitleID.equals("")) {
					int titleID = Integer.parseInt(strTitleID);
					ArrayList<Question> listQuestion = GetListQuestion(titleID);	// lấy danh sách câu hỏi từ mã đề	
					ArrayList<Answer> listAnswer = new ArrayList<Answer>();	// tạo danh sách câu hỏi với mỗi phần tử bao gồm câu hỏi và đáp án
					for (Question q : listQuestion) {
						listAnswer.add(GetAnswer(q.getQuestionID(), q.getContent()));
					}
					Title title = getTitleInformation(titleID);
					//request.setAttribute("listQuestion", listQuestion);
					request.setAttribute("listAnswer", listAnswer);
					request.setAttribute("title", title);
					RequestDispatcher rd = request.getRequestDispatcher("edit-exam.jsp");
					rd.forward(request, response);
					return;
				}
				else
					break;
			case "Thay đổi": // xác nhận việc sửa
				String titleID = request.getParameter("titleID");
				String newSubjectID = request.getParameter("newSubjectID");
				String newTitleName = request.getParameter("newTitleName");
				String newSchoolYear = request.getParameter("newSchoolYear");
				String newTime = request.getParameter("newTime");
				if (	titleID != null && !titleID.equals("") &&
						newSubjectID != null && !newSubjectID.equals("") &&
						newTitleName != null && !newTitleName.equals("") &&
						newSchoolYear != null && !newSchoolYear.equals("") &&
						newTime != null && !newTime.equals("")) {
					UpdateDB.UpdateTitle(titleID, newSubjectID, newTitleName, newSchoolYear, newTime);	// cập nhật lại đề thi
				}
				String numberOfQuestion = request.getParameter("numberOfQuestion");
				for (int i = 0; i < Integer.parseInt(numberOfQuestion); i++) {
					String questionID = request.getParameter("questionID" + i);
					String questionContent = request.getParameter("newQuestionContent" + i);
					UpdateDB.UpdateQuestion(questionID, questionContent);	// cập nhật lại câu hỏi
					String newAnswerA = request.getParameter("newAnswerA" + i);
					String newAnswerB = request.getParameter("newAnswerB" + i);
					String newAnswerC = request.getParameter("newAnswerC" + i);
					String newAnswerD = request.getParameter("newAnswerD" + i);
					String correctAnswer = request.getParameter("correctAnswer" + i);
					UpdateDB.UpdateAnswer("A", questionID, newAnswerA, correctAnswer);	// cập nhật lại các đáp án
					UpdateDB.UpdateAnswer("B", questionID, newAnswerB, correctAnswer);
					UpdateDB.UpdateAnswer("C", questionID, newAnswerC, correctAnswer);
					UpdateDB.UpdateAnswer("D", questionID, newAnswerD, correctAnswer);
				}
				request.setAttribute("listSubject", getListSubject());	// cập nhật lại danh sách môn học
				request.setAttribute("listTitle", getListTitle(null));	// cập nhật lại danh sách đề thi
				request.setAttribute("commandS", null);
				RequestDispatcher rd = request.getRequestDispatcher("manage-exam.jsp");
				rd.forward(request, response);
				return;
			case "Xóa":
				break;
			}
			RequestDispatcher rd = request.getRequestDispatcher("add-exam.jsp");
			rd.forward(request, response);
		}
		if (commandA != null) {
			switch(commandA) {
			case "Xác nhận":	// ấn nút xác nhận số câu hỏi
				request.setAttribute("subjectName", request.getParameter("subjectName"));
				request.setAttribute("titleName", request.getParameter("titleName"));
				request.setAttribute("schoolYear", request.getParameter("schoolYear"));
				request.setAttribute("time", request.getParameter("time"));
				String numberOfQuestion = request.getParameter("numberOfQuestion");
				if(numberOfQuestion != null && !numberOfQuestion.trim().equals("")) {
					int n = Integer.parseInt(request.getParameter("numberOfQuestion"));
					if(n > 0)
						request.setAttribute("numberOfQuestion", n);
					else
						request.setAttribute("numberOfQuestion", 0);
				}
				else
					request.setAttribute("numberOfQuestion", 0);
				break;
			case "Thêm":
				String subID = request.getParameter("subjectID");
				int subjectID = -1;
				if (subID != null && !subID.equals(""))
					subjectID = Integer.parseInt(subID);
				String titleName = request.getParameter("titleName");
				String schoolYear = request.getParameter("schoolYear");
				String timeExam = request.getParameter("time");
				int time = -1;
				if (timeExam != null && !timeExam.equals(""))
					time = Integer.parseInt(timeExam);
				int number = Integer.parseInt(request.getParameter("numberOfQuestion"));
				
				if (!existTitle(subjectID,schoolYear,titleName)) {	// kiểm tra xem đề thi tồn tại chưa
					response.getWriter().println("Mã môn:"+subjectID+",Mã đề"+titleName+",Năm học:"+schoolYear+",Thời gian:"+time);
					InsertDB.InsertTitle(subjectID, titleName, schoolYear, time);	// thêm đề mới vào csdl
					int titleID = getTitleID(subjectID, schoolYear, titleName);
					for (int i = 1; i <= number; i++) {
						String content = request.getParameter("question" + i);
						InsertDB.InsertQuestion(content,"NULL");	// thêm câu hỏi đã nhập vào csdl nếu chưa có
						int questionID = getQuestionID(content);	// lấy ID của câu hỏi vừa thêm vào
						InsertDB.InsertAnswer("A", questionID, request.getParameter("answerA" + i), request.getParameter("correctAnswer" + i));
						InsertDB.InsertAnswer("B", questionID, request.getParameter("answerB" + i), request.getParameter("correctAnswer" + i));
						InsertDB.InsertAnswer("C", questionID, request.getParameter("answerC" + i), request.getParameter("correctAnswer" + i));
						InsertDB.InsertAnswer("D", questionID, request.getParameter("answerD" + i), request.getParameter("correctAnswer" + i));
						InsertDB.InsertExaminationDetail(titleID, questionID);	// thêm mã đề và mã câu hỏi vào bảng chi tiết bài thi						
					}
					request.setAttribute("numberOfQuestion", 0);
					request.setAttribute("titleName", "");
					request.setAttribute("schoolYear", "");
					request.setAttribute("time", "");
					request.setAttribute("success", "1");
				}
				else {
					request.setAttribute("numberOfQuestion", 0);
					request.setAttribute("titleName", "");
					request.setAttribute("schoolYear", "");
					request.setAttribute("time", "");
					request.setAttribute("success", "0");
				}
				break;
			case "Hủy":
				RequestDispatcher rd = request.getRequestDispatcher("exam-exam.jsp");
				rd.forward(request, response);		
				return;
			}	
			RequestDispatcher rd = request.getRequestDispatcher("add-exam.jsp");
			rd.forward(request, response);		
		}
	}
	
	public ArrayList<Subject> getListSubject() {
		ArrayList<Subject> listSubject = new ArrayList<Subject>();
		ResultSet rs = SelectDB.getSubject();
		try {			
			while (rs.next()) { 
				Subject subject = new Subject();
				subject.setSubjectID(rs.getInt("SubjectID"));
				subject.setSubjectName(rs.getString("Name"));
				listSubject.add(subject);
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listSubject;
	}
	
	public boolean existSubject(String subjectName) {
		ResultSet rs = SelectDB.getSubject();
		try {			
			while (rs.next()) {
				if(rs.getString("Name").equals(subjectName))
					return true;
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return false;
	}
	
	public ArrayList<Title> getListTitle(String subjectName){
		ArrayList<Title> listTitle = new ArrayList<Title>();
		ResultSet rs = SelectDB.getTitle(subjectName);
		try {			
			while (rs.next()) { 
				Title title = new Title();
				title.setTitleID(rs.getInt("TitleID"));
				title.setSubjectName(rs.getString("SubjectName"));
				title.setTitleName(rs.getString("TitleName"));
				title.setSchoolYear(rs.getString("Schoolyear"));
				title.setTime(rs.getInt("_Time"));
				listTitle.add(title);
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listTitle;	
	}
	public Title getTitleInformation(int titleID){
		Title title = new Title();
		ResultSet rs = SelectDB.getTitleInfomation(titleID);
		try {			
			while (rs.next()) { 
				title.setTitleID(rs.getInt("TitleID"));
				title.setSubjectName(rs.getString("SubjectName"));
				title.setTitleName(rs.getString("TitleName"));
				title.setSchoolYear(rs.getString("Schoolyear"));
				title.setTime(rs.getInt("_Time"));
				break;
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return title;	
	}
	public boolean existTitle(int subjectID, String schoolyear, String name) {
		ResultSet rs = SelectDB.getTitleID(subjectID, schoolyear, name);
		try {			
			while (rs.next()) {
					return true;
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return false;
	}
	
	public boolean existQuestion(String content) {
		ResultSet rs = SelectDB.getQuestion(content);
		try {			
			while (rs.next()) {
					return true;
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return false;
	}
	
	public int getQuestionID(String content) {
		ResultSet rs = SelectDB.getQuestion(content);
		int id = -1;
		try {			
			while (rs.next()) {
				id = rs.getInt("QuestionID");
				return id;
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return id;
	}
	
	public int getTitleID(int subjectID, String schoolyear, String name) {
		ResultSet rs = SelectDB.getTitleID(subjectID, schoolyear, name);
		int id = -1;
		try {			
			while (rs.next()) {
				id = rs.getInt("TitleID");
				return id;
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return id;
	}
	public ArrayList<Question> GetListQuestion(int titleID) {
		ArrayList<Question> listQuestionID = new ArrayList<Question>();
		ResultSet rs = SelectDB.getQuestionExam(titleID);
		try {
			while (rs.next()) { 
				Question question = new Question();
				question.setQuestionID(rs.getString("QuestionID"));
				question.setContent(rs.getString("Content"));
				listQuestionID.add(question);
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listQuestionID;
	}
	public Answer GetAnswer(String questionID, String contentQuestion) {	// lấy câu thông tin đáp án từ câu hỏi
		Answer answer = new Answer();
		ResultSet rs = null;
		try {
			answer.setQuestionID(questionID);	// gán mã câu hỏi vào questionID
			answer.setQuestionContent(contentQuestion);	// gán nội dung câu hỏi vào questionContent		
			//answer.setImage(image); // gán tên ảnh vào
			rs = SelectDB.getAnswer(questionID);
			while (rs.next()) {
				if(rs.getString("AnswerID").equals("A")) {
					answer.setAnswerA(rs.getString("Content"));	// gán nội dung đáp án A vào answerA	
					if (rs.getString("CorrectAnswer").equals("A"))	// nếu đáp án đúng là A
						answer.setCorrectAnswer("A");	// gán đáp án đúng vào correctAnswer
				}
				if(rs.getString("AnswerID").equals("B")) {
					answer.setAnswerB(rs.getString("Content"));	// gán nội dung đáp án B vào answerB	
					if (rs.getString("CorrectAnswer").equals("B"))	// nếu đáp án đúng là B
						answer.setCorrectAnswer("B");	// gán đáp án đúng vào correctAnswer
				}
					
				if(rs.getString("AnswerID").equals("C")) {
					answer.setAnswerC(rs.getString("Content"));	// gán nội dung đáp án C vào answerC	
					if (rs.getString("CorrectAnswer").equals("C"))	// nếu đáp án đúng là C
						answer.setCorrectAnswer("C");	// gán đáp án đúng vào correctAnswer
				}
				if(rs.getString("AnswerID").equals("D")) {
					answer.setAnswerD(rs.getString("Content"));	// gán nội dung đáp án D vào answerD	
					if (rs.getString("CorrectAnswer").equals("D"))	// nếu đáp án đúng là D
						answer.setCorrectAnswer("D");	// gán đáp án đúng vào correctAnswer
				}
			}
		}
		catch (Exception e) {  
			e.printStackTrace();  
		} 
		return answer;
	}
}
