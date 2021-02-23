package ajax.text;

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
 * Servlet implementation class AjaxCsvServlet
 */
@WebServlet("/csv")
public class AjaxCsvServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 업무로직
		MemberManager manager = MemberManager.getInstance();
		List<Member> list = manager.getList();
		
		//2. 응답에 csv데이터를 출력
		StringBuilder sb = new StringBuilder();
		for(int i =0; i < list.size(); i++) {
			Member m = list.get(i);
			sb.append(m);
			//회원간 구분자 추가
			sb.append(i < list.size() - 1 ? "\n" : "");
		}
		System.out.println("scv = " + sb);
		
		response.setContentType("text/csv; charset=utf-8");
		response.getWriter()
				.append(sb);
	
	
	}

}



