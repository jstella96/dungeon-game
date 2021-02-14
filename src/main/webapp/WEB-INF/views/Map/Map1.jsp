<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>

//변동_ 
//벽돌 이미지의 그려질 위치 배열, 벽돌 처럼 막혀있는 조형물은 이 배열 사용해서
//drawBrick() 함수 매개 변수로 전달한다.
//개수 canvasWidth/standardLength * canvasHeight/standardLength 
BrickPositionArr = [
                   [0,2,3,4,5,6,8,10,11,12],
                   [0,6,8],
                   [0,2,3,4,6,8,10,11,12],
                   [0,2,4,6,8,10],
                   [0,2,4,6,7,8,10,12],
                   [0,4,10,12],
                   [2,4,5,6,7,8,9,10,12],
                   [0,1,2],
                   [0,1,2,3,4,5,6,7,8,9,10,11,12]
                ]; 



//다이아몬드 true/false 상채
var diamondState = [];
var diamondNo = [];
console.log(diamondState);
console.log(diamondNo);
<c:if test="${!empty diamondList}">
	 <c:forEach var="item" items="${diamondList }">
	 console.log("??");
	  diamondState.push(${item.state});
	  diamondNo.push(${item.no});
	</c:forEach>
</c:if>


//몬스터 필수 값 , 고정값, location 은 몬스터 레벨따라 바꿀까?
var monsterWidth=50,
  monsterHeight=50;
  
//레밸따라 로케이션도 바꿔야행...


////////////////////////

var monsterX=[],
	monsterY=[],// 50 몬스터 한 변 길이
	monsterSpeed=[],
	monsterPosition = [], //width or height 포지션에 따라 아래 한계값 다르게 주면 된다. 
	monsterLimitStart = [],
	monsterLimitEnd = [],
	monsterLevel = [],//레벨 별 몬스터 생명 수 여기 변수 바꿔!!!! 이게 뭐야
	basicMonsterLife = [],//레벨 별 몬스터 생명 수 여기 변수 바꿔!!!! 이게 뭐야
	monsterLife = [],	
	monsterLocation = [];
	monsterDeath = [];
	monsterId = [];	
<c:if test="${!empty monsterList}">
	<c:forEach var="item" items="${monsterList }">
	
	if(${item.x}==0){ // null 값이 0으로 들어온다. x값이 없다는건 죽은 몬스터가 아니다.
		monsterX.push(${item.minX}*standardLength+15);
		monsterY.push(${item.minY}*standardLength-monsterHeight);
		monsterLife.push(${item.life});
		monsterDeath.push(false)
	}else{
		monsterX.push(${item.x});
		monsterY.push(${item.y});
		monsterLife.push(0);
		monsterDeath.push(true)
	}	
	
	//포지션따라서 다르게
	if('${item.position}'=='width'){
		monsterLimitStart.push(${item.minX}*standardLength);
		monsterLimitEnd.push(${item.maxX}*standardLength - monsterWidth);
	}else{
		monsterLimitStart.push(${item.minY}*standardLength);
		monsterLimitEnd.push(${item.maxY}*standardLength - monsterHeight);
	}
	monsterSpeed.push(2);
	monsterPosition.push('${item.position}');//width or height 포지션에 따라 아래 한계값 다르게 주면 된다. 
	monsterLevel.push(${item.level});//레벨 별 몬스터 생명 수 여기 변수 바꿔!!!! 이게 뭐야
	basicMonsterLife.push(${item.life});
	monsterLocation.push([0,64,30,32]);
	monsterId.push(${item.id});
	</c:forEach>
</c:if>

/*
var monsterX=[5*standardLength],
    monsterY=[8*standardLength-monsterHeight],// 50 몬스터 한 변 길이
    monsterSpeed=[2],
	monsterPosition = ['width'], //width or height 포지션에 따라 아래 한계값 다르게 주면 된다. 
	monsterLimitStart = [5*standardLength],
	monsterLimitEnd = [9*standardLength - monsterWidth];
//레벨 별 몬스터 생명 수 여기 변수 바꿔!!!! 이게 뭐야
var levelMonster = [1];
var levelMonsterLife = [1];
var monsterLife = [1];	
	//몬스터 Width 고려
	//monsterLimitTopY = 5*standardLength,
	//monsterLimitBottomY = 9*standardLength - 50;//몬스터 height
	
	
	*/
	
	
//몬스터 위쪽 아래쪽 반복여부에 따른 
treasureExistence = true;
var treasurePositionArr =[3*standardLength+20,2*standardLength-60,60,60];//drawTreasure(treasureImg,[90*3,100,60,60]);


//보물상자 
//메소드 X. 
/*
treasureExistence = true;
var treasureX=5*standardLength,
	treasureY=8*standardLength-standardLength,//30 : standard - Height
	*/
//

    
function draw() {
    //1] 캔버스 전체 삭제 후 새로 그리기
    ctx.clearRect(0, 0, canvas.width, canvas.height);
   
    //2] 바닥에 그려지는 순서 배경 -> 벽 - > 캐릭터 
    drawBackground(backgroundImg);
    drawBrick(brickImg,BrickPositionArr,true);
    backgroundDesign()
    //drawMyCharacter();
    mapChange();
   
    <c:if test="${!empty diaList}">
	    <c:forEach var="item" items="${diaList }" varStatus="loop">	
			drawDiamond(diamondImg,[standardLength*(${item.x}-1),standardLength*${item.y}-diamondLength,diamondLength,diamondLength],diamondNo[${loop.index}],diamondState[${loop.index}]);
		</c:forEach>
	</c:if>
    
   // drawDiamond(diamondImg,[standardLength*(3-1),standardLength*2-diamondLength,diamondLength,diamondLength],0,chdia[0]);
    //drawDiamond(diamondImg,[standardLength*(4-1),standardLength*2-diamondLength,diamondLength,diamondLength],1,chdia[1]);
    //drawDiamond(diamondImg,[standardLength*(5-1),standardLength*2-diamondLength,diamondLength,diamondLength],2,chdia[2]);
     
     drawMonster(0);
     drawMonster(1);
     drawMonster(2);
     drawMonster(3);
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
var endGameInterval;
var endGameCountDownInterval;
var endGameTime = 0;
var endGameCountDownTime =10;
function endGame(){
	endGameTime++;
	ctx.beginPath();
	ctx.rect(0, 0, canvas.width, endGameTime*standardLength);
	ctx.fillStyle = "#000000";
	ctx.fill();
	ctx.closePath();
	if(endGameTime==10){
		clearInterval(endGameInterval);
		ctx.fillStyle = '#999999';
	    ctx.font = ' bold 28px Arial, sans-serif';
	    ctx.fillText("GameOver", 528, 400);
	    endGameCountDownInterval=setInterval(endGameCountDown, 1000);
		//10-9-8-7 해서 게임 오버 만들기. 
	}
}
function endGameCountDown(){
	
	ctx.clearRect(0, 0, canvas.width, canvas.height);
	ctx.beginPath();
	ctx.rect(0, 0, canvas.width, endGameTime*standardLength);
	ctx.fillStyle = "#000000";
	ctx.fill();
	ctx.fillStyle = '#999999';
    ctx.font = ' bold 28px Arial, sans-serif';
    ctx.fillText("GameOver", 528, 400);
    ctx.fillText(endGameCountDownTime, 587, 450);
    endGameCountDownTime--;
    if(endGameCountDownTime < 0 ){
    	clearInterval(endGameCountDownInterval);
    	console.log("메인 이동");
    	location.href="<c:url value='/'/>";
        
    }
}

function backgroundDesign(){
	 //해골.디자인.앞 4개 고정
	 ctx.drawImage(design2Img,128,95,32,32,280,280,40,40)
	

}



var drowinterval = setInterval(draw, 10);

</script>


