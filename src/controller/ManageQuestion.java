package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connect.InsertDB;
import connect.SelectDB;
import model.Answer;
import model.NewQuestion;
import model.Question;

@WebServlet("/ManageQuestion")
public class ManageQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public ManageQuestion() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Answer> list = new ArrayList<Answer>();
		for (Question q : getListQuestion("")) {
			list.add(getQuestionDetail(q.getQuestionID(), q.getContent(), q.getImage()));
		}
		HttpSession session = request.getSession();
		session.setAttribute("keyWord", "");
		request.setAttribute("listQuestion", list);
		request.getRequestDispatcher("manage-question.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		String command = request.getParameter("command");
		if(command != null && !command.equals("")) {
			switch(command) {
			case "Tìm":
				ArrayList<Answer> list = new ArrayList<Answer>();
				for (Question q : getListQuestion(request.getParameter("keyWord"))) {
					list.add(getQuestionDetail(q.getQuestionID(), q.getContent(), q.getImage()));
				}
				System.out.print(request.getParameter("keyWord").toString());
				request.setAttribute("listQuestion", list);	
				session.setAttribute("keyWord", request.getParameter("keyWord"));
				request.getRequestDispatcher("manage-question.jsp").forward(request, response);
				break;
			case "Quay lại":
				response.sendRedirect("manager.jsp");
				break;
			case "Sửa":
				ArrayList<Answer> listA = new ArrayList<Answer>();
				for (Question q : getListQuestion((String)session.getAttribute("keyWord"))) {
					listA.add(getQuestionDetail(q.getQuestionID(), q.getContent(), q.getImage()));
				}
				request.setAttribute("listQuestion", listA);	
				//request.setAttribute("keyWord", session.getAttribute("keyWord"));
				String questionID = request.getParameter("questionID");	// lấy mã câu hỏi được chọn
				System.out.println(questionID);
				request.setAttribute("questionIDSelected", questionID);
				request.getRequestDispatcher("manage-question.jsp").forward(request, response);
				break;
			case "Xác nhận":
				ArrayList<Answer> listAn = new ArrayList<Answer>();
				for (Question q : getListQuestion((String)session.getAttribute("keyWord"))) {
					listAn.add(getQuestionDetail(q.getQuestionID(), q.getContent(), q.getImage()));
				}
				request.setAttribute("listQuestion", listAn);	
				//request.setAttribute("keyWord", session.getAttribute("keyWord"));
				request.getRequestDispatcher("manage-question.jsp").forward(request, response);
				break;
			case "Thêm câu hỏi":
				request.getRequestDispatcher("add-question.jsp").forward(request, response);
				break;
			}
		}
		String commandA = request.getParameter("commandA");
		if(commandA != null && !commandA.equals("")) {
			switch(commandA) {
			case "Thêm":
				String content = request.getParameter("content");
				String answerA = request.getParameter("answerA");
				String answerB = request.getParameter("answerB");
				String answerC = request.getParameter("answerC");
				String answerD = request.getParameter("answerD");
				String correctAnswer = request.getParameter("correctAnswer");
				if(content != null && !content.equals("") &&
						answerA != null && !answerA.equals("") &&
						answerB != null && !answerB.equals("") &&
						answerC != null && !answerC.equals("") &&
						answerD != null && !answerD.equals("")) {
					if (!existQuestion(content)) {	// câu hỏi chưa tồn tại
						InsertDB.InsertQuestion(content,"Không");	// thêm câu hỏi đã nhập vào csdl nếu chưa có
						int qID = getQuestionID(content);	// lấy ID của câu hỏi vừa thêm vào
						// thêm đáp án vào csdl
						InsertDB.InsertAnswer("A", qID, answerA, correctAnswer);
						InsertDB.InsertAnswer("B", qID, answerB, correctAnswer);
						InsertDB.InsertAnswer("C", qID, answerC, correctAnswer);
						InsertDB.InsertAnswer("D", qID, answerD, correctAnswer);
						request.setAttribute("error", 0);
						request.getRequestDispatcher("add-question.jsp").forward(request, response);
					}
					else {	// câu hỏi đã tồn tại
						request.setAttribute("error", 1);
						request.setAttribute("content", content);
						request.setAttribute("answerA", answerA);
						request.setAttribute("answerB", answerB);
						request.setAttribute("answerC", answerC);
						request.setAttribute("answerD", answerD);
						request.setAttribute("correctAnswer", correctAnswer);
						request.getRequestDispatcher("add-question.jsp").forward(request, response);
					}
				}
				else {	// chưa nhập đủ thông tin
					request.setAttribute("error", 2);
					request.setAttribute("content", content);
					request.setAttribute("answerA", answerA);
					request.setAttribute("answerB", answerB);
					request.setAttribute("answerC", answerC);
					request.setAttribute("answerD", answerD);
					request.setAttribute("correctAnswer", correctAnswer);
					request.getRequestDispatcher("add-question.jsp").forward(request, response);
				}
				break;
			case "Làm mới":
				request.setAttribute("content", "");
				request.setAttribute("answerA", "");
				request.setAttribute("answerB", "");
				request.setAttribute("answerC", "");
				request.setAttribute("answerD", "");
				request.setAttribute("correctAnswer", "");
				request.getRequestDispatcher("add-question.jsp").forward(request, response);
				break;
			case "Quay lại":
				ArrayList<Answer> listA = new ArrayList<Answer>();
				for (Question q : getListQuestion((String)session.getAttribute("keyWord"))) {
					listA.add(getQuestionDetail(q.getQuestionID(), q.getContent(), q.getImage()));
				}
				request.setAttribute("listQuestion", listA);
				request.getRequestDispatcher("manage-question.jsp").forward(request, response);
				break;
			
			}
		}
	}

	public ArrayList<Question> getListQuestion(String keyWord) {
		ArrayList<Question> listNewQuestion = new ArrayList<Question>();
		ResultSet rs = SelectDB.getQuestion2(keyWord);
		try {			
			while (rs.next()) {
				Question question = new Question();
				question.setQuestionID(rs.getString("QuestionID"));
				question.setContent(rs.getString("Content"));
				question.setImage(rs.getString("_Image"));
				
				listNewQuestion.add(question);
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listNewQuestion;
	}
	
	public Answer getQuestionDetail(String questionID, String questionContent, String questionImage) {
		Answer a = new Answer();
		try {	
			a.setQuestionID(questionID);
			a.setQuestionContent(questionContent);
			a.setImage(questionImage);
			ResultSet rs = SelectDB.getAnswer(questionID);
			while (rs.next()) {
				if (rs.getString("AnswerID").equals("A"))
					a.setAnswerA(rs.getString("Content"));
				if (rs.getString("AnswerID").equals("B"))
					a.setAnswerB(rs.getString("Content"));
				if (rs.getString("AnswerID").equals("C"))
					a.setAnswerC(rs.getString("Content"));
				if (rs.getString("AnswerID").equals("D"))
					a.setAnswerD(rs.getString("Content"));
				a.setCorrectAnswer(rs.getString("CorrectAnswer"));
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return a;
	}
	
	public boolean existQuestion(String content) {
		try {			
			ResultSet rs = SelectDB.getQuestion(content);
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
}
