package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect.ConnectDB;
import connect.InsertDB;

@WebServlet("/CommentServlet")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public CommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String username = "";
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		Cookie[] listCookie = request.getCookies();
		if (listCookie != null) {
			for (int i = 0; i < listCookie.length; i++) {
				if (listCookie[i].getName().equals("username")) {
					username = listCookie[i].getValue();	
					InsertDB.InsertComment(username, title, content);
					response.sendRedirect("comment.jsp?sent=1");
					break;
				}
			}
		}
	}
}
