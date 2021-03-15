package com.kh.el.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.person.model.vo.Person;

/**
 * Servlet implementation class ELBasicServlet
 */
@WebServlet("/el/basic.do")
public class ELBasicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. jsp에서 사용할 데이터 생성
		request.setAttribute("coffee", "예가체프");
		request.setAttribute("year", 2021);
		request.setAttribute("today", new Date());
		request.setAttribute("person", new Person("홍길동", '남', 33, true));
		
		List<String> list = new ArrayList<>();
		list.add("안녕");
		list.add("hello wordld");
		list.add("goodbye corona");
		request.setAttribute("list", list);
		
		Map<String, Object> map = new HashMap<>();
		map.put("num", 123456);
		map.put("jang", new Person("장영실", '남', 48, false));
		request.setAttribute("map", map);
		
		HttpSession session = request.getSession();
		session.setAttribute("coffee", "하와이 코나");
		//page - request - session-application 순으로 찾기 떄문에 뒤에 session에 coffee있어도 앞에부터 찾는다
		
		
		//2. jsp 위임처리
		request.getRequestDispatcher("/el/basic.jsp")
		.forward(request, response);
	}

}
