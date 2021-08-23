<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	var time 	 = 0;
	var starFlag = true;
	var num 	 = 0;

// --- 스탑와치 변수들 ---	
  	var hour 	= 0;
  	var min 	= 0;
  	var sec 	= 0;
  	var timer;

	
	function init(){ $("#time").html("00:00:00"); }

	
	
	var timeArr = {};
	var timerIdx = 0;
	function Timer(defaultTimeSec){
		if(!defaultTimeSec){
			defaultTimeSec = 0;
		}
		this.number 		= timerIdx++;
		this.time 			= Number(defaultTimeSec);
		this.interval 		= null;
		this.$div 			= null;
		this.addRow();
		timeArr[this.number] = this;
	}
	
	Timer.prototype.setColors = function(flag){
		
		if(flag == 'start'){
			this.$div.find('.time').css('backgroundColor', '#EAEAEA'); // 회색 
			// 1. 이외에 전부 흰색으로 색상 변경
			for (var i = 0; i < $('#tbody tr').length; i++) {
				if(this.number != i){ 
					$('#time_'+ i).css('backgroundColor', '#FFFFFF'); // 흰색
				}
			}
			
			
			$(".fa").css("color","#4C4C4C"); 		// 검정색
			$(".fa-play").css("color","#FAED7D");	// 노랑
		}else{
			$(".fa").css("color","#4C4C4C"); 		// 검정색
			$(".fa-pause").css("color","#FAED7D");	// 노랑
		}
	}
	
	Timer.prototype.start = function(){
		if(!this.interval){
			var that = this; 
			stopAll();
			this.interval = setInterval(function(){
				that.time++;
				that.showStatus();
			},1000);
		}else{
			console.log('실행중!');
		}
	}
	Timer.prototype.stop = function(){
		if(this.interval){
			clearInterval(this.interval);
			this.interval = null;
		}else{console.log('없음!');}
	}
	Timer.prototype.toggleStart = function(obj){
		if(obj.interval){
			obj.stop();
			this.setColors('stop');
		}else{
			this.setColors('start');
			obj.start();
		}
	}
	Timer.prototype.getTime = function(){
		var time = this.time;
        var min  = Math.floor(time/60);	
        var hour = Math.floor(min/60);	// 시
        var sec  = time%60;				// 초
        var min  = min%60;				// 분
        if(hour<10){
        	hour = '0'+hour;
        }
        if(min<10){
        	min = '0'+min;
        }
        if(sec<10){
        	sec = '0'+sec;
        }
        
		return hour+':'+min+':'+sec;
	}
	Timer.prototype.showStatus = function(){
		
		var nowTime = this.getTime();
		// --- 해당 row 스탑와치 ---
		this.$div.find('.time').text(nowTime);
		// --- 전체 스탑와치 ---
		$("#time").html(nowTime);
		
	}
	
	Timer.prototype.addRow = function(){
		var cloneElements = $('#row').clone();
		var that = this;
		var row = $('<tr id="tr_'+num+'" class="rows"></tr>');
		row.append('<td id="chckBoxs">		<input type="checkbox" name="checkRow" value="'+num+'"></td>');	
		row.append('<td id="numbers">		<input type="text" id="rowNum" class="rowNum" name="platform_num" value="'+num+'"></td>');	 
		row.append('<td id="routine">		<input type="text"></td>');
		var td = $('<td id="stopWatchs"></td>');
		/* debugger;  */
		var div = $('<div id="time_'+num+'"  class="time" >00:00:00</div>').click(function(){that.toggleStart(that)});
		td.append(div);
		row.append(td);
		row.append('<td>					<input type="file"></td>');	
		// 1. rowNum 최대 치 +1
		// rowNum : 해당 
		num++;
		$(row).appendTo('#tbody');
		this.$div = $(row);
	}
	
	
	Timer.prototype.remove = function(){
		this.$div.remove();
		clearInterval(this.interval);
		delete timeArr[this.number];
	}	
	
	function startAll(){
		for(var i in timeArr){
			timeArr[i].start();
		}
	}
	
	function stopAll(){
		for(var i in timeArr){
			timeArr[i].stop();
		}
	}
	
	/*
	// ==== 현시간  클릭 이벤트 ====
	function fn_timeClick(time, num){

		// 1. 이외에 전부 흰색으로 색상 변경
		for (var i = 1; i <= $('#tbody tr').length; i++) {
			$('#time_'+ i).css('backgroundColor', '#FFFFFF'); // 흰색
			
		}
		
		// 2. 색상 변경(클릭) 
		time.style.background = "#EAEAEA"; // 회색 
		
		// row 시작
		fn_startBtn(num);
		
		time.id;
	}
	
	  // --- 스탑와치 시작 ---
	  function fn_stopWatch(value){
		  $("#time").html(value);
	  }
	  
	  
	  // --- row 스탑와치 시작 ---
	  function fn_startBtn(num){

		  
		  // 전역변수
		  if(starFlag){
		      	$(".fa").css("color","#FAED7D");	 // 노란색
		      	$(".fa-play").css("color","#4C4C4C");// 검정색
		      	
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
		        
		        if(th < 10){ th = "0" + hour; }
		        if(tm < 10){ tm = "0" + min;  }
		        if(ts < 10){ ts = "0" + sec;  }
		        
		        var nowTime = th + ":" + tm + ":" + ts;
				
		        // row set 시간
		        $("#time_"+num).html(nowTime);
		    	// 스탑와치 set 시작
				fn_stopWatch(nowTime);
		    	
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

	  */

	

	
	// ===== 추가 버튼(옛날) =====
	/* function fn_addRow(){
		// row를 복사하고
		var cloneElements = $('#row').clone();
		var row = "";

		
		num = fn_getLastRowNum(num);
		
		row = row 	+	'<tr id="tr_'+num+'" class="rows" >';
		row = row 	+	'<td id="chckBoxs">		<input type="checkbox" name="checkRow" value="'+num+'"></td>';	
 		//row = row 	+	'<td id="numbers">		<p id="rowNum_'+num+'"style="text-align: center;">'+num+'</p></td>'; 	
		row = row 	+	'<td id="numbers">		<input type="text" id="rowNum" class="rowNum" name="platform_num" value="'+num+'"></td>';	 
		row = row 	+	'<td id="routine">		<input type="text"></td>';	
		row = row 	+	'<td id="stopWatchs">	<div id="time_'+num+'"  class="rowTime" style="cursor: pointer" onclick="fn_timeClick(this, '+num+')">00:00:00</div></td>';	
		row = row 	+	'<td>					<input type="file"></td>';	
		row = row 	+	'</tr>';	


		// 1. rowNum 최대 치 +1
		// rowNum : 해당 
		
		$(row).appendTo('#tbody');
	} */

	

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
	
	function makeTimer(){
		new Timer();
	}
	
	
</script>


<body> 
	<br>
	
	<input type="button" value="카카오 공유">
	<input type="button" value="↑" 	 onclick="fn_upDown('up',this)">
	<input type="button" value="↓"   onclick="fn_upDown('down',this)">
	<input type="button" value="추가" onclick="makeTimer()">
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
			
			<%-- <%=request.getRealPath("/") %><!-- 현재 프로젝트의 실제 경로 --> --%>
			<!-- 스프링 파일이 저장되는 워크스페이스와 다르므로, 파일을 저장할 때 실제 경로를 알아야합니다 -->
			<%
			String testUrl = request.getRealPath("/");
			%>
			
			<img src="<%=testUrl%>images/grape.jpg">
			
			<h3> <나에게 할말 3> </h3>		
			
		</div>
		
	</div> 
	
	
	
	  
	

</body>
</html>