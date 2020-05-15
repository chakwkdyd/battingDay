<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<div>
	<a href="${path}/">회원가입</a>
	<a href="${path}/board/insertBoard" >방 만들기</a>
	<a href="${path}/member/login" >로그인</a>
</div>

<hr>