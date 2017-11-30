package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * LoginController
 * Servlet xá»­ lÃ½ Ä‘Äƒng nháº­p vÃ  Ä‘iá»�u hÆ°á»›ng
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("login");
		if("0".equals(login)) {	// remove cookie
			Cookie[] listCookie = request.getCookies();
			if(listCookie != null) {
				for(int i = 0; i < listCookie.length; i++) {
					if(listCookie[i].getName().equals("username")) {
						listCookie[i].setMaxAge(0);
						response.addCookie(listCookie[i]);
					}
					if(listCookie[i].getName().equals("password")) {
						listCookie[i].setMaxAge(0);
						response.addCookie(listCookie[i]);
					}		
					if(listCookie[i].getName().equals("role")) {
						listCookie[i].setMaxAge(0);
						response.addCookie(listCookie[i]);
					}		
				}
			}
		}
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
