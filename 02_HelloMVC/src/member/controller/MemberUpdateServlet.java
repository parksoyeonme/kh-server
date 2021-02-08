package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/member/memberUpdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. encoding처리
		request.setCharacterEncoding("utf-8");
		
		//2. 사용자입력값 처리
		String password = request.getParameter("password");
		String memberName = request.getParameter("memberName");
		String gender = request.getParameter("gender");
		
		Date birthDay = null;
		String date = request.getParameter("birthDay");
		if(!(date.equals(""))) {
			birthDay = Date.valueOf(date);
		}
		
		String email = request.getParameter("email");
		if(email.equals("")) {
	         email = null;
	      }
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		if(address.equals("")) {
	         address = null;
	      }
		
		//체크박스같은 경우 선택된 복수의 값이 배열로 전달된다.
		//String[] javax.servlet.ServletRequest.getParameterValues(String arg0)
		String[] hobbies = request.getParameterValues("hobby");
		
		String hobby = "";
		//String java.lang.String.join(CharSequence delimiter, CharSequence... elements)
		//파라미터로 전달한 문자열배열이 null이면, NullPointerException유발.
		if(hobbies != null) hobby = String.join(",", hobbies);

		Member member = new Member();
		member.setPassword(password);
		member.setMemberName(memberName);
		member.setGender(gender);
		member.setBirthDay(birthDay);
		member.setEmail(email);
		member.setPhone(phone);
		member.setAddress(address);
		member.setHobby(hobby);
		
			
		int result = new MemberService().updateMember(member);
		
		if(result != 0) {
			request.setAttribute("msg", "수정 성공했습니다.");
			
		}else {
			request.setAttribute("msg", "수정 실패했습니다.");	
		}
		request.setAttribute("loc", request.getContextPath());
		
		RequestDispatcher reqDispatcher = 
				request.getRequestDispatcher("/member/memberView.jsp");
		reqDispatcher.forward(request, response);
	}

}


// 실패