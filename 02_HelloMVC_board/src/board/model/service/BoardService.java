package board.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import board.model.dao.BoardDao;
import board.model.vo.Board;


public class BoardService {

	private BoardDao boardDao = new BoardDao();

	public List<Board> selectBoard(int cpage, int numPerPage) {
		Connection conn = getConnection();
		List<Board> list = boardDao.selectBoard(conn, cpage, numPerPage);
		close(conn);
		return list;
	}

	public int selectTotalBoard() {
		Connection conn = getConnection();
		int totalContents = boardDao.selectTotalBoard(conn);
		close(conn);
		return totalContents;
	}
	
}