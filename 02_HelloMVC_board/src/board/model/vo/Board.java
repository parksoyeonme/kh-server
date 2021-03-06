package board.model.vo;

import java.sql.Date;

/**
 * 
 * BOARD테이블의 한행과 Board객체가 매핑된다.
 *
 */
public class Board {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private String boardContent;
	private String boardOriginalFileName;
	private String boardRenamedFileName;
	private Date boardDate;
	private int boardReadCount;
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getBoardOriginalFileName() {
		return boardOriginalFileName;
	}
	public void setBoardOriginalFileName(String boardOriginalFileName) {
		this.boardOriginalFileName = boardOriginalFileName;
	}
	public String getBoardRenamedFileName() {
		return boardRenamedFileName;
	}
	public void setBoardRenamedFileName(String boardRenamedFileName) {
		this.boardRenamedFileName = boardRenamedFileName;
	}
	public Date getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}
	public int getBoardReadCount() {
		return boardReadCount;
	}
	public void setBoardReadCount(int boardReadCount) {
		this.boardReadCount = boardReadCount;
	}
	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardWriter=" + boardWriter
				+ ", boardContent=" + boardContent + ", boardOriginalFileName=" + boardOriginalFileName
				+ ", boardRenamedFileName=" + boardRenamedFileName + ", boardDate=" + boardDate + ", boardReadCount="
				+ boardReadCount + "]";
	}
	
	
	
}