package connect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import connect.ConnectDB;
public class UpdateDB {
	public static void UpdateAccount(String username, String attribute, String value){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "UPDATE Account SET " + attribute + " = N'" + value + "' WHERE Username = '" + username + "'";   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 	
	public static void UpdateInformation(String username, String attribute, String value){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "UPDATE Information SET " + attribute + " = N'" + value + "' WHERE Username = '" + username + "'";   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void UpdateComment(String commentID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "UPDATE Comment SET _Status = 1 WHERE CommentID = " + commentID;   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void UpdateSubject(String oldName, String newName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "UPDATE Subjects SET Name = N'"+ newName +"' WHERE Name = N'" + oldName + "';";   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void UpdateTitle(String titleID, String newSubjectID, String newTitleName, String newSchoolYear, String newTime){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "UPDATE Title SET SubjectID = "+ newSubjectID + ", Name = N'"+ newTitleName
					+ "', Schoolyear = '"+ newSchoolYear +"', _Time = "+ newTime 
					+ " WHERE TitleID = " + titleID + ";";   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void UpdateQuestion(String questionID, String questionContent){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "UPDATE Question SET Content = N'"+ questionContent +"' WHERE QuestionID = " + questionID + ";";   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void UpdateAnswer(String answerID, String questionID, String content, String correctAnswer){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "UPDATE Answer SET Content = N'"+ content +"', CorrectAnswer = '"+ correctAnswer +"' "
					+ "WHERE AnswerID = '" + answerID + "' AND QuestionID = "+ questionID +";";   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
}
