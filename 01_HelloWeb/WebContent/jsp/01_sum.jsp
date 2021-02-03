<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*, java.util.*" %>
<%
	//server단 처리 : java코드로 연산
	int sum = 0;
	for(int i = 1; i <= 10; i++)
		sum += i;
	//server시각 처리
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss.SSS");
	String time = sdf.format(new Date());
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Test</title>
<script>
window.onload = function(){
	var sum = 0;
	for(var i = 1; i <= 10; i++)
		sum += i;
	document.querySelector("span#result").innerHTML = sum;
	//alert('클라이언트 계산이 끝났습니다.');
	
	
	var now = new Date();
	var s = now.getFullYear() + "/"
		  + (now.getMonth() + 1) + "/"
		  + now.getDate() + " "
		  + now.getHours() + ":"
		  + now.getMinutes() + ":"
		  + now.getSeconds() + ":"
		  + now.getMilliseconds();
	document.querySelector("span#time").innerHTML = s;
};
</script>
</head>
<body>
	<%-- jsp주석 : java파일 변환시 생략--%>
	<!-- html주석 : client까지 전달되고, 화면처리에서 생략 -->
	<h1>JSP Test</h1>
	<p>1 ~ 10까지의 합 구하기</p>
	<ul>
		<li>서버 : <%-- <%= sum %> --%><% out.print(sum); %></li>
		<li>클라이언트 : <span id="result"></span></li>
	</ul>
	<p>시각 표시</p>
	<ul>
		<li>서버 : <%= time %></li>
		<li>클라이언트 : <span id="time"></span></li>
	</ul>
</body>
</html>