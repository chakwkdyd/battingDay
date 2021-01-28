<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../include/header.jsp"/>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
	.box{
		
		padding : 2px; 
		position: absolute;
		top: 20%; 
		left: 50%;
		background-color: #E4F7BA;
		padding: 10px; 
	} 
	.timerBox{
		width: 200px;
		outline: 2px solid black;
	}
	.timerBox .time{
		font-size: 30pt;
		color: #4C4C4C; 
		text-align: center;
		font-family: sans-serif;
	}
	.btnBox{
		margin-top: 10px;  
		text-align: center;
	}
	.btnBox .fa{
		margin: 0px 5px;
		font-size: 30pt;
		color: #FAED7D;
		cursor: pointer;
	}
	
	.aa 	 { width: 20px; }
	.bb 	 { width: 100px; }
	
	.btnBoxt {  margin: 10px auto;  
				text-align: center; }
	
	.rowTime{ text-align: center; }
	.rowNum{  text-align: center;  width: 30px; }
</style> 



<script type="text/javascript">
	var time = 0;
	var starFlag = true;
	var num =0;

// --- 스탑와치 변수들 ---	
  	var hour = 0;
  	var min = 0;
  	var sec = 0;
  	var timer;

	
	function init(){ $("#time").html("00:00:00"); }


	  // --- 시작 ---
	  function fn_startBtn(num){
	    if(starFlag){
	      	$(".fa").css("color","#FAED7D");// 노란색
	      	$(".fa-play").css("color","#4C4C4C");// 검정색
	      	
	      	//this.style.color = "#4C4C4C";	// 검정색
	      	starFlag = false;




	      	

          // --- 00:00:00 으로 초기화 ---
	      if(time == 0){ init(); }

		  // --- 변수 초기화 ---
		  // 1초 간격으로 실행될 메서드
	      timer = setInterval(function(){
	        time++;
			
	        min  = Math.floor(time/60);	
	        hour = Math.floor(min/60);	// 시
	        sec  = time%60;				// 초
	        min  = min%60;				// 분
		
	        var th = hour;
	        var tm = min;
	        var ts = sec;
	        if(th<10){
	        	th = "0" + hour;
	        }
	        if(tm < 10){
	        	tm = "0" + min;
	        }
	        if(ts < 10){
	        	ts = "0" + sec;
	        }

	        $("#time_"+num).html(th + ":" + tm + ":" + ts);
	        $("#time").html(th + ":" + tm + ":" + ts);
	      }, 1000);
	    }
	  }

	  // --- 일시정지 ---
	  function fn_pauseBtn(){
	    if(time != 0){
	      $(".fa").css("color","#FAED7D")
          $(".fa-pause").css("color","#4C4C4C");
	      clearInterval(timer);
	      starFlag = true;
	    }
	  }

	  // --- 정지 ---
	  function fn_stopBtn(){
	    if(time != 0){
	      $(".fa").css("color","#FAED7D");
	      $(".fa-stop").css("color","#4C4C4C");
	      
	      clearInterval(timer);
	      starFlag = true;
	      time = 0;
	      init();
	    }
	  }

	  

	// ==== 현시간  클릭 이벤트 ====
	function fn_timeClick(time, num){

		// 1. 이외에 전부 흰색으로 색상 변경
		
		// 2. 색상 변경(클릭) 
		time.style.background = "#EAEAEA";
		
		fn_startBtn(num);
		// 3. 
		
		// 4.   
		
/* 		1. 클릭한 time만 색상변경

		2. 스탑와치 리셋
		
		3. 스탑와치 시작 
		
		4. 정지 이벤트 */
		time.id;
	}

	
	// ===== 추가 버튼 =====
	function fn_addRow(){
		// row를 복사하고
		var cloneElements = $('#row').clone();
		var row = "";

		
		num = fn_getLastRowNum(num);
		
		row = row 	+	'<tr id="tr_'+num+'" class="rows" >';
		row = row 	+	'<td id="chckBoxs">		<input type="checkbox" name="checkRow" value="'+num+'"></td>';	
/* 		row = row 	+	'<td id="numbers">		<p id="rowNum_'+num+'"style="text-align: center;">'+num+'</p></td>'; */	
		row = row 	+	'<td id="numbers">		<input type="text" id="rowNum" class="rowNum" name="platform_num" value="'+num+'"></td>';	 
		row = row 	+	'<td id="routine">		<input type="text"></td>';	
		row = row 	+	'<td id="stopWatchs">	<div id="time_'+num+'"  class="rowTime" onclick="fn_timeClick(this, '+num+')">00:00:00</div></td>';	
		row = row 	+	'<td>					<input type="file"></td>';	
		row = row 	+	'</tr>';	


		// 1. rowNum 최대 치 +1
		// rowNum : 해당 
		
		$(row).appendTo('#tbody');
	}

	

	// 1. checkbox는 한개만 선택 하게 (위, 아래 버튼이면)
	// 2. 
	// ==== 위 아래 펑션 ====
	function fn_upDown(position, el){
		var resultNum = fn_getLastRowNum(num);
		


		var checkedCount = $("input[name=checkRow]:checked").length;
		if (checkedCount > 1 ) {
			alert("이동하려는 행을 하나만 선택해주세요")
		} 
		else if(checkedCount == 0) {
			alert("이동 하려는 행을 선택해주세요")
		}
		else {
			var element = $("input[name=checkRow]:checked").parent().parent();
			if(position == 'up'){
				moveRowUp(element);
			}else{
				moveRowDown(element);
			}
		}
	}


	var moveRowUp = function(element) {
		if( element.prev().html() != null  && element.prev().attr("checkRow") != "header"){
			element.insertBefore(element.prev());
			changNum();
		} else {
			alert("최상단입니다.")
		}
	};
	
	var moveRowDown = function(element) {

		if( element.next().html() != null ){
			element.insertAfter(element.next());
			changNum();
		}  else {
			alert("최하단입니다.")
		}
	};

	var changNum = function() {
		var num = 0;
		$('input[name=platform_num]').each(function(){
			num++;
			$(this).val(num);
		});
	};


	
	
	// ===== 순번 최대 rowNum 구하기 ======
	function fn_getLastRowNum(num){

		
		if(!$('.rows').length){ num = 1; }
		
		$('.rows').each(function (index, item) {
			num = index + 2;
		});

		return num;
	}
	
</script>


<body> 
	<br><br>
	
	
	<input type="button" value="카카오 공유">
	<input type="button" value="↑" onclick="fn_upDown('up',this)">
	<input type="button" value="↓" onclick="fn_upDown('down',this)">
	<input type="button" value="추가" onclick="fn_addRow()">
	<input type="button" value="저장" onclick="">
	<div style="border: 3px solid gold">
		
		
		<div style="float:  left; border: 3px solid gold">
			
			<table border="2px">
				<thead>
					<tr id="header"> 	
					 	<th class="aa"></th>
					 	<th >순서</th>
					 	<th class="bb">루틴</th>
					 	<th class="bb">시간</th> 
					 	<th class="bb">인증</th>
					</tr>
				</thead>
				
				<tbody id="tbody">
					
				</tbody>
			</table> 
		</div>
		

		<div style="float:  right; border: 3px solid gold">
			<td id="stopWatchs" style="">
				<!-- 스탑워치 -->
				<div id='box' class="box"> 
					<br>
					<div id='timerBox' class="timerBox">
						<div id="time" class="time">00:00:00</div>
					</div> 
					<div class="btnBoxt"> 
						<i id="startbtn" class="fa fa-play"  onclick="fn_startBtn()"	aria-hidden="true"></i>
						<i id="pausebtn" class="fa fa-pause" onclick="fn_pauseBtn()"	aria-hidden="true"></i>
						<i id="stopbtn"  class="fa fa-stop"  onclick="fn_stopBtn()"		aria-hidden="true"></i> 
					</div>
				</div>
			</td>
			
			  
			<h3> <##년 ##월 ##일 평점> </h3>		
			<h3> <오늘의 칭찬 3> </h3>		
			<h3> <나에게 할말 3> </h3>		
			
		</div>
		
	</div> 
	
	
	
	  
	

</body>
</html>