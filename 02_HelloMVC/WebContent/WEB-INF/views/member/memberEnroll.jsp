<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<section id=enroll-container>
<script>
//유효성검사해주기
$(function(){
	var frm = document.querySelector("[name=memberEnrollFrm]");
	frm.onsubmit = function(){
		if(memberId.value.length < 4){
	 		alert("아이디는 4글자 이상이어야 합니다.");
	        memberId.select();
	        return false;//조기리턴 -> 폼제출방지
	        }
		
		//아이디 중복검사
    	var $idValid = $("#idValid");
    	if($idValid.val() != 1){
    		alert("아이디 중복 검사해주세요.");
    		$idValid.focus();
    		return false;
    	}
	
	        //2.이름 검사 
	        if(/^[가-힣]{2,}$/.test(memberName.value) == false){
	        //memberName.value이 정규식에 /^[가-힣]{2,}$/가 맞는가 test하겠다
	        alert("이름은 한글 2글자 이상이어야합니다.");
	        memberName.select();//다시리턴할때 여기로 ,멤버네임에 마우스올려준다 라고 해야하나
	         //select memberName 블럭잡아줌 드래그처리
	        return false;
	        }
	
	        //3.비밀번호 검사 : 4글자이상 && (pwd.value == pwdCheck.value)
	        if(pwd.value.length < 4){
	        alert("비밀번호는 4글자 이상이어야 합니다.");
	        pwd.select();
	        return false;
	        }
	
	        if(pwd.value != pwdCheck.value){
	        alert("비밀번호가 일치하지 않습니다.");
	        pwd.value = '';
	        pwdCheck.value = '';
	        pwd.focus();
	        return false;
	        }
	
	        return true;
	
	}
});
/**
* 중복 검사 이후 아이디를 변경한 경우, 다시 중복검사를 해야한다.
*/
$("#memberId_").change(function(){
	$("#idValid").val(0);
});


/*
 *  아이디 중복검사
 */
 function checkIdDuplicate(){
	//1. 아이디 유효성 검사
	var $memberId = $(memberId_);
	if(/^[a-zA-Z0-9_]{4,}$/.test($memberId.val()) == false){
		alert("유효한 아이디를 입력해주세요.");
		$memberId.select();
		return;
	}
	var title = "checkIdDuplicatePopup";
	var spec = "left=500px, top=300px, width=300px, height=200px";
	open("", title, spec); //open(url, title, spec);이게있어야팝업가능
	
	
	//var $frm = $("[name=checkIdDuplicateFrm]");
	var $frm = $(document.checkIdDuplicateFrm);// name값은 document에서 바로 접근가능
	//아이디값 세팅
	$frm.find("[name=memberId]")
		.val($memberId.val()); //위에 사용한 memberId사용
	$frm.attr("action", "<%= request.getContextPath() %>/member/checkIdDuplicate")
		.attr("method", "POST")
		.attr("target", title) //폼과 팝업 연결 설정
		.submit();
	}

</script>
<!-- 아이디 중복검사용 폼 : 노출되지않는다 hidden이기때문에 -->
<form name="checkIdDuplicateFrm">
	<input type="hidden" name="memberId" />
</form>
	<h2>회원 가입 정보 입력</h2>
	<form name="memberEnrollFrm" action="<%=request.getContextPath() %>/member/memberEnroll" method="post">
		<table>
			<tr>
				<th>아이디<sup>*</sup></th>
				<td>
					<input type="text" placeholder="4글자이상" name="memberId" id="memberId_" required>
					<input type="button" value="중복검사" onclick="checkIdDuplicate();"/>
					<input type="hidden" id="idValid" value="0" />
					<%--중복검사 통과인경우 1 / 통과하지 못한경우 0 --%>
				</td>
			</tr>
			<tr>
				<th>패스워드<sup>*</sup></th>
				<td>
					<input type="password" name="password" id="password_" required><br>
				</td>
			</tr>
			<tr>
				<th>패스워드확인<sup>*</sup></th>
				<td>	
					<input type="password" id="password2" required><br>
				</td>
			</tr>  
			<tr>
				<th>이름<sup>*</sup></th>
				<td>	
				<input type="text"  name="memberName" id="memberName" required><br>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>	
				<input type="date" name="birthDay" id="birthDay" ><br />
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" placeholder="abc@xyz.com" name="email" id="email"><br>
				</td>
			</tr>
			<tr>
				<th>휴대폰<sup>*</sup></th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required><br>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" placeholder="" name="address" id="address"><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<input type="radio" name="gender" id="gender0" value="M" checked>
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F">
					<label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동"><label for="hobby0">운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산"><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서"><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임"><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행"><label for="hobby4">여행</label><br />
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
	</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
