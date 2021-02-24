<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>ajax - json</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.box {
	margin : 10px 0;
}
table { 
	border: 1px solid #000;
	border-collapse: collapse;
}
th, td {
	border: 1px solid #000;
	padding: 5px;
}
table img {
	width: 100px;
}
</style>
</head>
<body>
	<h1>JSON</h1>
	<h2>회원목록 조회</h2>
	<input type="button" value="실행" id="btn1" />
	<div class="box" id="result1"></div>
	<script>
	$("#btn1").click(function(){
		
		$.ajax({
			url : "<%= request.getContextPath() %>/gson/memberList",
			method : "GET",
			dataType : "json",
			success : function(data){
				//응답메세지의 json문자열이 javascript객체로 변환되어 전달됨.
				//console.log(data);
				
				var $table = $("<table></table>");
				$.each(data, function(index, member){
					console.log(member);
					var html = "<tr>";
					html += "<td><img src='<%= request.getContextPath() %>/images/" + member.profile + "'/></td>";
					html += "<td>" + member.name + "</td>";
					html += "<td>" + member.phone +"</td>";
					html += "</tr>";
					$table.append(html);
				});
				
				$("#result1").html($table);
			},
			error : function(xhr, textStatus, err){
				console.log(xhr, textStatus, err);
			}
		});
		
	});
	</script>
	
	<h2>회원명조회</h2>
	<input type="search" id="searchMemberName" />
	<input type="button" value="검색" id="btn2"/>
	<div class="box" id="result2"></div>
	<script>
	$("#btn2").click(function(){
		var $searchMemberName = $("#searchMemberName");
		if(/^.{1,}$/.test($searchMemberName.val()) == false)
			return;
		
		$.ajax({
			url : "<%= request.getContextPath() %>/gson/member",
			data : {
				searchMemberName : $searchMemberName.val() 
			},
			dataType : "json",
			method : "GET",
			success : function(data){
				console.log(data);
				var $result2 = $("#result2");
				if(data == null){
					$result2.html("조회된 회원이 없습니다.");
				}
				else {
					var $table = $("<table></table>");
					$table
						.append("<tr><th>이름</th><td>" + data.name + "</td></tr>")
						.append("<tr><th>전화번호</th><td>" + data.phone + "</td></tr>")
						.append("<tr><th>프로필</th><td><img src='<%= request.getContextPath() %>/images/" + data.profile + "'/></td></tr>");
					$result2.html($table);
				}
			},
			error : function(xhr, status, err){
				console.log(xhr, status, err);
			}
		});
	});
	
	</script>
	
	<h2>회원추가</h2>
	<form>
		<table>
			<tr>
				<td><label for="memberName">이름</label></td>
				<td><input type="text" id="memberName" /></td>
			</tr>
			<tr>
				<td><label for="memberPhone">전화번호</label></td>
				<td><input type="tel" id="memberPhone" /></td>
			</tr>
			<tr>
				<td><label for="memberProfile">프로필</label></td>
				<td><input type="text" id="memberProfile" /></td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="button" value="저장" id="btn3" />
				</th>
			</tr>		
		</table>
	</form>
	<script>
	$("#btn3").click(function(){
		var member = {
			name : $("#memberName").val(),	
			phone : $("#memberPhone").val(),	
			profile : $("#memberProfile").val(),	
		};
		console.log(member);
		var jsonStr = JSON.stringify(member);
		console.log(jsonStr);
		
		$.ajax({
			url : "<%= request.getContextPath() %>/gson/insertMember",
			method : "POST",
			//data : member,
			data : {
				member : jsonStr
			},
			success : function(data){
				console.log(data); // 1
				
				if(data == "1"){
					alert("회원정보를 추가했습니다.");
					//회원 목록 조회
					$("#btn1").trigger('click');//클릭 이벤트 핸들러 실행!
				}
				else {
					alert("회원정보를 추가에 실패했습니다.");
				}
			},
			error : function(xhr, status, err){
				console.log(xhr, status, err);
			},
			complete : function(){
				//입력창 초기화
				$("#memberName, #memberPhone, #memberProfile").val('');
			}
			
		});
		
	});
	
	</script>

	






</body>
</html>


