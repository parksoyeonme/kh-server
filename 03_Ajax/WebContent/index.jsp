<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax</title>
</head>
<body>
	<h1>Ajax</h1>
	<p>Asynchronous Javascript and Xml</p>
	<hr />
	<ul>
		<li><a href="<%= request.getContextPath() %>/text/text.jsp">text</a></li>
		<li><a href="<%= request.getContextPath() %>/text/csv.jsp">csv</a></li>
		<li><a href="<%= request.getContextPath() %>/text/autoComplete.jsp">autoComplete</a></li>
		<li><a href="<%= request.getContextPath() %>/html/html.jsp">html</a></li>
		<li><a href="<%= request.getContextPath() %>/xml/xml.jsp">xml</a></li>
	</ul>
</body>
</html>