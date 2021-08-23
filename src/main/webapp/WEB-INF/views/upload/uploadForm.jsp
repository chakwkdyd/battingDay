<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	iframe{
		width : 400px;
		height: 200px;
		border: 1px;
		border-style: solid;
	}
</style>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>

	<form id="form1" action="${path}/upload/uploadForm" method="post" enctype="multipart/form-data" target="iframe1">
		<input type="file" name="file">
		<input type="submit" value="업로드">
	</form>
	
	<iframe name="iframe1"></iframe>
</body>
</html>