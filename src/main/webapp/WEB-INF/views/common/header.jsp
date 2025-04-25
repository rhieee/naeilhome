<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%> 

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
    <style>
body {
	margin:0px;
	margin-left:auto;
	margin-right:auto;
}

#container{
        width: 100vw;
}
#container22{
	min-width: 1357px;
  	max-width: 1357px;
}
#container33{
width: 100vw;
}

#container44{
	min-width: 1357px;
  	max-width: 1357px;
}
     
a{
	text-decoration: none;
	color: inherit;
}
li{
	padding-right:20px;
}
.searchForm input {
    width: 215px;
    height: 20px;
    font-size: 0.8rem;
    font-weight: 300;
    text-align: center;
    color: #8e8e8e;
    padding: 3px 10px 3px 26px;
    border: 1px solid #dbdbdb;
    border-radius: 3px;
    background-image: url("/resources/image/search.png");
    background-repeat: no-repeat;
    background-size: 25px;
    background-position: 10px center;
    outline: none;
    margin: 30px 10px 0px 0px;
    float: right;
}

.searchBarInput:focus {
	outline: none;
	width: 215px;
	text-align: left;
	background-image: none;
}


/* 카테고리 토글 */
.dropdown{
  position : relative;
  display : inline-block;
}

.dropbtn{
  border : 0px;
  margin: 0px;
  padding: 0px;
  height: 60px; /* 토글 열리고 안사라지게 하는 범위 */
  border-radius : 1px;
  background-color: white;
  font-weight: 400;
  font-size: 16px;
  color : black;
} 

.dropdown-content{
  display : none;
  position : absolute;
  z-index : 2; /*다른 요소들보다 앞에 배치*/
  border: 1px solid #ccc;
  background-color: white;
  width: 200px;
  top: 50px; /* 뜨는 위치 조정 - 0px 주면 배너이미지 위치랑 겹쳐져서 작동 잘 안됨 */
}

#category1, #category2, #category3, #category4, #category5, #category6, #category7, #category8, #category9 {
  display : block;
  width: 100%;
  text-decoration : none;
  color : rgb(37, 37, 37);
  font-size: 16px;
  font-weight: 500;
  padding : 12px 20px;
  border: none;
  background-color: white;
  cursor: pointer;
}

#category1:hover, #category2:hover, #category3:hover, #category4:hover, 
#category5:hover, #category6:hover, #category7:hover, #category8:hover, #category9:hover{
  background-color : #ececec
}

.dropdown:hover .dropdown-content {
  display: block;
}

.category1.selected{
    color: red;
}
/* 카테고리 토글 (끝) */

/* 자동완성 리스트 스타일  */
.ui-autocomplete {
    position: absolute;
    z-index: 1000;
    max-height: 200px;
    overflow-y: auto;
    overflow-x: hidden;
    background-color: white;
    border: 1px solid #ccc;
    padding: 0;
    margin: 0;
}

/* 각 항목 스타일 */
.ui-menu-item {
    list-style: none;
	padding :0px;
    cursor: pointer;
}

/* 기본 상태에서 선택/포커스 되었을 때 파란색 제거하고 흰색 배경 유지 */
.ui-menu-item-wrapper,
.ui-state-focus,
.ui-state-active {
    background-color: white !important;
    color: #000 !important;
    border: none !important;
}

/* 마우스 호버 시  색상 지정 */
.ui-menu-item:hover,
.ui-menu-item-wrapper:hover {
    background-color: #ececec !important;
    color: #333 !important;
}

</style>

<script>

/* 추가 됨. */
// 로그인 여부 가져오기
var isLogOn = `${isLogOn}`

if(isLogOn == 'true'){
	
let timeout;

// 세션 시간 만료 시 로그아웃 컨트롤러로 이동.
function resetTimer() {
	clearTimeout(timeout);
	timeout = setTimeout(logout, 1800000);
	// 3600000 한시간 설정
	// 1800000 30분 설정
	// 900000 15분 설정
	
	// 테스트할때 사용 하기.
	// 300000 5분 설정
	// 60000 1분 설정
}

function logout() {
	alert("세션이 종료되어 로그아웃하겠습니다.");
	window.location.href = '/member/logout.do'; // 로그아웃 처리 페이지로 이동
}

// 사용자 활동 감지
window.onload = resetTimer;
window.onmousemove = resetTimer;
window.onkeypress = resetTimer;

}

// 위시 리스트 버튼
function wishList(){
 
	var isLogOn = `${isLogOn}`;
	
	if (isLogOn == 'true' && isLogOn != null) {
		window.location.href = '/mypage/wishlist/wishList.do';		
    } else {
        // 비로그인 시 로그인 페이지로 이동 여부 묻고 확인 누르면 이동
        if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
            window.location.href = '/member/loginForm.do';
    }
  }  
}

// 북마크 버튼
function bookMark(){
 
	var isLogOn = `${isLogOn}`;
	
	if (isLogOn == 'true' && isLogOn != null) {
		window.location.href = '/mypage/bookmark/bookMarkList.do';		
    } else {
        // 비로그인 시 로그인 페이지로 이동 여부 묻고 확인 누르면 이동
        if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
            window.location.href = '/member/loginForm.do';
    }
  }  
}

// 장바구니 버튼 - 합본 후 추가
function basketMark(){
 
	var isLogOn = `${isLogOn}`;
	
	if (isLogOn == 'true' && isLogOn != null) {
		window.location.href = '/basket/myBasket.do';		
    } else {
        // 비로그인 시 로그인 페이지로 이동 여부 묻고 확인 누르면 이동
        if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
            window.location.href = '/member/loginForm.do';
    }
  }  
}

// 카테고리 타고 스토어 갔을 때 스토어 카테고리 빨간색 글씨 유지
function change_btn(event) {
	var btns = document.querySelectorAll(".category1");

	// 모든 버튼에서 'selected' 클래스를 제거
	btns.forEach(function(btn) {
		btn.classList.remove("selected");
	});

	// 클릭된 버튼에 'selected' 클래스를 추가
	event.currentTarget.classList.add("selected");

	// 클릭된 버튼의 값을 localStorage에 저장 - 웹에 데이터를 저장
	localStorage.setItem("selectedCategory", event.currentTarget.value);
};

// 페이지가 로드될 때, 저장된 값을 확인하여 해당 버튼에 'selected' 클래스 적용
window.onload = function() {
	var selectedCategory = localStorage.getItem("selectedCategory");
	var category1 = document.getElementById("find_category");
	var category = null;
	if(category1 != null){
		category.value;
	}
	
	if (!selectedCategory || category == ''){
		selectedCategory = "all";
	}
	
	if (selectedCategory) {
		var btns = document.querySelectorAll(".category1");
		btns.forEach(function(btn) {
			if (btn.value === selectedCategory) {
				btn.classList.add("selected");
			}
		});
	}
	localStorage.removeItem('selectedCategory');
};

</script>

<!-- 자동완성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script>
$(function(){
    $("#searchInput").autocomplete({
        source: function(request, response) {
            $.ajax({
                url: "/autoComplete.do",
                type: "GET",
                dataType: "json",
                data: { keyword: request.term },
                success: function(data) {
                    response(data);
                },
                error: function(xhr, status, error) {
                    console.error("자동완성 오류:", error);
                    response([]);
                }
            });
        },
        minLength: 1  // 최소 1글자 이상 입력할 때 자동완성 실행
    });
});

document.addEventListener("DOMContentLoaded", function() {
	var targetDate;
	var midnight;
    const banner = document.getElementById("signupBanner");
    const closeBtn = document.getElementById("bannerCloseBtn");
    /* const resetBtn = document.getElementById("resetBannerState"); */ // (확인용) 확인용3개 검색후 주석 제거시 localStorage 상태값 변경 가능 
    
    var closeTime = new Date(localStorage.getItem('closeTime')); // localStorage에 저장한 X버튼 눌럿을 때 시간
    var standardTime = new Date(localStorage.getItem('standardTime'));
    var now = new Date();
	if(closeTime.getYear() != 70){
	    if(standardTime < now){
	    	localStorage.removeItem('bannerClosed');
	        localStorage.removeItem('closeTime');
	        localStorage.removeItem('standardTime');
	        banner.style.display = "flex";
	    }		
	}
    
    
 	// 페이지 로드 시, localStorage에서 배너 닫힘 여부 확인
	if (localStorage.getItem('bannerClosed') === 'true') {
		banner.style.display = "none";
	}else{
		banner.style.display = "flex";
	}

	// 닫기 버튼 클릭 시: 배너 숨김 및 상태 저장
	closeBtn.addEventListener("click", function() {
	   banner.style.display = "none";
	   localStorage.setItem('bannerClosed', 'true');
	        
	   targetDate = new Date(); // 닫기버튼 눌렀을 때 시간
	   var nowTime = targetDate.getHours();
	   var nowMinute = targetDate.getMinutes();
	   var nowS = targetDate.getSeconds();
	   localStorage.setItem('closeTime', targetDate);
	   
	   midnight = new Date(); // 최상단 배너 다시 뜨게하는 기준 시간
	   midnight.setHours(targetDate.getHours() + 12); // 다음 자정으로 설정
	   localStorage.setItem('standardTime', midnight);
	});

 	// (확인용) 초기화 버튼 클릭 시: localStorage 상태 초기화 후 배너 다시 표시
    /* resetBtn.addEventListener("click", function() {
        localStorage.removeItem('bannerClosed');
        localStorage.removeItem('closeTime');
        localStorage.removeItem('standardTime');
        banner.style.display = "flex"; // 기본 display 상태로 변경 (필요에 따라 수정)
    }); */
});

function topBannerLink(){
    console.log(isLogOn == 'true');
    if(isLogOn == 'true'){
        location.href = "/";
    }else {
        location.href = "/member/memberForm.do";
    }
}

</script>

<title>헤더</title>
</head>
<body>
<!-- 최상단 배너 -->
<a href="#" onclick="topBannerLink()">
<div id="signupBanner" style="position: relative; background-color: #00A9FF; text-align: center; padding: 10px; display: none; align-items: center; justify-content: center; , margin-top:0px;">
    <span style="margin-right: 5px;"><img src="/resources/image/topbanner.png" style="width:25px;"/> </span>
    <b style="color:White">내일의 집 회원가입 시 1000포인트 지급!!</b>
    <!-- 닫기(X) 버튼 -->
</div>
</a>
    <button id="bannerCloseBtn" 
        style="position: absolute; top: 15px; right: 15px; cursor: pointer; background: none; border: none; font-size: 16px;"><b style="color:White">X</b></button>
    <!-- (확인용) 배너 상태 초기화 버튼 -->
    <!-- <button id="resetBannerState">배너 상태 초기화</button> -->
    
<div id="container">
<div id="container22">
<div style="width:100%;">
<table style="margin: 0 auto; width: auto;">
  <tr>
     <td style="text-align:left; width: auto;">
        <a href="/">
            <img src="/resources/image/naeilhomeLogo1.png"  width="200px" style="margin-top:30px;"/>
        </a>
     </td>
     
    <!-- 검색 -->
	<form action="/search.do" method="get">
		<td style="text-align:left; width:110%;">
			<div class="searchForm">
				<input class="searchBarInput" type="search" id="searchInput" name="keyword" style="width:300px; height:45px; border-style:solid; border-width:3px; border-color:#ebece8;"placeholder="검색" />
       		</div>
		</td>
	</form>
     
     <td style="text-align:left; vertical-align: bottom;">
      <a href="#" onclick="bookMark()">
            <img src="/resources/image/bookMark.png"  width="30px" style="margin-right:7px;"/>
        </a>
     </td>
     <td style="text-align:left; vertical-align: bottom;">
     <a href="#" onclick="wishList()">
            <img src="/resources/image/wishList.png"  width="30px" />
        </a>
     </td>
     <td style="text-align:left; vertical-align: bottom;">
     <a href="#" onclick="basketMark()" style="margin-left:4px;">
            <img src="/resources/image/basket.png"  width="30px"/> <!-- 합본 후 추가 -->
        </a>
     </td>
  </tr>
</table>  
</div>
</div>

<div id="container33">
<hr style="border : 0px; border-top : 3px solid #ebece8; "/>
</div>

<div id="container44">
<c:choose>
<c:when test="${isLogOn == true && member != null}">
<div style="display: flex; justify-content: space-between; align-items: center; width: 100%; height:50px;">
    <nav style="display: inline-block;">
        <ul style="list-style-type: none; display: flex; flex-wrap: nowrap; padding: 0; margin: 0;">
            <li>
	            <div class="dropdown">
		     		<button class="dropbtn">
		     		<h3>카테고리</h3>
		     		</button>
			        	<div class="dropdown-content">
			        	<form action="/product/productList.do" method="post">
					    	<button onclick="change_btn(event)" id="category1" class="category1" name="all" value="all">전체</button>
					    	<button onclick="change_btn(event)" id="category2" class="category1" name="category" value="가구">가구</button>
					    	<button onclick="change_btn(event)" id="category3" class="category1" name="category" value="가전">가전</button>
					    	<button onclick="change_btn(event)" id="category4" class="category1" name="category" value="데코/식물">데코/식물</button>
					    	<button onclick="change_btn(event)" id="category5" class="category1" name="category" value="생활용품">생활용품</button>
					    	<button onclick="change_btn(event)" id="category6" class="category1" name="category" value="수납/정리">수납/정리</button>
					    	<button onclick="change_btn(event)" id="category7" class="category1" name="category" value="조명">조명</button>
					    	<button onclick="change_btn(event)" id="category8" class="category1" name="category" value="주방용품">주방용품</button>
					    	<button onclick="change_btn(event)" id="category9" class="category1" name="category" value="패브릭">패브릭</button>
					    </form>
			        	</div>
	        	</div>
        	</li>
            <li><a href="/product/productList.do"><h3>스토어</h3></a></li>
            <li><a href="/board/board_myhome/myHomeList.do"><h3>커뮤니티</h3></a></li>
        </ul>
    </nav>

    <table style="white-space: nowrap;">
        <tr style="display: flex; align-items: center;">
            <td style="text-align: right;">
                <a href="/mypage/myhome/myPageMyHomeList.do">
                 <c:if test="${member.memberImage==null}">
    			 <img src="/resources/image/mypage.png" style="border-radius: 50%; width:35px; height:35px; object-fit: fill;"/> <!-- 프로필 사진 넣기 -->
 				</c:if>
 				<c:if test="${member.memberImage!=null}">
    			 <img src="/memberProfileImage/${member.memberId}/${member.memberImage}" style="border-radius: 50%; width:35px; height:35px; object-fit: fill;"/> <!-- 프로필 사진 넣기 -->
 				</c:if>
                </a>
            </td>
            <td style="padding-right: 20px;">
                <a href="/mypage/myhome/myPageMyHomeList.do">
                    <h3 style="font-size: 18px; margin: 0;">${member.memberNickname}</h3>
                </a>
            </td>
            <td style="padding-right: 20px;">
                <a href="/member/logout.do"><h3 style="font-size: 18px; margin: 0;">로그아웃</h3></a>
                
           <%--  <c:if test="${member.memberEmail2 != 'social'}">
                <a href="/member/logout.do"><h3 style="font-size: 18px; margin: 0;">로그아웃</h3></a>
            </c:if>
            
            <c:if test="${member.memberEmail2 == 'social'}">
                <a href="/naver/logout.do"><h3 style="font-size: 18px; margin: 0;">로그아웃</h3></a>
            </c:if> --%>
            
            </td>
            <td style="text-align: right;">
                <a href="/board/board_question/FAQList.do"><h3 style="font-size: 18px; margin: 0;">고객센터</h3></a>
            </td>
        </tr>
    </table>
</div>
</c:when>

<c:otherwise>
<div style="display: flex; justify-content: space-between; align-items: center; width: 100%; height:50px;">
    <nav style="display: inline-block;">
        <ul style="list-style-type: none; display: flex; flex-wrap: nowrap; padding: 0; margin: 0;">
            <li>
            	<div class="dropdown">
		     		<button class="dropbtn">
		     		<h3>카테고리</h3>
		     		</button>
			        	<div class="dropdown-content">
			        	<form action="/product/productList.do" method="post">
					    	<button onclick="change_btn(event)" id="category1" class="category1" name="all" value="all">전체</button>
					    	<button onclick="change_btn(event)" id="category2" class="category1" name="category" value="가구">가구</button>
					    	<button onclick="change_btn(event)" id="category3" class="category1" name="category" value="가전">가전</button>
					    	<button onclick="change_btn(event)" id="category4" class="category1" name="category" value="데코/식물">데코/식물</button>
					    	<button onclick="change_btn(event)" id="category5" class="category1" name="category" value="생활용품">생활용품</button>
					    	<button onclick="change_btn(event)" id="category6" class="category1" name="category" value="수납/정리">수납/정리</button>
					    	<button onclick="change_btn(event)" id="category7" class="category1" name="category" value="조명">조명</button>
					    	<button onclick="change_btn(event)" id="category8" class="category1" name="category" value="주방용품">주방용품</button>
					    	<button onclick="change_btn(event)" id="category9" class="category1" name="category" value="패브릭">패브릭</button>
					    </form>
			        	</div>
	        	</div>
            </li>
            <li><a href="/product/productList.do"><h3>스토어</h3></a></li>
            <li><a href="/board/board_myhome/myHomeList.do"><h3>커뮤니티</h3></a></li>
        </ul>
    </nav>

    <table style="white-space: nowrap;">
        <tr style="display: flex; align-items: center;">
            <td style="padding-right: 20px;">
                <a href="/member/loginForm.do"><h3 style="border-radius: 5%; font-size: 18px; margin: 0;">로그인</h3></a>
            </td>
            <td style="padding-right: 20px;">
                <a href="/member/memberForm.do"><h3 style="border-radius: 5%; font-size: 18px; margin: 0;">회원가입</h3></a>
            </td>
            <td style="text-align: right;">
                <a href="/board/board_question/FAQList.do"><h3 style="font-size: 18px; margin: 0;">고객센터</h3></a>
            </td>
        </tr>
    </table>
</div>
</c:otherwise>
</c:choose>
</div>
</div>
</body>
</html>