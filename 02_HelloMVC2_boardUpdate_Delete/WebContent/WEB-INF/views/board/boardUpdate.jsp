<%@page import="board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>    
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<%
	Board board = (Board)request.getAttribute("board");
%> 
<script>
function boardValidate(){
	var $content = $("[name=boardContent]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}
function boardView(){
	history.go(-1);
}
</script>
<section id="board-container">
<h2>게시판 수정</h2>
<form action="<%=request.getContextPath() %>/board/boardUpdate" method="post" enctype="multipart/form-data">
	<input type="hidden" name="boardNo" value="<%=board.getBoardNo()%>" />
	<table id="tbl-board-view">
	<tr>
		<th>제 목</th>
		<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle() %>" required></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<input type="text" name="boardWriter" value="<%=board.getBoardWriter() %>" readonly/>
		</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td >
			<input type="file" name="upFile" value="<%=board.getBoardOriginalFileName() != null ? board.getBoardOriginalFileName() : ""%>">
		</td>
	</tr>
	<tr>
		<th>내 용</th>
		<td><textarea rows="5" cols="50" name="boardContent"><%=board.getBoardContent()%></textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" value="수정하기"/>
			<input type="button" value="취소" onclick="boardView();"/>
		</th>
	</tr>
</table>
</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>