<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String mainMenu = request.getParameter("main_menu");
	String sideMenu = request.getParameter("side_menu");
	String drinkMenu = request.getParameter("drink_menu");
	
	int sum = (int)request.getAttribute("sum");


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴주문</title>
<style>
#main{
	font-size: 30px;
	color: blue;
}
#side{
	font-size: 20px;
	color: purple;
}
#drink{
	color: yellowgreen;
}
#sum{
	color: red;
	font-size: 30px;
}
</style>
</head>
<body>
	<h1>감사합니다.</h1>
	<span id="main"><%=mainMenu %>,</span>
	<span id="side"><%=sideMenu %>,</span>
	<span id="drink"><%=drinkMenu %></span>을/를 주문하셨습니다.<br>
	총 결제금액은 <span id="sum"><%= sum%>원</span> 입니다.
	


</body>
</html>