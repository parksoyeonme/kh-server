package board.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import board.model.dao.BoardDao;
import board.model.vo.Board;

public class BoardService {

	private BoardDao boardDao = new BoardDao();
	
	public List<Board> selectBoardList(int cpage, int numPerPage) {
		Connection conn = getConnection();
		List<Board> list= boardDao.selectBoardList(conn, cpage, numPerPage);
		close(conn);
		return list;
	}

	public int selectBoardCount() {
		Connection conn = getConnection();
		int totalBoardCount = boardDao.selectBoardCount(conn);
		close(conn);
		return totalBoardCount;
	}

	public int insertBoard(Board board) {
		Connection conn = getConnection();

		int result = boardDao.insertBoard(conn, board);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return result;
	}

}