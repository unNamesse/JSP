package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;  //자바와 데이터베이스를연결
	private PreparedStatement pstmt;  //쿼리문 대기및 설정
	private ResultSet rs;  //결과값
	
	public UserDAO(){
		try {
			String dbURL="jdbc:mariadb://localhost:3306/bbs";
			String dbID="root"; //계정
			String dbPassword="123456"; //비번
			Class.forName("org.mariadb.jdbc.Driver"); //jdbc연결 클래스를 String 타입으로연결
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
			//드라이버 메니저에 미리 저장했던 연결 url솨db계정정보를담아연결설정
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//login
	public int login(String userID, String userPassword) {
		String sql="select userPassword from user where userID=?";
		try {
			pstmt=conn.prepareStatement(sql); //쿼리문을 대기 시킨다
			pstmt.setString(1, userID); //첫번쨰 ?에 매개변수로받아온 값을 대입
			rs=pstmt.executeQuery(); //쿼리를 실행한결과를 rs에 저장
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;  //로그인성공
				}else {
					return 0;  //비밀번호실패
				}
			}
			return -1; //아이디없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //오류
	}
	//조인-회원가입
	public int join(User user) {
		String sql="insert into user values(?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();//실행문
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
}
