package board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import board.model.exception.BoardException;
import board.model.service.BoardService;
import board.model.vo.Board;
import common.MvcFileRenamePolicy;

/**
 * Servlet implementation class BoardUpdateServlet
 */
@WebServlet("/board/boardUpdate")
public class BoardUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		Board board = boardService.selectOne(boardNo);
		
		request.setAttribute("board", board);
		request.getRequestDispatcher("/WEB-INF/views/board/boardUpdate.jsp")
			   .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String saveDirectory = getServletContext().getRealPath("/upload/board");
		int maxPostSize = 10 * 1024 * 1024;
		String encoding = "utf-8";
		FileRenamePolicy policy = new MvcFileRenamePolicy();
		
		MultipartRequest multipartReq = new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
		
		String boardTitle = multipartReq.getParameter("boardTitle");
		String boardContent = multipartReq.getParameter("boardContent");
		String boardWriter = multipartReq.getParameter("boardWriter");
		String boardOriginalFileName = multipartReq.getOriginalFileName("upFile");
		String boardRenamedFileName = multipartReq.getFilesystemName("upFile");
		
		
		int boardNo = Integer.parseInt(multipartReq.getParameter("boardNo"));
		Board board = new Board(boardNo, boardTitle, boardWriter, boardContent, null, null, null, 0);

		
		//2. 업무로직 : Board객체 db저장 요청
		//DML처리결과는  int타입
		int result = boardService.updateBoard(board);
		System.out.println("boardUpdate@boardUpdateservlet = " + board);
		
		String msg = result > 0 ? "게시글 수정 성공!" : "게시글 수정 실패!"; 
		
		
		request.getSession().setAttribute("msg", msg);
		String location = result > 0? 
	            request.getContextPath() + "/board/boardView?boardNo=" + board.getBoardNo():
	            request.getContextPath() + "/board/boardList";
	            
	      response.sendRedirect(location);
		
				
			}

}
