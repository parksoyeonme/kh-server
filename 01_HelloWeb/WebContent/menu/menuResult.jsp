<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
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
	font-size: 30px;
	color: red;
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