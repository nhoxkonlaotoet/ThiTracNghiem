package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

import connect.SelectDB;
import model.Answer;
import model.History;
import model.Question;
import model.Result;

@WebServlet("/HistoryServlet")
public class HistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public HistoryServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cookie[] listCookie = request.getCookies();
		String userName = "";
		if(listCookie != null)							
			for(int i = 0; i < listCookie.length; i++){
				if(listCookie[i].getName().equals("username")){	// đã đăng nhập
					userName = listCookie[i].getValue();	// lưu lại username
					break;
				}
			}
		
		if(userName.equals(""))	// chưa đăng nhập chuyển sang trang đăng nhập
			response.sendRedirect("login.jsp");
		else {
			String resultID = request.getParameter("ResultID");
			if (resultID != null && !resultID.trim().equals("")) {	// chi tiet bai lam
				ArrayList<Question> listQuestion = getListQuestion(resultID);	// lay danh sach cau hoi
				ArrayList<History> listHistory =  new ArrayList<History>();
				for (Question q : listQuestion) {
					listHistory.add(getHistory(q.getQuestionID(), resultID, q.getContent(), q.getImage()));
				}
				/*listHistory.add(getHistory("1", "1", "noi dung cau hoi", "khong co hinh"));
				for (History h : listHistory) {
					response.getWriter().println("câu hỏi: " + h.getQuestionContent());
					response.getWriter().println("Hinh anh: " + h.getImage());
					response.getWriter().println("Đáp án đúng: " + h.getCorrectAnswer());
					response.getWriter().println("\r\nĐáp án chọn: " + h.getChosenAnswer());
					response.getWriter().println("\r\nA. " + h.getAnswerA());
					response.getWriter().println("\r\nB. " + h.getAnswerB());
					response.getWriter().println("\r\nC. " + h.getAnswerC());
					response.getWriter().println("\r\nD. " + h.getAnswerD());
				}
				return;*/
				request.setAttribute("listHistory", listHistory);

				RequestDispatcher rd = request.getRequestDispatcher("history-detail.jsp");
				rd.forward(request, response);
			}
			else {
				request.setAttribute("listResult", getListResult(userName));
				RequestDispatcher rd = request.getRequestDispatcher("history.jsp");
				rd.forward(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	public ArrayList<Result> getListResult(String username){
		ArrayList<Result> listResult = new ArrayList<Result>();
		ResultSet rs = SelectDB.getResult(username);
		try {			
			while (rs.next()) { 
				Result result = new Result();
				result.setResultID(rs.getInt("ResultID"));
				result.setTitleID(rs.getInt("TitleID"));
				result.setUserName(rs.getString("Username"));
				result.setSubjectName(rs.getString("SubjectName"));
				result.setTitleName(rs.getString("TitleName"));
				result.setSchoolYear(rs.getString("Schoolyear"));
				result.setScore(rs.getString("Score"));
				result.setDate(rs.getString("_Date"));
				listResult.add(result);
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listResult;
	}
	
	public ArrayList<Question> getListQuestion(String resultID) {
		ArrayList<Question> listQuestionID = new ArrayList<Question>();
		ResultSet rs = SelectDB.getQuestionOfHistory(resultID);
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
	
	public History getHistory(String questionID, String resultID, String contentQuestion, String image) {	// lấy câu thông tin đáp án từ câu hỏi
		History history = new History();
		ResultSet rs = null;
		try {
			history.setQuestionID(questionID);	// gán mã câu hỏi vào questionID
			history.setQuestionContent(contentQuestion);	// gán nội dung câu hỏi vào questionContent		
			history.setImage(image); // gán tên ảnh vào
			rs = SelectDB.getAnswerOfHistory(questionID, resultID);
			while (rs.next()) {
				history.setChosenAnswer(rs.getString("ChosenAnswer")); // gán đáp án đã chọn
				if(rs.getString("AnswerID").equals("A")) {
					history.setAnswerA(rs.getString("Content"));	// gán nội dung đáp án A vào answerA	
					if (rs.getString("CorrectAnswer").equals("A"))	// nếu đáp án đúng là A
						history.setCorrectAnswer("A");	// gán đáp án đúng vào correctAnswer
				}
				if(rs.getString("AnswerID").equals("B")) {
					history.setAnswerB(rs.getString("Content"));	// gán nội dung đáp án B vào answerB	
					if (rs.getString("CorrectAnswer").equals("B"))	// nếu đáp án đúng là B
						history.setCorrectAnswer("B");	// gán đáp án đúng vào correctAnswer
				}
					
				if(rs.getString("AnswerID").equals("C")) {
					history.setAnswerC(rs.getString("Content"));	// gán nội dung đáp án C vào answerC	
					if (rs.getString("CorrectAnswer").equals("C"))	// nếu đáp án đúng là C
						history.setCorrectAnswer("C");	// gán đáp án đúng vào correctAnswer
				}
				if(rs.getString("AnswerID").equals("D")) {
					history.setAnswerD(rs.getString("Content"));	// gán nội dung đáp án D vào answerD	
					if (rs.getString("CorrectAnswer").equals("D"))	// nếu đáp án đúng là D
						history.setCorrectAnswer("D");	// gán đáp án đúng vào correctAnswer
				}
			}
		}
		catch (Exception e) {  
			e.printStackTrace();  
		} 
		return history;
	}
}
