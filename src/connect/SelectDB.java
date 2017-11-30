package connect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import connect.ConnectDB;
public class SelectDB {
	public static ResultSet getListAccount(){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Account LEFT OUTER JOIN Information ON Account.Username = Information.Username";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	public static ResultSet getAccountLogin(String username, String password){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Account WHERE Username='" + username + "' AND _Password='" + password + "' AND _Status = 1";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	public static ResultSet getAccount(String username){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Account WHERE Username='" + username + "'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	public static ResultSet getEmail(String email){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Information WHERE Email='" + email + "'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	public static ResultSet getSubject(){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Subjects";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	public static ResultSet getSchoolYear(int subjectID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT Schoolyear FROM Title WHERE SubjectID = "+ subjectID +" GROUP BY Schoolyear"; 
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	public static ResultSet getTitleName(int subjectID, String schoolyear){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT Name FROM Title WHERE SubjectID = " + subjectID + " AND Schoolyear = '" + schoolyear + "'"; 
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 

	public static ResultSet getAnswer(String questionID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Answer WHERE QuestionID = '" + questionID + "'"; 
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getQuestionExam(int titleID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT ExaminationDetail.QuestionID, Question.Content, Question._Image FROM ExaminationDetail,Question WHERE "
					+ "ExaminationDetail.QuestionID = Question.QuestionID "
					+ "AND ExaminationDetail.TitleID = " + titleID;  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getQuestionOfHistory(String resultID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT ResultDetail.QuestionID, Question.Content, Question._Image " 
						+"FROM ResultDetail, Question WHERE ResultDetail.QuestionID = Question.QuestionID AND ResultID = " + resultID;  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getAnswerOfHistory(String questionID, String resultID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT Answer.AnswerID, Answer.Content, Answer.CorrectAnswer, ResultDetail.ChosenAnswer " 
						+ "FROM Question, Answer, ResultDetail "
						+ "WHERE Question.QuestionID = Answer.QuestionID and Question.QuestionID = ResultDetail.QuestionID "
						+ "AND ResultID = "+ resultID +" AND Question.QuestionID = " + questionID;  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getTitleID(int subjectID, String schoolYear, String titleName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT TitleID FROM Title WHERE SubjectID = "+ subjectID +" AND Schoolyear = '"+ schoolYear +"' AND Name = '"+ titleName +"'";   
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	public static ResultSet getInformation(String username){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT Account.Username, Account._Password, Account._Role, Information.FullName, Information.Email, Information.Country "
					+ "FROM Account LEFT OUTER JOIN Information ON Account.Username = Information.Username "
					+ "WHERE Account.Username ='" + username +"'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;	
	}
	public static ResultSet getComment(){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Comment";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	public static ResultSet getTitle(String subjectName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "";
			if (subjectName != null)
				SQL = "SELECT TitleID, Subjects.Name AS SubjectName, Title.Name AS TitleName, Title.Schoolyear, Title._Time FROM Subjects,Title "
						+ "WHERE Subjects.SubjectID = Title.SubjectID AND Subjects.Name = N'" + subjectName + "'"; 
			else
				SQL = "SELECT TitleID, Subjects.Name AS SubjectName, Title.Name AS TitleName, Title.Schoolyear, Title._Time FROM Subjects,Title "
						+ "WHERE Subjects.SubjectID = Title.SubjectID"; 
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getTitleBySubject(String subjectName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT TitleID, Subjects.Name AS SubjectName, Title.Name AS TitleName, Title.Schoolyear, Title._Time FROM Subjects,Title "
						+ "WHERE Subjects.SubjectID = Title.SubjectID AND Subjects.Name like N'%"+ subjectName +"%'"; 
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getTitleByTitle(String titleName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT TitleID, Subjects.Name AS SubjectName, Title.Name AS TitleName, Title.Schoolyear, Title._Time FROM Subjects,Title "
						+ "WHERE Subjects.SubjectID = Title.SubjectID AND Title.Name like N'%"+ titleName +"%'"; 
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getTitleBySchoolYear(String schoolYear){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT TitleID, Subjects.Name AS SubjectName, Title.Name AS TitleName, Title.Schoolyear, Title._Time FROM Subjects,Title "
						+ "WHERE Subjects.SubjectID = Title.SubjectID AND Schoolyear like N'%"+ schoolYear +"%'"; 
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;		
	} 
	
	public static ResultSet getTitleInfomation(int titleID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT TitleID, Subjects.Name AS SubjectName, Title.Name AS TitleName, Title.Schoolyear, Title._Time FROM Subjects,Title "
					+ "WHERE Subjects.SubjectID = Title.SubjectID AND TitleID = "+ titleID;
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	
	public static ResultSet getQuestion(String content){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Question WHERE Content = N'"+ content +"'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	
	public static boolean ExistQuestion(String content){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Question WHERE Content = N'"+ content +"'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
			while(rs.next())
				return true;
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return false;
	} 
	
	public static ResultSet getResultz(String userName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT * FROM Question WHERE Content = N'"+ userName +"'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 

	public static ResultSet getResult(String username){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT ResultID, Result.TitleID, Result.Username, Subjects.Name AS SubjectName, "
					+ "Title.Name AS TitleName, Title.Schoolyear, Score, _Date "
					+ "FROM Result,Title,Subjects WHERE Result.TitleID = Title.TitleID AND Title.SubjectID = Subjects.SubjectID " 
					+ "AND Username ='" + username +"'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;	
	}
	public static String getResultID(){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		String id = "";
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT Max(ResultID) AS ID FROM Result";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
			while(rs.next()) {
				id = rs.getString("ID");
				return id;
			}
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return id;
	} 
	
	public static ResultSet getQuestionIDFromTitle(String titleID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT QuestionID FROM ExaminationDetail WHERE TitleID = " + titleID;
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
	public static ResultSet getTitleIDFromSubject(String subjectName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {
			con = ConnectDB.getConnection();
			String SQL = "SELECT Title.TitleID FROM Subjects,Title WHERE Subjects.SubjectID = Title.SubjectID AND Subjects.Name = N'"+ subjectName +"'";
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
		return rs;
	} 
}
