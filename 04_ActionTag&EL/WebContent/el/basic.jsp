<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	EL Expression Language 표현언어 출력언어
	jsp 2.0부터 사용된 스펙으로, jsp에서 간결한 출력식을 지원한다.
	
	(서버단 언어이기떄문에 서버에서 모든 처리후에 값만 html로 넘어간다)
	${vlaue}
	
	EL 내장객체
	속성에 저장된 객체를 EL이 별도의 맵으로 작성해둔것. 생략가능
	생략시 page - request - session -application 순으로 속성을 조회.
	-pageScope
	-requestScope
	-sessionScope (EX: sessionScope.memberLoggedIn.memberId 이런식으로 바로꺼내서 쓸수있다)
	-applicationScope
	
	사용자입력값 query string
	-param
	-paramValues
	
	요청 header정보
	-header
	-headerValues
	
	쿠키
	-cookie
	
	초기화 파라미터 : application에서 지정한 값들.
	-initParam
	
	포인터겍체
	-pageContext : 내장객체 중 유일하게 Map이 아닌 포인터객체
		getErrorData()
		getPage():PageContext
		getRequest():HttpServletRequest
		getResponse():HttpServletResponse
		getSession():HttpSession
		getServletConfig():ServletConfig
		getServletContext():ServletContext
	
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL - basic</title>
</head>
<body>
	<h1>EL - basic</h1>
	<ul>
		<%-- 결과는 같다   requestScope 왜 안 적어도 된다
						[속성에 저장된 객체를 EL이 별도의 맵으로 작성해 둔 것. 생략 가능.]
   					   [생략시 page - request - session - application순으로 속성을 조회.]
		<li>${requestScope.coffee}</li>
		<li>${requestScope.year}</li>
		<li>${requestScope.today}</li>
		<li>${requestScope.person}</li>
		
		<li>${coffee}</li>
		<li>${year}</li>
		--%>
		<li>${requestScope.coffee}</li>
		<li>${sessionScope.coffee}</li>
		<li>${today}</li>
		<li>${person}</li>
	
		<%--bean객체의 property --%>
		<ul>
		<%--person 안에 애들까지 접근할 수 있다. 역시나 서버단에서 모두 처리 후 값만 html로 --%>
			<%-- 
			<li>${requestScope.person.name}</li>
			<li>${requestScope.person.age}</li>
			<li>${requestScope.person.gender}</li>
			<li>${requestScope.person.married}</li>
			--%>
			<li>${person.name}</li>
			<li>${person.age}</li>
			<li>${person.gender}</li>
			<li>${person.married}</li>
		</ul>
		
		<li>${list}
			<ul>
				<li>${list[0]}</li>
				<li>${list[1]}</li>
				<li>${list[2]}</li>
			</ul>
		</li>
		<li>${map}
			<ul>
				<li>${map.num}</li> <%-- dot notatione --%>
				<li>${map['jang']}</li> <%-- bracket notation --%>
					<ul>
						<li>${map['jang']['name']}</li>
						<li>${map['jang']['age']}</li>
						<li>${map['jang']['gender']}</li>
						<li>${map['jang']['married']}</li>
						<li>${map.jang.name}</li>
						<li>${map.jang.age}</li>
						<li>${map.jang.gender}</li>
						<li>${map.jang.married}</li>
					</ul>
			</ul>
		</li>
		<li>존재하지 않는 값 : ${hello}</li>
		<%--값이 존재하지 않아도 null을 출력하지 않는다. 그냥 빈칸으로 출력됨관대함 --%>
		<li>존재하지 않는 값의 속성을 참조 : ${hello.world}</li>
		<%--EL은 결코 NillPinterException을 유발하지 않는다. --%>
	</ul>
	
	<h2>param</h2>
	<ul>
		<li>${param.productId}</li>
		<li>${param.amount}</li>
		<%-- <li>${param.option}</li> 을 사용하면 1번밖에 안나온다--%>
		<li>${paramValues}
			<ul>
				<li>${paramValues.option[0]}</li>
				<li>${paramValues.option[1]}</li>
			</ul>
		</li>
		
	</ul>
	
	<h2>header</h2>
	<%-- request.getHeader("User-Agent) --%>
	<ul>
		<li>${header["User-Agent"]}</li>
		<li>${header["Referer"]}</li>
	</ul>
	
	<h2>cookies</h2>
	<ul>
		<li>${cookie.JSESSIONID.value}</li>
	</ul>

	<h2>pageContext</h2>
	<ul>
		<li><%=request.getMethod() %></li>
		<li>${pageContext.request.method}</li>
		<li><%=request.getContextPath() %></li>
		<li>${pageContext.request.contextPath}</li>
	</ul>
	<ul>
		<li>${pageContext.errorData}</li>
		<li>${pageContext.request}</li>
		<li>${pageContext.response}</li>
		<li>${pageContext.page}</li>
		<li>${pageContext.session}</li>
		<li>${pageContext.servletConfig}</li>
		<li>${pageContext.servletContext}</li>
		
	</ul>
</body>
</html>