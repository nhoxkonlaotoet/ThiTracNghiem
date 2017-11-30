package connect;
import java.sql.Connection;
import java.sql.DriverManager;
public class ConnectDB {
	public static Connection getConnection(){
		String connectionUrl = "jdbc:sqlserver://localhost:1433;" +  
				"databaseName=LTW;integratedSecurity=True";  
		Connection conn = null;
        try {
        	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");  
			conn = DriverManager.getConnection(connectionUrl);  
        } catch (Exception e) {
            e.printStackTrace();	
        }
        return conn;
	}
	public static void main(String[] args) {
		System.out.println(getConnection());
	}
}
