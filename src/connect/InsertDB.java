package connect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import connect.ConnectDB;
public class InsertDB {
	public static void InsertComment(String username, String title, String content){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO Comment VALUES('" + username + "',N'"+ title +"',N'" + content +"',0)";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void InsertAccount(String username, String password, String email, String fullname, String birthday, String country) {
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO Account VALUES('"+ username +"','"+ password +"','member',1); "
					+ "INSERT INTO Information VALUES('"+ username +"',N'"+ fullname +"','"+ birthday +"','"+ email +"',N'"+ country +"');";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void InsertSubject(String subjectName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO Subjects VALUES(N'" + subjectName + "')";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void InsertTitle(int subjectID, String titleName, String schoolYear, int time){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO Title VALUES("+ subjectID +",N'" + titleName + "','"+ schoolYear +"',"+ time +")";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	}
	public static void InsertQuestion(String content, String image){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO Question VALUES(N'" + content + "', N'"+ image +"')";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	}
	public static void InsertAnswer(String answerID, int questionID, String content, String correctAnswer){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO Answer VALUES('"+ answerID +"',"+ questionID +",N'"+ content +"','"+ correctAnswer +"')";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	}
	public static void InsertExaminationDetail(int titleID, int questionID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO ExaminationDetail VALUES("+ titleID +","+ questionID +")";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	}
	public static void InsertResult(String userName, String titleID, String score, String date){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO Result VALUES(" + titleID + ",'"+ userName +"'," + score +",'"+ date +"')";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void InsertResultDetail(String resultID, String questionID, String chosenAnswer){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "INSERT INTO ResultDetail VALUES(" + resultID + ","+ questionID +",'" + chosenAnswer +"')";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
}
