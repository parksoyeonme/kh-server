<%@page import="member.model.vo.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Member> list = (List<Member>)request.getAttribute("list"); 
%>
<table id="tbl-member">
	<tr>
		<th>프로필</th>
		<th>이름</th>
		<th>전화번호</th>
	</tr>
	<%
	for(Member m : list){
	%>
	<tr>
		<td>
			<img src="<%= request.getContextPath() %>/images/<%= m.getProfile() %>" alt="<%= m.getName() %>사진" />
		</td>
		<td><%= m.getName() %></td>
		<td><%= m.getPhone() %></td>
	</tr>
	<%
	}
	%>
</table>



