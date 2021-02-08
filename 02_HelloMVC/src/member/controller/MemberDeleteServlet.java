package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;

/**
 * Servlet implementation class MemberDeleteServlet
 */
@WebServlet("/member/memberDelete")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. encoding처리
		request.setCharacterEncoding("utf-8");
		
		//2. 사용자 입력 값 처리
		String memberId = request.getParameter("memberId");
		int result = new MemberService().deleteMember(memberId);
	
		String msg = "";
		String loc = request.getContextPath();
		String view = "/index.jsp";
		
		if(result>0) {
			msg = "탈퇴되었습니다";
		}else {
			msg = "실패했습니다";
		}
		
		HttpSession session = request.getSession(false);
		if(session != null) {
			session.invalidate();
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		RequestDispatcher reqDispatcher = request.getRequestDispatcher(view);
		reqDispatcher.forward(request, response);
	}

}
