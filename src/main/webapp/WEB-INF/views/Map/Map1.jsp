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
                   [2,4,5,6,8,9,10,12],
                   [0,1,2],
                   [0,1,2,3,4,5,6,7,8,9,10,11,12]
                ]; 


//몬스터 필수 값 
monsterExistence = true;
var monsterX=5*standardLength,
    monsterY=8*standardLength-50,// 50 몬스터 한 변 길이
    monsterSpeed=4,
	monsterPosition = 'width', //width or height 포지션에 따라 아래 한계값 다르게 주면 된다. 
	monsterLimitLeftX = 5*standardLength,
	monsterLimitRightX = 9*standardLength - 50;//몬스터 Width 고려
	//monsterLimitTopY = 5*standardLength,
	//monsterLimitBottomY = 9*standardLength - 50;//몬스터 height
	
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
    BackgroundDesign()
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
     
    
   // drawCharacter(characterImg,[400,200+30,70,70],true);  
   // drawCharacter(treasureCloseImg,[400,330,70,70],true);  
}

function BackgroundDesign(){
	 ctx.drawImage(design2Img,128,95,32,32,300,300,40,40)
	 ctx.drawImage(design2Img,128,66,32,30,300,350,40,40)
	 ctx.drawImage(design2Img,0,67,32,30,300,400,40,40)
	 ctx.drawImage(design2Img,161,8,30,27,300,450,40,40)

}



var interval = setInterval(draw, 10);

</script>


