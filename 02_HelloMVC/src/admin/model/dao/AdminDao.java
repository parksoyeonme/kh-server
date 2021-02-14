package admin.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import static common.JDBCTemplate.close;

import member.model.vo.Member;

public class AdminDao {
	
	private Properties prop = new Properties();

	public AdminDao() {
		String fileName = "/sql/admin/admin-query.properties";
		String absPath = AdminDao.class.getResource(fileName).getPath();
		try {
			prop.load(new FileReader(absPath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<Member> selectList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		List<Member> list = null;
		
		try {
			//1. PreparedStatement객체 생성
			//2. 미완성 쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			//3. 실행 및 ResultSet처리
			rset = pstmt.executeQuery();
			//4. Member --> List에 추가
			list = new ArrayList<>();
			while(rset.next()) {
				Member member = new Member();
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
				list.add(member);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 자원반납
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	public int updateMemberRole(Connection conn, String memberId, String memberRole) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateMemberRole");
		//filter해야함
		
		try {
			//1. PreparedStatement객체 생성 및 쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberRole);
			pstmt.setString(2, memberId);
			
			//2. 실행
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//3. 자원반납
			close(pstmt);
		}
		return result;
	}

	public List<Member> selectMembersBy(Connection conn, String searchType, String searchKeyword) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectMembersBy");
		sql = sql.replace("#" , searchType);
		//select * from member where # like '%'||?||'%'
		//#은 searchType에따라 바뀐다.
		
//		if(searchType == null & searchKeyword == null)
//			sql = "select * from member order by enroll_date desc";
//    	else if(searchType.equals("member_id"))    //아이디로 검색할 때
//    		sql ="select * from member where member_id =?";
//		else if(searchType.equals("member_name"))    // 이름으로 검색할 때
//			sql ="select * from member where member_name =?";
//	    else if(searchType.equals("gender"))    // 성별로 검색할 때
//	    	sql ="select * from member where gender=?";
	
		List<Member> list = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
//			if(searchType == null & searchKeyword == null)
//				pstmt = conn.prepareStatement("select * from member order by enroll_date desc");
//	    	else if(searchType.equals("member_id"))    //아이디로 검색할 때
//	    		pstmt = conn.prepareStatement("select * from member where member_id =?");
//			else if(searchType.equals("member_name"))    // 이름으로 검색할 때
//				pstmt = conn.prepareStatement("select * from member where member_name =?");
//		    else if(searchType.equals("gender"))    // 성별로 검색할 때
//		    	pstmt = conn.prepareStatement("select * from member where gender=?");
			
			pstmt.setString(1, searchKeyword);
			//안된다 안돼
			rset = pstmt.executeQuery();
			list = new ArrayList<Member>();
			
			
			while(rset.next()) {
				Member member = new Member();
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
				list.add(member);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 자원반납
			close(rset);
			close(pstmt);
		}
		return list;
	}

	
	
}








