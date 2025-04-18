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
	<title>북마크</title>
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

/* 나의 게시글 */
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

    /* 글쓰기 버튼 */
.write-btn {
    padding: 10px 20px; 
    background-color: #00A9FF; 
    color: white; 
    font-weight: bold; 
    font-size: 15px; 
    border: none; 
    border-radius: 5px; 
    cursor: pointer; 
}

    /* 게시글 목록 (그리드 형식) */
    .grid-wrapper {
    	margin-top:10px;
        display: flex;
        justify-content: center;
        width: 100%;
    }

    .grid-container {
        display: grid;
        grid-template-columns: repeat(3, 1fr); /* 4개씩 가로 배치 */
        gap: 25px; /* 카드 간격 */
        min-width : 986px;
		max-width : 986px;
		margin-bottom:55px; /* 마이페이지 페이징과 거리둠 */
    }

    /* 개별 카드 스타일 */
    .card {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        transition: transform 0.2s;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        height:350px;
        border-radius: 5px; 
    }

    .card:hover {
        transform: translateY(-5px);
    }

    .card-content {
        padding: 15px;
        text-align: center;
    }

    .card-content h3 {
        font-size: 16px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .card-content p {
        font-size: 14px;
        color: #666;
        margin: 5px 0;
    }

    .card-content a {
        text-decoration: none;
        font-weight: bold;
        color: #007bff;
    }
/* 썸네일 스타일 */
    .thumbnail {
        width: 100%;
        height: 200px; /* 원하는 썸네일 높이 설정 */
        overflow: hidden;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f0f0f0; /* 이미지가 없을 경우 배경색 */
    }

    .thumbnail img {
        width: auto;  
        height: 200px; 
        object-fit: cover; 
    }
	
	.top-bar {
    display: flex;
    justify-content: space-between; /* 양쪽 끝으로 배치 */
    align-items: center; /* 수직 중앙 정렬 */
	}
	li{
	font-weight:bold;
	}

/* 체크박스 스타일 */
#editContainer {
	display: flex;
	justify-content: space-between; /* 좌우 끝으로 배치 */
	margin-top:25px;
}

#edit{
display: flex; 
margin-left: auto;
}

#edit2{
display: flex; 
/* justify-content: center; */
text-align: center;
display: none; 
}

#checkBox{
            width: 20px;  /* 너비 조절 */
            height: 20px; /* 높이 조절 */
            display : none;
}	
#checkOpen{
margin-right:5px;
cursor: pointer;
}

#checkCancel{
display:none;
cursor: pointer;
margin-left:5px;
}

#checkDelete{
display:none;
cursor: pointer;
}

#checkAll{
cursor: pointer;
 width: 20px;  /* 너비 조절 */
 height: 20px; /* 높이 조절 */
 margin-top:18px;
}

</style>
</head>

<script>

// 체크 박스 관련 함수
function checkOpen(){
	
	// 체크박스 보이기
	$('#checkArea > *').css("display", "block");
	$('#checkArea > *').css("margin", "0 auto");
	
	// 편집버튼 숨기고 취소, 삭제 버튼 보이기
	$("#checkOpen").css("display", "none");
	$("#checkCancel").css("display", "block");
	$("#checkDelete").css("display", "block");
	$("#edit2").css("display", "flex");
	
	// 카드 크기 늘리기
	$(".card").css("height","360px")
};

function checkCancel(){
	// 체크 박스 체크 해제, 숨기기, 취소 버튼 숨기기
	$('#checkArea > *').prop("checked", false);
	$('#checkArea > *').css("display", "none");
	$("#checkCancel").css("display", "none");
	
	// 삭제, 전체 선택 버튼 숨기기, 편집 버튼 보이기
	$("#checkDelete").css("display", "none");
	$("#edit2").css("display", "none");
	$("#checkOpen").css("display", "block");
	
	// 카드 크기 줄이기
	$(".card").css("height","350px")
};

function checkDelete(){
	
	// 해당 아이디에 있는 모든 체크 박스 선택
	var checkBoxs = $("#checkArea > *");
	var checkedVal = [];
	
	// 체크 되었는지 확인.
	for (var i = 0; i < checkBoxs.length; i++){
		if(checkBoxs[i].checked){
		
		// 배열에 값들을 밀어 넣기.
		checkedVal.push(checkBoxs[i].value);
		}
	}
	
    if (checkedVal.length > 0) {
        $.ajax({
            url: '/mypage/bookmark/deleteMyBookMarkLists.do',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ checkedVal: checkedVal }),
            
            success: function() {
                alert("삭제가 완료 되었습니다.");
                location.reload();
            },
            
            error: function() {
                alert("오류가 발생하였습니다. 다시 시도해 주세요.");
            }
        });
        
    } else {
        alert("체크된 항목이 없습니다.");
    }
	
};

function checkAll() {
    var checkBoxs = $("#checkArea > *");
    var checkBoxAll = $("#checkAll").is(":checked");

    if (checkBoxAll) {
        checkBoxs.prop("checked", true);
    } else {
        checkBoxs.prop("checked", false);
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
    </li> 
    <li class="nav1_ul_li"><a href="/member/memberModifyForm.do" class="nav1_ul_li_a">설정</a></li>
    <li class="nav1_ul_li"><a href="/board/board_question/myQuestionList.do" class="nav1_ul_li_a">문의내역</a></li>
  </ul>
  <c:if test="${not empty myhomeMap.articlesList}">
  <!-- 편집버튼 -->
  <div id="editContainer">
    <div id="edit2">
    <p>전체 선택</p>
    <input id="checkAll" type="checkbox" oninput="checkAll()">
    </div>
  	<div id="edit">
        <a id="checkOpen" onclick="checkOpen()">편집</a>
        <a id="checkDelete" onclick="checkDelete()">삭제</a>
        <a id="checkCancel" onclick="checkCancel()">취소</a>
        </div>
    </div> 
    </c:if>   
</nav>

<!-- 북마크 게시글 -->
   <div class="grid-wrapper">
        <div class="grid-container">
            <c:choose>
                <c:when test="${not empty myhomeMap.articlesList}">
                    <c:forEach var="article" items="${myhomeMap.articlesList}" varStatus="status" >
                        <div class="card">
                           <!-- 썸네일 자리 -->
                            <div class="thumbnail">
                                <c:choose>
                                    <c:when test="${not empty article.boardMyhomeArticleNo}"> 
                                    <a href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
                                        <img src="/board/board_myhome/myHomeCoverImages.do?articleNo=${article.boardMyhomeArticleNo}&image=${article.imageFileName}" alt="커버 이미지">
                                    </c:when>
                                    <c:otherwise>(이미지 없음)</c:otherwise>
                                </c:choose>
                            </div>

                            <!-- 게시글 정보 -->
                            <div class="card-content">
                                <h3>
                                    <!-- 조회수 증가 후 게시글 상세페이지 이동 -->
								    <a href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
								        ${article.boardMyhomeTitle}
                                    </a>
                                </h3>
                                <p>${article.memberNickName}</p>
                                <p>👍🏻${article.boardMyhomeLikes} | 👀 ${article.boardMyhomeViews} | 💬${article.totalReply}</p>
                                <p>${article.boardMyhomeUpdated}</p>
                                
                                <!-- 편집 체크 박스 -->
                                <div id="checkArea">
                                <input id="checkBox" type="checkbox" value="${article.boardMyhomeArticleNo}">
                                </div>
                                                     
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                <div style="text-align: left; margin-left:60px; margin-top:45px;">
   				 	<p>북마크한 게시글이 없습니다.</p>
				</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- 페이지네이션 -->
<c:if test="${not empty totalPages}">
    <div class="pagination">
        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
            <a href="?pageNum=${i}">${i}</a>
        </c:forEach>
    </div>
</c:if>

</body>

</html>