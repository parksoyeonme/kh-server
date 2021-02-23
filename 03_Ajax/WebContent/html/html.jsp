<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - html</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
#result-container {
	border: 1px solid gray;
	padding: 5px;
}
table#tbl-member{border:1px solid; border-collapse:collapse;}
#tbl-member th, #tbl-member td{border:1px solid; padding:10px;}
#tbl-member img{width:100px;}
</style>
</head>
<body>
	<h1>HTML</h1>
	<button id="btn">실행</button>
	<div id="result-container"></div>
	<script>
	$("#btn").click(function(){
		$.ajax({
			url : "<%= request.getContextPath() %>/html",
			method : "GET",
			dataType : "html",
			success : function(data){
				console.log(data);
				$("#result-container").html(data);
			},
			error : function(xhr, textStatus, err){
				console.log(xhr, textStatus, err);
			}
		});		
	});
	</script>
</body>
</html>