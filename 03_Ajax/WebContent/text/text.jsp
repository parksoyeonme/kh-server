<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - text</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
	console.log('jquery loading complete!');
	
	$("#btn").click(function(){
		//ajax요청 전송
		$.ajax({
			url : "<%= request.getContextPath() %>/text",
			//data : "name=홍길동&age=50",
			data : {
				name : "신사임당",
				age : 48
			}, //이런식으로 객체로 보내도댐
			method : "GET", //기본값 GET | POST | PUT | DELETE
			dataType : "text", // xml | json | html | text | script
			beforeSend : function(){
				//비동기통신 요청전 호출
				console.log("beforeSend");
			},
			success : function(data){
				//data매개변수에는 응답결과가 담겨 있다.
				//alert(data);
				//$("#result").html(data); // data를 html방식으로 보내주세요
				$("#result").text(data); //보내는타입에따라 보여지는게 달라짐
			},
			error : function(xhr, textStatus, err){ //xhr -> XMLHttpRequest
				//처리실패시 호출
				console.log(xhr, textStatus, err);
			},
			complete : function(){
				//요청성공/실패와 상관없이 마지막에 호출 : try~catch의 finally와 같음
				console.log('complete');
			}
		});
	});
});

</script>
<style>
#result {
	width : 500px;
	min-height: 100px;
	background-color:lightgray;
	border: 2px solid gray;
	padding: 5px;
	margin: 5px 0 ;
}
</style>
</head>
<body>
	<h1>text</h1>
	<input type="button" value="실행" id="btn" />
	<div id="result"></div>
</body>
</html>