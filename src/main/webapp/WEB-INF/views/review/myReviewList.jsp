<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- style="text-decoration-line:none" -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 리뷰</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
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


.top-bar {
   display: flex;
   justify-content: space-between; /* 양쪽 끝으로 배치 */
   align-items: center; /* 수직 중앙 정렬 */
}
li{
font-weight:bold;
}
/*헤더 스타일 끝 */

/* nav와 리뷰 목록 사이의 간격 스타일 추가 */
.nav-spacing {
    margin-bottom: 100px;
}



.review-item {
    display: flex;
    align-items: flex-start;
    gap: 16px;
    padding-bottom: 24px;         /* 아래 패딩 추가 → 선과 간격 */
    margin-bottom: 24px;          /* 다음 항목과의 간격 */
    border-bottom: 1px solid #eee;
}


.review-image-box {
    width: 100px;
    height: 100px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
}

.review-img {
    width: 100px;
    height: 100px;
    object-fit: contain;          /* 원본 비율 유지 */
    background-color: #ffffff;    /* 이미지 여백 영역을 흰색으로 */
    border: 1px solid #ddd;       /* 테두리 추가 */
    border-radius: 5px;           /* 둥근 테두리 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);  /* 은은한 그림자 */
    padding: 4px;                 /* 이미지 안 여백 살짝 */
}

/* 이미지 없는 경우 스타일 */
.review-img.placeholder {
    width: 100px;
    height: 100px;
    background-color: #f3f3f3;
    border: 1px dashed #ccc;
    border-radius: 5px;
}





.review-content {
	flex: 1;
}

.review-content h3 {
	margin: 0;
	font-size: 18px;
	font-weight: bold;
}

.review-content p {
	margin: 5px 0;
	font-size: 14px;
	color: #4D4D4D;
}

.review-content .rating {
	font-size: 14px;
	color: #4D4D4D; /* 별점 색상 */
}
</style>
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
    <li class="nav1_ul_li" style="color:#00A9FF;">나의 쇼핑
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

<div class="nav-spacing"></div>


<!-- 리뷰내역 -->
<c:if test="${not empty myReviewMap.myReviewList}">
<c:forEach var="review" items="${myReviewMap.myReviewList}">
    <div class="review-item">
        <!-- 이미지 있을 때 -->
        <div class="review-image-box">
            <c:set var="hasImage" value="false"/>
            <c:forEach var="image" items="${myReviewMap.imageList}">
                <c:if test="${image.articleNO == review.reviewNo && not empty image.imageFilename}">
                    <img src="/review/imagesReview.do?reviewNo=${review.reviewNo}&imageName=${image.imageFilename}" class="review-img"/>
                    <c:set var="hasImage" value="true"/>
                </c:if>
            </c:forEach>
        
            <!-- 이미지 없을 때 -->
            <c:if test="${not hasImage}">
                <div class="review-img placeholder"></div>
            </c:if>
        </div>
        
        <!-- 리뷰 제목, 리뷰 내용 -->
        <div class="review-content">
            <a href="/product/selectProduct.do?productNO=${review.productNo}&productName=${review.productName}">
                <h3>${review.productName}</h3>
            </a>
            <p>${review.reviewContents}</p>
            
            <!-- 별점 -->
            <c:forEach var="i" begin="1" end="5">
                <c:choose>
                    <c:when test="${i <= review.reviewStarAvg}">
                        <img src="/resources/image/iconStar1.png" width="15px" alt="노란별"/>
                    </c:when>
                    <c:otherwise>
                        <img src="/resources/image/iconStar2.png" width="15px" alt="까만별"/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</c:forEach>

</c:if>

<c:if test="${empty myReviewMap.myReviewList}">
<p>작성된 리뷰가 없습니다.</p>
</c:if>



</body>
</html>