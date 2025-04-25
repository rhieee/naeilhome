<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 추가 -->
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.spring.naeilhome.mypage.myhome.domain.MyPageMyhomeDomain" %>

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

/* 사이즈 설정 */
    body {
        font-family: Arial, sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
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
	
/* 여기부터 추가됨 */
/* 팔로워 목록  */
#followerBox{
	margin-top: 55px;
	margin-left: auto;
	margin-right: auto;
	min-width : 515px;
	max-width : 515px;
}

#followerList {
    
}

.followerItem {
    display: flex;
    align-items: center;
    margin-bottom: 10px; 
}

.profileImage {
    border-radius: 50%;
    width:35px;
    height:35px;
    object-fit: fill;
}

.nickname {
    margin-left: 10px; 
}

.buttonContainer {
    margin-left: auto; 
    text-align: right;
    margin-top: 5px; 
}
	

/* 팔로잉 버튼 스타일 */
#nofollowButton {
background-color: #4D4D4D; /* 기본 색 */
color: white;
border: none;
border-radius: 5px;
cursor: pointer;
font-size: 14px;
transition: background-color 0.3s;
padding: 5px;
}


/* 팔로우 버튼 스타일 */
#followButton {
background-color: #008ED6; /* 기본 색 */
color: white;
border: none;
border-radius: 5px;
cursor: pointer;
font-size: 14px;
transition: background-color 0.3s;
padding: 5px;
}
#yourPage {
	cursor: pointer;
}
</style>
</head>

<script>
function follow(followerId, button) {
	
    var followId = followerId;
    
    $.ajax({
        url: '/mypage/follow/follow.do',
        type: 'POST',
        data: { followId: followId },
        
        success: function() {
            location.reload();
        },
        
        error: function() {
        }
    });
}

/* 너의 페이지로 */
function yourPage(yourId){
	 
	 $(".yourId").val(yourId);
	 var memberIdCheck = `${member.memberId}`;
	 
	 if(yourId == memberIdCheck){
		 $("#yourPageForm").attr("action", "/mypage/myhome/myPageMyHomeList.do");
		 $("#yourPageForm").submit();
		 $("#yourPageForm").attr("action","");
		 
	 }else{
		 $("#yourPageForm").attr("action", "/mypage/myhome/yourPageMyHomeList.do");
		 $("#yourPageForm").submit();
		 $("#yourPageForm").attr("action","");
	 }
	 
 }
 
</script>
<body>
<nav class="nav1">
  <ul class="nav1_ul">
    <li style="color:#00A9FF;" class="nav1_ul_li">프로필
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
    <li class="nav1_ul_li"><a href="/member/memberModifyForm.do" class="nav1_ul_li_a">설정</a></li>
     <li class="nav1_ul_li"><a href="/board/board_question/myQuestionList.do" class="nav1_ul_li_a">문의내역</a></li>
  </ul>
</nav>

<!-- 여기부터 추가 됨. -->

<div id="followerBox">
<p style="text-align: left; margin-left:3px; font-weight: bold;">팔로워</p>

<c:if test="${!empty followLists}">
<div id="followerList">
    <c:forEach var="follower" items="${followLists.followerList}">
        <c:set var="isFollowing" value="false" />
        <c:forEach var="check" items="${followLists.checkFollow}">
            <c:if test="${check.FOLLOWERID == follower.memberId}">
                <c:set var="isFollowing" value="${check.CHECKFOLLOW}" />
            </c:if>
        </c:forEach>
        
        <div class="followerItem">
            <!-- 프로필 사진 -->
            <c:if test="${follower.memberImage == null}">
    			<a id="yourPage" onclick="yourPage('${follower.memberId}')">    
                <img src="/resources/image/mypage.png" class="profileImage" style="margin-top:4px;"/>
                </a>
            </c:if>
                   
            <c:if test="${follower.memberImage != null}">
            <a id="yourPage" onclick="yourPage('${follower.memberId}')">
                <img src="/memberProfileImage/${follower.memberId}/${follower.memberImage}" class="profileImage" style="margin-top:4px;"/>
                </a>
            </c:if>
                  
            <a id="yourPage" onclick="yourPage('${follower.memberId}')">
            <p class="nickname">${follower.memberNickname}</p> <!-- 닉네임 -->
            </a>
                
            <form id="yourPageForm" action="/mypage/myhome/yourPageMyHomeList.do" method="POST">
        		<input class="yourId" name="yourId" type="hidden" value=""/>
        		</form>	
            <div class="buttonContainer">
                <c:if test="${isFollowing}">
                    <button id="nofollowButton" onclick="follow('${follower.memberId}', this)">팔로잉</button> <!-- 팔로우 중 -->
                </c:if>
                <c:if test="${!isFollowing}">
                    <button id="followButton" onclick="follow('${follower.memberId}')">팔로우</button> <!-- 팔로우 안 함 -->
                </c:if>
            </div>
        </div>
    </c:forEach>
</div>
</c:if>
<c:if test="${empty followLists}">
팔로워가 없습니다.
</c:if>
</div>

</body>
</html>