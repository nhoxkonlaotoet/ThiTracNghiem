package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connect.SelectDB;
import connect.UpdateDB;
import model.Comment;

@WebServlet("/ManageComment")
public class ManageComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public ManageComment() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("listComment", getComment());
		RequestDispatcher rd = request.getRequestDispatcher("manage-comment.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String commentID = request.getParameter("commentID");
		if (commentID != null)
			UpdateDB.UpdateComment(commentID);
		request.setAttribute("listComment", getComment());
		RequestDispatcher rd = request.getRequestDispatcher("manage-comment.jsp");
		rd.forward(request, response);
	}
	
	public ArrayList<Comment> getComment() {
		ArrayList<Comment> listComment = new ArrayList<Comment>();
		ResultSet rs = null;  
		try {
			rs = SelectDB.getComment();
			while (rs.next()) {
				Comment comment = new Comment();
				comment.setCommentID(rs.getString("CommentID"));
				comment.setUsername(rs.getString("Username"));
				comment.setTitle(rs.getString("Title"));
				comment.setContent(rs.getString("Content"));
				comment.setStatus(rs.getBoolean("_Status"));
				listComment.add(comment);
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return listComment;
	}
}
