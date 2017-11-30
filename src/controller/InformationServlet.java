package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect.ConnectDB;
import connect.SelectDB;
import connect.UpdateDB;
import model.Information;

/**
 * Servlet implementation class informationServlet
 */
@WebServlet("/InformationServlet")
public class InformationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InformationServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		getInformation(request, response);
		RequestDispatcher dispatcher=request.getRequestDispatcher("personal.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		getInformation(request, response);
		String type = request.getParameter("type");
		String change = request.getParameter("change");
		switch(type) {
		case "name":
			request.setAttribute("changename", "1");
			RequestDispatcher rd1 = request.getRequestDispatcher("personal.jsp");
			rd1.forward(request, response);
			break;		
		case "password":
			request.setAttribute("changepassword", "1");
			RequestDispatcher rd2 = request.getRequestDispatcher("personal.jsp");
			rd2.forward(request, response);
			break;
		case "country":
			request.setAttribute("changecountry", "1");
			RequestDispatcher rd3 = request.getRequestDispatcher("personal.jsp");
			rd3.forward(request, response);
			break;
		}
		switch(change) {
		case "changename":
			request.setAttribute("changename", null);
			String name = request.getParameter("name");	// new name
			//response.getWriter().print(name);
			//changeData(request.getParameter("username"), "Information", "FullName", name, request);	// change name in Database
			UpdateDB.UpdateInformation(request.getParameter("username"), "FullName", name);
			request.setAttribute("info",updateInformation(request.getParameter("username")));	// update new info
			RequestDispatcher rd1 = request.getRequestDispatcher("personal.jsp");
			rd1.forward(request, response);
			break;
		case "changepassword":
			request.setAttribute("changepassword", null);
			String password = request.getParameter("password"); // new password
			//changeData(request.getParameter("username"), "Account", "_Password", password, request);	// change password in Database
			UpdateDB.UpdateAccount(request.getParameter("username"), "_Password", password);
			request.setAttribute("info", updateInformation(request.getParameter("username")));	// update new info
			RequestDispatcher rd2 = request.getRequestDispatcher("personal.jsp");
			rd2.forward(request, response);
			break;
		case "changecountry":
			request.setAttribute("changecountry", null);
			String country = request.getParameter("country"); // new country
			//changeData(request.getParameter("username"), "Information", "Country", country, request);	// change country in Database
			UpdateDB.UpdateInformation(request.getParameter("username"), "Country", country);
			request.setAttribute("info", updateInformation(request.getParameter("username")));	// update new info
			RequestDispatcher rd3 = request.getRequestDispatcher("personal.jsp");
			rd3.forward(request, response);
			break;
		}
	}
	public void getInformation(HttpServletRequest request, HttpServletResponse response) {
		//PrintWriter out = response.getWriter();  
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");

		ResultSet rs = null;  
		String username = "";
		Cookie[] listCookie = request.getCookies();
		Information info = new Information();
		if (listCookie != null) {
			for (int i = 0; i < listCookie.length; i++) {
				if (listCookie[i].getName().equals("username"))
					username = listCookie[i].getValue();
			}
			try {
				rs = SelectDB.getInformation(username);
				while (rs.next()) {  
					info.setUsername(rs.getString("Username"));
					info.setPassword(rs.getString("_Password"));
					info.setRole(rs.getString("_Role"));
					info.setFullname(rs.getString("Fullname"));
					info.setEmail(rs.getString("Email"));
					info.setCountry(rs.getString("Country")); 
					request.setAttribute("info",info);					
				}
			}  
			catch (Exception e) {  
				e.printStackTrace();  
			}  
		}

	}
	public Information updateInformation(String username) {	// update new info
		Information info = new Information();
		ResultSet rs = null;
		try {
			rs = SelectDB.getInformation(username);
			while (rs.next()) {  
				info.setUsername(rs.getString("Username"));
				info.setPassword(rs.getString("_Password"));
				info.setRole(rs.getString("_Role"));
				info.setFullname(rs.getString("Fullname"));
				info.setEmail(rs.getString("Email"));
				info.setCountry(rs.getString("Country"));
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return info;
	}
	public void changeData(String username, String table, String type, String value, HttpServletRequest request) {	
		try {
					
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	}
}
