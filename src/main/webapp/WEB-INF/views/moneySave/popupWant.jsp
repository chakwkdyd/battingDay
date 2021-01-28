<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
 var urls = "";
 
	window.onload = function() {

		//==== < 추가 / 수정 / 삭제 이벤트 > ====
		if( ${map.flag}.id == "insert"){
			hide(1);
			$("#delYn").val("N"); // 삭제 안 함.
        	$("#fixeYn").val("N");// 고정 안 함.
			urls = "/callinder/insertWant.do";
		}else{
			hide();
		}

		if(${map.flag}.id != 0){
			$("#popTxt").val('${map.txt}');
			$("#popPrice").val(${map.price});
			
		}

		//==== < 라디오 버튼 이벤트 > ====
		$("input:radio[name=fixeYn1]").click(function(){
			var f = $("#frm");
			
			// === 일반 ===
			 if($("input[name=fixeYn1]:checked").val() == "1"){
	        	$("#delYn").val("N"); // 삭제 안 함.
	        	$("#fixeYn").val("N");// 고정 안 함.
	        	urls = "/callinder/insertWant.do";
			// === 고정 ===
			 }else if($("input[name=fixeYn1]:checked").val() == "2"){
	        	$("#delYn").val("N"); // 삭제 안 함.
	        	$("#fixeYn").val("Y");// 고정  함. 
	        	urls = "/callinder/insertWant.do";
				 
			// === 수정 ===
			 }else if($("input[name=fixeYn1]:checked").val() == "3"){
	        	$("#delYn").val("N");		// 삭제 안 함.
	        	$("#fixeYn").val(${fixeYn});// 고정  함.
	        	urls = "/callinder/updateWant.do";
				 
			// === 삭제 ===
			 }else if($("input[name=fixeYn1]:checked").val() == "4"){
	        	$("#delYn").val("Y");// 삭제 함.
	        	urls = "/callinder/deleteWant.do";
	        }
		});
			
	}

	// ----- 라디오 버튼 히든 -----
	function hide(num){
		// -- 추가 버튼 --
		if(num == 1){
			$("#divBtn").show();
			$("#divUpdate").hide();
			$("#normal").prop("checked", true);
			
		// -- 디테일 --
		}else{
			$("#divUpdate").show();
			$("#divBtn").hide();
			$("#normal").prop("checked", false);
			$("#update").prop("checked", true);
		}		
	}

	

		
		
	//==== < Want insert > ====
	function fn_insert(flag){
		var queryString = $('#frm').serialize();

		if(flag == null){
			close();
		}else{
		// == 저장 / 수정 / 삭제 ==
			console.log(urls);
			
			$.ajax({
				 url : urls
				,type : 'post'
				,data : queryString			
				,datatype : 'text'
				,success : function(result){
					
					window.opener.fn_selWant()
					window.opener.fn_submit(1);
				 	close();
				}
				,error: function(data){
					alert("====== 에 러 ======");
				}
				
			});
		}
	}


	

</script>
<body>
<h2> [ ${map.years}년  ${map.months}월  I WANT ] </h2>
		
		
	<form id="frm">
		<input type="hidden" name="seq" 	 id="seq" 		value="${seq}">
		<input type="hidden" name="years" 	 id="years" 	value="${map.years}">
		<input type="hidden" name="months" 	 id="months" 	value="${map.months}">
		<input type="hidden" name="delYn" 	 id="delYn" 	> 
		<input type="hidden" name="fixeYn" 	 id="fixeYn" 	> 
		
	
		<table border="1">
			<thead>
				<tr>
					<th>내용</th>
					<th>가격</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<input type="text" name="txt" 	 id="popTxt" value="${txt}" placeholder="사고싶은 것">
					</td>
					<td>
						<input type="number" name="price" id="popPrice" value="${price}" placeholder="가격">
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: center;">
						<div id="divBtn">
							<input type="radio" name="fixeYn1" id="normal"   value="1"><label for="normal">일반</label>
							<input type="radio" name="fixeYn1" id="fixe"  	 value="2"><label for="fixe">고정</label>
						</div>
						<div id="divUpdate">
							<input type="radio" name="fixeYn1" id="update" 	 value="3"><label for="update">수정</label>
							<input type="radio" name="fixeYn1" id="del" 	 value="4"><label for="del">삭제</label>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;">
						<input type="button" id="insert" onclick="fn_insert('insert')" style="width: 165px;" value="확인">
						<input type="button" onclick="fn_insert()" style="width: 165px;" value="취소">
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>