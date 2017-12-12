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
import javax.websocket.Session;

import connect.InsertDB;
import connect.SelectDB;
import model.NewQuestion;
import model.Question;
import model.Subject;
import model.Title;

@WebServlet("/AddExam")
public class AddExam extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public AddExam() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setAttribute("listSubject", getListSubject()); // lấy danh sách môn học
		session.removeAttribute("listQuestionID");
		session.removeAttribute("listNewQuestion");
		request.getRequestDispatcher("add-exam.jsp").forward(request, response);
		
//		ArrayList<NewQuestion> listQ = getListQuestion("");
//		for (NewQuestion q : listQ)
//			response.getWriter().println( q.getQuestionID() + q.getContent());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		request.setAttribute("listSubject", getListSubject()); // lấy danh sách môn học
		HttpSession session = request.getSession();
		String command = request.getParameter("command");
		if(command != null && !command.equals("")) {
			switch(command) {
			case "Thêm":
				ArrayList<Question> listNewQuestionID = (ArrayList<Question>)session.getAttribute("listNewQuestionID");
				String questionID = request.getParameter("questionID");
				String questionContent = request.getParameter("questionContent");
				String questionImage = request.getParameter("questionImage");
				if (listNewQuestionID == null || listNewQuestionID.size() == 0)
					listNewQuestionID = new ArrayList<Question>();
				Question newQ = new Question();
				newQ.setQuestionID(questionID);
				newQ.setContent(questionContent);
				newQ.setImage(questionImage);
				listNewQuestionID.add(newQ);
				session.setAttribute("listNewQuestionID", listNewQuestionID);
				request.setAttribute("listQuestion", getListQuestion(""));	// lấy danh sách câu hỏi
				request.getRequestDispatcher("list-question.jsp").forward(request, response);
				break;
			case "Xóa":
				String id = request.getParameter("questionIDSelected");
				ArrayList<NewQuestion> listNewQuestion = (ArrayList<NewQuestion>)session.getAttribute("listNewQuestion");
				for (int i = 0; i < listNewQuestion.size(); i++) {
					if (listNewQuestion.get(i).getQuestionID().equals(id)) {
						listNewQuestion.remove(i);
					}
				}
				session.removeAttribute("listNewQuestion");
				session.setAttribute("listNewQuestion", listNewQuestion);
				request.getRequestDispatcher("add-exam.jsp").forward(request, response);
				break;
			case "Thêm câu hỏi đã có":
				UpdateTitleDetail(request);
				// cập nhật lại danh sách câu hỏi
				session.removeAttribute("listNewQuestion");
				session.setAttribute("listNewQuestion", UpdateListQuestion(request));
				request.setAttribute("listQuestion", getListQuestion(""));	// lấy danh sách câu hỏi
				request.getRequestDispatcher("list-question.jsp").forward(request, response);
				break;
			case "Thêm câu hỏi mới":
				UpdateTitleDetail(request);
				// cập nhật lại danh sách câu hỏi 
				request.setAttribute("newQuestion", "1");
				session.removeAttribute("listNewQuestion");
				session.setAttribute("listNewQuestion", UpdateListQuestion(request));
				request.getRequestDispatcher("add-exam.jsp").forward(request, response);
				break;
			case "Cập nhật":
				// cập nhật lại thông tin đề thi
				UpdateTitleDetail(request);
				// cập nhật lại danh sách câu hỏi
				session.removeAttribute("listNewQuestion");
				session.setAttribute("listNewQuestion", UpdateListQuestion(request));
				request.getRequestDispatcher("add-exam.jsp").forward(request, response);
				break;
			case "Tìm":
				request.setAttribute("listQuestion", getListQuestion(request.getParameter("keyWord")));	// lấy danh sách câu hỏi theo từ khóa
				request.getRequestDispatcher("list-question.jsp").forward(request, response);
				break;
			case "Quay lại":
				ArrayList<Question> listNew = (ArrayList<Question>)session.getAttribute("listNewQuestionID");	// danh sách câu hỏi đã chọn
				ArrayList<NewQuestion> list = (ArrayList<NewQuestion>)session.getAttribute("listNewQuestion");	// danh sách câu hỏi đang thêm vào
				if(list == null || list.size() == 0)	// tạo mới khi danh sách câu hỏi đang thêm rỗng
					list = new ArrayList<NewQuestion>();
				if(listNew != null && listNew.size() > 0)	// có chọn câu hỏi thì mới thêm để tránh lỗi
					for (Question q : listNew) {
						list.add(getQuestionDetail(q.getQuestionID(), q.getContent(), q.getImage()));
					}
				session.removeAttribute("listNewQuestionID");	// xóa danh sách câu hỏi đã chọn
				session.removeAttribute("listNewQuestion");
				session.setAttribute("listNewQuestion", list);
				request.getRequestDispatcher("add-exam.jsp").forward(request, response);
				break;
			case "Thêm đề thi":
				//Lấy danh sách câu hỏi muốn thêm vào đề
				ArrayList<NewQuestion> listQuestion = UpdateListQuestion(request);
				
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
				if (!existTitle(subjectID,schoolYear,titleName)) {	// kiểm tra đề thi chưa tồn tại thì mới thêm
					InsertDB.InsertTitle(subjectID, titleName, schoolYear, time);	// thêm đề mới vào csdl
					int titleID = getTitleID(subjectID, schoolYear, titleName);		// lấy mã đề thi vừa được thêm vào
					for(NewQuestion n : listQuestion) {
						if (n.getIsNew().equals("true")) {	// câu hỏi mới
							if (!existQuestion(n.getContent())) {	// câu hỏi chưa tồn tại
								InsertDB.InsertQuestion(n.getContent(),"Không");	// thêm câu hỏi đã nhập vào csdl nếu chưa có
								int qID = getQuestionID(n.getContent());	// lấy ID của câu hỏi vừa thêm vào
								// thêm đáp án vào csdl
								InsertDB.InsertAnswer("A", qID, n.getAnswerA(), n.getCorrectAnswer());
								InsertDB.InsertAnswer("B", qID, n.getAnswerB(), n.getCorrectAnswer());
								InsertDB.InsertAnswer("C", qID, n.getAnswerC(), n.getCorrectAnswer());
								InsertDB.InsertAnswer("D", qID, n.getAnswerD(), n.getCorrectAnswer());
								// thêm mã đề và mã câu hỏi vào bảng chi tiết bài thi
								InsertDB.InsertExaminationDetail(titleID, qID);		
							}
							else {	// câu hỏi đã tồn tại
								int qID = getQuestionID(n.getContent());	// lấy ID của câu hỏi vừa thêm vào
								// thêm mã đề và mã câu hỏi vào bảng chi tiết bài thi
								InsertDB.InsertExaminationDetail(titleID, qID);	
							}
						}
						else {	// câu hỏi đã tồn tại
							// thêm mã đề và mã câu hỏi vào bảng chi tiết bài thi
							InsertDB.InsertExaminationDetail(titleID, Integer.parseInt(n.getQuestionID()));	
						}
					}
					session.removeAttribute("listNewQuestion");
					session.removeAttribute("titleDetail");
					request.setAttribute("success", "1");
					request.getRequestDispatcher("add-exam.jsp").forward(request, response);
				}
				else {
					// gửi thông báo đề thi đã tồn tại
					UpdateTitleDetail(request);
					request.setAttribute("success", "0");
					request.getRequestDispatcher("add-exam.jsp").forward(request, response);
				}
				break;
			}
		}
	}
	
	public void UpdateTitleDetail(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Title t = new Title();
		if (	request.getParameter("subjectID") == null || 
				request.getParameter("subjectID").trim().equals("") || 
				request.getParameter("subjectID").equals("Chọn môn học"))
			t.setSubjectID("-1");
		else
			t.setSubjectID(request.getParameter("subjectID"));
		t.setTitleName(request.getParameter("titleName"));
		t.setSchoolYear(request.getParameter("schoolYear"));
		String time = request.getParameter("time");
		if(time != null && !time.equals(""))
			t.setTime(Integer.parseInt(time));
		else
			t.setTime(0);
		if (session.getAttribute("titleDetail") != null)
			session.removeAttribute("titleDetail");
		session.setAttribute("titleDetail", t);
		System.out.println("Mã môn: "+t.getSubjectID());
		System.out.println("Tên đề: "+t.getTitleName());
		System.out.println("Năm học: "+t.getSchoolYear());
		System.out.println("Thời gian: "+t.getTime());
	}
	
	public ArrayList<NewQuestion> UpdateListQuestion(HttpServletRequest request){
		ArrayList<NewQuestion> listNewQuestion = new ArrayList<NewQuestion>();
		String number = request.getParameter("numberOfQuestion");
		if(number != null && !number.equals("")) {
			int n = Integer.parseInt(number.trim());
			for (int i = 1; i < n; i++) {
				NewQuestion nQ = new NewQuestion();
				nQ.setQuestionID(request.getParameter("questionID" + i));
				System.out.println(request.getParameter("questionContent" + i));
				nQ.setContent(request.getParameter("questionContent"+ i));
				nQ.setAnswerA(request.getParameter("answerA" + i));
				nQ.setAnswerB(request.getParameter("answerB" + i));
				nQ.setAnswerC(request.getParameter("answerC" + i));
				nQ.setAnswerD(request.getParameter("answerD" + i));
				nQ.setCorrectAnswer(request.getParameter("correctAnswer" + i));
				nQ.setIsNew(request.getParameter("isNew" + i));
				nQ.setImage("Không");
				listNewQuestion.add(nQ);
			}
		}
		return listNewQuestion;
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
	
	public NewQuestion getQuestionDetail(String questionID, String questionContent, String questionImage) {
		NewQuestion question = new NewQuestion();
		try {	
			question.setQuestionID(questionID);
			question.setContent(questionContent);
			question.setImage(questionImage);
			question.setIsNew("false");
			ResultSet rs = SelectDB.getAnswer(questionID);
			while (rs.next()) {
				if (rs.getString("AnswerID").equals("A"))
					question.setAnswerA(rs.getString("Content"));
				if (rs.getString("AnswerID").equals("B"))
					question.setAnswerB(rs.getString("Content"));
				if (rs.getString("AnswerID").equals("C"))
					question.setAnswerC(rs.getString("Content"));
				if (rs.getString("AnswerID").equals("D"))
					question.setAnswerD(rs.getString("Content"));
				question.setCorrectAnswer(rs.getString("CorrectAnswer"));
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return question;
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
