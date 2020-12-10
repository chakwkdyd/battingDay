<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
	


	<h1> 로그인 </h1>
	<form action="/member/login.do">
		
		<table border="1">
			<tr><td style="text-align: center; background-color: #B4FFFF;">아이디</td></tr>
			<tr>
				<td>
					<input type="text" name="user_id" id="user_id">
				</td>
			</tr>
				
			<tr><td style="text-align: center; background-color: #B4FFFF;">비밀번호</td></tr>
			<tr>
				<td>
					<input type="password" name="user_pw" id="pw1" class="pw">
				</td>
			</tr>
				
			 
			
			<tr>
				<td>
					<input type="text" id="roginResult" style="width: 100%;" hidden="true">
					<input style="width: 100%;" type="submit" value="로그인">
				</td>
			</tr>
			<tr>
				<td>
					<a href="${path}/member/getId.do">아이디 찾기</a>
					<a href="${path}/member/getPw.do">비밀번호찾기 </a>
				</td>
			</tr>
			
		</table>
	</form>

</body>
</html>