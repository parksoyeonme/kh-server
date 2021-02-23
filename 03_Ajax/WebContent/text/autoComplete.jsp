<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax - autoComplete</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
	<h1>Auto Complete</h1>
	<div class="wrapper">
		<input type="text" id="searchName"/>
	</div>
	<script>
	function ajaxSearchName(request, response){
		//서버 비동기 통신
		$.ajax({
			url : "<%= request.getContextPath() %>/autoComplete",
			data : {
				searchName : request.term
			},
			method : "GET",
			dataType : "text",
			success : function(data){
				console.log(data);
				var arr = data.split(",");
				console.log(arr);
				/*
				[
					{label: '강유정', value: '강유정'},
					{label: '이효정', value: '이효정'},
					{label: '정다미', value: '정다미'},
					...
				]
				*/
				arr = $.map(arr, function(str){
					//배열요소 -> 변경처리 -> 요소리턴
					return {
						label : str,
						value : str
					};
				});
				console.log(arr);
				//검색어 목록 작성
				response(arr);
			},
			error : function(xhr, status, err){
				console.log(xhr, status, err);
			}
		});
	}

	
	$("#searchName").autocomplete({
		//source : ['Apple', 'application', 'appear', 'abcde'],
		source : function(request, response){
			//배열이 아닌 함수형태로도 처리가 가능하다.
			//console.log(request);//사용자 입력값을 포함하는 객체
			//console.log(response);//자동검색어 목록을 만들기 위한 함수
			ajaxSearchName(request, response);
		},
		minLength : 1,
		delay : 500,
		focus : function(e, focus){
			//포커스를 가져도 선택되지 않도록함.
			return false;
		}
	});
	
	
	/* 
	$("#searchName").keyup(function(){
		console.log($(this).val());
		
		//아무것도 치지않았을때는 아무결과도 안나오도록
		if($(this).val().length == 0)
			return;
		
		$.ajax({
			url : "<%= request.getContextPath() %>/autoComplete",
			data : {
				searchName : $(this).val() //이쪽에서 servlet parameter data 준것
			},
			method : "GET",
			dataType : "text",
			success : function(data){
				console.log(data);
				var arr = data.split(",");
				console.log(arr);
				
			},
			error : function(xhr, status, err){
				console.log(xhr, status, err);
			}
		});
		
	}); */
	</script>


</body>
</html>