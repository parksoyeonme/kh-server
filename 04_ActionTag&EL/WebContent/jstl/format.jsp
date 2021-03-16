<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl - format</title>
</head>
<body>
	<h1>Format</h1>
	<h2>숫자</h2>
	<c:set var="num1">1234567890</c:set>
	<c:set var="num2">123.4567</c:set>
	<ul>
		<li>
			<fmt:formatNumber value="${num1}" pattern="#,###" />
		</li>
		<li>
			<%-- 원화로 표시되서 나온다 --%>
			<fmt:setLocale value="ko_kr"/>
			<fmt:formatNumber value="${num1}" type="currency"/>
		</li>
		<li>
			<%--반올림 --%>
			<fmt:formatNumber value="${num2}" pattern="#.##"/>
		</li>
		<li>
			<%-- 버림처리 --%>
			<fmt:formatNumber value='<%= Math.floor(Double.valueOf((String)pageContext.getAttribute("num2")) * 100) / 100 %>' pattern="#.##"/>
		</li>
		<li>
		<%-- 소수점 한자리수까지만 표현해주세요--%>
			<fmt:formatNumber value="0.015" type="percent" maxFractionDigits="1"/>
		</li>
	</ul>
	
	<h2>날짜 시각</h2>
	<c:set var="now" value="<%= new Date() %>"/>
	<ul>
		<li>
			<%--<fmt:formatDate value="${now}" type="time"/> --%>
			<%-- 오전 11:46:06 --%>
			<fmt:formatDate value="${now}" type="both"/>
			<%--2021. 3. 16 오전 11:46:06 --%>
		</li>
		<li>
			<fmt:formatDate value="${now}" pattern="yyyy/MM/dd(E) HH:mm:ss"/>
			<%--2021/03/16(화) 11:48:02 --%>
		</li>
	</ul>
	
</body>
</html>