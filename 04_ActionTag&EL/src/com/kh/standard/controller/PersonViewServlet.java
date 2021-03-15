package com.kh.standard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.person.model.vo.Person;

/**
 * Servlet implementation class PersonViewServlet
 */
@WebServlet("/standard/person.do")
public class PersonViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. Person객체 생성
			Person person = new Person();
			person.setName("홍길동");
			person.setGender('남');
			person.setAge(33);
			person.setMarried(true);
			
			request.setAttribute("person", person);
			
		//2. jsp처리위엄
			request.getRequestDispatcher("/standard/useBean.jsp")
			.forward(request, response);
	}

}
