package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect.ConnectDB;
import connect.InsertDB;
import connect.SelectDB;
//servlet đăng ký và đăng nhập
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public UserServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String command = request.getParameter("command");
		switch(command) {
		case "register":
			String err ="";
			String username = request.getParameter("username");
			String password = request.getParameter("password");			
			String email = request.getParameter("email");
			if(username != null && username.trim() != ""){
				if (AccountExist(username))//username already exist
					err = err + "&Acc=1";
			}
			if(email != null && email.trim() != ""){
				if(EmailExist(email))	// email exists
					err = err + "&Ema=1"; //Email was used
				//else
				//	err = err + "&Ema=2";
			}
			if (username.trim() == "" || username == null)
				err = err + "&Acc=0"; 
			if (email.trim() == "" || email == null)
				err = err + "&Ema=0"; 	// forget to fill email 
			if (password.trim() == "" || password == null || password.length() < 6)		
				err = err + "&Pas=1"; // password invalid
			if (!AccountExist(username) && username.trim() != "" 
					&& !EmailExist(email) && email.trim() != ""
					&& password.trim().length() >= 6) {
				String fullname = request.getParameter("fullname");
				String birthday = request.getParameter("birthday");
				String country = request.getParameter("country");
				InsertDB.InsertAccount(username, password, email, fullname, birthday, country);
				err = "&Acc=2";
			}
			response.sendRedirect("register.jsp?"+ err);
			break;
		case "login":
			String username2 = request.getParameter("username");
			String password2 = request.getParameter("password");
			if(login(username2, password2, request)){	// login successful
				Cookie[] listCookie = request.getCookies();
				if(listCookie != null)
					for(int i = 0; i < listCookie.length; i++) {
						if(listCookie[i].getName().equals("username"))
							listCookie[i].setMaxAge(0);
						if(listCookie[i].getName().equals("password"))
							listCookie[i].setMaxAge(0);
						if(listCookie[i].getName().equals("role"))
							listCookie[i].setMaxAge(0);
					}
				Cookie usernameCookie = new Cookie("username",username2);
				usernameCookie.setMaxAge(60*60*24);	
				response.addCookie(usernameCookie);
				Cookie passwordCookie = new Cookie("password",password2);
				passwordCookie.setMaxAge(60*60*24);
				response.addCookie(passwordCookie);
				Cookie roleCookie = new Cookie("role",(String)request.getAttribute("role"));
				roleCookie.setMaxAge(60*60*24);
				response.addCookie(roleCookie);
				response.sendRedirect("index.jsp");

			}

			else{	// login failed
				response.sendRedirect("login.jsp?err=1");
			}
			break;
		}

	}


	public boolean login(String username, String password, HttpServletRequest request) {
		ResultSet rs = null;  
		try {
			rs = SelectDB.getAccountLogin(username, password); 
			while (rs.next()) {
				request.setAttribute("role", rs.getString("_Role"));
				return true;
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}
	public boolean AccountExist(String username)
	{
		ResultSet rs = null;
		try {
			rs = SelectDB.getAccount(username);
			while (rs.next()) {
				return true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public boolean EmailExist(String email)
	{
		ResultSet rs = null;
		try {
			rs = SelectDB.getEmail(email);
			while (rs.next()) {
				return true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
