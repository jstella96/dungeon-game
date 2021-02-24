<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">


//변동_ 
//벽돌 이미지의 그려질 위치 배열, 벽돌 처럼 막혀있는 조형물은 이 배열 사용해서
//drawBrick() 함수 매개 변수로 전달한다.
//개수 canvasWidth/standardLength * canvasHeight/standardLength 
var BrickPositionArr = [
                   [0,2,3,4,6,7,8,10,11,12],
                   [0,4,6,12],
                   [0,2,4,6,8,9,10,12],
                   [0,2,4,6,8,12],
                   [0,1,2,4,5,6,8,10,12],
                   [2,8,10,12],
                   [0,2,3,4,6,7,8,10,12],
                   [6,10,12],
                   [0,1,2,3,4,5,6,7,8,9,10,11,12]
                ];  
 
function draw() {
    //1] 캔버스 전체 삭제 후 새로 그리기
    ctx.clearRect(0, 0, canvas.width, canvas.height);
   
    //2] 바닥에 그려지는 순서 배경 -> 벽 - > 캐릭터 
    drawBackground(backgroundImg);
    drawBrick(brickImg,BrickPositionArr,true);
    backgroundDesign()
    //drawMyCharacter();
    mapChange();
   
    <c:if test="${!empty diamondList}">
	    <c:forEach var="item" items="${diamondList }" varStatus="loop">	
			drawDiamond(diamondImg,[standardLength*(${item.x}-1),standardLength*${item.y}-diamondLength,diamondLength,diamondLength],diamondId[${loop.index}],diamondState[${loop.index}]);
		</c:forEach>
	</c:if>
    
	 <c:if test="${!empty monsterList}">
	    <c:forEach var="item" items="${monsterList }" varStatus="loop">	
	   	 drawMonster(${loop.index});
		</c:forEach>
	</c:if>

	   
    <c:if test="${!empty itemList}">
	    <c:forEach var="item" items="${itemList }" varStatus="loop">	
	  	  drawItem("${item.name}",[standardLength*(${item.x}-1),standardLength*${item.y}-itemLength,itemLength,itemLength],itemId[${loop.index}],itemState[${loop.index}]);
		</c:forEach>
	</c:if>
    
	
     drawMyCharacter();

     
     if(treasureExistence){
     	drawTreasure(treasureImg,treasurePositionArr);
      }
     
     if(attackExistence){
    	monsterAttack();
     }	
     
     if(magicBallExistence){
    	 console.log(magicBallExistence);
    	 launchMagicBall()
     }
     if(life==0){
    	 clearInterval(drowinterval);
    	 endGameInterval = setInterval(endGame, 200);
     }
 
}


function backgroundDesign(){
	 //해골.디자인.앞 4개 고정
	 ctx.drawImage(design2Img,128,95,32,32,280,280,40,40)
	

}



var drowinterval = setInterval(draw, 10);

</script>


