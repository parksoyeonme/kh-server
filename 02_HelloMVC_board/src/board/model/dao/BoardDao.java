package board.model.dao;

import static common.JDBCTemplate.close;

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

public class BoardDao {

	private Properties prop = new Properties();

	/**
	 * build-path의 board-query.properties의 내용을 읽어와 필드 prop에 저장한다.
	 */
	public BoardDao() {
		String fileName = "/sql/board/board-query.properties";
		String absPath = BoardDao.class.getResource(fileName).getPath();
		try {
			prop.load(new FileReader(absPath));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public List<Board> selectBoard(Connection conn, int cpage, int numPerPage) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectBoard");
		List<Board> list = null;
		try {
			//1. PreparedStatement객체 생성
			//2. 미완성 쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, (cpage - 1) * numPerPage + 1);//시작 rnum
			pstmt.setInt(2, cpage * numPerPage);//마지막 rnum
			
			//3. 실행 및 ResultSet처리
			rset = pstmt.executeQuery();
			//4. Member --> List에 추가
			list = new ArrayList<>();
			while(rset.next()) {
				Board board = new Board();
				board.setBoardNo(rset.getInt("board_no"));
				board.setBoardTitle(rset.getString("board_title"));
				board.setBoardWriter(rset.getString("board_writer"));
				board.setBoardContent(rset.getString("board_content"));
				board.setBoardOriginalFileName(rset.getString("board_original_filename"));
				board.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				board.setBoardDate(rset.getDate("board_date"));
				board.setBoardReadCount(rset.getInt("board_read_count"));
				list.add(board);
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

	public int selectTotalBoard(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContents = 0;
		String sql = prop.getProperty("selectTotalBoard");
		//select count(*) from member
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalContents = rset.getInt(1);//컬럼순서로 가져옴.
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContents;
	}

	
	
	
}