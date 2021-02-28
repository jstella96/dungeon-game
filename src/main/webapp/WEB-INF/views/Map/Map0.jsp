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



var timeCount = 0;
var noticExistence = false;
var LanternCheck = true;


//Member 테이블 체크해서 재생여부 판단. 
prologExistence =false;
/*시작위치 */
if(prologExistence){
	myCharacterX = 180;
	myCharacterY = 520;
}


function mapEvent(){
	 //0-3] 캐릭터 위치가 bbs 근방에 있고, 스페이스를 눌렀을때 설명서가 펴진다.noticExistence는 아래 함수에서도 변경된다.
    if( myCharacterX > 700 &&  myCharacterX < 950 &&  myCharacterY > 200 &&  myCharacterY < 400 ){
		 if(noticExistence){
			 ctx.drawImage(noticImg, 200,300,300,200);  
		 }
	 }else{
   	     noticExistence=false;
     }  
     
    //0-4]rologExistence 프롤로그를 한번 재생한 후에는  재재생이 안되도록.
     if(prologExistence){
    	 playProlog()
     }
}




//0]event 1번 : 프롤로그 실행 함수. timeCount를 이용해 시나리오를 만든다.
function playProlog(){
    //0-0]시간의 흐름을 체크해주는 카운트
    timeCount++;
    //0-1]시나리오 중 렌턴을 습득할 때까지(flase) 렌턴은 그려지는 상태로 있다.
    if(LanternCheck){
    	Lantern(); 
      	ctx.drawImage(lanternImg, 500,400,50,50);
     }
    
    //0-2]글씨를 쓰기 위하여 글씨 색상과 폰트 설정
	ctx.fillStyle = '#999999';
    ctx.font = ' bold 28px Arial, sans-serif';

   //0-3]프롤로그 시나리오 시작 마지막에 drawMyCharacter(); 없으면 캐릭터 조종 불가 각 상황에 Motion() 메소드로 캐릭터 움직임 컨트롤
   if(timeCount>200 && timeCount<= 500){
	  	  ctx.fillText("여기가 어디지..", 250, 250);
	  	  stopMotion();
    }else if(timeCount>500 && timeCount <= 700){
	  	  ctx.fillText("어..저게 뭐지 렌턴인가?", 250, 250);
	  	  stopMotion();
    }else if(timeCount>700 && timeCount <= 900){
  	 
	       if(myCharacterX<=450){
	  		  myCharacterX += 3;
	  		  rigthMotion()
	  	   }else if(myCharacterY >= 400){
	  		  myCharacterY -= 3;
	  		  upMotion();
	  	   }else{
	  		  stopMotion();
	  	   }  
    }else if(timeCount>900 && timeCount <= 1000){
	  	   ctx.fillText("불을 지펴보자", 250, 250);
	  	   rigthMotion();
    }else if(timeCount > 1000 && timeCount <= 1150){
	  	   ctx.fillText("치직.. 치치직...", 250, 250);
	  	   rigthMotion();
	  	   if(timeCount%2 == 0){
		    	   lanternImg.src = '<c:url value="/resources/img/map/lanternRed.png"/>';
		   }else{       
		           lanternImg.src = '<c:url value="/resources/img/map/lanternYellow.png"/>'; 
		   }
    }else if(timeCount>1150 && timeCount <= 1200){
	      rigthMotion();
    }else if(timeCount>1200 && timeCount <= 1300){
	      LanternCheck = false;
	      rigthMotion();
    }else if(timeCount>1300 && timeCount <= 1450){
	      ctx.fillText("밝아졌다!!", 150, 230);
	      stopMotion();
    }else if(timeCount>1450 && timeCount <= 1600){
  	   if(timeCount<1500){
	    	   leftMotion();
	       }else if(timeCount<1550){
	    	   upMotion();
	       }else if(timeCount<=1600){
	    	   rigthMotion(); 
	       }
     }else if(timeCount>1600 && timeCount <= 1750){
  	  ctx.fillText("어 저기 묘비가 있네 가볼까", 150, 230);
  	  rigthMotion();  
     }else if(timeCount>1800){
  	  ctx.fillText("묘비에 다가가 스페이스를 눌러보자", 150, 230);
  	  ctx.fillText("방향키로 움직일 수 있다", 150, 270);
  	  drawMyCharacter();   
     }else{
  	   stopMotion();
     }
  
}



function backgroundDesign(){
	 drawCharacter(design2Img,[128,95,32,32,860,300,30,30],true);
	 drawCharacter(design2Img,[325,65,88,63,780,250,90,90],true);

}




function Lantern(){
	grd = ctx.createRadialGradient(myCharacterX+35, myCharacterY+35, 20,  myCharacterX+35, myCharacterY+35, 150),
    grd.addColorStop(0, "rgba(255, 255, 220, 0.1)");
    grd.addColorStop(1, "rgba( 0,0, 0, 1)");
    ctx.rect(0, 0, 13*standardLength,9*standardLength);
    ctx.fillStyle = grd;
    ctx.fill();
}                
  


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


