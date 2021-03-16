<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jstl - c:forEach</title>
<style>
table, th, td {
	border: 1px solid #000;
}
</style>
</head>
<body>
	<h1>c:forEach</h1>
	<h2>String[]</h2>
	<ul>
		<c:forEach items="${names}" var="name">
			<li>${name}</li>
		</c:forEach>
	</ul>

	<h2>List&lt;String&gt;</h2>
	<ul>
		<c:forEach items="${list}" var="name">
			<li>${name}</li>
		</c:forEach>
	</ul>

	<h2>List&lt;Person&gt;</h2>
	<table id="tbl-person">
		<thead>
			<tr>
				<th>no</th>
				<th>name</th>
				<th>gender</th>
				<th>age</th>
				<th>married</th>
			</tr>
			<c:forEach items="${personList}" var="person" varStatus="vs">
				<tr>
					<%-- <td>${vs.count}</td> 1부터 시작--%>
					<td>${vs.index}</td>
					<td>${person.name}</td>
					<td>${person.gender}
					<!-- (input:r[name=gender]#gender$+label[for=gender$])*2 -->
					<input type="radio" name="gender${vs.count}" id="gender${vs.count}-1"  ${person.gender == '남'.charAt(0) ? 'checked' : ''}/>
					<label for="gender${vs.count}-1">남</label>
					<input type="radio" name="gender${vs.count}" id="gender${vs.count}-2" ${person.gender == '여'.charAt(0) ? 'checked' : ''}/>
					<label for="gender${vs.count}-2">여</label>
				</td>
					<td>${person.age}</td>
					<td>
						<input 
							type="checkbox" 
							onclick="return false;"
							${person.married ? 'checked' : ''} />
							
					</td>
				</tr>

			</c:forEach>
		</thead>
	</table>

	<h2>Set</h2>
	<span>
	<c:forEach items="${set}" var="num" varStatus="vs">
		<%-- ${num}<c:if test="${vs.count != set.size()}">,</c:if>--%>
		<%-- ${num}${vs.count != set.size() ? ',' : ''}--%>
		<%-- ${num}${vs.count eq set.size() ? "" : ","}--%>
		<%-- ${num}${not vs.last ? ', ' : ''} --%>
		<%-- ${num}${vs.first}${vs.last}--%>
		${num}${not vs.last ? ',' : ''}
	</c:forEach>
	</span>
	
	<h2>Map</h2>
	<table id="tbl-map">
		<thead>
			<tr>
				<th>key</th>
				<th>value</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${map}" var="entry">
			<tr>
				<td${entry.key}></td>
				<td>${entry.value}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<h2>c:forTokens</h2>
	<ul>
		<c:forTokens items="${s}" delims="," var="id">
		<li>${id}</li>
		</c:forTokens>
	</ul>
</body>
</html>