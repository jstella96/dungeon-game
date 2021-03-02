<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

//변동_ 
//벽돌 이미지의 그려질 위치 배열, 벽돌 처럼 막혀있는 조형물은 이 배열 사용해서
//drawBrick() 함수 매개 변수로 전달한다.
//개수 canvasWidth/standardLength * canvasHeight/standardLength 
var BrickPositionArr = [
                   [0,2,4,5,6,7,8,9,10,11,12],//1
                   [0,2,4,8],//2
                   [0,2,4,5,6,8,10,11,12],//3
                   [0,8,10],//4
                   [0,1,2,3,4,5,6,8,10,12],//5
                   [4,6,8,10],//6
                   [0,1,2,4,6,8,10,11,12],//7
                   [2,4,6,8],//8
                   [0,1,2,4,6,7,8,9,10,11,12]//9
                ]; 

function backgroundDesign(){
	 //해골.디자인.앞 4개 고정
	 //ctx.drawImage(design2Img,128,95,32,32,280,280,40,40)
}



function mapEvent(){
	
	 drawTreasure();
	 drawRedDiamond(redDiamondImg,redDiamondShow)

}



var treasureEventExistence = true;
var touchCheck = false;
var redDiamondShow=false;
var eventId = 1;

var treasureImg =new Image;
treasureImg.src = '<c:url value="/resources/img/map/boxkey/box1.png"/>';

var treasureOpenImg =new Image;
treasureOpenImg.src = '<c:url value="/resources/img/map/boxkey/box1open.png"/>';


var treasurePositionArr =[5*standardLength+15,2*standardLength-60,60,60];//drawTreasure(treasureImg,[90*3,100,60,60]);

//보물상자 그리기
function drawTreasure(){
	//console.log(getItems)getItems.includes("key")
	  if(treasureEventExistence){
	      	ctx.drawImage(treasureImg,
	       		treasurePositionArr[0],
	       		treasurePositionArr[1],
	            treasurePositionArr[2],
	            treasurePositionArr[3]);
	}else{
		  ctx.drawImage(treasureOpenImg,
			  		treasurePositionArr[0],
			  		treasurePositionArr[1],
			        treasurePositionArr[2],
			        treasurePositionArr[3]);
      }
    
}



document.addEventListener("keydown", keyDownNoticHandler, false);


//아이템이름 key2, 아이디 2번
function keyDownNoticHandler(e){

	if(e.keyCode == 32) {
		 if( myCharacterX > treasurePositionArr[0]-50 &&  myCharacterX < treasurePositionArr[0]+treasurePositionArr[2]+50 &&
			myCharacterY > treasurePositionArr[1]-50 &&  myCharacterY < +treasurePositionArr[0]+treasurePositionArr[3]+50&&
		    treasureEventExistence==true && getItems.includes("key1"))
		 {
			 treasureEventExistence=false;
			 redDiamondShow=true;
			 useItemAjax(1);
			 clearEventAjax(eventId);
		 } 
    }   
}



//이벤트 관련 메소드.

function drawRedDiamond(redDiamondImg,showOrhide){
	  if(showOrhide){
	        ctx.drawImage(redDiamondImg,treasurePositionArr[0]-40,treasurePositionArr[1],55,55)
	        var state = targetCrash(treasurePositionArr[0]-50,treasurePositionArr[1],55,55);                
	    
	        if(state != null){
	             redDiamondShow=false;
	             getRedDiamondAjax()
	        }
	  }else{
		  return;
	  }
}

// 특정 위치에만 나타나기 때문에 다이아 흭득 사실만 저장
function getRedDiamondAjax(){

	$.ajax({
		url:"<c:url value="/map/reddia/get"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		data:'id=${sessionScope.memberId}&map=${memberDto.map}',
		success:function(){
			//console.log("레드 다이아 습득")
			var diaCount = $("#diamondCount").html()
			diaCount = parseInt(diaCount)+10;
			$("#diamondCount").html(diaCount);
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}

function useItemAjax(itemId){

	$.ajax({
		url:"<c:url value="/map/use/item"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		data:'id=${sessionScope.memberId}&item_id='+itemId,
		success:function(){
			console.log("아이템 사용")
			itemSetting()
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}

function clearEventAjax(eventId){

	$.ajax({
		url:"<c:url value="/map/clear/event"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		data:'id=${sessionScope.memberId}&event_id='+eventId,
		success:function(){
			console.log("이벤트 달성")
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}

function EventCheckAjax(eventId){

	$.ajax({
		url:"<c:url value="/map/get/event"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		data:'id=${sessionScope.memberId}&event_id='+eventId,
		dataType:'text',
		success:function(data){
			if(data == "y"){
				treasureEventExistence = true;
			}else{
				treasureEventExistence = false;
			}
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}

EventCheckAjax(eventId)

</script>


