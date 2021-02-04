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
import member.model.vo.Member;

/**
 * @WebServlet : web.xml에 servlet, servlet-mapping태그 등록을 대신해주는 annotation
 */
@WebServlet(urlPatterns={"/member/login"})
public class MemberLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 인코딩처리
		request.setCharacterEncoding("utf-8");
		
		//2. 사용자입력값 처리
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		System.out.println("memberId@servlet = " + memberId);
		System.out.println("password@servlet = " + password);
		
		//3. 업무로직 : 사용자입력 아이디/비번이 DB에 저장된 아이디/비번과 일치 여부 판단
		//아이디로 member객체를 조회
		// - member객체가 존재할 경우
		//		a. 비밀번호가 일치하는 경우(성공)
		//		b. 비밀번호가 일치하지 않는 경우(실패)
		// - c. member객체가 존재하지 않을 경우 : 아이디오류(실패)
		Member member = memberService.selectOne(memberId);
		//멤버객체에 memberId 선택해와서 비교
		System.out.println("member@servlet = " + member);
		
		//로그인 성공
		if(member != null && password.equals(member.getPassword())) {
			//request.setAttribute("msg", "로그인 성공!");
			
			//jsp에서 로그인한 사용자 정보를 출력하기 위해 member객체를 request에 저장 -> 실패!
			//request.setAttribute("memberLoggedIn", member);
			
			//session객체에 로그인한 사용자정보를 기록
			//create여부 (기본값은 true)
			//세션객체가 존재하면 해당객체를 리턴, 존재하지 않으면 새로 생성후 리턴
			HttpSession session = request.getSession(true);
			session.setAttribute("memberLoggedIn", member);
			
			//4. redirection처리 : 요청 url을 변경
			//주어진 주소(location)로 클라이언트에게 다시 요청하라는 응답
			response.sendRedirect(request.getContextPath());
		}
		//로그인 실패 : 아이디 존재X, 비번이 틀린 경우
		else {
			request.setAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			//이동할 곳 지정, 인덱스로 보내주자
			request.setAttribute("loc", request.getContextPath());
			

			//4. view단 처리 (jsp) : 위로옮긴 이유는 이제는 세션으로 로그인성공을 처리하기 때문에
			//실패한 경우에 비밀번호가 틀렸습니다의 문구만 리퀘스트 하면되기때문
			RequestDispatcher reqDispatcher = 
					request.getRequestDispatcher("/index.jsp");
			reqDispatcher.forward(request, response);
		}
		
		
		
	}

}