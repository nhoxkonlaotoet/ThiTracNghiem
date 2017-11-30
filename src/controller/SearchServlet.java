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

import connect.SelectDB;
import model.Title;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public SearchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("listTitle", getListTitle());	
		RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String type = request.getParameter("type");
		String keyWord = request.getParameter("keyWord");
		if(type != null & !type.trim().equals("") && keyWord != null && !keyWord.trim().equals("")) {
			switch (type){
			case "subject":
				request.setAttribute("listTitle", getListTitleBySubject(keyWord));
				break;
			case "title":
				request.setAttribute("listTitle", getListTitleByTitle(keyWord));
				break;
			case "schoolyear":
				request.setAttribute("listTitle", getListTitleBySchoolYear(keyWord));
				break;
			}
		}
		else{
			request.setAttribute("listTitle", getListTitle());
		}
		RequestDispatcher rd = request.getRequestDispatcher("search.jsp");
		rd.forward(request, response);
	}
	
	public ArrayList<Title> getListTitle(){
		ArrayList<Title> listTitle = new ArrayList<Title>();
		ResultSet rs = SelectDB.getTitle(null);
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
	
	public ArrayList<Title> getListTitleBySubject(String subjectName){
		ArrayList<Title> listTitle = new ArrayList<Title>();
		ResultSet rs = SelectDB.getTitleBySubject(subjectName);
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
	
	public ArrayList<Title> getListTitleByTitle(String titleName){
		ArrayList<Title> listTitle = new ArrayList<Title>();
		ResultSet rs = SelectDB.getTitleByTitle(titleName);
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
	
	public ArrayList<Title> getListTitleBySchoolYear(String schoolYear){
		ArrayList<Title> listTitle = new ArrayList<Title>();
		ResultSet rs = SelectDB.getTitleBySchoolYear(schoolYear);
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
}
