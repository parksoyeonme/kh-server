package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.util.MvcUtils;
import member.model.service.MemberService;
import member.model.vo.Member;


@WebServlet("/member/updatePassword")
public class MemberUpdatePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService memberService = new MemberService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/updatePassword.jsp").forward(request, response);
	}
 
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		HttpSession session = req.getSession(false);
		Member member = (Member)session.getAttribute("memberLoggedIn");
	
		//입력한 현재 패스워드
		String currPassword = MvcUtils.getEncryptedPassword(req.getParameter("password"));
		
		//변경할 패스워드
		String updatePassword = MvcUtils.getEncryptedPassword(req.getParameter("newPassword"));
		
		String msg = "";
		String loc = req.getContextPath() + "/member/memberView?memberId=" + member.getMemberId();
		
		if(!(currPassword.equals(member.getPassword()))){
			msg += "비밀번호를 확인해주세요";
			
			session.setAttribute("msg", msg);
			resp.sendRedirect(loc);
			return;
		}
		
		int result = memberService.updatePassword(member.getMemberId(), updatePassword);
		
		if(result>0) {
			msg += "비밀번호 변경이 되었습니다.";
		} else {
			msg += "비밀번호 변경에 실패하였습니다.";
		}
		
		session.setAttribute("msg", msg);
		resp.sendRedirect(loc);
	}
	
	

}