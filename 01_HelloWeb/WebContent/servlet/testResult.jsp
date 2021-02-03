<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%--jsp주석 --%>
<%
   //java코드 공간 그외는 html공간
   //jsp에서는 HttpServletRequeset, HttpServletResponse객체에
   //선언없이 request, response명으로 접근할 수 있다.
   	String name = request.getParameter("name");
    String color = request.getParameter("color");
    String animal = request.getParameter("animal");
    String[] foodArr = request.getParameterValues("food");
    
    //servlet생산 데이터
    Date now = (Date)request.getAttribute("now");
      
    System.out.println("name@jsp = " + name);
    System.out.println("color@jsp = " + color);
    System.out.println("animal@jsp = " + animal);
    System.out.println("food@jsp = " + Arrays.toString(foodArr));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset='utf-8'/>
	<title>테스트 결과</title>
</head>
<body>
	<h1>테스트결과</h1>
	<p><%= now %>></p>
	<%--jsp표현식: 출력시 사용, ';(세미콜론 사용금지) --%>
	<p>이름 : <%= name %></p>
	<p>색깔 : <%= color %></p>
	<p>동물 : <%= animal %></p>
	<p>음식 : <%= Arrays.toString(foodArr) %></p>
</body>
</html>