package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connect.InsertDB;
import connect.SelectDB;
import model.Answer;
import model.Question;
import model.Subject;

@WebServlet("/ExamServlet")
public class ExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ExamServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		ArrayList<Subject> listSubject = GetSubject();	// lấy danh sách môn học
		request.setAttribute("listSubject", listSubject);
		String subject = request.getParameter("subject");	// lấy mã môn chọn
		String schoolyear = request.getParameter("schoolyear");
		String title = request.getParameter("title");
		if (subject != null) {	// chưa chọn năm học
			int subjectID = Integer.parseInt(subject);
			request.setAttribute("listSchoolYear", GetSchoolYear(subjectID));
			session.removeAttribute("subjectID");
			session.setAttribute("subjectID", subjectID);	// lưu mã môn lại vào session
			if (schoolyear != null) {	// đã chọn năm học
				request.setAttribute("listTitle", GetTitle(subjectID,schoolyear));
				request.setAttribute("schoolyear", schoolyear);
				session.removeAttribute("schoolyear");
				session.setAttribute("schoolyear", schoolyear);
			}
			if (title != null) {
				session.removeAttribute("title");
				session.setAttribute("title", title);
			}
		}
		RequestDispatcher rd = request.getRequestDispatcher("choose.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String command = request.getParameter("command");
		int titleID = GetTitleID(
				(int)session.getAttribute("subjectID"),
				(String)session.getAttribute("schoolyear"),
				(String)session.getAttribute("title"));
		ArrayList<Question> listQuestion = GetListQuestion(titleID);	// lấy danh sách câu hỏi từ mã đề		
		ArrayList<Answer> listAnswer = new ArrayList<Answer>();	// tạo danh sách câu hỏi với mỗi phần tử bao gồm câu hỏi và đáp án
		for (Question q : listQuestion) {
			listAnswer.add(GetAnswer(q.getQuestionID(), q.getContent(), q.getImage()));
		}
		request.setAttribute("listAnswer", listAnswer);
		
		if(command != null) {
			switch (command) {
			case "completeselection":	// chọn đề thi xong và ấn bắt đầu thi
				request.setAttribute("exam", "start"); // bắt đầu làm bài thi
				RequestDispatcher rd = request.getRequestDispatcher("examination.jsp");
				rd.forward(request, response);
				break;
			case "submit":
				request.setAttribute("exam", "submit"); // nộp bài thi
				ArrayList<String> listSelectedAnswer = new ArrayList<String>();
				float score = 0;
				int numberOfQuestion = Integer.parseInt(request.getParameter("numberOfQuestion"));
				for (int i = 0; i < numberOfQuestion; i++) {
					String ans = request.getParameter("question" + (i + 1));	// lấy đáp án đã chọn của từng câu hỏi
					listSelectedAnswer.add(ans);	// thêm đáp án vào danh sách
				}
				for (int j = 0; j < numberOfQuestion; j++) {
					String a = listSelectedAnswer.get(j);
					String b = listAnswer.get(j).getCorrectAnswer();
					if (a.equals(b)) {
						score += 10.0/numberOfQuestion;
					}
				}
				DecimalFormat df = new DecimalFormat("0.00");
				score = Float.parseFloat(df.format(score));
//				response.getWriter().print("Đáp án chọn:");
//				for (String s : listSelectedAnswer)
//					response.getWriter().print(s);
//				response.getWriter().print("Đáp án đúng:");
//				for (Answer a : listAnswer)
//					response.getWriter().print(a.getCorrectAnswer());
//				response.getWriter().print("Điểm: " + score);
				Date today=new Date(System.currentTimeMillis());
				SimpleDateFormat timeFormat= new SimpleDateFormat("hh:mm dd/MM/yyyy");
				String time = timeFormat.format(today.getTime());
				
				InsertDB.InsertResult(request.getParameter("userName"), Integer.toString(titleID), Float.toString(score), time);
				String resultID = SelectDB.getResultID();
				for (int k = 0; k < listAnswer.size(); k++)
					InsertDB.InsertResultDetail(resultID, listAnswer.get(k).getQuestionID(), listSelectedAnswer.get(k));
				request.setAttribute("score", score);
				request.setAttribute("listSelectedAnswer", listSelectedAnswer);
				RequestDispatcher rd2 = request.getRequestDispatcher("examination.jsp");
				rd2.forward(request, response);
				break;
			}
		}
	}
	
	public ArrayList<Subject> GetSubject() {
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
	public ArrayList<String> GetSchoolYear(int subjectID) {	
		ArrayList<String> listTitle = new ArrayList<>();
		ResultSet rs = SelectDB.getSchoolYear(subjectID);
		try {			
			while (rs.next()) { 
				listTitle.add(rs.getString("Schoolyear"));
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listTitle;
	}
	public ArrayList<String> GetTitle(int subjectID, String schoolyear) {
		ArrayList<String> listTitle = new ArrayList<>();
		ResultSet rs = SelectDB.getTitleName(subjectID, schoolyear);
		try {
			while (rs.next()) { 
				listTitle.add(rs.getString("Name"));
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listTitle;
	}

	public Answer GetAnswer(String questionID, String contentQuestion, String image) {	// lấy câu thông tin đáp án từ câu hỏi
		Answer answer = new Answer();
		ResultSet rs = null;
		try {
			answer.setQuestionID(questionID);	// gán mã câu hỏi vào questionID
			answer.setQuestionContent(contentQuestion);	// gán nội dung câu hỏi vào questionContent		
			answer.setImage(image); // gán tên ảnh vào
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
	
	public ArrayList<Question> GetListQuestion(int titleID) {
		ArrayList<Question> listQuestionID = new ArrayList<Question>();
		ResultSet rs = SelectDB.getQuestionExam(titleID);
		try {
			while (rs.next()) { 
				Question question = new Question();
				question.setQuestionID(rs.getString("QuestionID"));
				question.setContent(rs.getString("Content"));
				question.setImage(rs.getString("_Image"));
				listQuestionID.add(question);
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listQuestionID;
	}
	public int GetTitleID(int subjectID, String schoolyear, String title) {
		int titleID = -1;
		ResultSet rs = SelectDB.getTitleID(subjectID, schoolyear, title);
		try {
			while (rs.next()) { 
				titleID = rs.getInt("TitleID");
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return titleID;
	}
}
