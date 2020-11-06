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

window.onload = function() {
	if(1 == ${result}){
		fn_parents();
		close();
	}
}

	// ==== < li 삭제 ajax > ====
	function fn_resetLi(string, fixe, flag){
		// ==== 서버 O ==== 
		if( fixe == 'O'){
			var frm = $("#frm");
			// -- 삭제 --
			if(string == 'del'){
				if (confirm("정말 삭제하시겠습니까??") == true){
					frm.attr("action", "/callinder/delete.do");
					frm.submit();
				}
			// -- 수정 --
			}else{
				if (confirm("수정 하시겠습니까??") == true){
					$("#popTxt2").val($("#popTxt").val());  
					$("#popPrice2").val($("#popPrice").val());  
					
					frm.attr("action", "/callinder/update.do");
					frm.submit();
				}
			}
		// ==== 서버 값 X ====		
		}else{
			var ids = '${id}'.split("_");
			var str = $(opener.document).find("#${id}");
				
			// ======= 삭제 ======
			if(string == 'del'){
				if (confirm("정말 삭제하시겠습니까??") == true){
					// --- 고정값  삭제 ---
					if(flag == 'all'){
						window.opener.fn_popReset(str[0].textContent,'all', ids[0], 1, ids[2]);
					// --- 일반값 삭제 ---
					}else{
						window.opener.fn_popReset(str[0].textContent,'no', ids[0], ids[2], ids[3]);
					}
				}
			// ====== 수정 ======
			}else{
				if (confirm("수정 하시겠습니까??") == true){
					
					// --- Validation ---
					if( Validation(ids[0], $("#popTxt").val(), $("#popPrice").val()) == false){ return; }
					
	
					// --- 고정값  삭제  && li생성 ---
					if(flag == 'all'){
						window.opener.fn_popReset(str[0].textContent,'all', ids[0], 1, ids[2]);
						// --고정 li생성--
						window.opener.fn_Calculation(ids[0], ids[2], 'Y', $("#popTxt").val(), $("#popPrice").val());
					// --- 일반값 삭제  && li생성 ---
					}else{
						window.opener.fn_popReset(str[0].textContent,'no', ids[0], ids[2], ids[3]);
						// --일반 li생성--
						window.opener.fn_Calculation(ids[0], ids[2], 'N', $("#popTxt").val(), $("#popPrice").val());
					}
				}
			
			}
			close();
		}
	}
	
	// ========= < 부모 메서드 호출 > =========
	function fn_parents(){
		window.opener.fn_submit(1); 
	}

	// ========= < Validation > =========
	function Validation(flag, str, price){
		if(flag =="P"){
			if(str ==""){ 
				alert('수입내용을 입력하시오.');
				return false;
			}else if(price ==""){
					alert('수입금액을 입력하시오.');
				return false;
			}			
		}else{
			if(str ==""){ 
				alert('지출내용을 입력하시오.');
				return false;
			}else if(price ==""){
				alert('지출금액을 입력하시오.');
				return false;
			}
		}
	}
	
	//========= < 엔터 이벤트 > =========
	function fn_enter(flag, num){
		var str   = $('#txt').val();
		var price = $('#plice').val();
		
		 if (window.event.keyCode == 13) {
			if(flag =="P"){
				if(str ==""){ 
					alert('수입내용을 입력하시오.');
					return;
				}else if(price ==""){
						alert('수입금액을 입력하시오.');
					return;
				}else{
					 fn_Calculation(flag, num);
				}			
			}else if(flag =="M"){
				if(str ==""){ 
					alert('지출내용을 입력하시오.');
					return;
				}else if(price ==""){
					alert('지출금액을 입력하시오.');
					return;
				}else{
					 fn_Calculation(flag, num);
				}
			}
		}
	}

</script>
<body>
<h2> < 수정 페이지 > </h2>
		
		
		
	<form id="frm" method="post">
		<input type="hidden" name="fseq" 	  value="${pk}">
		<input type="hidden" name="popTxt"    id="popTxt2">
		<input type="hidden" name="popPrice"  id="popPrice2">
		<input type="hidden" name="flag" 	  value="${p_m}">
	</form>
	
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
						<input type="text" 	 id="popTxt" value="${txt}" placeholder="수입내용">
					</td>
					<td>
						<input type="number" id="popPrice" value="${price}" placeholder="수입금액(₩)" onkeyup="fn_enter('P', ${i});">
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;">
						<input type="button" onclick="fn_resetLi('update', '${fixe}', '${flag}')" style="width: 165px;" value="수정">
						<input type="button" onclick="fn_resetLi('del', '${fixe}', '${flag}')" style="width: 165px;" value="삭제">
					</td>
				</tr>
			</tbody>
		</table>
	
</body>
</html>