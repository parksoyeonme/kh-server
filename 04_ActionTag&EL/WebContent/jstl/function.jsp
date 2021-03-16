<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl - function</title>
</head>
<body>
	<h1>Functions(문자열관련이 대부분)</h1>
	<c:set var="str1">Hello world, Hello jstl</c:set>
	<c:set var="str2">Hello el</c:set>
	<ul>
		<li>${fn:toUpperCase(str1)}</li>
		<li>${fn:toLowerCase(str1)}</li>
		<li>${fn:length(str1)}</li>
		<li>${fn:contains(str1, 'world')}
			<c:if test="${fn:contains(str1, 'world')}">world 있다</c:if>
			<c:if test="${not fn:contains(str1, 'world')}">world 없다</c:if>
		</li>
		<li>${fn:indexOf(str1, 'wwwwwworld')}
		<%-- 값이 없으면 -1 --%>
			<c:if test="${fn:indexOf(str1, 'world') != -1}">world 있다</c:if>
			<c:if test="${fn:indexOf(str1, 'world') == -1}">world 없다</c:if>
		</li>
		<li>${fn:replace(str1, 'Hello', 'Good bye')}</li>
		<li>${fn:substring(str1, 6, 11)}</li>
		<%-- <li>${str1.concat(str2)}</li> --%>
		<%-- Hello world, Hello jstlHello el --%>
		<li>${str1.concat(",").concat(str2)}</li>
		<%-- Hello world, Hello jstl,Hello el 아래와 동일 --%>
		<li>${str1}, ${str2}</li>
		<li>${fn:split(str1, ', ')}
			<ul>
				<%-- 구분자는 문자단위 처리--%>
				<c:forEach items="${fn:split(str1, ', ')}" var="s">
				<li>${s}</li>
				</c:forEach>
			</ul>		
		</li>
		<c:set var="xss"><script>document.body.style.color='red';</script></c:set>
		<li>${fn:escapeXml(xss)}</li>
		
		
	</ul>

</body>
</html>