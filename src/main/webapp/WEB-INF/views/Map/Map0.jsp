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
/*Map0에서 만 사용하는 이미지*/
var bbsImg =new Image;
bbsImg.src = '<c:url value="/resources/img/map/bbs.png"/>';

var noticImg =new Image;
noticImg.src = '<c:url value="/resources/img/map/notic1.jpg"/>';

var lanternImg = new Image;
lanternImg.src = '<c:url value="/resources/img/map/lanternDark.png"/>';

/*시작위치 */
myCharacterX = 180;
myCharacterY = 520;


var noticExistence = false;
var prolog = true;
var timeCount = 0;
var LanternCheck = true;




function draw() {
    //1] 캔버스 전체 삭제 후 새로 그리기
    ctx.clearRect(0, 0, canvas.width, canvas.height);
   
    //2] 바닥에 그려지는 순서 배경 -> 벽 - > 캐릭터 
    drawBackground(backgroundImg);
    drawBrick(brickImg,BrickPositionArr,true);
    drawMyCharacter();
    mapChange();
    drawCharacter(bbsImg,[700,200+30,150,150],true);  
     
     if( myCharacterX > 500 &&  myCharacterX < 800 &&  myCharacterY > 200 &&  myCharacterY < 500 ){
		 if(noticExistence){
			 ctx.drawImage(noticImg, 200,300,300,200);  
		 }
	 }else{
   	     noticExistence=false;
     }  
     
     if(LanternCheck){
    	
      	 Lantern(); 
      	 ctx.drawImage(lanternImg, 500,400,50,50);
       }
     
     timeCount++;
     ctx.fillStyle = '#999999';
     ctx.font = ' bold 28px Arial, sans-serif';
     if(prolog && timeCount>200 && timeCount<500){
    	  ctx.fillText("여기가 어디지..", 250, 250);
     }if(timeCount>500 && timeCount < 700){
    	  ctx.fillText("어..저게 뭐지 렌턴인가?", 250, 250);
         
     }if(timeCount>700 && timeCount < 900){
    	
    	  if(myCharacterX<=450){
    		  myCharacterX += 3; 
    	  }else if(myCharacterY >= 400){
    		  myCharacterY -= 3;
    	  }
          
      }if(timeCount>900 && timeCount < 1100){
    	   ctx.fillText("불을 지펴보자", 250, 250);
    	   
      }if(timeCount>1100 && timeCount < 1200){
    	   ctx.fillText("치직.. 치치직...", 250, 250);
	       if(timeCount%2 == 0){
	       lanternImg.src = '<c:url value="/resources/img/map/lanternRed.png"/>';
	       }else{
	       lanternImg.src = '<c:url value="/resources/img/map/lanternYellow.png"/>';   
	       }
	   }if(timeCount>1250){
	      LanternCheck = false;
	      ctx.fillText("어 저기 안내판이 있잖아 가봐야겠다", 250, 250);
       }
       
     
    	 
    	 /*if(myCharacterX <= 400){
    		 myCharacterX += 3; 
    	 }else{
    		 myCharacterY -= 3;	 
    	 }*/
       	
 }
     



	


function startMotion(){
	
}



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
		 if(noticExistence){
	    	   noticExistence=false; 
	       }else{
	    	   noticExistence=true
	     }   
    }   
}

</script>


