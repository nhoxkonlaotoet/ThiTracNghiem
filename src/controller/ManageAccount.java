package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Response;

import connect.ConnectDB;
import connect.SelectDB;
import connect.UpdateDB;
import model.Account;

@WebServlet("/ManageAccount")
public class ManageAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public ManageAccount() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ArrayList<Account> listAccount = getListAccount();
		request.setAttribute("listAccount", listAccount);
		RequestDispatcher rd = request.getRequestDispatcher("manage-account.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String command = request.getParameter("command");
		String username = request.getParameter("username");
		ArrayList<Account> listAccount = getListAccount();
		request.setAttribute("listAccount", listAccount);
		switch(command) {
		case "Thay đổi":
			request.setAttribute("username", username);
			break;
		case "Xác nhận":
			String newFullname = request.getParameter("newfullname");
			String newEmail = request.getParameter("newemail");
			UpdateDB.UpdateInformation(username, "Fullname", newFullname);
			UpdateDB.UpdateInformation(username, "Email", newEmail);
			listAccount = getListAccount();	// re-update list account
			request.setAttribute("listAccount", listAccount);
			request.setAttribute("username", null);
			break;
		case "Hủy":
			request.setAttribute("username", null);
			break;
		case "Khóa":
			UpdateDB.UpdateAccount(username, "_Status", "false");
			listAccount = getListAccount();	// re-update list account
			request.setAttribute("listAccount", listAccount);
			request.setAttribute("username", null);
			break;
		case "Mở khóa":
			UpdateDB.UpdateAccount(username, "_Status", "true");
			listAccount = getListAccount();	// re-update list account
			request.setAttribute("listAccount", listAccount);
			request.setAttribute("username", null);
			break;
		case "+":
			UpdateDB.UpdateAccount(username, "_Role", "manager");
			listAccount = getListAccount();	// re-update list account
			request.setAttribute("listAccount", listAccount);
			request.setAttribute("username", null);
			break;
		case "-":
			UpdateDB.UpdateAccount(username, "_Role", "member");
			listAccount = getListAccount();	// re-update list account
			request.setAttribute("listAccount", listAccount);
			request.setAttribute("username", null);
			break;
		}
		RequestDispatcher rd = request.getRequestDispatcher("manage-account.jsp");
		rd.forward(request, response);
	}
	
	public ArrayList<Account> getListAccount() {
		ArrayList<Account> listAccount = new ArrayList<Account>();
		ResultSet rs = null;
		try {
			rs = SelectDB.getListAccount();
			while (rs.next()) { 
				Account account = new Account();
				account.setUsername(rs.getString("Username"));
				account.setFullname(rs.getString("Fullname"));
				account.setRole(rs.getString("_Role"));
				account.setEmail(rs.getString("Email"));
				account.setStatus(rs.getBoolean("_Status"));
				listAccount.add(account);
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return listAccount;
	}
}
