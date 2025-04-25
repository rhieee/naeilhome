<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%>     
<!-- style="text-decoration-line:none" -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$(document).ready(function(){
     $('.nav1_ul_li').mouseenter(function(){
        $(this).children('.sub-ul').children('.sub-ul_li').stop().slideDown(400);
    });
      $('.nav1_ul_li').mouseleave(function(){
        $(this).children('.sub-ul').children('.sub-ul_li').stop().slideUp(400);
    });
});
</script>
<style>
.nav1{
    position: relative;
}
.nav1_ul{
    display: flex;
    justify-content: center; /* 가로 방향 중앙 정렬 */
    width: 100%;
}
.nav1_ul_li {
    list-style: none;
    text-align: center;
    position: relative;
    height: 20px; /* 서브메뉴 뜨는 높이 */
    margin: 5px 50px 5px 50px;
    padding: 0px;
    padding-bottom: 5px;
}
.sub-ul{display: flex;
    position: absolute;
    top: 100%;
    transform: translateX(-50%); /* 서브메뉴 위치 조정 */
    width: max-content;
}
.sub-ul_li {
    list-style: none;
    text-align: center;
}
.sub-ul_li {
    display: none;
    margin: 20px;
}
.nav1_ul_li_a, .sub-nav_a {
    color: black;
    text-decoration-line: none;
}
.nav1_ul_li:hover {
    border-style: solid;
    border-width: 0px 0px 2px 0px;
    border-color: #00A9FF;
}
.sub-nav_a:hover {
    color: #00A9FF;
}

a{
font-weight:bold;
}

body {
        font-family: Arial, sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        font-family: "BMJUA", "Noto Sans KR", sans-serif;
    }
    
.container {
        width: 100%;
        position: relative;
        margin-left: auto;
    	margin-right: auto;
    	min-width : 986px;
		max-width : 986px;
    }
    
li{
	font-weight:bold;
}

.imageCircle img {
    margin-top: 50px;
    width: 200px;
    height: 200px;
    border-radius: 50%; /* 동그라미 만들기 */
    object-fit: fill; /* 우겨 넣기 */
    /* object-fit: cover;  */ /* 자르기 */
    border: 1px solid #ccc;
}

.imageCircle img:hover {
	cursor: pointer;
	 opacity: 0.3;
}

#memberModify{
	min-width : 500px;
	max-width : 500px;
	margin-left: auto;
	margin-right: auto;
}

#memberModify p{
	font-weight: bold;
	text-align: left;
}

#memberPhone1, #memberPhone2, #memberPhone3{
width: 155px;
}

#phone{
width:101.6%;
display: flex;
  justify-content: space-between;
  align-items: center;
  margin-left: auto;
  margin-right: auto;
}

#authentication{
background-color: #00A9FF; 
color: white;
	width: 130px; 
    height: 45px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 0px;
    margin-left:8px;
}

#authentication:hover {
    background-color: #008ED6;
	color: white;
    cursor: pointer;
}



#phone input{
	width: 200px; 
    height: 45px;
    font-size: 16px;
    border: 1px solid #ccc;
}

#email{
width: 507px;
display: flex;
  justify-content: space-between;
  align-items: center;
  margin-left: auto;
  margin-right: auto;
}

#memberEmail1, #memberEmail2{
width: 231px;
}

input {
width:100%;
height: 45px;
border-radius: 5px;
border: 1px solid #ccc;
}

#memberModifySelect{
	margin-top:10px;
	display: flex;
    flex-direction: column;
    align-items: flex-start;
}

#memberModifySelect a{
margin-bottom:5px;
}

#complete{
 align-self: center;
}

#complete{
margin-left:5px;
	width:507px;
	height: 45px;
	background-color: #00A9FF; 
    color: white;
    border: none;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: 5px; 
    cursor: pointer;
    transition: background-color 0.3s;
    margin-bottom:100px;
}

#complete:hover{
    background-color: #008ED6;
}

#chk_zip {
    display: flex; 
    align-items: center;
    width:103.5%;
}
#chk_zip a {
    margin-right: 10px; 
}

#chk_zip input{
	width:100%;
	height: 45px;
	border-radius: 5px;
	border: 1px solid #ccc;
	margin-right:10px;
}

#chk_zip button {
    width: 130px; 
    height: 45px;
    font-size: 16px;
    border: 1px solid #ccc;
}

#chk_zip button:hover {
    background-color: #008ED6;
    cursor: pointer;
}

#selectEmail2{
	width: 130px; 
    height: 45px;
    font-size: 16px;
    border: 1px solid #ccc;
}

#memberPhone1{
	width: 50px; 
    height: 45px;
    font-size: 16px;
    border: 1px solid #ccc;
}

#adress {
color: white;
width: 150px; 
height: 45px;
color: white;
font-size: 16px;
border: 1px solid #ccc;
background-color: #00A9FF; 
text-align: center;
display: inline-block; /* inline-block으로 설정 */
line-height: 45px; /* 높이와 동일하게 설정하여 수직 중앙 정렬 */
text-decoration: none; /* 링크의 밑줄 제거 (선택 사항) */
font-weight: normal;
}

#adress:hover {
background-color: #008ED6;
color: white;
font-weight: normal;
}

#memberModifySelect a{
	cursor: pointer;
}

.mailCheck {
	display: flex;
    align-items: center;
    justify-content: flex-start;
}

.checkBtn{
	background-color: #00A9FF;
	border-radius: 5px; 
	border:none; 
	color: white;
	width:507px;
	height: 45px;
	font-size: 16px;
	margin-top: 10px;
}

#mailCheckBtn{
	background-color: #00A9FF;
	border-radius: 5px; 
	border:none; 
	color: white;
}

#mailCheckBtn:hover, .checkBtn:hover{
    background-color: #008ED6;
}

#originProfile:hover{
	color: rgba(0,0,0);
}

#originProfile{
	background-color: transparent; /* 배경색 제거 */
    color: rgba(0,0,0,0.5);
    border: none;
    padding: 0px; /* 패딩 제거 */
    margin:0px;
    text-align: center;
    text-decoration: none;
    font-size: 16px;
    cursor: pointer;
    width:85px;
}

</style>
<script>

//중복확인용 변수들
var msg1, msg2, usable, not_usable;
var result1 = true; // 닉네임 상태 (true: 사용 가능, false: 사용 불가)
var InputEmail1StatusCheck = true; // email1 입력 상태
var InputEmail2StatusCheck = true; // email2 입력 상태
var checkZip = true; // 우편번호 입력 상태
var emailAuth = true; // 이메일 인증 상태
var phoneCheck = true; // 휴대폰 중복 확인

//닉네임 중복 확인 (실시간)
function nickNameCheck() {
    var nickName = document.getElementsByName("memberNickName")[0].value;
    msg1 = document.getElementById('nickMsg1');
    msg2 = document.getElementById('nickMsg2');
    
    if(nickName != `${member.memberNickname}`){
    if (nickName.length < 2 || nickName.length > 10) {
        msg1.innerText = '2 ~ 10 글자만 가능합니다.';
        msg2.innerText = "";
        result1 = false;
        disableSubmitButton();
    } else { 
        $.ajax({
            url: '/member/nickNameCheck.do',
            method: 'post',
            data: { 'nickName': nickName },
            dataType: 'json',
            success: function(data) {
                result1 = (data.result === "true");
                
                if (result1 === false) {
                    not_usable = '중복되는 닉네임입니다.';
                    msg2.innerText = "";
                    msg1.innerText = not_usable;
                    result1 = false;
                } else {
                    usable = '사용가능한 닉네임입니다.';
                    msg1.innerText = "";
                    msg2.innerText = usable;
                    result1 = true;
                }
            },
            error: function() {
                alert('error');
            }
        });
    }
}else{
	msg2.innerText = "";
	msg1.innerText = "";
	result1 = true;
}
}

// 우편번호 검색 API
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullRoadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            if (fullRoadAddr !== '') {
                fullRoadAddr += extraRoadAddr;
            }

            document.getElementById('memberZip1').value = data.zonecode;
            document.getElementById('memberZip2').value = fullRoadAddr;
        }
    }).open();
};

// 이메일 칸 건드리면 false로 변경
function resetEmailAuth(){
	emailAuth = false;
}

//핸드폰 중복검사
function checkPhone() {
    var phone1 = document.getElementById('memberPhone1').value;
    var phone2 = document.getElementById('memberPhone2').value;
    var phone3 = document.getElementById('memberPhone3').value;
    var phone = phone1 + phone2 + phone3;

    var phoneChcek = `${member.memberPhone1}` + `${member.memberPhone2}` + `${member.memberPhone3}`;
    
    if(phoneChcek != phone){
    $.ajax({
        url: '/member/phoneCheck.do',
        method: 'post',
        data: { 'phone': phone },
        dataType: 'json',
        success: function(data) {
        	
            console.log(data); // 서버 응답 확인
            const phoneCheck = (data.result === "TRUE");
            const phoneMsg = document.getElementById('phoneMsg');
            
            if (phoneCheck === false) {
                phoneMsg.textContent = "이미 가입된 번호입니다.";
                phoneCheck = false;
                
            } else {
                phoneMsg.textContent = ""; // true일 때 메시지 제거
                phoneCheck = true;
            }
        },
        error: function() {
            alert('error');
        }
    });
    }else{
        phoneCheck = true;
    }
}

//이메일 도메인 선택/직접입력
function choiceEmail(value){
	if(value === '직접입력'){
		document.getElementsByName("memberEmail2")[0].value = "";
		document.getElementsByName("memberEmail2")[0].readOnly = false;
	} else {
		document.getElementsByName("memberEmail2")[0].value = value;		
		document.getElementsByName("memberEmail2")[0].readOnly = true;
		document.getElementById('emailMsg1').innerText = ""; // 도메인 선택했으면 경고메시지 초기화
		document.getElementById('emailMsg2').innerText = "";		
	}
	if(document.getElementsByName("memberEmail2")[0].value != ""){InputEmail2StatusCheck = true;}
	else{InputEmail2StatusCheck = false;}
};

// 최종검사

document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementsByTagName('form')[0];

    function updateMember(event) {
    	
    	var social = `${member.memberEmail2}`;
    	
        if(social != 'social'){
        var email1 = document.getElementById('memberEmail1').value;
        var email2 = document.getElementById('memberEmail2').value;
        var email = email1 + email2;
        var emailCheck = `${member.memberEmail1}` + `${member.memberEmail2}`;
        
        
        if(emailCheck === email){
        	emailAuth = true;
        }
        
        // 이메일 인증 상태 확인
        if (!emailAuth) {
            alert('이메일 인증을 해주세요.');
            return false; // 이메일 인증이 완료되지 않았으면 폼 제출 안 됨
        }
        }
        
        var phone1 = document.getElementById('memberPhone1').value;
        var phone2 = document.getElementById('memberPhone2').value;
        var phone3 = document.getElementById('memberPhone3').value;

        // 정규 표현식을 사용하여 4자리 숫자 확인
        const regex = /^[0-9]{4}$/;

        if (!regex.test(phone2) || !regex.test(phone3)) {
            alert('전화번호는 4자리 숫자여야 합니다.');
            return false;
        }
        
        if (!phone1 || !phone2 || !phone3) {
            alert('전화번호를 입력해 주세요.');
            return false;
        }
        

        if ((phoneCheck === true && result1 === true) &&
        	(InputEmail1StatusCheck && InputEmail2StatusCheck) &&
        	(checkZip && emailAuth)) {
        	
            $("#memberModifyForm").submit(); // 모든 필드가 유효하면 폼 제출
	        } else {
            alert('입력 정보를 확인해 주세요.');
            let tagId;

            // 문제 있는 곳 표시 및 부드럽게 스크롤
            if (!InputEmail1StatusCheck) {
                tagId = document.getElementById('email');
                tagId.scrollIntoView({ behavior: "smooth" });
            } else if (!InputEmail2StatusCheck) {
                tagId = document.getElementById('email');
                tagId.scrollIntoView({ behavior: "smooth" });
            } else if (!checkZip) {
                tagId = document.getElementById('zip');
                tagId.scrollIntoView({ behavior: "smooth" });
            } else if (!emailAuth) {
                tagId = document.getElementById('email');
                tagId.scrollIntoView({ behavior: "smooth" });
            }
            if (result1 === false) {
                tagId = document.getElementById('nickName');
                tagId.scrollIntoView({ behavior: "smooth" });
            }

            return false; // 폼 제출 방지
        }
    }

    
    // 폼 제출 버튼 클릭 시 이벤트 실행
    document.getElementById('complete').addEventListener('click', function(event) {
        event.preventDefault(); 
        updateMember(event);  
    });
});


// 프로필 사진 변경 관련
function profileImage(){
    	if (confirm("프로필 사진을 변경하시겠습니까?") == true){  
    		$('#imagesButton').val('');
    		$('#imagesButton').click();
    	 }else{
    		 return false;
    	 }
     }
     
     let data = {
    		    boardMyhomeArticleNo: `${selectMyHome.boardMyhomeArticleNo}`,
    		    memberId : `${member.memberId}`,
    		    isLogOn : `${isLogOn}`,
    		    member : `${member}`,    
    		};
     
// 이미지 업로드 (나중에 미리보기로 만들어볼까?)
document.addEventListener('DOMContentLoaded', function() {
	 document.getElementById("imagesButton").addEventListener("change", function() {
    	     if (this.files.length > 0) {
    	         var formData = new FormData();
    	         formData.append("file", this.files[0]);
    	         
    	         // 아이디 가져오기
    	         var memberId = data.memberId;
    	         
    	         // 경로 지정
    	         var src = '/memberProfileImage/' + memberId + '/';
    	         
    	         $.ajax({
    	     		 type: "POST",
    	              enctype: 'multipart/form-data',
    	              processData: false,
    	              contentType: false,
    	              url: "/member/memberProfileImageUpload.do",
    	              data: formData,
    	              dataType: "json",
    	              success: function(fileName) {
    	                  alert('프로필 사진이 변경되었습니다.');
    	              var fileName = fileName.fileName;
    	              var image = src + fileName;
    	              
    	              // img src 속성에 이미지 경로 넣어주기.
    	              $("#memberProfileImage").attr("src","");
    	              $("#memberProfileImage2").attr("src","");
    	              $("#memberProfileImage").attr("src",image);
    	              $("#memberProfileImage2").attr("src",image);
    	              $("#memberImage").val(fileName);
    	              },
    	              error: function(status) {
    	                  alert('사진 업로드 실패');
    	                  alert(status);
    	              }
    	          });
    	         
    	     } else {
    	         console.log("파일이 선택되지 않았습니다.");
    	     }
    	 });
    });			

function showPopupDelete() {
	var social = `${member.memberEmail2}`;
	
    if(social != 'socialNaver' && social != 'socialGoogle' && social != 'kakaoSocial'){
	window.open("memberDeletePwd.do", "비밀번호 확인", "width=600, height=600, left=711, top=100]"); 
    }else{
    window.location.href = '/member/memberDeleteLastCh.do';	
    }
	}

function showPopupPwd() {
	window.open("changePassword.do", "비밀번호 수정", "width=600, height=600, left=711, top=100]"); 
	}
	
//기본 프로필로 변경
function originProfileCh(){
	
	$("#memberImage").val("");
	$("#memberProfileImage").attr("src","/resources/image/mypage.png");
	$("#memberProfileImage2").attr("src","/resources/image/mypage.png");
	
}
		
</script>
</head>
<body>
<nav class="nav1">
  <ul class="nav1_ul">
    <li class="nav1_ul_li">프로필
        <ul class="sub-ul">
            <li class="sub-ul_li"><a href="/mypage/myhome/myPageMyHomeList.do" class="sub-nav_a">나의 게시글</a></li>
            <li class="sub-ul_li"><a href="/mypage/bookmark/bookMarkList.do" class="sub-nav_a">북마크</a></li>
            <li class="sub-ul_li"><a href="/mypage/like/likeList.do" class="sub-nav_a">좋아요</a></li>
        </ul>
    </li>
<li class="nav1_ul_li">나의 쇼핑
        <ul class="sub-ul">
            <li class="sub-ul_li"><a href="/mypage/delivery/deliveryList.do" class="sub-nav_a">주문배송목록</a></li>
            <li class="sub-ul_li"><a href="/mypage/wishlist/wishList.do" class="sub-nav_a">상품 찜 목록</a></li>
            <li class="sub-ul_li"><a href="/mypage/point/pointList.do" class="sub-nav_a">포인트</a></li>
            <li class="sub-ul_li"><a href="/review/myReviewList.do" class="sub-nav_a">나의 리뷰</a></li>
        </ul>
    </li class="nav1_ul_li"> 
    <li class="nav1_ul_li"><a style="color:#00A9FF;" href="/member/memberModifyForm.do" class="nav1_ul_li_a">설정</a></li>
    <li class="nav1_ul_li"><a href="/board/board_question/myQuestionList.do" class="nav1_ul_li_a">문의내역</a></li>
  </ul>
</nav>





<div id="memberModify">
<form id="memberModifyForm" action="/member/memberUpdate.do" method="POST">

 <div class="imageCircle">
 	<c:if test="${member.memberImage==null}">
     <img id="memberProfileImage2" src="/resources/image/mypage.png" onclick="profileImage()"/><br> <!-- 프로필 사진 넣기 -->
     </c:if>
     
     <c:if test="${member.memberImage!=null}">
     <img id="memberProfileImage" src="/memberProfileImage/${member.memberId}/${member.memberImage}" onclick="profileImage()"/><br> <!-- 프로필 사진 넣기 -->
     </c:if>
     
     <input onchange="imageButtonCilck()" id="imagesButton" type="file" style="display:none;" accept="image/jpeg,image/jpg,image/png" />
     <input id="memberImage" name="memberImage" type="hidden" value='${member.memberImage}'/>
     
 </div>
     <input id="originProfile" type="button" value="이미지 삭제" onclick="originProfileCh()" />

 
 <!-- readonly : 값은 못바꾸지만 폼타고 전송됨.
 	  disabled : 값을 못바꾸지만 폼으로 전송도 안됨. -->
<c:if test="${member.memberEmail2 != 'socialNaver' && member.memberEmail2 != 'socialGoogle' && member.memberEmail2 != 'kakaoSocial'}">
<p>아이디</p>
<input style="font-size: 16px; color: rgba(0, 0, 0, 0.5);" type="text" name="memberId" value="${member.memberId}" readonly/>
</c:if>

<c:if test="${member.memberEmail2 == 'socialNaver' || member.memberEmail2 == 'socialGoogle' || member.memberEmail2 == 'kakaoSocial'}">
<input style="font-size: 16px; color: rgba(0, 0, 0, 0.5);" type="hidden" name="memberId" value="${member.memberId}" readonly/>
</c:if>

<p id="nickName">닉네임<b id="nickNameCheck"></b></p>
<input type="text" name="memberNickName" maxlength="10" onkeyup="nickNameCheck()" value="${member.memberNickname}" required/>
<p id="nickMsg1"></p>
<p id="nickMsg2"></p>



<c:if test="${member.memberEmail2 != 'socialNaver' && member.memberEmail2 != 'socialGoogle' && member.memberEmail2 != 'kakaoSocial'}">
<p style="display: flex; justify-content: space-between; align-items: center;">
    이메일<b id="emailCheck"></b>
    <button type="button" id="mailCheckBtn" onclick="mailCheck()">본인인증</button>
</p>

<!-- 이메일 입력란 -->
<div id="email">
<input id="memberEmail1" type="text" name="memberEmail1" onkeyup="deInputKo(event)" oninput="resetEmailAuth()" value="${member.memberEmail1}" required/>
&nbsp;@&nbsp;
<input id="memberEmail2" type="text" name="memberEmail2" onkeyup="deInputKo(event)" oninput="resetEmailAuth()" value="${member.memberEmail2}" required/>

<select style="margin-left:15px;" id="selectEmail2" onchange="choiceEmail(this.value)"> 
<option class="email2Select" value="직접입력">직접입력</option>
<option class="email2Select" value="gmail.com">gmail.com</option>
<option class="email2Select" value="naver.com">naver.com</option>
<option class="email2Select" value="daum.net">daum.net</option>
<option class="email2Select" value="yahoo.com">yahoo.com</option>
</select>
</div>
<p id="emailMsg1"></p>
<p id="emailMsg2"></p>

<!-- 메일 인증 -->
<div class="mailCheck" style="display:none;">
<div class="mailCheckBox">
<input class="mailCheckInput" placeholder="인증번호 6자리를 입력해주세요." maxlength="6">
<input class="checkBtn" onclick="authNumberCheck()" type="button" value="확인" style="display:none;"/>
</div>
</div>
</c:if>

<c:if test="${member.memberEmail2 == 'socialNaver' || member.memberEmail2 == 'socialGoogle' || member.memberEmail2 == 'kakaoSocial'}">
<input id="memberEmail1" type="hidden" name="memberEmail1" onkeyup="deInputKo(event)" oninput="resetEmailAuth()" value="${member.memberEmail1}" required/>
<input id="memberEmail2" type="hidden" name="memberEmail2" onkeyup="deInputKo(event)" oninput="resetEmailAuth()" value="${member.memberEmail2}" required/>
</c:if>


<p>전화번호</p>
<div id="phone">
    <select id="memberPhone1" name="memberPhone1" required> 
        <c:if test="${member.memberPhone1 != '010'}">
            <option class="phone1Select" value="010">010</option>
        </c:if>
        <c:if test="${member.memberPhone1 == '010'}">
            <option class="phone1Select" value="010" selected>010</option>
        </c:if>
        <c:if test="${member.memberPhone1 != '011'}">
            <option class="phone1Select" value="011">011</option>
        </c:if>
        <c:if test="${member.memberPhone1 == '011'}">
            <option class="phone1Select" value="011" selected>011</option>
        </c:if>
        <c:if test="${member.memberPhone1 != '016'}">
            <option class="phone1Select" value="016">016</option>
        </c:if>
        <c:if test="${member.memberPhone1 == '016'}">
            <option class="phone1Select" value="016" selected>016</option>
        </c:if>
    </select>
    &nbsp;<b>-</b>&nbsp;
    <input type="text" id="memberPhone2" name="memberPhone2" maxlength='4' oninput="this.value = this.value.replace(/[^0-9]/g, '')" value="${member.memberPhone2}" required onblur="checkPhone()"/>
    &nbsp;<b>-</b>&nbsp;
    <input type="text" id="memberPhone3" name="memberPhone3" maxlength='4' oninput="this.value = this.value.replace(/[^0-9]/g, '')" value="${member.memberPhone3}" required onblur="checkPhone()"/>
</div>
<p id="phoneMsg"></p>


<h2 id="zip" style="margin-top:50px;">주소</h2> 

<p>우편번호<b id="zipCheck"></b></p>
<div id="chk_zip">
<input type="text" id="memberZip1" name="memberZip1" readonly value="${member.memberZip1}" required/>
<a id="adress" href="javascript:execDaumPostcode()">우편번호 검색</a>
</div>

<p>도로명 주소</p>
<input type="text" id="memberZip2" name="memberZip2" readonly value="${member.memberZip2}" required/>

<p>상세주소</p>
<input type="text" id="memberZip3" name="memberZip3" value="${member.memberZip3}"/>


<div id="memberModifySelect">
<%-- <a style="margin-top:20px;" href="/member/memberDeleteLastCh.do">탈퇴하기 ></a> --%>

<c:if test="${member.memberEmail2 != 'socialNaver' && member.memberEmail2 != 'socialGoogle' && member.memberEmail2 != 'kakaoSocial'}">
<a style="margin-top:20px;" onclick="showPopupDelete();">탈퇴하기 ></a>
<a onclick="showPopupPwd();">비밀번호 수정 ></a>
</c:if>
<c:if test="${member.memberEmail2 == 'socialNaver' || member.memberEmail2 == 'socialGoogle' || member.memberEmail2 == 'kakaoSocial'}">
<a style="margin-top:20px;" onclick="showPopupDelete();">연동해제 ></a>
</c:if>
<button type="button" id="complete">수정</button>
</div>
</form>

</div>

</body>

<script>

//이메일 인증
function mailCheck() {
    const email1 = $('#memberEmail1').val();
    const email2 = $('#memberEmail2').val();
    const email = email1 + '@' + email2; // 이메일 수정
	const memberEmail1 = `${member.memberEmail1}`;
	const memberEmail2 = `${member.memberEmail2}`;
    const memberEmail = memberEmail1 + '@' + memberEmail2;
	
    // 이메일 유효성 검사
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
   if(email != memberEmail){
    if (emailRegex.test(email)) {
        $.ajax({
            type: 'POST',
            url: '/mail/mailCheck.do',
            data: {"memberEmail1": email1, "memberEmail2":email2 },
            dataType: 'json',
            success: function (data) {
                var useEmailCount = data.useEmailCount;
                
                if(useEmailCount == 0){
                	$(".mailCheckInput").attr('disabled', false);
                    $(".mailCheck").css("display","block");
                    $(".mailCheckInput").attr('required',true);
                    alert('인증번호가 발송되었습니다.');
                    
                } else{
                	
                    alert('중복된 이메일입니다.');
                }
            },
            error: function (error) {
            }
        });
    } else {
        alert("올바른 이메일을 입력해 주세요.");
    }
   }else{
	   alert("사용중인 이메일로는 변경하실 수 없습니다.");
   }
}

// 확인 버튼 활성화
$('.mailCheckInput').on('input', function() {
    const inputVal = $(this).val();
    if (inputVal.length === 6) { 
        $(".checkBtn").show();
        $(".checkBtn").attr("disabled", false);
    } else {
        $(".checkBtn").hide();
        $(".checkBtn").attr("readonly", true);
    }
});

// 인증번호 비교하러 서버로
function authNumberCheck() {
    const email1 = $('#memberEmail1').val();
    const email2 = $('#memberEmail2').val();
    const email = email1 + '@' + email2;
    const authNumber = $('.mailCheckInput').val(); // 인증번호 입력값 가져오기

    $.ajax({
        type: 'POST',
        url: '/mail/authNumberCheck.do',
        data: { email: email, authNumber: authNumber }, // 이메일 및 입력한 인증번호 전송
        
        success: function (data) {
        	
            $(".mailCheckInput").attr('readonly', true);
            $(".checkBtn").attr("readonly", true);
            $("#memberEmail1").attr("readonly", true);
            $("#memberEmail2").attr("readonly", true);
            $("#selectEmail2").attr("readonly", true);
            $(".mailCheck").css("display","none");
            $("#mailCheckBtn").hide();
            $("#mailCheckBtn").attr("readonly", true);
            
            console.log(data);
            alert('인증이 완료되었습니다.');
            
            emailAuth = true;
        },
        error: function (error) {
            console.log(error);
            alert('잘못된 인증번호 입니다.');
        }
    });
}

</script>
</html>