package member.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import member.model.vo.Member;
import static common.JDBCTemplate.close;

/**
 * DAO Data Access Object
 * 
 * PreparedStatement객체 생성(쿼리필요)
 * 쿼리실행 및 결과 Service단으로 리턴
 * - DML int리턴 
 * - DQL ResultSet리턴 -> 자바객체로 데이터 이전
 * 
 * 자원반납
 */
public class MemberDao {

	private Properties prop = new Properties(); //prop 이라는 properties형식의 변수생성
	
	/**
	 * 객체 생성시 member-query.properties의 내용을 읽어다 prop필드에 저장
	 */
	public MemberDao() {
		String fileName = "/sql/member/member-query.properties";
		String path = MemberDao.class.getResource(fileName).getPath();
		//우리가 웹상에서사용하는 파일경로를 묶어서 사용가능 .getrource를 경로를 
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
		//System.out.println("path@MemberDao = " + path);
		//System.out.println("prop@MemberDao = " + prop);
	}
	
	public Member selectOne(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectOne");
		Member member = null;
		
		try {
			//1.PreparedStatement객체생성(미완성쿼리 값대입)
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			//2.Statement실행 및 결과처리:ResultSet -> Member
			rset = pstmt.executeQuery();
			while(rset.next()) {
				member = new Member();
				member.setMemberId(rset.getString("member_id"));
				member.setPassword(rset.getString("password"));
				member.setMemberName(rset.getString("member_name"));
				member.setMemberRole(rset.getString("member_role"));
				member.setGender(rset.getString("gender"));
				member.setBirthDay(rset.getDate("birthday"));
				member.setEmail(rset.getString("email"));
				member.setPhone(rset.getString("phone"));
				member.setAddress(rset.getString("address"));
				member.setHobby(rset.getString("hobby"));
				member.setEnrollDate(rset.getDate("enroll_date"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			//3.자원반납(ResultSet, PreparedStatement)
			close(rset);
			close(pstmt);
		}
		
		
		return member;
	}

	public int updateEnroll(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("updateEnroll");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setNString(4, member.getMemberRole());
			pstmt.setString(5, member.getGender());
			pstmt.setDate(6, member.getBirthDay());
			pstmt.setString(7, member.getEmail());
			pstmt.setString(8, member.getPhone());
			pstmt.setString(9, member.getAddress());
			pstmt.setString(10, member.getHobby());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			//3.자원반납(ResultSet, PreparedStatement)
			close(rset);
			close(pstmt);
	}
		
		return result;
	}

}
