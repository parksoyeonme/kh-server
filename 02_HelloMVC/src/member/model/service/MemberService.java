package member.model.service;

import java.sql.Connection;

import member.model.dao.MemberDao;
import member.model.vo.Member;
import static common.JDBCTemplate.*;
/*
 * Connection 객체생성
 * Dao에 업무로직 하달
 * 트랜잭션처리
 * 자원반납
 * 
 */
public class MemberService {
	
	private MemberDao memberDao = new MemberDao();

	public Member selectOne(String memberId) {
		//1.Connection 객체생성
		Connection conn = getConnection();
		//2.dao 요청
		Member member = memberDao.selectOne(conn, memberId);
		//3.트랜잭션관리(DML관리)
		//4.자원반납
		close(conn);
		return member;
	}

	public int updateEnroll(Member member) {
		//1.Connection 객체생성
		Connection conn = getConnection();
		//2.dao 요청
		int result = memberDao.updateEnroll(conn, member);
		//3.트랜잭션관리(DML관리)
		//4.자원반납
		close(conn);
		return result;
	}

}
