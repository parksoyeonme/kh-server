<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - xml</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
#result-container {
	border: 1px solid gray;
	padding: 5px;
}
table#tbl-member{border:1px solid; border-collapse:collapse;}
#tbl-member th, #tbl-member td{border:1px solid; padding:10px;}
#tbl-member img{width:100px; }
</style>
</head>
<body>
	<h1>XML</h1>
	<button id="btn">실행</button>
	<div id="result-container"></div>
	<script>
	$("#btn").click(function(){
		$.ajax({
			url : "<%= request.getContextPath() %>/xml",
			method : "GET",
			dataType : "xml",
			success : function(data){
				//console.log(data); //text -> xml document
				var $root = $(data).find(":root"); // members
				//console.log($root); //root 루트 태그 찾아주는것
				
				//자식태그중 member리턴
				var $member = $root.find("member");
				console.log($member);
				
				var $table = $("<table id='tbl-member'></table>");
				
				$member.each(function(index, member){
					var $member = $(member);
					var html = "<tr>";
					html += "<td><img src='<%= request.getContextPath() %>/images/" + $member.find("profile").text() + "' /></td>";
					html += "<td>" + $member.find("name").text() + "</td>";
					html += "<td>" + $member.find("phone").text() + "</td>";					
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