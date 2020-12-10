<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/header.jsp"/>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript">
	
	$(document).ready(function(){
		$("#resultNum").css("display", "none");



		$("#btn").click(function(){
			var param = { "email" : $("#user_email").val() };

			$.ajax({
				 url : "/member/checkEmail.do"
				,type: "get"
				,data : param
				,datatype: 'text'
				,success: function(data){

					if(data == false){
						alert('입력하신 이메일은 없는 이메일 입니다.');
					}else{
						alert('메일로 임시 비밀번호가 보내졌습니다.');
						
					}
					
				}
				
			});
		});
	});
	
	
	
</script>
<body>
<h2>ID찾기</h2>

	<table border="1" a>
	
			<tr><td style="text-align: center; background-color: #B4FFFF;">이메일</td></tr>
			<tr>
				<td>
					<input type="email" name="user_email" id="user_email">
				</td>
			</tr>
				
			<tr>
				<td>
					<input type="button"  value="확인" id="btn"  style="width: 100%;">
				</td>
			</tr>
			
			<tr id="resultNum">
				<td>
					<input type="text"  id="momentPw"  placeholder="임시번호 "   style="width: 50%;">
					<input type="button"  value="확인" id="btn"  style="width: 50%;">
				</td>
			</tr>
	</table>
</body>
</html>