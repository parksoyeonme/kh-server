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
 * Servlet implementation class JsonMemberListServlet
 */
@WebServlet("/gson/memberList")
public class GsonMemberListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 업무로직 : 전체회원
		MemberManager manager = MemberManager.getInstance();
		List<Member> list = manager.getList();
	
		//2. json문자열로 변환 & 응답 출력
		//toJson(obj) json문자열로 변환
		//fromJson(jsonStr):obj json문자열을 자바객체로 변환
//		Gson gson = new Gson();
//		String jsonStr = gson.toJson(list);
//		System.out.println("jsonStr = " + jsonStr);
//		
		response.setContentType("application/json; charset=utf-8");
//		response.getWriter().append(jsonStr);
		
		new Gson().toJson(list, response.getWriter());
		
	}

}




