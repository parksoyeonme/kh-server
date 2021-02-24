package ajax.json.simple;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonMemberServlet
 */
@WebServlet("/json/member")
public class JsonMemberServlet extends HttpServlet {
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
		JSONObject obj = null;
		for(Member m : list) {
			if(searchMemberName.equals(m.getName())) {
				//JSONObject객체 생성
				obj = new JSONObject();
				obj.put("name", m.getName());
				obj.put("phone", m.getPhone());
				obj.put("profile", m.getProfile());
			}
		}
		System.out.println("obj = " + obj);
		//3. 응답출력 : 헤더작성, 출력
		response.setContentType("application/json; charset=utf-8");
		//response.getWriter().append(obj.toJSONString());//NPE 유발코드
		response.getWriter().print(obj);
	}

}