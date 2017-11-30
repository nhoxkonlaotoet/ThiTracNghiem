package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect.ConnectDB;

/**
 * Servlet implementation class testttt
 */
@WebServlet("/testttt")
public class testttt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public testttt() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//String delete = request.getParameter("delete");
		//response.getWriter().println(delete);
		//response.sendRedirect("index.jsp");
		if (checkConnect(request, response)) {
			response.getWriter().println("kết nối thành công");
		}
		else
			response.getWriter().println("kết nối thất bại");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String username = request.getParameter("username");
		response.getWriter().print(username);
	}
	public boolean checkConnect(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Connection con = ConnectDB.getConnection();
		java.sql.Statement stmt = null; 
		ResultSet rs = null;  
		String sql = "select * from Account";	
		try {
			stmt = con.createStatement();  
			rs = stmt.executeQuery(sql); 
			while (rs.next()) {
				//response.getWriter().println(rs.getString("Username"));
				return true;
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
