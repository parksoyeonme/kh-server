package ajax.json.gson;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonMemberServlet
 */
@WebServlet("/gson/member")
public class GsonMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 사용자입력값 확인 searchMemberName
		String searchMemberName = request.getParameter("searchMemberName");
		System.out.println("searchMemberName = " + searchMemberName);
		
		//2. 업무로직 : 해당이름이 존재하는 지 검사
		// 해당 Member객체는 JSONObject객체로 생성하기
		List<Member> list = MemberManager.getInstance().getList();
		Member member = null;
		for(Member m : list) {
			if(searchMemberName.equals(m.getName())) {
				member = m;
			}
		}
		//3. 응답출력 : 헤더작성, 출력
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(member, response.getWriter());
		
	}

}