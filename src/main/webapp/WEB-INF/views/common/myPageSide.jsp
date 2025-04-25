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
 <style>
 
#profile {
    margin-top: 110px;
    min-width: 60%;
    min-height: 400px;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
    display: grid;
    place-items: center; /* 세로 가로 가운데 정렬 */
}

.imageCircle img {
    margin-top: 50px;
    width: 150px;
    height: 150px;
    border-radius: 50%; /* 동그라미 만들기 */
    object-fit: fill;
}

.profileText {
    margin-top: 15px;
    text-align: center;
    font-size: 20px;
}

.follow {
    display: flex;
    justify-content: center; /* 가로 가운데 정렬 */
    margin-top: 0px; /* 위쪽 여백 */
    font-weight: bold; 
}

#solid {
border-right: 2px solid rgba(0, 0, 0, 0.2);
}

.settingButton {
    background-color: white;
    color: gray;
    padding: 2px 2.5px 2px 2.5px;
    border: none;
    text-align: center;
    margin: 15px;
    cursor: pointer; /* 커서 모양 */
    border-radius: 5px;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
}

.settingButton:hover {
    background-color: #f0f0f0;
}

#Category2 td{
text-align:center;
opacity : 0.5;
font-weight:bold;
}

#Category3 td{
text-align:center;
font-weight:bold;
opacity : 0.8;
}

#Category td{
padding-right:7px;
}

#followButton{
 background-color: #99E0FF; 
    color: white;
    border: none;
    padding: 5px 13px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin-left: 5px;
    border-radius: 5px;
    cursor: pointer; 
    transition: background-color 0.3s; /* 배경색 변화 효과 */
    border-radius: 5px;
}

#followButton:hover{
background-color: #66CEFF; 
}

#nofollowButton{
 background-color: #4D4D4D; 
    color: white;
    border: none;
    padding: 5px 13px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin-left: 5px;
    border-radius: 5px;
    cursor: pointer; 
    transition: background-color 0.3s; /* 배경색 변화 효과 */
    border-radius: 5px;
}

#nofollowButton:hover{
background-color: #666666; 
}
#followButtons{
margin-top:0px;
}
#profile2{
margin-top: 77px;
    min-width: 60%;
    min-height: 350px;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.2);
}
 </style>
  <meta charset="UTF-8">
  <title>사이드 메뉴</title>
</head>
<script>

// 팔로우 팔로잉 버튼
function follow(button, event){
 
	event.preventDefault();
	
	var followId = $("#followId").val();
	
	if (${isLogOn == true && member != null}) {
		
    	$.ajax({
            url: "/mypage/follow/follow.do",
            type: 'POST',
            data: {
            	followId: followId
            },
            success: function() {
            	if (button.id === "followButton") {
                    button.id = "nofollowButton";
                    button.textContent = "팔로잉";
                } else {
                    button.id = "followButton";
                    button.textContent = "팔로우";
                }
            },
            error: function(status) {
            }
        });
    } else {
        // 비로그인 시 로그인 페이지로 이동 여부 묻고 확인 누르면 이동
        if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
            window.location.href = '/member/loginForm.do';
        }
    }
} 

</script>
<body>
<c:if test="${empty yourIdInfo}">
<div id="profile">
 <div class="imageCircle">
 <c:if test="${member.memberImage==null}">
     <img src="/resources/image/mypage.png"/> <!-- 프로필 사진 넣기 -->
 </c:if>
 <c:if test="${member.memberImage!=null}">
     <img src="/memberProfileImage/${member.memberId}/${member.memberImage}"/> <!-- 프로필 사진 넣기 -->
 </c:if>
 </div>
 <div class="profileText">
     <h3>${member.memberNickname}</h3>
 </div>
 <table class="follow">
 <tr>
 	<!-- 팔로우, 팔로잉 0일 경우 체크 -->
 	<c:set var="followCount" value="${followCount != null ? followCount : 0}" />
	<c:set var="followingCount" value="${followingCount != null ? followingCount : 0}" />
	
         <td>
         <a href="/mypage/follow/followerList.do">팔로워 ${followCount}</a>
         </td>
         <td id="solid"></td>
         <td>
         <a href="/mypage/follow/followingList.do">팔로잉 ${followingCount}</a>
         </td>
</tr>
     </table>
     <a id="setting" href="/member/memberModifyForm.do"><button class="settingButton">설정</button></a>
     
     
     <table id="Category" style=" border-spacing: 5px;">
     <tr>
     <td style="text-align:center;">
      <a href="/mypage/bookmark/bookMarkList.do">
            <img src="/resources/image/bookMark.png"  width="30px" style="opacity : 0.5;"/>
        </a>
     </td>
     <td style="text-align:center;">
     <a href="/mypage/wishlist/wishList.do">
            <img src="/resources/image/wishList.png"  width="30px" style="opacity : 0.5;"/>
        </a>
     </td>
     <td style="text-align:center;">
     <a href="/mypage/like/likeList.do">
            <img src="/resources/image/like.png"  width="35px" style="opacity : 0.5;"/>
        </a>
     </td>
     </tr>
     
     <tr id="Category2">
     <td><a href="/mypage/bookmark/bookMarkList.do">북마크</a></td>
     <td><a href="/mypage/wishlist/wishList.do">찜</a></td>
     <td><a href="/mypage/like/likeList.do">좋아요</a></td>
     </tr>
     
     <!-- 북마크, 좋아요 널일 경우 체크 -->
	<c:set var="bookMarkTotal" value="${bookMarkTotal != null ? bookMarkTotal : 0}" />
	<c:set var="wishListTotal" value="${wishListTotal != null ? wishListTotal : 0}" />
	<c:set var="likeTotal" value="${likeTotal != null ? likeTotal : 0}" />
     
     <!-- 개수 표시 -->
     <tr id="Category3">
     <td><a href="/mypage/bookmark/bookMarkList.do">${bookMarkTotal}</a></td>
     <td><a href="/mypage/wishlist/wishList.do">${wishListTotal}</a></td>
     <td><a href="/mypage/like/likeList.do">${likeTotal}</a></td>
     </tr>
     </table>
</div>
</c:if>
<c:if test="${!empty yourIdInfo}">
<div id="profile2">
 <div class="imageCircle">
 <c:if test="${yourIdInfo.MEMBERIMAGE==null}">
     <img src="/resources/image/mypage.png"/> <!-- 프로필 사진 넣기 -->
 </c:if>
 <c:if test="${yourIdInfo.MEMBERIMAGE!=null}">
     <img src="/memberProfileImage/${yourIdInfo.MEMBERID}/${yourIdInfo.MEMBERIMAGE}"/> <!-- 프로필 사진 넣기 -->
 </c:if>
 </div>
 <div class="profileText">
     <h3>${yourIdInfo.MEMBERNICKNAME}</h3>
 </div>
<div id="followButtons">
    <c:if test="${checkBoardFollow =='false' || checkBoardFollow == null}">
        <td><button id="followButton" onclick="follow(this,event)">팔로우</button></td>
    </c:if>
    <c:if test="${checkBoardFollow =='true' && checkBoardFollow != null}">
        <td><button id="nofollowButton" onclick="follow(this,event)">팔로잉</button></td>
    </c:if>
    <input id="followId" type="hidden" name="followId" value="${yourIdInfo.MEMBERID}" />
</div>
</div>
</c:if>
</body>
</html>