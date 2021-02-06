package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/member/memberEnroll")
public class MemberEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 회원가입 폼을 제공
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request
			.getRequestDispatcher("/WEB-INF/views/member/memberEnroll.jsp")
			.forward(request, response);
	}

	/**
	 * 폼제출 : 회원가입 처리
	 * 
	 * 1. 회원가입 성공/실패여부를 사용자에게 경고창으로 알림할 것.
	 * 2. 인덱스페이지 이동할 것
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//1. 인코딩처리
		request.setCharacterEncoding("utf-8");
		//2. 사용자입력값 처리
		String memberId = request.getParameter("memberId");
		String password = request.getParameter("password");
		String memberName = request.getParameter("memberName");
		String birthDay = request.getParameter("birthDay");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String gender = request.getParameter("gender");
		String[] hobbyArr = request.getParameterValues("hobby");
		
		//hobby for문
		String hobby = "";
		
		
		/*
		 * MEMBER_ID   NOT NULL VARCHAR2(15)  
			PASSWORD    NOT NULL VARCHAR2(300) 
			MEMBER_NAME NOT NULL VARCHAR2(30)  
			MEMBER_ROLE NOT NULL CHAR(1)       
			GENDER               CHAR(1)       
			BIRTHDAY             DATE          
			EMAIL                VARCHAR2(100) 
			PHONE       NOT NULL CHAR(11)      
			ADDRESS              VARCHAR2(200) 
			HOBBY                VARCHAR2(100) 
			ENROLL_DATE          DATE 
		 * 
		 * */
		
		//4. view단 처리 (jsp) : 위로옮긴 이유는 이제는 세션으로 로그인성공을 처리하기 때문에
		//실패한 경우에 비밀번호가 틀렸습니다의 문구만 리퀘스트 하면되기때문
		RequestDispatcher reqDispatcher = 
				request.getRequestDispatcher("/index.jsp");
		reqDispatcher.forward(request, response);
	}

}
