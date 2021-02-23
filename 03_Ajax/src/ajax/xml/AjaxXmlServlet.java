package ajax.xml;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class AjaxXmlServlet
 */
@WebServlet("/xml")
public class AjaxXmlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.업무로직
		List<Member> list = MemberManager.getInstance().getList();
		
		//2. view단처리 : jsp를 통해서 xml생성
		request.setAttribute("list", list);
		request.getRequestDispatcher("/xml/xmlMember.jsp")
			   .forward(request, response);
	
	
	}

}