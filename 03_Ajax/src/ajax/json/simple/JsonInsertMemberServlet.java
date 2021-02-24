package ajax.json.simple;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonInsertMemberServlet
 */
@WebServlet("/json/insertMember")
public class JsonInsertMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		try {
			//1. 사용자입력값 처리
//			String name = request.getParameter("name");
//			String phone = request.getParameter("phone");
//			String profile = request.getParameter("profile");
//			Member member = new Member(name, phone, profile);
			
			//json문자열로 전송시 member=json문자열
			String jsonStr = request.getParameter("member");
			System.out.println("jsonStr = " + jsonStr);

			//json문자열 -> java객체
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject)parser.parse(jsonStr);
			Member member = new Member();
			member.setName((String)obj.get("name"));
			member.setPhone((String)obj.get("phone"));
			member.setProfile((String)obj.get("profile"));
			
			System.out.println("member = " + member);
			
			//2. 업무로직 : manager객체의 list에 추가
			List<Member> list = MemberManager.getInstance().getList();
			list.add(member);
			System.out.println("list = " + list);
			
			//3. 처리결과 응답출력
			//성공 1, 실패 0 출력!
			response.getWriter().print(1);
		} catch(Exception e) {
			e.printStackTrace();
			response.getWriter().print(0);
		}
		
	}

}