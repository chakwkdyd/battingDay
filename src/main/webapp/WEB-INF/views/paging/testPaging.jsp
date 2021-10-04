<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 목록</title>
</head>
<script type="text/javascript">

	function selChange(num){
		location.href = "/paing/boardList?page=0&perPageNum="+ num;
	}
</script>
<style>
	h2 {
		text-align: center;
	}
	table {
		width: 100%;
	}
	#outter {
		display: block;
		width: 60%;
		margin: auto;
	}
	a {
		text-decoration: none;
	}
	
	 ul li {	
	 		list-style-type: none; 
			/* float: left;
			margin-left: 20px; */
			display: inline-block;
  	} 
	 ul {
			text-align: center;
	} 
</style>
<body>
<h2>게시판</h2>

<div id="outter">
	<div style="float: right;">
		<select id="cntPerPage" name="sel" onchange="selChange(this.value)">
			<option value="5"
				<c:if test="${perPageNum == 5}">selected</c:if>>5줄 보기</option>
			<option value="10"
				<c:if test="${perPageNum == 10}">selected</c:if>>10줄 보기</option>
			<option value="15"
				<c:if test="${perPageNum == 15}">selected</c:if>>15줄 보기</option>
			<option value="20"
				<c:if test="${perPageNum == 20}">selected</c:if>>20줄 보기</option>
		</select>
	</div> <!-- 옵션선택 끝 -->
	<table border="1">
		<tr>
			<td>No.</td>
			<td width="50%">제목</td>
			<td>작성자</td>
			<td>등록일</td>
			<td>조회수</td>		
		</tr>
		<c:forEach items="${list}" var="list">
			<tr>
				<td>${list.idx}</td>
				<td><a href='detail?seq=${list.idx}'>${list.title}</a></td>
				<td>${list.writer}</td>
				<td><fmt:formatDate value="${list.insert_day}" pattern="yyyy.MM.dd"/> </td>
				<td>${list.enter_cnt}</td>
			</tr>
		</c:forEach>
	</table>
	<input type="button" value="글쓰기" style="float: right;" onclick="location.href='/write'"><br>
	
	
	
	<ul class="btn-group pagination">
		pageMaker.prev ---> ${pageMaker.prev}
		<br>
		pageMaker.next    ---> ${pageMaker.next}
		<br>
	    pageMaker.endPage ---> ${pageMaker.endPage}
	    <br><br><br>
		<!-- 이전 버튼 -->
		 <c:if test="${pageMaker.prev}">
		    <li>
		        <a href='<c:url value="/paing/boardList?page=${pageMaker.startPage-1}"/>'><i class="fa fa-chevron-left">이전</i></a>
		    </li>
	    </c:if>
	    
	    
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="pageNum">
		    <li>
		        <a href='<c:url value="/paing/boardList?page=${pageNum}"/>'><i class="fa">${pageNum}</i></a>
		    </li>
	    </c:forEach>
	    
	    
	    <!-- 다음버튼 -->
	  
	    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    <li>
		        <a href='<c:url value="/paing/boardList?page=${pageMaker.endPage+1}"/>'><i class="fa fa-chevron-right">다음</i></a>
		    </li>
	    </c:if>
	    
	</ul>
</div>
</body>
</html>