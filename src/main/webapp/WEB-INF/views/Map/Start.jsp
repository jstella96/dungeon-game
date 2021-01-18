<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
    *{
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
    }#StartcanvasBtns{
    	
   	}
</style> 
	<div id="Startcanvas">
		
		 <div id="StartcanvasBtns">
		 <a class="btn btn-default" href="<c:url value="/map/login"/>">게임시작</a>
		 <a class="btn btn-default" id="ruleBtn">게임방법</a>
		 </div>
	</div>
	
	<div class="modal fade" id="ruleModal" data-backdrop="false" >
	    <div class="modal-dialog modal-sm" >
	        <div class="modal-content">
	           
	            <div class="modal-body">		
				   		<form action="/map/start">
							<input>
							<button type="submit">가입</button>
							<a class="btn btn-default" id="joinBtn" >가입</a>
						</form>
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
	</script>