<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>

//변동_ 
//벽돌 이미지의 그려질 위치 배열, 벽돌 처럼 막혀있는 조형물은 이 배열 사용해서
//drawBrick() 함수 매개 변수로 전달한다.
//개수 canvasWidth/standardLength * canvasHeight/standardLength 
BrickPositionArr = [
                   [0,1,2,3,4,5,6,7,8,9,10,11,12],
                   [0,1,2,3,4,5,6,7,8,9,10,11,12],
                   [0,12],
                   [0,12],
                   [0,12],
                   [0,12],
                   [0,],
                   [0,1,2,3,4,5,6,7,8,9,10,11,12],
                   [0,1,2,3,4,5,6,7,8,9,10,11,12]
                ]; 
                
var noticExistence = false;

function draw() {
    //1] 캔버스 전체 삭제 후 새로 그리기
    ctx.clearRect(0, 0, canvas.width, canvas.height);
   
    //2] 바닥에 그려지는 순서 배경 -> 벽 - > 캐릭터 
    drawBackground(backgroundImg);
    drawBrick(brickImg,BrickPositionArr,true);
    drawMyCharacter();
    mapChange();
   
    <c:if test="${!empty diaList}">
	    <c:forEach var="item" items="${diaList }" varStatus="loop">	
			drawDiamond(diamondImg,[standardLength*(${item.x}-1),standardLength*${item.y}-diamondLength,diamondLength,diamondLength],diamondNo[${loop.index}],diamondState[${loop.index}]);
		</c:forEach>
	</c:if>
    
   // drawDiamond(diamondImg,[standardLength*(3-1),standardLength*2-diamondLength,diamondLength,diamondLength],0,chdia[0]);
    //drawDiamond(diamondImg,[standardLength*(4-1),standardLength*2-diamondLength,diamondLength,diamondLength],1,chdia[1]);
    //drawDiamond(diamondImg,[standardLength*(5-1),standardLength*2-diamondLength,diamondLength,diamondLength],2,chdia[2]);
     if(monsterExistence){
    	drawMonster();
     }
     if(treasureExistence){
     	drawTreasure(treasureImg,treasurePositionArr);
      }
     if(LanternCheck){
    	 Lantern(); 
    	 LanternCount += 1;
    	 if(LanternCount>1000){
    		 LanternCount = 0;
    		 LanternCheck = false;
    	 }
     }
     drawCharacter(bbsImg,[600,200+30,150,150],true);  
     if(noticExistence){
    	ctx.drawImage(noticImg, 200,300,300,200);  
     }
     else{
    	
     }
     
   // drawCharacter(treasureCloseImg,[400,330,70,70],true);  
}

var LanternCheck = false;
var LanternCount = 0;
function Lantern(){
	grd = ctx.createRadialGradient(myCharacterX+35, myCharacterY+35, 20,  myCharacterX+35, myCharacterY+35, 150),
    grd.addColorStop(0, "rgba(255, 255, 220, 0.1)");
    grd.addColorStop(1, "rgba( 0,0, 0, 1)");
    ctx.rect(0, 0, 13*standardLength,9*standardLength);
    ctx.fillStyle = grd;
    ctx.fill();
}                
  

var interval = setInterval(draw, 10);

document.addEventListener("keydown", keyDownNoticHandler, false);

function keyDownNoticHandler(e) {
	         
	if(e.keyCode == 32) {
		if( myCharacterX > 500 &&  myCharacterX < 800 &&  myCharacterY > 200 &&  myCharacterY < 500 ){
			 if(noticExistence){
		    	   noticExistence=false; 
		       }else{
		    	   noticExistence=true
		     }  
		}
      
    }   
}

</script>


