<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<div>

	<a href="${path}/member/login" >로그인</a>
	<a href="${path}/">회원가입</a>
	<a href="${path}/upload/uploadForm">업로드 테스트</a>
	
	<a href="${path}/board/insertBoard" >방 만들기</a>
	<a href="${path}/callinder/moneySave.do">가계부 </a>
	
	<a href="${path}/plan/planing.do">계획표 </a>
	<a href="${path}/sample/openSampleList.do">test </a>
	
</div>

<hr>