<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="http://example.com/myicon.png"> 
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<jsp:include page="../include/header.jsp"/>



<script type="text/javascript">

$(function(){
	$('#pwResult').hide();
});
	
	//===PW체크===
	function isSame(){
		
		var pw1 = $('#pw1').val();
		var pw2 = $('#pw2').val();
		
		if(pw1 != pw2 && (pw2 != '' && pw1 != '')){
			$('#pw2').val('');
			$('#pwResult').show();
			$('#pwResult').css('color', 'red');
			$('#pwResult').val('비밀번호가 일치하지 않습니다.');
			$('#pw2').focus(); 
		}else if(pw1 == pw2 && (pw2 != '' && pw1 != '')){
			$('#pwResult').show();
			$('#pwResult').css('color', 'blue');
			$('#pwResult').val('비밀번호가 일치합니다.');
		}
	}

	// ===ID체크===
	function idCheck(){
		
		var id 		= $("#user_id").val();
		var param 	= {"id" : id};
		
		$.ajax({
			 url : "/member/checkId.do"
			,type : 'get'
			,data : param			
			,datatype : 'text'
			,success : function(result){
				console.log(result);
				if(result == true){
					$("#idResult").show();
					$("#idResult").css("color", "blue");
					$("#idResult").val('사용가능 ID 입니다');
				}else if( result == false){
					$("#idResult").show();
					$("#idResult").css("color", "red");
					$("#idResult").val('사용불가 ID 입니다');
					
				}
				
			}
			
		});
	}
</script>

<body>

	<h1> 회원 가입 </h1>
	<form action="/member/join.do">
		
		<table border="1">
			<tr><td>아이디:</td></tr>
			<tr>
				<td>
					<input type="text" name="user_id" id="user_id">
					<input type="button" value="ID체크" onclick="idCheck()">
					<br>
					<input type="text" id="idResult" style="width: 100%;" hidden="true">
					
				</td>
			</tr>
			
			<tr><td>비밀번호:</td></tr>
			<tr>
				<td>
					<input type="text" name="user_pw" id="pw1" class="pw">
				</td>
			</tr>
			
			<tr><td>비밀번호 재확인:</td></tr>
			<tr>
				<td>
					<input type="text" id="pw2" class="pw" onchange="isSame()">
					<br>
					<input type="text" id="pwResult" style="width: 100%;">
				</td>
			</tr>
			
			<tr><td>이름:</td></tr>
			<tr>
				<td>
					<input type="text" name="user_name">
				</td>
			</tr>
			
			<tr><td>번호:</td></tr>
			<tr>
				<td>
					<input type="text" name="tel_number">
				</td>
			</tr>
			
			<tr><td>이메일:</td></tr>
			<tr>
				<td>
					<input type="email" name="user_email">
				</td>
			</tr>
			
			<tr>
				<td>
					<input type="submit" value="가입하기">
				</td>
			</tr>
		</table>
	</form>
	
</body>
</html>