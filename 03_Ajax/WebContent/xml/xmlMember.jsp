<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="java.util.List"%>
<%@page import="member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	xml Extensible Markup Language
	사용자 정의 태그 문서
 --%>
<%
	List<Member> list = (List<Member>)request.getAttribute("list");
%>
<members>
<% 
	for(Member m : list){
%>
 	<member>
 		<name><%= m.getName() %></name>
 		<phone><%= m.getPhone() %></phone>
 		<profile><%= m.getProfile() %></profile>
 	</member>
 <%
	}
 %>	
 </members>

 
 
 
 
 