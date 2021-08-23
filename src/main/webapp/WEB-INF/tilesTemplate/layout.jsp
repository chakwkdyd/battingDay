<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<%@ include file="./commonInclude.jsp" %>
</head>

	
<body>
	<div class="header">
		<tiles:insertAttribute name="header"/>
	</div>
	<div class="body">
		<tiles:insertAttribute name="body"/>
	</div>
	<div class="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
	
</html>