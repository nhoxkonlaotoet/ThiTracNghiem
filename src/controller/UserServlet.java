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
			String fullname = request.getParameter("fullname");
			String birthday = request.getParameter("birthday");
			String country = request.getParameter("country");

			request.setAttribute("username", username);
			request.setAttribute("password", password);
			request.setAttribute("email", email);
			request.setAttribute("fullname", fullname);
			request.setAttribute("birthday", birthday);
			request.setAttribute("country", country);
			
			if(username != null && username.trim() != ""){
				if (AccountExist(username))//username already exist
					request.setAttribute("Acc", "1");
			}
			if(email != null && email.trim() != ""){
				if(EmailExist(email))	// email exists
					request.setAttribute("Ema", "1"); //Email was used
			}
			if (username.trim() == "" || username == null)
				request.setAttribute("Acc", "0");
			if (email.trim() == "" || email == null)
				request.setAttribute("Ema", "0");
			if (password.trim() == "" || password == null || password.length() < 6)	
				request.setAttribute("Pas", "1"); // password invalid
			if (!AccountExist(username) && username.trim() != "" 
					&& !EmailExist(email) && email.trim() != ""
					&& password.trim().length() >= 6) {
				InsertDB.InsertAccount(username, password, email, fullname, birthday, country);
				request.setAttribute("Acc", "2");
				// đăng ký thành công rồi thì reset tất cả các ô nhập liệu lại

				request.setAttribute("username", "");
				request.setAttribute("password", "");
				request.setAttribute("email", "");
				request.setAttribute("fullname", "");
				request.setAttribute("birthday", "");
				request.setAttribute("country", "");
			}
			request.getRequestDispatcher("register.jsp").forward(request, response);
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
				request.setAttribute("err", "1");
				request.setAttribute("username", username2);
				request.getRequestDispatcher("login.jsp").forward(request, response);
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
