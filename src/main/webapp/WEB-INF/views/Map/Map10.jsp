<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">


//변동_ 
//벽돌 이미지의 그려질 위치 배열, 벽돌 처럼 막혀있는 조형물은 이 배열 사용해서
//drawBrick() 함수 매개 변수로 전달한다.
//개수 canvasWidth/standardLength * canvasHeight/standardLength 
var BrickPositionArr = [
                   [0,2,4,5,6,8,10,12],
                   [0,2,6,8,10],
                   [0,2,3,4,6,8,10,11,12],
                   [2,4],
                   [0,1,2,4,6,7,8,9,10,11,12],
                   [2,4,6,12],
                   [0,1,2,4,6,7,8,10,12],
                   [2,4,10,12],
                   [0,2,4,5,6,7,8,9,10,11,12]
                ]; 

function backgroundDesign(){
	 //해골.디자인.앞 4개 고정
	 ctx.drawImage(design2Img,128,95,32,32,280,280,40,40)
}


function mapEvent(){
	 //해골.디자인.앞 4개 고정
	 ctx.drawImage(design2Img,128,95,32,32,280,340,40,40)
}

</script>


