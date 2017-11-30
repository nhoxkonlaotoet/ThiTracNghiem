package connect;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import connect.ConnectDB;
public class DeleteDB {
	public static void DeleteSubject(String subjectName){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {	
			con = ConnectDB.getConnection();
			rs = SelectDB.getTitleIDFromSubject(subjectName);
			while(rs.next()) { // xóa đề thi trước khi xóa môn thi
				DeleteTitle(rs.getString("TitleID"));
			}
			String SQL = "DELETE Subjects WHERE Name = N'" + subjectName + "'";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void DeleteTitle(String titleID){
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs1 = null;
		try {	
			con = ConnectDB.getConnection();
			rs1 = SelectDB.getQuestionIDFromTitle(titleID);
			while(rs1.next()) {
				String SQL = "DELETE ExaminationDetail WHERE QuestionID = "+ rs1.getString("QuestionID"); // xóa ExaminationID theo QuestionID 
				stmt = con.createStatement();  
				ResultSet rs2 = stmt.executeQuery(SQL);
				DeleteQuestion(rs1.getString("QuestionID"));
			}
			String sql = "DELETE Title WHERE TitleID = "+ titleID; // xóa đề thi
			stmt = con.createStatement();  
			rs1 = stmt.executeQuery(sql);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
	public static void DeleteQuestion(String questionID){	
		Connection con = null;  
		Statement stmt = null;
		ResultSet rs = null;
		try {	 
			con = ConnectDB.getConnection();
			// xóa câu hỏi thì phải xóa đáp án trước
			String SQL = "DELETE Answer WHERE QuestionID = " + questionID 
					+ "; DELETE Question WHERE QuestionID = " + questionID;  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL);
		}  
		catch (Exception e) {  
			e.printStackTrace();  
		}  
	} 
}
