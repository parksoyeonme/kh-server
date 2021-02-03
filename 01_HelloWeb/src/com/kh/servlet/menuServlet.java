package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.tribes.util.Arrays;

/**
 * Servlet implementation class menuServlet
 */

public class menuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public menuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 한글깨짐 방지 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//2. 사용자 입력값 처리
		String mainMenu = request.getParameter("main_menu");
		String sideMenu = request.getParameter("side_menu");
		String drinkMenu = request.getParameter("drink_menu");
		
		System.out.println("main_menu = " + mainMenu);
		System.out.println("side_menu = " + sideMenu);
		System.out.println("drink_menu = " + drinkMenu);
		
		int sum = 0;
		
		switch(mainMenu) {
		case "한우버거": 
			sum += 5000; 
			break;
		case "밥버거": 
			sum += 4500; 
			break;
		case "치즈버거": 
			sum += 4000; 
			break;
		}
		
		switch(sideMenu) {
		case "감자튀김": 
			sum += 1500; 
			break;
		case "어니언링": 
			sum += 1700; 
			break;
		}
		
		switch(drinkMenu) {
		case "콜라":
		case "사이다":
			sum += 1000; 
			break;
		case "커피": 
			sum += 1500; 
			break;
		case "밀크쉐이크": 
			sum += 2500; 
			break;
		}
		
		//request의 속성 (임시 저장소) 저장
	      request.setAttribute("sum", sum);
	      
		//3. 응답 작성
	    //jsp로 html작성을 위임(넘긴다)
		RequestDispatcher reqDispatcher
	      = request.getRequestDispatcher("/menu/menuEnd.jsp");
	      reqDispatcher.forward(request, response);
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
