<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
	JSTL JSP Standard Tag Library
	Custom Action Tag로 별도의 jar파일을 프로젝트에 추가한 후 사용할 수 있다.


 --%>
 
 <c:set var="num1">100</c:set>
 <c:set var="num2" value="20" scope="page" />
 
 <<c:set var="today" value="<%=new Date() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - core</title>
</head>
<body>
	<h1>JSTL - core</h1>
	<ul>
	<%--c:out은 출력식 --%>
		<li>num1 : <c:out value="${num1}"/> ${num1}</li>
		<li>num1 : <c:out value="${num2}"/> ${num2}</li>
		<li>${today}</li>
	</ul>
	
	<h2>c:if</h2>
	<%-- 
	<c:if test="${num1 > num2}">
		${num1}이 ${num2}보다 큽니다
	</c:if>
	<c:if test="${num1 < num2 }">
		${num1}이 ${num2}보다 작습니다
	</c:if>
	<c:if test="${num1 eq num2 }">
		${num1}이 ${num2}보다 같습니다.
	</c:if>
	--%>
	<c:if test="${Integer.parseInt(num1) > Integer.parseInt(num2)}">
		${num1}이 ${num2}보다 큽니다.
	</c:if>
	<c:if test="${Integer.parseInt(num1) < Integer.parseInt(num2)}">
		${num1}이 ${num2}보다 작습니다.
	</c:if>
	<c:if test="${Integer.parseInt(num1) eq Integer.parseInt(num2)}">
		${num1}과 ${num2}는 같습니다.
	</c:if>
	
	<hr />
	
	<c:if test="${Integer.parseInt(param.no1) > Integer.parseInt(param.no2) }">
		${param.no1}이 ${param.no2}보다 큽니다.
	</c:if>
	<c:if test="${Integer.parseInt(param.no1) < Integer.parseInt(param.no2) }">
		${param.no1}이 ${param.no2}보다 작습니다.
	</c:if>
	<c:if test="${Integer.parseInt(param.no1) eq Integer.parseInt(param.no2) }">
		${param.no1}이 ${param.no2}보다 같습니다.
	</c:if>
	
	
</body>
</html>