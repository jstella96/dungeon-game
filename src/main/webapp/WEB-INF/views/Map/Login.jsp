<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
    *{
        padding :0;
        margin:0;
    }#canvas{
        display:block;
        margin : 0 auto;
        width : 1235px;
        height : 855px;
        background-image: url(<c:url value="/resources/img/map/background2.png"/>);
	    background-position: center;
	    background-size: cover;
    }
</style> 
	<div id="canvas">
		<div>
			<form action="<c:url value='/map/login'/>" method="post">
				<input type="text" name="id"/>
				<input type="password" name="pwd"/>
				<button type="submit">로그인</button>
			</form>
		</div>

	</div>
	
		
	