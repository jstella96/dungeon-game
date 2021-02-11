<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dokdo&family=East+Sea+Dokdo&family=Jua&display=swap" rel="stylesheet">
<style>
    *{
    	user-select: none;
        padding :0;
        margin:0;
    }#Startcanvas{
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
   	}.loginDiv a{
   		background-color: #f5f0de
   	}#modalBtn{
   		border:none;
   		color:#f0e8cb;
   		background-color: #5b4f63; 
   		border-radius: 10px;
   		font-weight: 400;
		font-family: 'Jua', sans-serif;
		font-size: 20px;
   	}
   	
  
</style> 
	<div id="Startcanvas">
		
			  <div class="col-xs-4 col-xs-offset-4 loginDiv">
						<form class="form-horizontal" action="map/start"  autocomplete="off">
							  <div class="form-group">
							  
							    <div class="col-xs-offset-1 col-xs-10">
							      <input type="email" class="form-control" name="id "id="id" placeholder="아이디">
							    </div>
							  </div>
							  <div class="form-group">
							   <div class="col-xs-offset-1 col-xs-10">
							      <input type="password" class="form-control" id="password" placeholder="비밀번호">
							    </div>
							  </div>
							  <span style="color:red">${error}</span>
							  <div class="form-group">
							    <div class="col-xs-offset-2 col-xs-8">
							       	<button class="col-xs-5" id="loginBtn" type="submit" class="btn btn-default">게임시작</button>
	      						    <button class="col-xs-5 col-xs-offset-2" type="button" id="modalBtn" class="btn btn-default">간단가입</button>
								</div>
							  </div>
						 </form>
					  </div> 
	 	 
	</div>
	
	<div class="modal fade" id="ruleModal" data-backdrop="false" >
	    <div class="modal-dialog modal-sm" >
	        <div class="modal-content">
	           
	            <div class="modal-body">		
				   	<div class="col-xs-4 col-xs-offset-4 loginDiv">
						<form class="form-horizontal" action="map/start">
							  <div class="form-group">
							  
							    <div class="col-xs-offset-1 col-xs-10">
							      <input type="email" class="form-control" id="inputEmail3" placeholder="아이디">
							    </div>
							  </div>
							  <div class="form-group">
							   
							    <div class="col-xs-offset-1 col-xs-10">
							      <input type="password" class="form-control" id="inputPassword3" placeholder="비밀번호">
							    </div>
							  </div>
							  <div class="form-group">
							    <div class="col-xs-offset-5 col-xs-6">
							       <a class="btn btn-default col-xs-offset-1 col-xs-5" href="<c:url value="/login"/>">게임시작</a>
								 </div>
							  </div>
						 </form>
					  </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            </div>
	        </div>
	    </div>
	</div><!-- /모달 -->
<script>
$('#ruleBtn').click(function(){
	$('#ruleModal').modal();
	console.log("dd");
	
})
		
//로그인 에러 
var error = '${error}';

//프론트 유효성 체크
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
</script>
	</script>