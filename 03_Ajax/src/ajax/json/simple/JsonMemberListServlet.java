package ajax.json.simple;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import member.manager.MemberManager;
import member.model.vo.Member;

/**
 * Servlet implementation class JsonMemberListServlet
 */
@WebServlet("/json/memberList")
public class JsonMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 업무로직 : 전체회원
		MemberManager manager = MemberManager.getInstance();
		List<Member> list = manager.getList();
	
		//2. json문자열로 변환 & 응답 출력
		//json-simple
		//JSONObject 객체
		//JSONArray 배열
		JSONArray arr = new JSONArray();
		for(Member m : list) {
			JSONObject obj = new JSONObject();
			obj.put("name", m.getName());
			obj.put("phone", m.getPhone());
			obj.put("profile", m.getProfile());
			arr.add(obj);
		}
		System.out.println(arr);
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().append(arr.toJSONString());
		
		
	}

}




