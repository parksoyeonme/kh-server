<%@page import="board.model.vo.BoardComment"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.model.vo.Board"%>
<% 
	Board board = (Board)request.getAttribute("board");
	List<BoardComment> commentList = (List<BoardComment>)request.getAttribute("commentList");
%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script>
$(function(){
	/**
	* 댓글 삭제 
	*/
	$(".btn-delete").click(function(){
		if(confirm('해당 댓글을 정말 삭제하시겠습니까?')){
			var boardCommentNo = $(this).val();
			location.href = "<%= request.getContextPath() %>/board/boardCommentDelete?boardCommentNo=" + boardCommentNo +"&boardNo=<%= board.getBoardNo() %>"; 
		}
	});
	
	
	
	/**
	* 대댓글(답글) 버튼을 누르면 해당 tr바로 하위에 새로운 tr태그를 생성해 폼을 제공한다.
	*/
	$(".btn-reply").one('click', function(){
		<% if(memberLoggedIn == null) { %>
			<%--로그인 하지 않은 경우 --%>
			loginAlert();
		<% } else { %>
			<%--로그인한 경우 --%>
			var $this = $(this);//현재 클릭한 .btn-reply
			var html = '<tr>';
			html += '<td style="display:none; text-align:left" colspan="2">'; 
			html += '<form action="<%= request.getContextPath() %>/board/boardCommentInsert" method="POST">';
			html += '<input type="hidden" name="boardRef" value="<%= board.getBoardNo() %>" />';
			html += '<input type="hidden" name="boardCommentWriter" value="<%= memberLoggedIn != null ? memberLoggedIn.getMemberId() : "" %>" />';
			html += '<input type="hidden" name="boardCommentLevel" value="2" />';
			html += '<input type="hidden" name="boardCommentRef" value="' + $this.val() + '" />';
			html += '<textarea name="boardCommentContent" cols="60" rows="2"></textarea>';
			html += '<button type="submit" class="btn-insert2">등록</button>';
			html += '</form>';
	        html += '</td>';
	        html += '</tr>';
	        
	        //기준 tr
	        var $trFromBtnReply = $this.parent().parent();
	        console.log(html);
	        //추가할 요소 기준
	        $(html).insertAfter($trFromBtnReply)
	        	   .find("td")
				   .slideDown(800)
				   .find("form")
				   .submit(function(e){
					   var $textarea = $(e.target).children('textarea');
					   if(/^(.|\n){1,}$/.test($textarea.val()) == false){
							alert("댓글 내용을 작성해주세요.");
							$textarea.focus();
							e.preventDefault();
						}
					   
				   });
			
		<% } %>
	});
	
	
	/**
	* 로그인 하지 않고 댓글을 작성할 수 없다.
	*/
	$("[name=boardCommentContent]").focus(function(){
		<%-- if(<%= memberLoggedIn == null %>)
			loginAlert(); --%>
		
		<% if(memberLoggedIn == null){%>
			loginAlert();
		<% } %>
	});
	
	/**
	* 폼 제출 유효성 검사
	* 1. return false;
	* 2. event.preventDefault();
	*/
	$("[name=boardCommentFrm]").submit(function(e){
		var $boardCommentContent = $("[name=boardCommentContent]");
		if(/^(.|\n){1,}$/.test($boardCommentContent.val()) == false){
			alert("댓글 내용을 작성해주세요.");
			$boardCommentContent.focus();
			e.preventDefault();
		}
	});
	
	
});

function loginAlert(){
	alert("로그인후 댓글을 작성할 수 있습니다.");
	$("#memberId").focus();
}

function fileDownload(oName, rName){
	console.log(oName, rName);
	location.href = "<%= request.getContextPath() %>/board/fileDownload?oName=" + oName + "&rName=" + rName; 
}
</script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/board.css" />
<section id="board-container">
	<h2>게시판</h2>
	<table id="tbl-board-view">
		<tr>
			<th>글번호</th>
			<td><%= board.getBoardNo() %></td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><%= board.getBoardTitle() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%= board.getBoardWriter() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%= board.getBoardReadCount() %></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td>
			<%-- 첨부파일이 있을경우만, 이미지와 함께 original파일명 표시 --%>
			<% if(board.getBoardOriginalFileName() != null){ %>
				<a href="javascript:fileDownload('<%=board.getBoardOriginalFileName() %>', '<%= board.getBoardRenamedFileName() %>')">
					<img alt="첨부파일" src="<%=request.getContextPath() %>/images/file.png" width=16px>
					<%= board.getBoardOriginalFileName() %>
				</a>
			<% } %>
			</td>
		</tr>
		<tr>
			<th>내 용</th>
			<td><%= board.getBoardContent() %></td>
		</tr>
		<%-- 작성자와 관리자만 마지막행 수정/삭제버튼이 보일수 있게 할 것 --%>
		<% if(
			memberLoggedIn != null
		 && (memberLoggedIn.getMemberId().equals(board.getBoardWriter())
		 	|| MemberService.ADMIN_MEMBER_ROLE.equals(memberLoggedIn.getMemberRole()))
		){ %>
		<tr>
			<th colspan="2">
				<input type="button" value="수정하기" onclick="updateBoard();"/> 
				<input type="button" value="삭제하기" onclick="deleteBoard();" />
			</th>
		</tr>
		<script>
		function updateBoard(){
	        location.href="<%=request.getContextPath()%>/board/boardUpdate?boardNo=<%=board.getBoardNo() %>";
		}
		
		function deleteBoard(){
			if(confirm("이 게시물을 삭제하시겠습니까?")){
				$("[name=boardDelFrm]").submit();
			}
		}
		</script>
		<form 
			action="<%= request.getContextPath() %>/board/boardDelete"
			method="POST"
			name="boardDelFrm">
			<input type="hidden" name="boardNo" value="<%= board.getBoardNo() %>"/>
			<input type="hidden" name="rName" value="<%= board.getBoardRenamedFileName() != null ? board.getBoardRenamedFileName() : "" %>" />
		</form>
		<% } %>
	</table>
	
	
	<hr style="margin-top:30px;" />	
    
	<div class="comment-container">
        <div class="comment-editor">
            <form action="<%=request.getContextPath()%>/board/boardCommentInsert" method="post" name="boardCommentFrm">
                <input type="hidden" name="boardRef" value="<%= board.getBoardNo() %>" />
                <input type="hidden" name="boardCommentWriter" value="<%= memberLoggedIn != null ? memberLoggedIn.getMemberId() : "" %>" />
                <input type="hidden" name="boardCommentLevel" value="1" />
                <input type="hidden" name="boardCommentRef" value="0" />    
				<textarea name="boardCommentContent" cols="60" rows="3"></textarea>
                <button type="submit" id="btn-insert">등록</button>
            </form>
        </div>
		<!--table#tbl-comment-->
		
		<table id="tbl-comment">
		<%
	    if(commentList != null){
	        for(BoardComment bc : commentList){
	            if(bc.getBoardCommentLevel()==1){
	    %>
	                <tr class=level1>
	                    <td>
	                        <sub class=comment-writer><%=bc.getBoardCommentWriter() %></sub>
	                        <sub class=comment-date><%=bc.getBoardCommentDate()%></sub>
	                    	<br />
	                        <%=bc.getBoardCommentContent() %>
	                    </td>
	                    <td>
	                        <button class="btn-reply" value="<%=bc.getBoardCommentNo()%>">답글</button>
	                        <% if(memberLoggedIn != null
	                        	&&(bc.getBoardCommentWriter().equals(memberLoggedIn.getMemberId())
	                        		|| MemberService.ADMIN_MEMBER_ROLE.equals(memberLoggedIn.getMemberRole()))
	                        		){ %>
	                        <%--댓글 작성자와 관리자권한이 있는 경우만 노출 --%>
	                        <button class="btn-delete" value="<%= bc.getBoardCommentNo() %>">삭제</button>
	                        <% }%>
	                    </td>
	                </tr>
	                
	                
	    <% 		} 
	            else { %>
	                <tr class=level2>
	                    <td>
	                        <sub class=comment-writer><%=bc.getBoardCommentWriter() %></sub>
	                        <sub class=comment-date><%=bc.getBoardCommentDate()%></sub>
	                    	<br />
	                        <%=bc.getBoardCommentContent() %>
	                    </td>
	                    <td>
	                        <% if(memberLoggedIn != null
	                        	&&(bc.getBoardCommentWriter().equals(memberLoggedIn.getMemberId())
	                        		|| MemberService.ADMIN_MEMBER_ROLE.equals(memberLoggedIn.getMemberRole()))
	                        		){ %>
	                        <%--댓글 작성자와 관리자권한이 있는 경우만 노출 --%>
	                        <button class="btn-delete" value="<%= bc.getBoardCommentNo() %>">삭제</button>
	                        <% }%>
	                    </td>
	                </tr>
	
	    <%
	            }
	
	        }	
	    } 
	    %>
		</table>
				
	</div>
	
	
	
	
</section>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>