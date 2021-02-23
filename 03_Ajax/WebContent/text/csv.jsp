<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - csv</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
#result-container {
	border: 1px solid gray;
	padding: 5px;
	min-height: 100px;
	background-color: lightgray;
}
table#tbl-member{border:1px solid; border-collapse:collapse;}
#tbl-member th, #tbl-member td{border:1px solid; padding:10px;}
#tbl-member img{width:100px; }
</style>
</head>
<body>
	<h1>CSV</h1>
	<input type="button" value="실행" id="btn" />
	<div id="result-container"></div>
	<script>
	$("#btn").click(function(){
		$.ajax({
			url : "<%= request.getContextPath() %>/csv",
			method : "GET",
			dataType : "text",
			success : function(data){
				console.log(data);
				
				var arr = data.split("\n");
				console.log(arr);
				
				var $table = $("<table id='tbl-member'></table>");
				$.each(arr, function(index, str){
					var member = str.split(",");
					console.log(index, member);
					var html = "<tr>";
					html += "<td><img src='<%= request.getContextPath() %>/images/" + member[2] + "'/></td>";
					html += "<td>" + member[0] + "</td>";
					html += "<td>" + member[1] + "</td>";					
					html += "</tr>";
					$table.append(html);
				});
				
				$("#result-container").html($table);
				
			},
			error : function(xhr, textStatus, err){
				console.log(xhr, textStatus, err);
			}
		});		
	});
	</script>
</body>
</html>