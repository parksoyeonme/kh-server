package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;

/**
 * Servlet implementation class AdminMemberFinderServlet
 */
@WebServlet("/admin/memberFinder")
public class AdminMemberFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 사용자 입력값 처리
		
		//2. 업무로직 : 검색
		List<Member> list = adminService.selectMembersBy(searchType, searchKeyword);
		System.out.println(list);
		
		//3. view단 처리 : fowarding /WEB-INF/views/memberList.jsp
		request.getRequestDispatcher("/WEB-INF/views/memberList.jsp")
			   .forward(request, response);
		
	}

}