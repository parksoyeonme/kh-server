package board.model.vo;

import java.sql.Date;

public class BoardExt extends Board {

	private int boardCommentCount;

	public BoardExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BoardExt(int boardNo, String boardTitle, String boardWriter, String boardContent,
			String boardOriginalFileName, String boardRenamedFileName, Date boardDate, int boardReadCount, 
			int boardCommentCount) {
		super(boardNo, boardTitle, boardWriter, boardContent, boardOriginalFileName, boardRenamedFileName, boardDate,
				boardReadCount);
		this.boardCommentCount = boardCommentCount;
	}

	public int getBoardCommentCount() {
		return boardCommentCount;
	}

	public void setBoardCommentCount(int boardCommentCount) {
		this.boardCommentCount = boardCommentCount;
	}

	@Override
	public String toString() {
		return "BoardExt [boardCommentCount=" + boardCommentCount + ", toString()=" + super.toString() + "]";
	}
	
	
	
	
	
	
}