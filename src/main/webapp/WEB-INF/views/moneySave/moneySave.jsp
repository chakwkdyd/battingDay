<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<html>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/header.jsp"/>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>가계부</title>
</head>

<style type="text/css">
	.category 	{ background-color: #FFD9FA;}
 	.day 		{ background-color: #CEFBC9;}
	.month 		{ width : 500px;}
	
	
	.P_tr1:not(.category){
		background-color: #FAED7D;
		height: 150px;
	}
	
	.P_tr3:not(.category){
		background-color: #B5B2FF;
		height: 150px;
	}
	
</style>


<script type="text/javascript">
	var count = 0; // 전역변수(고정값 삭제)

	
	$(document).ready(function(){
		var px = window.innerWidth + "px";
		$("#bodys").css({
			 "overflow" : "scroll"
			,"float":"left"
			,"width":px
		});

		fn_selWant();
	});
	

	// ========= < 엑셀다운로드 > =========
	function fn_excel(){
		  var f = $('#excelForm');
	      f.action = "/callinder/exelDown.do";
	      f.submit();
	}
	
	// ========= < 엔터 이벤트 > =========
	function fn_enter(flag, num){
		var str   = $('#'+flag+'_txt_'+num).val();
		var price = $('#'+flag+'_num_'+num).val();

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
					 $('#'+flag+'_txt_'+num).focus();
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
					 $('#'+flag+'_txt_'+num).focus();
				}
			}
		}
	}

	// TODO (디테일 페이지때 고정 값인지 아닌지 구분값을 보내줘야함) ->		${fixeYn}	 	+"&fixeYn="+
	// ========= < I WANT POPUP  > =========
	function fn_popupWant(flag, seq, txt, price){
		var popTitle 	= "childwin";
		var popOption 	= "width=800,height=400,left=600";

		if(seq == null){
			window.open("/callinder/popupWant.do?flag="+flag+"&years="+${year}+"&months="+${month}, popTitle, popOption);
		}else{
			window.open("/callinder/popupWant.do?flag="+flag+"&years="+${year}+"&months="+${month}+"&seq="+seq+"&txt="+txt+"&price="+price, popTitle, popOption);
		}
		
	}

		
		
	
	// ========= < li 삭제(서버/팝업)  > =========
	function fn_reset(e, allResult, flag, num, count, fixe){	
		if(e == null){
			// TODO -> ${lastDay}는 현재 페이지 기준으로 upload되야함
			// 모든 값들 리셋 P_li_div_1
			for(var i=0; i<=${lastDay}; i++) {
				$('#P_li_div_'+i).empty(); 
				$('#P_result_'+i).empty(); 
				$('#M_li_div_'+i).empty(); 
				$('#li_div').empty(); 
				$('#M_result_'+i).empty(); 
				$('#resultAll_'+i).empty(); 
				
			}
			
		// ---- onClick으로 li 없애기 ----
		}else{
			// TODO 팝업에 oclick된애 값가져가기 1029
			var popTitle 	= "childwin";
			var popOption 	= "width=800,height=400,left=600";
			window.open("", popTitle, popOption);

			
			var str		= e.childNodes[0].wholeText;
			var prices 	= str.split(' : '); 


			var id = e.id;
			var nums = id.split("_");

			var resultPk = [];
			// ==== 서버 들렸다 온 값 ====
			if(fixe == 'O'){
				// --- 고정값 ---
				if(nums.length == 3 ){
					var normarPk = $("#"+flag+"_allLiHidden_"+count).val();
					resultPk = normarPk.split("_");
				// --- 일반값 ---
				}else{
					var allPk = $("#"+flag+"_liHidden_"+num+"_"+count+"").val();
					resultPk  = allPk.split("_");
				}
			}
			// 3. 일반 or 고정 값인지 구분후  -> split()
			// 4. split마지막 값 pk 너주기			
			$("#c_str").val(prices[0]);			// 내용
			$("#c_price").val(prices[1]);		// 금액
			$("#c_pk").val(resultPk[7]);		// pk 값 
			$("#c_fixe").val(fixe); 			// 서버 여부 
			$("#c_allResult").val(allResult); 	// 고정여부
			$("#c_id").val(e.id); 				// id값 
			$("#c_flag").val(nums[0]); 			// P or M (구분 값)
			
			
			
			$("#myform").submit();
		}
	}

	window.onload = function() {
		// --현재 달 조회 --
		fn_submit(1);
	}

	// ========= < 이전 이달 이후  > =========
	function fn_chageMonth(str){
		$("#move_result").val(str);		// 구분(prev, thisMonth, next, prevY ,nextY)
		$("#move_year").val(${year} );	// 년
		$("#move_month").val(${month});	// 월
		
		$("#moveForm").submit();

		// --현재 달 조회 --
		fn_submit(1);
	}
	

	// ============<팝업 li 삭제>============
	function fn_popReset(e, allResult, flag, num, count){
		var  prices = e.split(' : ');
		// -- TODO -- 서버에서 갖고온 값 삭제
		
		// ===== 고정값 =====
		if(allResult == 'all'){
			$('#'+flag+'_allLi_'+count).remove(); 
			$('#'+flag+'_allLiHidden_'+count).remove(); 
		    $("input:checkbox[id="+flag+"_check_"+num+"]:checkbox").prop("checked", true);
			fn_reustPrice(flag, num, prices[1], count);
		
				
		// ===== 일반값 =====
		}else{
			$('#'+flag+'_li_'+num+"_"+count).remove(); 
			$('#'+flag+'_liHidden_'+num+"_"+count).remove(); 
			// --- 값들 계산 ---
			fn_reustPrice(flag, num, prices[1], count);

		}
	}

	// ==== < Want 조회 > ====
	function fn_selWant(){
		
		var data = {
				 "year" :  ${year}
				,"month" : ${month}
		}
		
		
		$.ajax({
			 url : "/callinder/selectWant.do"
			,type : 'get'
			,data : data			
			,datatype : 'text'
			,success : function(result){

			
				
				
				// 1. 모든 li 제거
				$('#div_want').empty();
				
				// 2. 서버에서 갖고 온값들 li에 뿌려주기
				if(result != null){
					// ==== 루프 ====
					result.forEach(function(element){

						
						if(element.fixeYn == 'Y'){
							$('#div_want').append("<li style='float:left; color:blue;' id=\"want_Li_"+element.seq+"\"  onclick=fn_popupWant('update','"+element.seq+"','"+element.txt+"'"+",'"+element.price+"')>"+ element.txt +" : "+element.price+"</li>"); 
						}else{
							$('#div_want').append("<li style='float:left;' id=\"want_Li_"+element.seq+"\"  onclick=fn_popupWant('update','"+element.seq+"','"+element.txt+"'"+",'"+element.price+"')>"+ element.txt +" : "+element.price+"</li>"); 
						}
					});
				}
			}
			,error: function(data){
				alert("====== 에 러 222 ======");
			}
			
		});
	}

	
	// ==== < Want 삭제> ====
	
	
	// ==== < fn_submit > ====
	function fn_submit(num){
		if(num == 1){
			var queryString = {
							 "year" :  ${year}
							,"month" : ${month}
							,"flag" :  "Y"
					}
		}else{
			var queryString = $('#frm').serialize();
		}
		
		$.ajax({
			 url : "/callinder/saveList.do"
			,type : 'get'
			,data : queryString			
			,datatype : 'text'
			,success : function(result){
				if(num == 'insert'){
					alert("저장됐습니다.");
				}
				
				// 1. 모든 li 제거
				fn_reset();
				
				// 2. 서버에서 갖고 온값들 li에 뿌려주기
				if(result != null){
					// ==== 루프 ====
					result.forEach(function(element){
						if(element.flag == 'P'){
							// ---- li 생성 ----
							fn_Calculation(element.flag, element.days, element.fixe, element.p_txt, element.p_price, element.fseq);
						}else if(element.flag == 'M'){
							// ---- li 생성 ----
							fn_Calculation(element.flag, element.days, element.fixe, element.m_txt, element.m_price, element.fseq);
							
						}
					});
					
				}
			}
			,error: function(data){
				alert("====== 에 러 111======");
			}
			
		});
	}
	
	

	

	// ========= < 전체 값 계산 > =========
	function fn_reustPrice(flag, num, price, count, ajax){
		var resultNum = parseInt(0);
		
		
	
		// ========= [일반값] ==========
		if($("input:checkbox[id="+flag+"_check_"+num+"]").is(":checked") == false){

			// TODO: li값이 없으면 0으로set 수입/지출합 && 결과
			
			// 1. ---- 해당 low 수입합/지출합 set ----
			if($('#'+flag+'_li_div_'+num + ' li').length == 0){
				$('#'+flag+'_result_'+num).text(0);
			// --- li가 존재하면 ---
			}else{
				// ====== 수입/지출 합 ====== 
				$('#'+flag+'_li_div_'+num + ' li').each(function(i){
		       		var value 	 = $(this).text().split(' : ');
		       		var valueNum = 	parseInt(value[1]);
	
		       			resultNum += valueNum
		       			// --- 수입합/ 지출합 set
		       			$('#'+flag+'_result_'+num).text(resultNum); 
		  		});
			}

			
			// ---- 2. 해당 low 결과값 set ----
			var P_result = $('#P_result_'+num).text();// 수입합
			var M_result = $('#M_result_'+num).text();// 지출합
			
			$('#resultAll_'+num).text(commas(P_result - M_result));
			
			
			// ---- 3. 수입 합/지출합 전체 계산 ----  P_result_1
			// ====== 총 수입/지출 합 ======
			var pNum 	= parseInt(0); // 각 low의 수입값 담을 변수
			var pResult = parseInt(0); // 계산된 수입합(일반)
			var mNum 	= parseInt(0); // 각 low의 지출값 담을 변수
			var mResult = parseInt(0); // 계산된 지출합(일반)

			// nan이면 안 돌기
   			for(var i=1; i<=${lastDay}; i++) {
	   			if( $('#P_result_'+i).text() ){ // 값이 있으면 true
					pNum = parseInt($('#P_result_'+i).text());
					pResult +=pNum;
	   			}
	   			if( $('#M_result_'+i).text() ){ // 값이 있으면 true
					mNum = parseInt($('#M_result_'+i).text());
					mResult +=mNum;
	   			}
   			}
   			// ---- 4. 고정값 수입합/ 지출합 전체 계산 ----
			var P_Gresult = parseInt(0);
			var M_Gresult = parseInt(0);
			
			$('#li_div li').each(function(i){
      			var value 	 = $(this).text().split(' : ');
	       		var valueNum = 	parseInt(value[1]);

				// [Javascript] this == [jQuery] $(this)[0]
      			var ids = this.id;
      			if( ids.indexOf("P_allLi") != -1){
		      		P_Gresult += valueNum;
	      		}else{
	      			M_Gresult += valueNum; 	
	      		}
      		});

			var allP = P_Gresult + pResult;
			var allM = M_Gresult + mResult;
			// ---- 5. 총수입/총지출 set ----
			$('#P_all').text(commas(allP));
			$('#M_all').text(commas(allM));
			
			// ---- 6. 각각의 수입합을 계산해 -> 총 합계 ----
			$('#monthResult').text(commas(allP - allM));

		// ========= [고정값] ==========
		}else{

				// ---- 1. 고정 수입/지출 전체 값 구하기 ----	
				var P_Gresult = parseInt(0);
				var M_Gresult = parseInt(0);
				
				$('#li_div li').each(function(i){
	      			var value 	 = $(this).text().split(' : ');
		       		var valueNum = 	parseInt(value[1]);
		       		
					// [Javascript] this == [jQuery] $(this)[0]
					var ids = this.id;
	      			if( ids.indexOf("P_allLi") != -1){
			      		P_Gresult += valueNum;
		      		}else{
		      			M_Gresult += valueNum; 	
		      		}
	      		});
	      		
				// ---- 2. 일반 수입/지출 전체 값 구하기 ----
				var pNum 	= parseInt(0); // 각 low의 수입값 담을 변수
				var pResult = parseInt(0); // 계산된 수입합(일반)
				var mNum 	= parseInt(0); // 각 low의 지출값 담을 변수
				var mResult = parseInt(0); // 계산된 지출합(일반)
	
				// nan이면 안 돌기
	   			for(var i=1; i<=${lastDay}; i++) {
		   			if( $('#P_result_'+i).text() ){ // 값이 있으면 true
						pNum = parseInt($('#P_result_'+i).text());
						pResult +=pNum;
		   			}
		   			if( $('#M_result_'+i).text() ){ // 값이 있으면 true
						mNum = parseInt($('#M_result_'+i).text());
						mResult +=mNum;
		   			}
	   			}
				var allP = P_Gresult + pResult;
				var allM = M_Gresult + mResult;
				// ---- 3. 총수입/총지출 set ----
				$('#P_all').text(commas(allP));
				$("#p_r").val(allP);	// form 수입 총합 
				
				$('#M_all').text(commas(allM));
				$("#m_r").val(allM);	// form 지출 총합

				
				// ---- 4. 총합계 계산  && set ----
				$('#monthResult').text(commas(allP - allM));
			    $("#month_r").val(allP - allM);		// form 총금액

			$("input:checkbox[id="+flag+"_check_"+num+"]:checkbox").prop("checked", false);
		}
	}

	// --- 콤마 펑션 ----
	function commas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
	
	// ========= < li 생성 > =========
	function fn_Calculation(flag, num, fixe, str, price, pk){
		count +=1; // ID값 변수

		// --- Validation ---
		if( Validation(flag, str, price) == false){ return; }
		
		
		
		// ==== ajax아닐때는 값을 갖고옴 ====
		if(str == null){
			var str   = $('#'+flag+'_txt_'+num).val();
			var price = $('#'+flag+'_num_'+num).val();
		
		}

		
		// === ajax 조건 (고정값) ===
		if(fixe == 'Y'){
			$("input:checkbox[id="+flag+"_check_"+num+"]:checkbox").prop("checked", true);
			if(flag == 'P'){
				$('#li_div').append("<li style='float:left; color:blue;' id=\"P_allLi_"+count+"\"  onclick=fn_reset(this,'all','"+flag+"','"+num+"'"+",'"+count+"','O')>"+ str +" : "+price+"</li>");
				
			}else if(flag == 'M'){
				$('#li_div').append("<li style='float:left; color:red;'  id=\"M_allLi_"+count+"\"  onclick=fn_reset(this,'all','"+flag+"','"+num+"'"+",'"+count+"','O')>"+ str +" : "+price+"</li>");
			}
			// TODO : 조회된 값들은  fseq을 set시켜줘야 할듯!!
			$('#li_div').append("<input type='hidden'id='"+flag+"_allLiHidden_"+count+"' name='"+flag+"_result' value='"+${year}+"_"+${month}+"_"+num+"_"+flag+"_"+str+"_"+price+"_Y_"+pk+"'>");
			
			$('#'+flag+'_txt_'+num).val("");
			$('#'+flag+'_num_'+num).val("");
			
		// ====== 일반 등록 =====		
		}else if($("input:checkbox[id="+flag+"_check_"+num+"]").is(":checked") == false){

			
			// ==== 일반 li 생성 ====
			if( pk ){
				$('#'+flag+'_li_div_'+num).append("<li id="+flag+"_li_"+num+"_"+count+" onclick=fn_reset(this,'no','"+flag+"','"+num+"'"+",'"+count+"','O')>"+ str +" : "+price+"</li>");
				$('#'+flag+'_li_div_'+num).append("<input type='hidden' id="+flag+"_liHidden_"+num+"_"+count+" name='"+flag+"_result' value='"+${year}+"_"+${month}+"_"+num+"_"+flag+"_"+str+"_"+price+"_N_"+pk+"'>");
			}else{
				$('#'+flag+'_li_div_'+num).append("<li id="+flag+"_li_"+num+"_"+count+" onclick=fn_reset(this,'no','"+flag+"','"+num+"'"+",'"+count+"','X')>"+ str +" : "+price+"</li>");
				$('#'+flag+'_li_div_'+num).append("<input type='hidden' id="+flag+"_liHidden_"+num+"_"+count+" name='"+flag+"_result' value='"+${year}+"_"+${month}+"_"+num+"_"+flag+"_"+str+"_"+price+"_N'>");
			}
			
			$('#'+flag+'_txt_'+num).val("");
			$('#'+flag+'_num_'+num).val("");

		// ====== 고정 등록 =====	
		}else{
			$("input:checkbox[id="+flag+"_check_"+num+"]:checkbox").prop("checked", true);
			if(flag == 'P'){
				$('#li_div').append("<li style='float:left; color:blue;' id=\"P_allLi_"+count+"\"  onclick=fn_reset(this,'all','"+flag+"','"+num+"'"+",'"+count+"','X')>"+ str +" : "+price+"</li>");
			}else{
				$('#li_div').append("<li style='float:left; color:red;'  id=\"M_allLi_"+count+"\"  onclick=fn_reset(this,'all','"+flag+"','"+num+"'"+",'"+count+"','X')>"+ str +" : "+price+"</li>");
			}							
			$('#li_div').append("<input type='hidden'id='"+flag+"_allLiHidden_"+count+"' name='"+flag+"_result' value='"+${year}+"_"+${month}+"_"+num+"_"+flag+"_"+str+"_"+price+"_Y'>");			
			
			$('#'+flag+'_txt_'+num).val("");
			$('#'+flag+'_num_'+num).val("");
		}
		
		// ==== 전체 값 계산기 ====
		fn_reustPrice(flag,num,price, count);
	} 
</script>

<body>
	<form id="moveForm" method="post" action="/callinder/moneySave.do">
	    <input type="hidden" id="move_year" 	name="moveYear">
	    <input type="hidden" id="move_month" 	name="moveMonth">
	    <input type="hidden" id="move_result" 	name="moveResult">
	    <input type="hidden" value="0" 			name="moveDay">
	    <input type="hidden" value="Y" 			name="flag">
	</form>
	
	
	<form id="myform" method="post" action="/callinder/popup.do" target="childwin">
	    <input type="hidden" id="c_str" 		name="txt">
	    <input type="hidden" id="c_price"   	name="price">
	    <input type="hidden" id="c_fixe"   		name="fixe">
	    <input type="hidden" id="c_pk"   		name="pk">
	    <input type="hidden" id="c_id"   		name="id">
	    <input type="hidden" id="c_allResult"   name="flag">
	    <input type="hidden" id="c_flag" 	  	name="p_m">
	    <input type="hidden" value="2"			name="result">
	    
	</form>
	
	<form name="excelForm" id="excelForm" method="POST" action="/callinder/excelDown.do">
	    <input type="hidden" 	name="years"	value="${year}">
	    <input type="hidden" 	name="months"	value="${month}">
	    
	    <input type="hidden"  id="p_r"		name="P_result"	>
	    <input type="hidden"  id="m_r"		name="M_result"	>
	    <input type="hidden"  id="month_r"	name="monthResult">
	    
	</form>



	<form id="frm" method="post">
		<h3> < ${year}년  ${month}월 > </h3>
			
		
		
		<div style="float:left; margin-top: 30px; padding:2px;">
			<input type="button" onclick="fn_submit('insert');" style="float:left; margin-right: 15px; padding:2px; width: 60px;" value="저장">
			<input type="button" onclick="fn_excel();"  		style="float:left; margin-right: 15px; padding:2px; width: 60px;" value="엑셀다운">
			
			<input type="button" onclick="fn_chageMonth('prevY');" 		style="float:left; margin-left: 5px; padding:2px; width: 25px; height: 25px;" value="<<">
			<input type="button" onclick="fn_chageMonth('prev');" 		style="float:left; margin-left: 5px; padding:2px; width: 25px; height: 25px;" value="<">
			<input type="button" onclick="fn_chageMonth('thisMonth');" 	style="float:left; margin-left: 5px; padding:2px; height:25px;" value="This Month">
			<input type="button" onclick="fn_chageMonth('next');" 		style="float:left; margin-left: 5px; padding:2px; width: 25px; height: 25px;" value=">">
			<input type="button" onclick="fn_chageMonth('nextY');" 		style="float:left; margin-left: 5px; padding:2px; width: 25px; height: 25px;" value=">>">
			
		</div>
		<div style="background: pink; float:left; margin-left: 50px; margin-bottom: 10px;">
			&nbsp;&nbsp;
			<p style="float:left; font-weight:bold;">&nbsp;[${month}월] 총 합계:&nbsp;</p><!-- 적자!! 흑자!! 창띄어주기! -->
			<p style="float:left;" id="monthResult"></p>
			
			<p style="float:left; font-weight:bold;">&nbsp;총 수입 :&nbsp;</p>
			<p style="float:left; color:#A566FF;" id="P_all"></p>
			
			<p style="float:left; font-weight:bold;">&nbsp;총 지출:&nbsp;</p>
			<p style="float:left; color:#6B9900;" id="M_all"></p>
			&nbsp;&nbsp;
		</div>
		
		<div style="float:right; background: yellow; margin: 15px; padding:2px; width:px;">
		
			<div style="float:left; font-weight:bold; text-align: center;"> < [${year}년  ${month}월] I WANT > </div>  
			<input type="button" style="float:left; margin-left: 10px;"  value="추가" onclick="fn_popupWant('insert')">
			
			<br><br>
			<div id="div_want" style="float:bottom">
			</div>
		</div>
		
		<div style="background: pink; float:left; margin-left: 10px; margin-bottom: 10px;">
			<div style="background: pink; float:left; text-align: center;">
				<p style="float:left; font-weight:bold; align-self: center;">&nbsp;${month}월 고정 값들:&nbsp;&nbsp;</p>
			</div>
			<!-- 고정값 기입됨. -->
			<div id="li_div" style="background: pink; float:right;"></div>
		</div>
		
		<!-- 현재 스크린 기준으로 width를 수정해야함 -->
		<div id="bodys">
			<table border="1" >
				<thead>
					<tr>	
						<th class="month">
							<p> ${month}월</p>
						</th>
						
						<c:forEach var="i" begin="1" end="${lastDay}"  >
							<th class="day">
							
								<c:if test="${i eq day}">
									<p style="color: red"> ${i}일</p>
								</c:if>
								<c:if test="${i ne day}">
									<p> ${i}일</p>
								</c:if>
							</th>
						</c:forEach>
					</tr>
				</thead>
				
				
				<tbody>
					<c:forEach items="${str}" var="st" varStatus="status">
						<tr class="P_tr${status.count}">
							<th class="category">   ${st}</th>
							
							<c:forEach var="i" begin="1" end="${lastDay}"  >
								<td >
									
									<!-- 수입 -->
									<c:if test="${st eq '수입' }">
										<input type="text" 	 id="P_txt_${i}" placeholder="수입내용">
										<input type="number" id="P_num_${i}" placeholder="수입금액(₩)" onkeyup="fn_enter('P', ${i});">
										<input type="button" onclick="fn_Calculation('P', ${i})"   value="확인">
										<input type="checkbox"  id="P_check_${i}"> <label for="P_check_${i}">고정수입</label>
										<div id="P_li_div_${i}"></div>
									</c:if>
									
									<!-- 수입합계 -->
									<c:if test="${st eq '수입합' }">
										<div id="P_result_${i}"></div>
									</c:if>
									
									
									<!-- 지출 -->
									<c:if test="${st eq '지출' }">
										<input type="text"   id="M_txt_${i}" placeholder="지출내용">
										<input type="number" id="M_num_${i}" onkeyup="fn_enter('M', ${i});" placeholder="지출금액(₩)">
										<input type="button" onclick="fn_Calculation('M', ${i})"   value="확인">
										<input type="checkbox" id="M_check_${i}"> <label for="M_check_${i}">고정지출</label>
										<div id="M_li_div_${i}"></div>
									</c:if>
									
									
									<!-- 지출합계 -->
									<c:if test="${st eq '지출합' }">
										<div id="M_result_${i}"></div>
									</c:if>
								
									
									<!-- 총합계 -->
									<c:if test="${st eq '결과' }">
										<div id="resultAll_${i}"></div>
									</c:if> 
									
									
								</td>
							</c:forEach>
						</tr>
					</c:forEach>
				
				
				
				</tbody>
			
			</table>
		</div>
	</form>
</body>
</html>
