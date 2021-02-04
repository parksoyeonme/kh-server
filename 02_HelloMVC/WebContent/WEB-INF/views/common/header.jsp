<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member"%>
<%
	String msg = (String)request.getAttribute("msg");
	//System.out.println("msg@header.jsp = " + msg);
	String loc = (String)request.getAttribute("loc");
	//System.out.println("loc@header.jsp = " + loc);
	//Member memberLoggedIn = (Member)request.getAttribute("memberLoggedIn");
	Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
	System.out.println("memberLoggedIn@header.jsp = " + memberLoggedIn);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello MVC</title>
<%-- application별칭(context-root, context-path)를 동적으로 얻어오기  /mvc --%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" />
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-3.5.1.js"></script>
<script>
<% if(msg != null) { %> alert("<%= msg %>"); <% } %>
<% if(loc != null) { %> location.href = "<%= loc %>"; <% } %>


$(function(){
	/*
	* 로그인폼 유효성 검사
	*
	* 폼 전송을 방지
	* return false
	* e.preventDefault()
	*/
	$(loginFrm).submit(function(e){
		//아이디 검사
		var $memberId = $(memberId);
		if(/^.{4,}$/.test($memberId.val()) == false){
			alert("유효한 아이디를 입력하세요.");
			$memberId.select(); //다시입력을 유도
			return false;//폼 전송 방지
		}
		//비번검사
		var $password = $(password);
		if(/^.{4,}$/.test($password.val()) == false){
			alert("유효한 비밀번호를 입력하세요.");
			$password.select();
			e.preventDefault();//폼 전송 방지
		}
	});
	
	
	
});
</script>
</head>
<body>
	<div id="container">
		<header>
			<h1>Hello MVC</h1>
			<!-- 로그인메뉴 시작 -->
			<div class="login-container">
			<% if(memberLoggedIn == null){ %>
				<form 
					id="loginFrm"
					action="<%= request.getContextPath() %>/member/login"
					method="POST">
					<table>
						<tr>
							<td><input type="text" name="memberId" id="memberId" placeholder="아이디" tabindex="1"></td>
							<td><input type="submit" value="로그인" tabindex="3"></td>
						</tr>
						<tr>
							<td><input type="password" name="password" id="password" placeholder="비밀번호" tabindex="2"></td>
							<td></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="checkbox" name="saveId" id="saveId" />
								<label for="saveId">아이디저장</label>&nbsp;&nbsp;
								<input type="button" value="회원가입">
							</td>
						</tr>
					</table>
				</form>
			
			<% } else { %>
			<%-- 로그인 성공시 --%>
			<table id="logged-in">
				<tr>
					<td><%= memberLoggedIn.getMemberName() %>님, 안녕하세요.</td>
				</tr>			
				<tr>
					<td>
						<input type="button" value="내 정보보기" />
						<input type="button" value="로그아웃" />
					</td>
				</tr>
			</table>
			<% } %>
			</div>
			<!-- 로그인메뉴 끝-->
			<!-- 메인메뉴 시작 -->
			<nav>
				<ul class="main-nav">
					<li class="home"><a href="#">Home</a></li>
					<li id="notice"><a href="#">공지사항</a></li>
					<li id="board"><a href="#">게시판</a></li>
				</ul>
			</nav>
			<!-- 메인메뉴 끝-->
			
		</header>
		
		<section id="content">