package com.kh.jstl.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.person.model.vo.Person;

/**
 * Servlet implementation class JstlCoreForEachServlet
 */
@WebServlet("/jstl/forEach.do")
public class JstlCoreForEachServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. jsp에서 사용할 데이터
		String[] names = {"홍길동", "신사임당", "세종대왕", "장영실"};
		
		//String[] -> Arraylist
		List<String> list = Arrays.asList(names);
		
		List<Person> personList = new ArrayList<Person>(){
			//초기화블럭
			{
				this.add(new Person("유관순", '여', 18, false));
				this.add(new Person("윤봉길", '남', 35, true));
				this.add(new Person("장발장", '남', 55, true));
			}
		};
		
		Set<Integer> set = new HashSet<Integer>() {
			{
				this.add(1);
				this.add(3);
				this.add(5);
				this.add(3);
				this.add(1);
			}
		};
		
		Map<String,Object> map = new HashMap<String, Object>(){
			{
				this.put("hongged", "홍길동");
				this.put("today", new Date());
				this.put("number", new Double(1234.5678));
			}
		};
	
		//csv 데이터
		String s = "hongged,sinsa,jys,sejong,ygsgs";
		
		request.setAttribute("names", names);
		request.setAttribute("list", list);
		request.setAttribute("personList", personList);
		request.setAttribute("set", set);
		request.setAttribute("map", map);
		request.setAttribute("s", s);
		
	
		//2. jsp로 위임
		request.getRequestDispatcher("/jstl/forEach.jsp")
		.forward(request, response);
	
	}


}