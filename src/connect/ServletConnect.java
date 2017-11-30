package connect;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ServletConnect")
public class ServletConnect extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public ServletConnect() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().print("Hellooooooooooo!");
		// Create a variable for the connection string.  
		String connectionUrl = "jdbc:sqlserver://localhost:1433;" +  
				"databaseName=CNPM1;integratedSecurity=True"; 

		// Declare the JDBC objects.  
		Connection con = null;  
		Statement stmt = null;  
		ResultSet rs = null;  
		try {
			// Establish the connection.  
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");  
			con = DriverManager.getConnection(connectionUrl);  

			// Create and execute an SQL statement that returns some data.  
			String SQL = "SELECT * FROM Account";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 

			// Iterate through the data in the result set and display it.  
			while (rs.next()) {  
				response.getWriter().println(rs.getString(1) + " | " + rs.getString(2) + " | " + rs.getString(3) + " | " + rs.getString(4) + " | " + rs.getString(5));  
				response.getWriter().println();
			}  
		}  

		// Handle any errors that may have occurred.  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		finally {  
			if (rs != null) try { rs.close(); } catch(Exception e) {}  
			if (stmt != null) try { stmt.close(); } catch(Exception e) {}  
			if (con != null) try { con.close(); } catch(Exception e) {}  
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
