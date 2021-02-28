<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
*{  font-family: 'Roboto', sans-serif;
    padding :0;
    margin:0;
    user-select: none;
}canvas{
    display:block;
    margin : 0 auto;
}.inventory{
   width:1160px;
   background-color: #363742;
   align-items: center;
   border: 5px solid #434043;
   position:relative;
}.inventory div{
   display:inline-block;
   height:66px;
   margin: 10px;
   background-color: #5c5064;
   color: #281f2a
}.inventory-cell{
    width:66px;
    position:relative;
}.life-cell{
    width:200px;
    position:relative;
}.life-cell #heartDiv{
    position:absolute;
    top:24px;
    left: 60px;
    font-size: 25px;
}.life-cell #heartDiv i{
	color:#af2e2e;
}.diamond-cell{
	width:200px;
    position:relative;
}.diamond-cell #gemDiv{
    position:absolute;
    top:24px;
    left: 57px;
    font-size: 25px;
}.diamond-cell #gemDiv i{
	color:#522d8e;
}#save-cell{
	background-color: #363742;
	color:#888888;
	font-weight: 700;
}#save-cell span{
	position:relative;
}#endBtn{
	position:absolute;
	bottom: 2px;
	right: 2px;
	color:#888888;
	font-weight: 700;
	cursor: pointer;
}.item{
	position:absolute;
	width: 70%;
	height: 60%;
	top: 27%;
    left: 15%;
    min-height: 70%;
    background-position: center;
    background-size: cover;
    
}.item.key{
 	background-image: url('<c:url value="/resources/img/map/key.png"/>');
}.item.redkey{
 	background-image: url('<c:url value="/resources/img/map/key.png"/>');
}.item.bluekey{
 	background-image: url('<c:url value="/resources/img/map/key.png"/>');
}.item.yellokey{
 	background-image: url('<c:url value="/resources/img/map/key.png"/>');
}
</style>

<canvas id="myCanvas" width="1170" height="810"></canvas>

<center>
<div class="inventory">
	<div class="life-cell">Lift<br>
		<span id="heartDiv">
			<i class="fa fa-heart"></i> X <span id="lifeCount">${memberDto.life}</span>
		</span>
	</div>
	<div class="diamond-cell">Diamond<br>
		<span id="gemDiv">
			<i class="fas fa-gem"></i> X <span id="diamondCount">${memberDto.diamondCount}</span>
		</span>
	</div>	
	<div class="inventory-cell">item
		<span class="item"> </span>
	</div>
	<div class="inventory-cell">item
		<span class="item"> </span>
	</div>
	<div class="inventory-cell">item
		<span class="item"> </span>
	</div>
	<div class="inventory-cell">item
		<span class="item"> </span>
	</div>	
	<div class="inventory-cell">item
			<span class="item"> </span>
	</div>	
	<div class="inventory-cell">item
			<span class="item"> </span>
	</div>	
	<div id="save-cell">
	<i class="fa fa-history"></i><span>자동저장 중</span><br>
	</div>
	<a style ="text-decoration:none;" href="<c:url value='/'/>" id="endBtn">나가기</a>
</div>  
</center>     

<div id='test' style="width:1170px; height:810; background-color: red;"></div>


<script>
//캔버스 사용 설정

var getItems=[];

function itemSetting(){
	$.ajax({
		url:"<c:url value="/map/item/get/inben"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		dataType:'json',//서버로 부터 응답 받을 데이타의 형식 설정
		data:'id=${sessionScope.memberId}',
		success:function(data){
			var invenSize=0;
			getItems=[];
			$(".inventory-cell").html("item");
			$.each(data,function(index,element){
				if(element["state"] == "false" && element["use"] == "false"){
					var itemOption = 'item <span class="item '+element["name"]+'"> </span>';
					$(".inventory-cell").eq(invenSize).html(itemOption);
					invenSize++;
					getItems.push(element["name"]);
					console.log(getItems);
				}
			});				
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}
itemSetting()

var canvas = document.getElementById("myCanvas");
var test = $("#test").html();
var ctx = canvas.getContext("2d");

//게임 배경//각페이지에서 입력
var BrickPositionArr = null;

//게임 최소단위의 정사각형의 한 면. ex)벽돌or바닥or조형물들은 이 길이를 기준으로 반복된다.
var standardLength = 90;

//게임 다이아몬드의 사이즈
var diamondLength = 40;
var itemLength = 30;
//게임이 표시 될 캔버스의 너비
var canvasWidth = 13*standardLength;
var canvasHeight = 9*standardLength;

//캐릭터 or 작은npc의 너비
var characterWidth=60;
var characterHeight=60;

//캐릭터 시작 위치/start
var myCharacterX=95;
var myCharacterY=630;

	var x= ${memberDto.x};
	var y= ${memberDto.y};
	
	if(y==0){
		myCharacterX=standardLength*x;
		myCharacterY=standardLength-50;	
	}else if(y==8){
		myCharacterX=standardLength*x;
		myCharacterY=standardLength*y;	
	}else if(x==0){
		myCharacterX=standardLength-50;
		myCharacterY=standardLength*y;	
	}else if(x==12){
		myCharacterX=standardLength*x;
		myCharacterY=standardLength*y;	
	}
	



//캐릭터 스피드
var myCharacterSpeed = 5;

//이미지위치
var myCharacterStopImgLocation=[165,0,30,50],
    myCharacterDownImgLocation=[165,0,30,50],
    myCharacterUpImgLocation=[165,145,30,50],
    myCharacterLeftImgLocation=[165,50,30,50],
    myCharacterRightImgLocation=[160,100,30,50];


//눌리는 순간 true로 변환 되며 이벤트 실행
var rightPressed = false;
var leftPressed = false;
var downPressed = false;
var upPressed = false;

//이미지 연결
var backgroundImg = new Image;
backgroundImg.src = '<c:url value="/resources/img/map/floor.png"/>';

var brickImg = new Image;
brickImg.src = '<c:url value="/resources/img/map/brick.jpg"/>';

var myCharacterImg = new Image;
myCharacterImg.src = '<c:url value="/resources/img/map/Chr.png"/>';

var monsterImg = new Image;
monsterImg.src = '<c:url value="/resources/img/map/monster.png"/>';

var characterImg =new Image;
characterImg.src = '<c:url value="/resources/img/map/monster.png"/>';

var diamondImg =new Image;
diamondImg.src = '<c:url value="/resources/img/map/diamond.png"/>';

var redDiamondImg =new Image;
redDiamondImg.src = '<c:url value="/resources/img/map/reddiamond.png"/>';

var keyImg =new Image;
keyImg.src = '<c:url value="/resources/img/map/key.png"/>';

var design1Img = new Image;
design1Img.src = '<c:url value="/resources/img/map/design1.gif"/>';

var design2Img = new Image;
design2Img.src = '<c:url value="/resources/img/map/design2.png"/>';

var attackImg = new Image;
attackImg.src = '<c:url value="/resources/img/map/attack.png"/>';

var magicBallImg = new Image;
magicBallImg.src = '<c:url value="/resources/img/map/magicBall.png"/>';

var bloodImg = new Image;
bloodImg.src = '<c:url value="/resources/img/map/blood.png"/>';

var keyImg = new Image;
keyImg.src = '<c:url value="/resources/img/map/key.png"/>';

//디폴트 false 사용하는 페이지에서 true로 전환
var monsterExistence = false;

var prologExistence =false;

//다이아몬드 true/false 상채
var diamondState = [];
var diamondId = [];
<c:if test="${!empty diamondList}">
	 <c:forEach var="item" items="${diamondList }">
	  diamondState.push(${item.state});
	  diamondId.push(${item.id});
	</c:forEach>
</c:if>

var itemState = [];
var itemId = [];
<c:if test="${!empty itemList}">
	 <c:forEach var="item" items="${itemList}">
		itemState.push(${item.state});
	 	itemId.push(${item.id});
	 	
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

var endGameInterval;
var endGameCountDownInterval;
var endGameTime = 0;
var endGameCountDownTime =10;


function draw() {
    //1] 캔버스 전체 삭제 후 새로 그리기
    ctx.clearRect(0, 0, canvas.width, canvas.height);
   
    //2] 바닥에 그려지는 순서 배경 -> 벽 - > 캐릭터 
    drawBackground(backgroundImg);
    drawBrick(brickImg,BrickPositionArr,true);
    backgroundDesign()
    //drawMyCharacter();
    mapChange();
    mapEvent();
    
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
     
     //map0의 프롤로그 or 캐릭터 스스로 움직일 때는 실행되면 안됨
 	if(prologExistence != true){
      drawMyCharacter();
 	}

}



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

function drawItem(itemName,itemPositionArr,itemId,showOrhide){
	  if(showOrhide){
		  	switch(itemName) {
			case "key":
				ctx.drawImage(keyImg,itemPositionArr[0],itemPositionArr[1],
								itemPositionArr[2],itemPositionArr[3])
				break;
			case "key1":
				ctx.drawImage(keyImg,itemPositionArr[0],itemPositionArr[1],
						itemPositionArr[2],itemPositionArr[3])
				break;
			case "key2":
				ctx.drawImage(keyImg,itemPositionArr[0],itemPositionArr[1],
						itemPositionArr[2],itemPositionArr[3])
				break;
		  	}
	        var state = targetCrash(itemPositionArr[0] ,itemPositionArr[1],
	        					itemPositionArr[2],itemPositionArr[3],itemId);  
	        if(state != null){
	        	var arrNo = this.itemId.indexOf(itemId);
	        	itemState[arrNo]=false;
	            getItemAjax(itemId)
	        }
	        
	  }else{
		  return;
	  }
}

//공통메소드 이동메소드
function mapChange(){
    
    for(var h=0 ; h < canvasHeight/standardLength ;h++){
        for(var w=0; w< canvasWidth/standardLength ; w++) {
           var brickX = w*standardLength; //벽돌의 
           var brickY = h*standardLength;
           var brickWidth = standardLength; 
           var brickHeight = standardLength;
        
           if(!BrickPositionArr[h].includes(w)){
               if(h==0){
                
                 if(standardLength * w <= myCharacterX &&myCharacterX <=standardLength*(w+1) && 
                     0 <= myCharacterY  && myCharacterY<=(standardLength-characterHeight)){
                        console.log('상단'+h+'행'+w) //h=0 상단
                        location.href="<c:url value='/map/change?x="+w+"&y="+h+"&page=${memberDto.map}&life="+life+"'/>";
                     }
              }
               if(h==8){
               
                if(standardLength * w <= myCharacterX &&myCharacterX <=standardLength*(w+1) && 
                (standardLength*9-characterHeight) <= myCharacterY  && myCharacterY<=standardLength*9){
                        console.log('하단'+h+'행'+w) //h=0 상단
                        location.href="<c:url value='/map/change?x="+w+"&y="+h+"&page=${memberDto.map}&life="+life+"'/>";
                      }
               }
               if(w==0){
                
                if(  0 <= myCharacterX && myCharacterX <= (standardLength-characterWidth) && 
                 standardLength * h <= myCharacterY  && myCharacterY<=standardLength*(h+1)){
                        console.log('왼단'+h+'행'+w) //h=0 상단
                        location.href="<c:url value='/map/change?x="+w+"&y="+h+"&page=${memberDto.map}&life="+life+"'/>";
                     }

                }
               if(w==12){
                if(  (standardLength*13-characterHeight) <= myCharacterX && myCharacterX <= standardLength*13 && 
                 standardLength * h <= myCharacterY  && myCharacterY<=standardLength*(h+1)){
                        console.log('오른단'+h+'행'+w) //h=0 상단
                        location.href="<c:url value='/map/change?x="+w+"&y="+h+"&page=${memberDto.map}&life="+life+"'/>";
                     }
               }
            }
               
        }
    }
}


//공통메소드 캐릭터 관련 1] drawCharacter(캐릭터 이미지,캐릭터포지션Arr,충돌체크여부(boolean))
//공통메소드 배경 관련 1]drawBrick(brickImg,positionArr,frontOrBack)
//공통메소드 몬스터 관련 1]drawMonster();
//    drawBackground(backgroundImg);
//drawMyCharacter();
//    
//    drawBrick(brickImg,BrickPositionArr,true);
//    drawMonster();
//    drawCharacter(characterImg,characterPositionArr,true);
// 배열 4 개 일시 x축 y축 가로길이 세로길이
//아마 물건 기준.. 음.. 해골같은 배경에 쓰이려나>? 
function drawCharacter(characterImg,characterPositionArr,crashCheck){
	  if(characterPositionArr.length == 4){
        ctx.drawImage(characterImg,
                        characterPositionArr[0],
                        characterPositionArr[1],
                        characterPositionArr[2],
                        characterPositionArr[3]);
	        if(crashCheck){           
	            var state = targetCrash(characterPositionArr[0] ,characterPositionArr[1],characterPositionArr[2],characterPositionArr[3]);                
	            if(state != null){
	        		switch (state){
	           		    case 'left':
	           		   			  myCharacterX -= myCharacterSpeed;
	           		        break;
	           		    case 'rigth':
	           		   			  myCharacterX += myCharacterSpeed;
	           		        break;
	           		    case 'top':
	           		  			   myCharacterY += myCharacterSpeed;
	           		        break;
	           		    case 'bottom':
	           		  			   myCharacterY -= myCharacterSpeed;
	           		        break;
	           		    default :
	           		       		console.log("error");
	        			}
	        	   }    
    	 }
	}else{
		 ctx.drawImage(characterImg,
                 characterPositionArr[0],
                 characterPositionArr[1],
                 characterPositionArr[2],
                 characterPositionArr[3],
                 characterPositionArr[4],
                 characterPositionArr[5],
                 characterPositionArr[6],
                 characterPositionArr[7]);
	 	if(crashCheck){           
		     var state = targetCrash(characterPositionArr[4] ,characterPositionArr[5],characterPositionArr[6],characterPositionArr[7]);                
		     if(state != null){
		 		switch (state){
		    		    case 'left':
		    		   			  myCharacterX -= myCharacterSpeed;
		    		        break;
		    		    case 'rigth':
		    		   			  myCharacterX += myCharacterSpeed;
		    		        break;
		    		    case 'top':
		    		  			   myCharacterY += myCharacterSpeed;
		    		        break;
		    		    case 'bottom':
		    		  			   myCharacterY -= myCharacterSpeed;
		    		        break;
		    		    default :
		    		       		console.log("error");
		 			}
		 	   }    
		 }
	 }
}	  


//충돌체크 메소드, 타겟의 정보를 받아와서 캐릭터와의 충돌여부를 체크한다.
//targetCrash(타겟)
function targetCrash(targetX ,targetY,targetWidth,targetHeight){
    //오른쪽 충돌 _ 계산 로직 만약) 캐릭터의 오른쪽 위치가 벽돌의 왼쪽 위치+-10 안에 있는데.
    // 사람의 왼쪽 부분이 벽돌 왼쪽위치보다 크구 y값이 잘 맞으면 
    if((myCharacterX+characterWidth) > (targetX-10) &&(myCharacterX+characterWidth) < (targetX+10) ){
        if((myCharacterX+characterWidth) > targetX && (targetY+targetHeight)>myCharacterY &&myCharacterY>(targetY-characterHeight)){
               return 'left';
        }}
    //왼쪽 충돌 _ 계산 로직  
    if(targetX+targetWidth-10<myCharacterX && targetX+targetWidth+10 >myCharacterX){
        if((targetX+targetWidth) > myCharacterX && (targetY+targetHeight)>myCharacterY &&myCharacterY>(targetY-characterHeight)){
            return 'rigth';
        }
    }
    //위쪽 충돌 _ 계산 로직
    if(targetY+targetHeight-10<myCharacterY && targetY+targetHeight+10 >myCharacterY){
        if((targetY+targetHeight) > myCharacterY && (targetX+targetWidth)>myCharacterX &&myCharacterX>(targetX-characterWidth)){
            return 'top';
        }
    }
    //아래쪽 충돌 _ 계산 로직
    if((myCharacterY-characterHeight-10)<myCharacterY && myCharacterY <(targetY-characterHeight+10)){
        if((myCharacterY+characterHeight) > targetY && (targetX+targetWidth)>myCharacterX &&myCharacterX>(targetX-characterWidth)){
            return 'bottom';
        }
    }
                       
}



//다이아몬드 그리는 메소드
//drowDiamond(다이아몬드 한개의 이미지,그려질 정보를 담은 4개의 배열[X좌표,Y좌표,가로길이,세로길이],다이아몬드 고유숫자,나타냄여부_캐릭터가 보석을 습득했을경우 보여지지않음)
function drawDiamond(diamondImg,diamondPositionArr,diamondId,showOrhide){
	  if(showOrhide){
	        ctx.drawImage(diamondImg,
			        		diamondPositionArr[0],
			        		diamondPositionArr[1],
			        		diamondPositionArr[2],
			        		diamondPositionArr[3]
			        		)
	        var state = targetCrash(diamondPositionArr[0] ,diamondPositionArr[1],
	        			 	diamondPositionArr[2],diamondPositionArr[3],diamondId);  
	        if(state != null){
	        	console.log("asdasdasd");
	          	var arrNo = this.diamondId.indexOf(diamondId);
	             diamondState[arrNo]=false;
	             getDiamondAjax(diamondId)
	        }
	        
	  }else{
		  return;
	  }
}


//벽돌(or배경) 그리는 메소드
//drowBrick(벽돌한개의 이미지,2중 배열_가로*세로 그려질 위치 파악 ,충돌체크 여부_boolean값_true:충돌있음_fasle:충돌없음))
function drawBrick(brickImg,positionArr,crash_Or_NoCrash) {
	  
    for(var h=0 ; h < canvasHeight/standardLength ;h++){
        for(var w=0; w< canvasWidth/standardLength ; w++) {
           var brickX = w*standardLength,// 그려질 벽돌(or배경)의 X좌표
          	   brickY = h*standardLength,// 그려질 벽돌(or배경)의 Y좌표
           	   brickWidth = standardLength,//그려질 벽돌(or배경)의 가로길이
          	   brickHeight = standardLength;//그려질 벽돌(or배경)의 세로길이
        
           if(positionArr[h].includes(w)){
                ctx.drawImage(brickImg,brickX ,brickY ,standardLength,standardLength);
                //매직 볼 충격 검사
                if(magicBallExistence){
                	if(magicBallLocation[0]>brickX && magicBallLocation[0]<(brickX +standardLength)
                				&& magicBallLocation[1]>brickY&& magicBallLocation[1]<(brickY +standardLength)){
                		clearTimeout(magicballTimeout);
                		magicBallExistence = false;
                		console.log("asdasdasdasdas");
                	}
                }
                if(crash_Or_NoCrash){
                	var state = targetCrash(brickX ,brickY,brickWidth,brickHeight);
                	if(state != null){
                		switch (state){
	               		    case 'left':
	               		   			  myCharacterX -= myCharacterSpeed;
	               		        break;
	               		    case 'rigth':
	               		   			  myCharacterX += myCharacterSpeed;
	               		        break;
	               		    case 'top':
	               		  			   myCharacterY += myCharacterSpeed;
	               		        break;
	               		    case 'bottom':
	               		  			   myCharacterY -= myCharacterSpeed;
	               		        break;
	               		    default :
	               		       		console.log("error");
                		}//switch()    
               		}//if()
                }//if()
            }//if()    
        }//for()
    }//for()
}//drawBrick()



//내 캐릭터 움직이는 로직, 
//방향키가 모두 안눌렸있다면 정면 그림
function drawMyCharacter(){
   // ctx.drawImage(myCharacterImg,,0,0,35,54) 
   //자르는 시작x, 시작 y, 길이x, 길이, y , 캐릭터 위치x, 위치y , 사진 사이즈 x, 사이즈 y)
    if(!rightPressed && !leftPressed && !downPressed & !upPressed){
    	stopMotion()
    }else if(rightPressed) {
        myCharacterX += myCharacterSpeed;
        rigthMotion();
    }
    else if(leftPressed) {
        myCharacterX -= myCharacterSpeed;
        leftMotion()

    }else if(downPressed) {
        myCharacterY += myCharacterSpeed;
        downMotion()

    }
    else if(upPressed) {
        myCharacterY -= myCharacterSpeed;
        upMotion()

    } 
}

var ddddddd =false;
//몬스터 그리는 메서드, 몬스터 정보는 전역변수로 각 페이지에서 받아 온다, 각 페이지 타일즈 선언으로 인하여. 

var life =${memberDto.life};


//몬스터 죽었을때 실행: 피,시체,아이템 떨군다.
function monsterDieMotion(no){
	ctx.drawImage(design2Img,128,95,32,32,monsterX[no] ,monsterY[no],40,40)
    ctx.drawImage(bloodImg,monsterX[no]+5,monsterY[no]+5,40,40);
   
}



function drawMonster(no){
	if(monsterDeath[no]){
    	monsterDieMotion(no);
    	return;
	}
 	//몬스터 레벨에따라 생명령 다르게
    var remainingLife=basicMonsterLife[no]-(basicMonsterLife[no] - monsterLife[no]);
    if (remainingLife <= 0){
    	monsterDeath[no] = true;
    	deathMonsterAjax(no);
    }
    var percentageOfLife = remainingLife / basicMonsterLife[no] * 50

	ctx.fillStyle = "#000000";
    ctx.fillRect(monsterX[no],monsterY[no]-20, 50, 5)
    ctx.fillStyle = "#af2e2e";
    ctx.fillRect(monsterX[no],monsterY[no]-20, percentageOfLife, 5)
    
    if(magicBallExistence){
    	if(magicBallLocation[0]>monsterX[no] && magicBallLocation[0]<(monsterX[no]+monsterWidth)
    				&& magicBallLocation[1] > (monsterY[no]-magicBallLocation[3]) && magicBallLocation[1]<(monsterY[no]+monsterHeight)){
    		clearTimeout(magicballTimeout);
    		magicBallExistence = false;
    		console.log("볼에 몬스터가 맞았다.");
    		monsterLife[no] =monsterLife[no]-1;
    		if(magicBallAttackdirection == "right"){
    			monsterX[no] += 50;
    		}else if(magicBallAttackdirection == "left"){
    			monsterX[no] -= 50;
    		}else if(magicBallAttackdirection == "up"){
    			monsterY[no] -= 50;
    		}else{
    			monsterY[no] += 50;
    		}
    	}
    }
    
   
    
     if(monsterPosition[no] == 'width'){   
	     monsterX[no] += monsterSpeed[no];
	     if(monsterX[no] > monsterLimitEnd[no]){
	       monsterSpeed[no] = -2;
	       monsterLocation[no] = [0,32,30,32];
	     }if(monsterX[no] < monsterLimitStart[no]){
	       monsterLocation[no] = [0,64,30,32];
	       monsterSpeed[no] = 2;
	     }
     }else if(monsterPosition[no] == 'height'){
    	 
	       monsterY[no] += monsterSpeed[no];
	     if(monsterY[no] > monsterLimitEnd[no]){
	         monsterSpeed[no] = -2;
	     	 monsterLocation[no] = [0,96,30,32];
	     }if(monsterY[no] < monsterLimitStart[no]){
	         monsterSpeed[no] = 2;
	    	 monsterLocation[no] = [0,0,30,32];
	     }
     }else{
    	 console.log('drawMonster() error')
    	 return;
     }
   
     ctx.drawImage(monsterImg,monsterLocation[no][0],monsterLocation[no][1],monsterLocation[no][2],monsterLocation[no][3]
     					,monsterX[no] ,monsterY[no] ,monsterWidth,monsterHeight);
     

     //몬스터와 충돌할 시에 50칸 뒤로 물러나고, 일정시간 배경이 암전된다.
     var state = targetCrash(monsterX[no] ,monsterY[no],monsterWidth,monsterHeight);
  	 if(state != null){
  		 //공격 당한후 0.5 초 동안 타격을 받지 않도록
  		 if(!attackExistence){
  			life = life -1;
  			//$("lifeCount").html(life)
  			//console.log($("#lifeCount").html())
  			$("#lifeCount").html(life)
	  		attackExistence =true;
	  		monsterAttackTimeCheck();
  		 }	 
  		 switch (state){
   		    case 'left':
   		    	myCharacterX -= 60;
   		    	
             //	LanternCheck = true;
   		        break;
   		    case 'rigth':
	   		    myCharacterX += 60;
	   		    
	          //  LanternCheck = true;
   		        break;
   		    case 'top':
   		    	myCharacterY += 60;
   	         //   LanternCheck = true;
   		        break;
   		    case 'bottom':
   		    	myCharacterY -= 60;
   	         //   LanternCheck = true;
   		        break;
   		    default :
   		    	console.log('drawMonster() error');
		}//switch()    
	}//if() 
}//drawMonster()






//키 눌림 체크용 눌리면 - true로 이벤트 작동 -떨어질 때 다시 false 
document.addEventListener("keydown", keyDownHandler, false);
document.addEventListener("keyup", keyUpHandler, false);

function keyDownHandler(e) {
    if(e.keyCode == 39) {
        rightPressed = true;
    }
    else if(e.keyCode == 37) {
        leftPressed = true;
    }

    if(e.keyCode == 40) {
         downPressed = true;
        }
    else if(e.keyCode == 38) {
          upPressed = true;
    }
    
}

function keyUpHandler(e) {
    if(e.keyCode == 39) {
        rightPressed = false;
    }
    else if(e.keyCode == 37) {
        leftPressed = false;
    }
    else if(e.keyCode == 40) {
         downPressed = false;
    }
    else if(e.keyCode == 38) {
         upPressed = false;
   }
}

var magicBallDiameter = 30;
var magicBallAttackdirection ="";
$(document).keydown(function(e){
    //컨트롤 누르고 엔터
    if(!magicBallExistence){
		if(e.which == 39 && e.ctrlKey){
				magicBallAttackdirection = "right";	
				magicBallLocation =[myCharacterX+characterWidth,myCharacterY+(characterHeight/2)-(magicBallDiameter/2),30,30]
				magicBallXspeed = 3;
				magicBallYspeed = 0;
				magicBallExistence =true;
				magicballTimeCheck()
			
		}else if(e.which == 37 & e.ctrlKey){
				magicBallAttackdirection = "left";
				magicBallLocation =[myCharacterX,myCharacterY+(characterHeight/2)-(magicBallDiameter/2),30,30]
				magicBallXspeed = -3;
				magicBallYspeed = 0;
				magicBallExistence =true;
				magicballTimeCheck()
		}else if(e.which == 40 & e.ctrlKey){
				magicBallAttackdirection = "down";
				magicBallLocation =[myCharacterX+(characterWidth/2)-(magicBallDiameter/2),myCharacterY+characterHeight,30,30]
				magicBallXspeed = 0;
				magicBallYspeed = 3;
				magicBallExistence =true;
				magicballTimeCheck()
		}else if(e.which == 38 & e.ctrlKey){
				magicBallAttackdirection = "up";
				magicBallLocation =[myCharacterX+(characterWidth/2)-(magicBallDiameter/2),myCharacterY,30,30]
				magicBallXspeed = 0;
				magicBallYspeed = -3;
				magicBallExistence =true;
				magicballTimeCheck()
		}
    }	
});


//
var magicBallExistence =false;
var magicBallLocation =[myCharacterX+50,myCharacterY+20,30,30]
var magicBallXspeed = 3;
var magicBallYspeed = 0;


function launchMagicBall(){
	magicBallLocation[0] = magicBallLocation[0]+magicBallXspeed;
	magicBallLocation[1] = magicBallLocation[1]+magicBallYspeed;
	ctx.drawImage(magicBallImg,magicBallLocation[0],magicBallLocation[1],magicBallLocation[2],magicBallLocation[3]);	
}

var magicballTimeout =null;
function  magicballTimeCheck(){
	
	magicballTimeout = setTimeout(function() {
		  console.log('check');
		  magicBallExistence =false;  
	}, 2000);
	
}


var attackExistence =false;
var attackLocation = [myCharacterX-3,myCharacterY-3,30,30]


function monsterAttack(){
	  attackLocation = [myCharacterX-3,myCharacterY-3,30,30]
	  ctx.drawImage(attackImg,attackLocation[0],attackLocation[1],attackLocation[2],attackLocation[3]);
}

function  monsterAttackTimeCheck(){
	
	setTimeout(function() {
		
		  attackExistence =false;
	}, 400);
}




//인터벌. 0.01초단위로 그림이 그려짐


//1]배경_바닥 메소드, 가장 첫번째로 캔버스에 표시되는 이미지 
//background에 반복 될 이미지를 매개변수로 전달한다.
//이미지는 캔버스 전체화면에 그려지게 되고,
//기준이 되는 이미지 한면의 길이와 캔버스 길이는 전역변수값을 받는다.
//이미지가 그려지는 x좌표와 y좌표가 2중 for 문을 돌면서 기준길이 값을 기준으로 옮겨 가므로 그려질 수 있다.
function drawBackground(backgroundImg){
	for(var h=0 ; h < canvasHeight/standardLength ;h++){
	    for(var w=0; w< canvasWidth/standardLength ; w++) {
	
	        var backgroundX = w*standardLength;
	        var backgroundY = h*standardLength;
	
	        ctx.drawImage(backgroundImg,backgroundX ,backgroundY,standardLength,standardLength);
	
	    }
	}
}


//다이아몬드 true/false 상채
var diamondState = [];
var diamondNo = [];
console.log(diamondState);
console.log(diamondNo);
<c:if test="${!empty diaList}">
	 <c:forEach var="item" items="${diaList }">
	 console.log("??");
	  diamondState.push(${item.state});
	  diamondNo.push(${item.no});
	</c:forEach>
</c:if>



function getDiamondAjax(diamondId){
	console.log("번호"+diamondId)
	$.ajax({
		url:"<c:url value="/map/diamond/get"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		dataType:'text',//서버로 부터 응답 받을 데이타의 형식 설정
		data:"diamondId="+diamondId,
		success:function(data){
		 	//console.log('성공:',data);
		 	//여기서 + 처리 해주는게 아닌가
			var diaCount = $("#diamondCount").html()
			diaCount++;
			$("#diamondCount").html(diaCount);
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}

function getItemAjax(itemId){
	console.log("번호"+itemId)
	$.ajax({
		url:"<c:url value="/map/item/get"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		dataType:'text',//서버로 부터 응답 받을 데이타의 형식 설정
		data:"itemId="+itemId,
		success:function(data){
		 	
			console.log("성공")
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}




function deathMonsterAjax(no){
	
	$.ajax({
		url:"<c:url value="/map/monster/death"/>",//요청할 서버의 URL주소
		type:'get',//데이타 전송방식(디폴트는 get방식) 
		dataType:'text',//서버로 부터 응답 받을 데이타의 형식 설정 응답 : 죽은 몬스터 id 값
		data:"monsterId="+monsterId[no]+"&monsterX="+monsterX[no]+"&monsterY="+monsterY[no],
		success:function(data){
		 	console.log('성공 : ',data);
		},
		error:function(error){//서버로부터 비정상적인 응답을 받았을때 호출되는 콜백함수
			console.log('에러 : ',error.responseText);
		}	
	});
}



//캐릭터 모션
function stopMotion(){
ctx.drawImage(myCharacterImg,
        myCharacterStopImgLocation[0],
        myCharacterStopImgLocation[1],
        myCharacterStopImgLocation[2],
        myCharacterStopImgLocation[3],
        myCharacterX, myCharacterY,
        characterWidth,characterHeight);  
}
function rigthMotion(){
	ctx.drawImage(myCharacterImg,
            myCharacterRightImgLocation[0],
            myCharacterRightImgLocation[1],
            myCharacterRightImgLocation[2],
            myCharacterRightImgLocation[3],
            myCharacterX ,myCharacterY,
            characterWidth,characterHeight);
}
function upMotion(){
	 ctx.drawImage(myCharacterImg,
             myCharacterUpImgLocation[0],
             myCharacterUpImgLocation[1],
             myCharacterUpImgLocation[2],
             myCharacterUpImgLocation[3],
             myCharacterX ,myCharacterY,
             characterWidth,characterHeight);
}
function downMotion(){
	 ctx.drawImage(myCharacterImg,
             myCharacterDownImgLocation[0],
             myCharacterDownImgLocation[1],
             myCharacterDownImgLocation[2],
             myCharacterDownImgLocation[3],
             myCharacterX,myCharacterY,
             characterWidth,characterHeight);
}
function leftMotion(){
	ctx.drawImage(myCharacterImg,
            myCharacterLeftImgLocation[0],
            myCharacterLeftImgLocation[1],
            myCharacterLeftImgLocation[2],
            myCharacterLeftImgLocation[3],
            myCharacterX,myCharacterY,
            characterWidth,characterHeight);
}
	


var interval = setInterval(draw, 10);
</script>