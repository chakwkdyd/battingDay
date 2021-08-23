<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

$(function(){
	

});

	$("#giftImg"),change(function(){
		if(this.files &&  this.files[0]){
			var reader = new FileReader;
			reader.onload = function(data){
				$(".select_img").attr("src", data.data.target.result).width(500); 
			}
			reader.readAsDataURL(this.files[0]);
		}	
	});

	//====참여 여부 이벤트=====
	/* function joinYn1(){
		var result = $("#joinYn").val();
		if( result == "참석"){
			$("#joinYn").val('불참');
		}else {
			$("#joinYn").val('참석');
		}
	} */

</script>


</head>
<body>
	<h1>방 만들기</h1>
	
	
	
	<form action="/board/insert.do">
		
		<table border="1">
			<tr>
				<td>
					방제: <input type="text" name="bet_title" >
				</td>
				<td>
					종료일 :
					<input type="number" name="bet_EndDate" style="margin-right: 5px;">
				</td>
				<td>
					참여자 수:
					<select name="bet_personCount">
						<option>5</option>
						<option>10</option>
						<option>15</option>
						<option>20</option>
					</select>
				</td>
				
			</tr>
			<tr style="height: 100px;">
				<td>
					<!-- 카테고리 (for each문)-->
					카테고리 : 
					<select name="bet_category">
						<option>다이어트</option>
						<option>자격증</option>
						<option>미라클모닝</option>
					</select>
				</td>
				<td colspan="2" >
					<!-- 상품(파일) 조회-->
					상품(파일): <input type="file" id="giftImg" name="file" >
					<div class="select_img">
						<img src="">
						<%=request.getRealPath("/") %>
					</div>
					
				</td>
			</tr>
			
			
			<tr >
				<td colspan="3" align="center">
					<!-- <input type="button" style="width: 20%"; name="bet_join_yn" value="참석" onclick="joinYn1()" id="joinYn">
					<input type="button" style="width: 20%"; value="투표"> -->
					<input type="button" style="width: 20%"; value="수정">
					<input type="button" style="width: 20%"; value="삭제">
				</td>
				
			</tr>
			
			<tr>
				<td colspan="3">
					<input type="submit" style="width: 100%;" value="저장" >
				</td>
			</tr>
			
		</table>
	</form>	
	
	
	

</body>
</html>