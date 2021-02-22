package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;

/**
 * Servlet implementation class BoardCommentDeleteServlet
 */
@WebServlet("/board/boardCommentDelete")
public class BoardCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 사용자입력값
		int boardCommentNo = Integer.parseInt(request.getParameter("boardCommentNo"));
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		//2. 업무로직
		int result = boardService.deleteBoardComment(boardCommentNo);
		String msg = result > 0 ? "댓글 삭제 성공!" : "댓글 삭제 실패!";
		
		//3. 사용자피드백 & 리다이렉트
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath() + "/board/boardView?boardNo=" + boardNo);
	
	}

}






