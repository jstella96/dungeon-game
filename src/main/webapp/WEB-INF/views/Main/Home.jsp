<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet"  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=East+Sea+Dokdo&family=Jua&display=swap" rel="stylesheet">
<title>할머니의 미로던전</title>
   <style>
    *{
    	user-select: none;
        padding :0;
        margin:0;
    }#startCanvas{
        display:block;
        margin : 0 auto;
        width : 1235px;
        height : 855px;
        background-image: url(<c:url value="/resources/img/map/background2.png"/>);
	    background-position: center;
	    background-size: cover;
	    position: relative;
    }.loginDiv{
   		position: absolute;
   		top:630px;
   	}.loginDiv input{
   		background-color: #f5f0de
   	}.loginDiv button{
   		border:none;
   		color:#f0e8cb;
   		background-color: #5b4f63; 
   		border-radius: 10px;
   		font-weight: 400;
		font-family: 'Jua', sans-serif;
		font-size: 21px;
	 }#signModal .modal-dialog{
	 	top:530px;
	 	width: 400px;
	 }#signModal .modal-dialog .modal-content{
	 	background-color: #111111;
	 }#signModal input{
		 background-color: #f5f0de
	 }#signModal button{
   		border:none;
   		color:#f0e8cb;
   		background-color: #5b4f63; 
   		border-radius: 10px;
   		font-weight: 400;
		font-family: 'Jua', sans-serif;
		font-size: 20px;
	 }#signModal label{
	 	font-size:18px;
	 }#signModal #idDuplicateCheckBtn{
	 	font-size: 12px;
	 	color: #5b4f63; 
	 }
    </style> 
</head>

<body>
	<div id="startCanvas">
		<div class="col-xs-4 col-xs-offset-4 loginDiv">
			<form class="form-horizontal" action="<c:url value="/login"/>" method="post"  autocomplete="off">
				  <div class="form-group">
				    <div class="col-xs-offset-1 col-xs-10">
				      <input type="text" class="form-control" name="id" id="id" placeholder="아이디">
				    </div>
				  </div>
				  <div class="form-group">
				   <div class="col-xs-offset-1 col-xs-10">
				      <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호">
				    </div>
				  </div>
				 
				  <div class="form-group">
				    <div class="col-xs-offset-2 col-xs-8">
				       	<button class="col-xs-5" id="loginBtn" type="submit">게임시작</button>
    					<button class="col-xs-5 col-xs-offset-2" type="button" id="modalBtn">간단가입</button>
					</div>
				  </div>
				  <div class="form-group">
				   <span class="col-xs-offset-1 col-xs-10" style="text-align:center; color:#820000">${error}</span>
				  </div>
			 </form>
		  </div> 
	</div><!-- startCanvas -->
	 <div class="modal fade" id="signModal" data-backdrop="false" >
		    <div class="modal-dialog modal-sm" >
		        <div class="modal-content">
		            <div class="modal-body">		
						<form class="form-horizontal" action="<c:url value="/sign"/>" method="post" autocomplete="off">
							  <div class="form-group">
							  		<div class="col-xs-12">
								  		<label for="id">아이디</label> 
									    <a class="duplicateCheckBtn" id="idDuplicateCheckBtn">중복체크</a>
								    </div>	
								    <div class="col-xs-12">
								      <input type="text" class="form-control" id="signId" name="id" placeholder="4-20자 입력해주세요">
								   </div>
							  </div>
							  <div class="form-group">
							    <label for="password" class="col-xs-12">비밀번호</label>
							    <div class="col-xs-12">
							      <input type="password" class="form-control" id="signPassword" name="password" placeholder="4-20자 입력해주세요">
							    </div>
							  </div>
							 <div align="right">
								<button type="submit" id="signBtn" class="btn btn-default">가입신청</button>
				                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
							 </div>
						</form>
					</div>
		        </div>
		    </div>
		</div><!-- /모달 -->
	

	
	
<script>
	//1]모달 열기
	$('#modalBtn').click(function(){
		$('#signModal').modal();
	})
			
	//2]프론트 유효성 체크
	$("#loginBtn").click(function(){
		if($("#id").val().length < 1){
			
			alert("아이디를 입력해 주세요");
			return false;
			
		}else if($("#password").val().length < 1){
			
			alert("비밀번호를 를 입력해 주세요");
			return false;
			
		}else{
			console.log("유효성 체크완료.이상없음");
		} 
		
	});
	
	//3]회원가입 관련
	var idDuplicateCheck = false;
	var idResult = "";
	
	//4]회원가입 - 프론트 유효성 체크
	$("#signBtn").click(function(){
		if(!($("#signId").val().length >= 4 &&  $("#signId").val().length <= 20)){
		
			alert("아이디는 4-20자 사이로 입력해 주세요");
			return false;
			
		}else if(!($("#signPassword").val().length >= 4 &&  $("#signPassword").val().length <= 20)){
		
			alert("비밀번호는 4-20자 사이로 입력해 주세요");
			return false;
			
		}else if(!idDuplicateCheck || $("#signId").val() != idResult){
			
			alert("아이디 중복체크를 해주세요");
			return false;
			
		}else{
			
			console.log("유효성 체크완료.이상없음");
		}  
		
	})
	
	//5]회원가입 - 아이디 중복체크 - 유효성
	$("#idDuplicateCheckBtn").click(function(){
		
		if(!($("#signId").val().length >= 4 &&  $("#signId").val().length <= 20)){
			
			alert("아이디는 4-20자 사이로 입력해 주세요");
			return false;
			
		}else{
			idDuplicateCheckAjax();
		}
	})
	
	//6]회원가입 - 아이디 중복 체크
	function  idDuplicateCheckAjax(){
		
		$.ajax({
			url:"<c:url value="/sign/ajax"/>",//요청할 서버의 URL주소
			type:'get',//데이타 전송방식(디폴트는 get방식) 
			dataType:'text',//서버로 부터 응답 받을 데이타의 형식 설정
			data: "id="+$("#signId").val(),
			success:function(data){//서버로부터 정상적인 응답을 받았을때 호출되는 콜백함수
				var result = (data =='available' ? true : false);
				if(result){
					alert("이 아이디는 사용할 수 있습니다.");
					idDuplicateCheck = true;
					idResult = $("#signId").val();
				}else{
					alert("이 아이디는 사용할 수 없습니다.");
					idDuplicateCheck = false;
				}
			},
			error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
				console.log("ajaxError")
				alert("이 아이디는 사용할 수 없습니다.");
				idDuplicateCheck = false;
			}
				
		});
		
	}
</script>
</body>
</html>