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

	var ms		=0; 	// 현재 시간값을 계산하면 밀리세컨단위가 나와. 그래서 ms.(1/1000초 단위). 초기화 시켜주세요~
	var state	=false;	// 현재 상태값. state 는 초시계를 동작중인지, 아니면 멈춘상태인지. 여부를 알려주는 변수. 반드시 function 외부에! 스타트인지 스탑인지 봐야하니깐.
	var now; 			// 현재시간(초시계 동작이후 시간). 
	var then; 			//기 준시간. 초시계는 기준시간이 있을 꺼 아니야??00:00:00 //now-then:초시계 돈 만큼이 된다.

	var result;
	var s;

	
	function swStart(){
	
   	  // --- 종료 ---
	  if(state == true){ 
	   		state	=	false; //멈추게 한다.
	   		now		=	new Date(); 					//now가 지정된다. > 밀리초단위의 시간값을 가지고 있다.
	  		ms		=	now.getTime() - then.getTime() 	//현재시간-지나간 시간을 빼면 지나간 시간이 나옵니다. 1000분의 1초단위.
	  		
	   $("input[name='time']").val( parseInt(ms/1000) );//그냥 ms넣으면 밀리세컨 단위로 들어감.> 초단위로 바꾸는게 parseInt(ms/1000)

   	  // --- 시작 ---
	  }else {
	    	state	=true; 			// sw(스탑워치)시작 해라.
	    	then 	= new Date(); 	//돌고있는 상태의 값.
	    	then.setTime(then.getTime()-ms); //멈춰줘야해.
	    }
	 }


	function swReset(){
	  state	=false; //멈추게 한다.
	  ms	=0; //이때 초기화가 된다.
	  $("input[name='time']").val(parseInt(ms/1000));//그냥 ms넣으면 밀리세컨 단위로 들어감.> 초단위로 바꾸는게 parseInt(ms/1000)
	
	}

	// ⑤ 시간이 화면에 보여지는 기능을 만들어주겠습니다.
 	function display(){
	  setTimeout("display();",1000); //1초마다 한 번씩 자기자신(display)을 불러라.
		//초시계가 돌고있다면
		  if (state==true) {
		    now	= new Date(); //그때그때를 잡아줘야해.
		    ms	= now.getTime()	-	then.getTime();	//현재시간-지나간 시간을 빼면 지나간 시간이 나옵니다. 1000분의 1초단위.
		    
		    result	= parseInt(ms/1000);// 서버로 보낼값

			// -- 시/분/초 메서드
		    resultTime(result);
		  }
	 }


	
	 function resultTime(t){

	    var ms1 = 0;;

	   
    	var then1	= new Date(); 	//돌고있는 상태의 값.
    	then1.setTime(then1.getTime()-ms1); //멈춰줘야해.
    	
    	
		// ---- 60초과 ----
		if(t > 60){
		//if(true){
			var now1 = new Date(); 								//그때그때를 잡아줘야해.;

		 	if(s > 60){
				    ms1 	= 0;
			    }else{
					ms1	 = now1.getTime()	-	then1.getTime();	//현재시간-지나간 시간을 빼면 지나간 시간이 나옵니다. 1000분의 1초단위.
			    }
			    
				s	 = parseInt(ms1/1000);						

			// === 초  ===
	    	$("input[name='time1']").val(s);//그냥 ms넣으면 밀리세컨 단위로 들어감.> 초단위로 바꾸는게 parseInt(ms/1000)
	    	
		// ---- 60이하면 ----
		 }else{
	    	$("input[name='time1']").val(t);//그냥 ms넣으면 밀리세컨 단위로 들어감.> 초단위로 바꾸는게 parseInt(ms/1000)
		 }

		 
	    // === 분 ===
	    var m = Math.floor(t/60); // 내림
    	$("input[name='time2']").val(m);//그냥 ms넣으면 밀리세컨 단위로 들어감.> 초단위로 바꾸는게 parseInt(ms/1000)
    	
	    // === 시 ===
	    var h = Math.floor(t/3600) ;
    	$("input[name='time3']").val(h);//그냥 ms넣으면 밀리세컨 단위로 들어감.> 초단위로 바꾸는게 parseInt(ms/1000)
	 }
</script>

<body onLoad="display()">
	<h1>계획표</h1>
	
	
 <form name="watchForm">

   <input type="text" name="time3" style="border:1 solid gray;width:100px;text-align:right">
   <input type="text" name="time2" style="border:1 solid gray;width:100px;text-align:right">
   <input type="text" name="time1" style="border:1 solid gray;width:100px;text-align:right">
   <br><br>
   <input type="button" name="startButton" value="start/stop" 	onClick="swStart()">
   <input type="button" name="resetButton" value="reset" 		onClick="swReset()">
   
  </form>
</body>
</html>