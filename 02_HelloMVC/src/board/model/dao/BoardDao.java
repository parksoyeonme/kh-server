package board.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import board.model.vo.Board;

import static common.JDBCTemplate.*;


public class BoardDao {

	private Properties prop = new Properties();

	/**
	 * build-path의 board-query.properties의 내용을 읽어와 필드 prop에 저장한다.
	 */
	public BoardDao() {
		try {
			//클래스객체 위치찾기 : 절대경로를 반환한다. 
			String fileName = BoardDao.class.getResource("/sql/board/board-query.properties").getPath();
			prop.load(new FileReader(fileName));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}

	public List<Board> selectBoardList(Connection conn, int cPage, int numPerPage) {
		List<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectBoardList");
		
		try{
			//미완성쿼리문을 가지고 객체생성. 
			pstmt = conn.prepareStatement(query);
			
			//시작 rownum과 마지막 rownum 구하는 공식
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			
			//쿼리문실
			//완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				Board b = new Board();
				//컬럼명은 대소문자 구분이 없다.
				b.setBoardNo(rset.getInt("board_noooo"));
				b.setBoardTitle(rset.getString("board_title"));
				b.setBoardWriter(rset.getString("board_writer"));
				b.setBoardContent(rset.getString("board_content"));
				b.setBoardOriginalFileName(rset.getString("board_original_filename"));
				b.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setBoardReadCount(rset.getInt("board_read_count"));
				list.add(b);
			}
			
		}catch(Exception e){
//			e.printStackTrace();
			//런타임예외로 전환해서 다시 던지기
			throw new RuntimeException("게시물 조회 오류", e);
		}finally{
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}

	public int selectBoardCount(Connection conn) {
		PreparedStatement pstmt = null;
		int totalContents = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectBoardCount");
		
		try{
			//미완성쿼리문을 가지고 객체생성. 
			pstmt = conn.prepareStatement(query);
			
			//쿼리문실행
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				totalContents = rset.getInt("cnt");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return totalContents;
	}

	public int insertBoard(Connection conn, Board board) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertBoard");
		//insert into board values(seq_board_no.nextval, ?, ?, ?, ?, ?, default, default)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBoardTitle());
			pstmt.setString(2, board.getBoardWriter());
			pstmt.setString(3, board.getBoardContent());
			pstmt.setString(4, board.getBoardOriginalFileName());
			pstmt.setString(5, board.getBoardRenamedFileName());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	
	
	
}