<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    	margin-top:55px;
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
        width: auto;  /* 가로 비율 유지 */
        height: 200px; 
        object-fit: cover; /* 넘치는 부분 자름 */
    }
	
	.top-bar {
    display: flex;
    justify-content: space-between; /* 양쪽 끝으로 배치 */
    align-items: center; /* 수직 중앙 정렬 */
	}
		li{
	font-weight:bold;
	}
</style>
</head>
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

<!-- 나의 게시글 -->
   <div class="grid-wrapper">
        <div class="grid-container">
            <c:choose>
                <c:when test="${not empty myhomeMap.articlesList}">
                    <c:forEach var="article" items="${myhomeMap.articlesList}">
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
			${article.boardMyhomeTitle}</a>
                                </h3>
                                <p>${article.memberNickName}</p>
                                <p>👍🏻${article.boardMyhomeLikes} | 👀 ${article.boardMyhomeViews} | 💬${article.totalReply}</p>
                                <p>${article.boardMyhomeUpdated}</p>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p>게시글이 없습니다.</p>
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