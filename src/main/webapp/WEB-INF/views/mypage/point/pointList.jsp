<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트</title>
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

li{
font-weight:bold;
}

/* 사용 가능 포인트  */
.point-box { /* 포인트 박스 컨테이너 */
border: 1px solid #eee;    /* 테두리 */
border-radius: 4px;        /* 모서리 둥글게 */
padding: 20px;             /* 내부 여백 */
text-align: center;        /* 중앙 정렬 */
margin: 20px auto;         /* 위아래 여백, 가운데 정렬 */
max-width: 400px;          /* 최대 가로 폭 */
background-color: #fff;    /* 배경색 (필요 시) */
margin-top: 60px;
}
.point-box h3 { /* 제목 */
margin: 0;
padding: 0;
font-size: 18px;
font-weight: bold;
color: #333;
}
.point-box .point-amount { /* 포인트 금액 */
font-size: 32px;
font-weight: bold;
color: #00A9FF;
margin: 10px 0;
}

/* 포인트 안내 */
.point-guide {
margin-top: 30px;         /* 상단 여백 */
padding: 20px;           /* 내부 여백 */
border: 1px solid #eee;  /* 옅은 테두리 */
border-radius: 4px;      /* 모서리를 살짝 둥글게 */
background-color: #fff;  /* 배경색 (필요 시) */
line-height: 1.6;        /* 줄 간격 */
color: #333;             /* 글자색 */
max-width: 1000px;        /* 최대 가로 폭 */
margin-left: auto;       /* 수평 중앙 정렬 */
margin-right: auto;
text-align: left;
}
.point-guide h3 {
margin-top: 0;
font-size: 18px;
font-weight: bold;
color: #333;
margin-bottom: 15px;
}
.point-guide p {
margin: 0 0 10px; /* 문단 간 간격 */
}

/* 포인트 내역 */
h2.point-title { /* 포인트 내역 제목 */
font-size: 20px;
margin-bottom: 10px;
text-align: left;
}
.point-separator { /* 구분선 */
border: none;
border-top: 1px solid #ccc;
margin: 10px 0 20px 0;
}
.history-table { /* 포인트 내역 테이블 */
width: 100%;
border-collapse: collapse;
}
.history-table th, .history-table td {
border: 1px solid #ccc;
padding: 8px;
text-align: center;
font-size: 14px;}
.history-table th {
background-color: #f8f8f8;
color: #333;
}
.history-table td {
color: #555;
}
.history-table .plus {
color: #00A9FF;
font-weight: bold;
}
.history-table .minus {
color: #fd4949;
font-weight: bold;
}
.history-table .reviewPoint {
color: #fd4949; 
font-weight: bold;
}
.history-table .new {
color: #fd4949; 
font-weight: bold;
}
</style>

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
	    <li style="color:#00A9FF;" class="nav1_ul_li">나의 쇼핑
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
	</nav>
	
	<!-- 사용 가능한 포인트 -->
	<div class="point-box">
        <h3>사용 가능한 포인트</h3>
        <p class="point-amount">
            <c:out value="${point.pointRemain}" default="0"/> P
        </p>
	</div>
       
    <!-- 포인트 내역 -->
    <h2 class="point-title">포인트 내역</h2>
    <hr class="point-separator"/>
    
    <%-- <table class="history-table">
        <tr>
            <th>일시</th>
            <th>내용</th>
            <th>포인트 변동 내역</th>
        </tr>
        <c:forEach var="newGood" items="${newGood}">
        	<tr>
		        <td><fmt:formatDate value="${newGood.memberJoindate}" pattern="yyyy-MM-dd"/></td>
		        <td><strong>[회원가입] </strong>회원가입</td>
		        <td class="new">+ 1000 P</td>
	        </tr>
	    </c:forEach>
        <c:forEach var="plus" items="${plusHistory}">
            <tr>
                <td><fmt:formatDate value="${plus.orderJoinDate}" pattern="yyyy-MM-dd"/></td>
                <td><strong>[구매확정] </strong>${plus.productName}</td>
                <td class="plus">+${plus.productPoint} P</td>
            </tr>
        </c:forEach>
        <c:forEach var="minus" items="${minusHistory}">
	        <tr>
	            <td><fmt:formatDate value="${minus.orderDate}" pattern="yyyy-MM-dd"/></td>
	            <td><strong>[포인트 사용] </strong>${minus.productName}</td>
	            <td class="minus">-${minus.productPoint} P</td>
	        </tr>
	    </c:forEach>
	    <c:forEach var="reviewPoint" items="${reviewPoint}">
	        <tr>
	            <td><fmt:formatDate value="${reviewPoint.reviewUpdated}" pattern="yyyy-MM-dd"/></td>
	            <td><strong>[리뷰작성] </strong>${reviewPoint.reviewContents}</td>
	            <td class="reviewPoint">+150 P</td>
	        </tr>
	    </c:forEach>
    </table> --%>
    
    
    <table class="history-table">
	    <tr>
	        <th>일시</th>
	        <th>내용</th>
	        <th>포인트 변동 내역</th>
	    </tr>
	    <c:forEach var="history" items="${totalHistory}">
	        <tr>
	            <td><fmt:formatDate value="${history.historyDate}" pattern="yyyy-MM-dd" /></td>
	            <td><strong>${history.historyType} </strong>${history.historyContent}</td>
	            <c:choose>
		            <c:when test="${fn:startsWith(history.pointChange, '+')}">
		                <td style="color: #00A9FF;">${history.pointChange}</td>
		            </c:when>
		            <c:otherwise>
		                <td style="color: #fd4949;">${history.pointChange}</td>
		            </c:otherwise>
		        </c:choose>
		        </tr>
		    </c:forEach>
	</table>


	<hr class="point-separator"/>
	<!-- 포인트 안내 -->
    <div class="point-guide">
        <h3>포인트 안내</h3>
        <p> 포인트는 내일의 집 이용약관에 따라 회원만 적립 및 사용이 가능합니다.</p>
        <p> 포인트 사용 시 다른 사용자와 양도/매매/현금화 등은 불가능합니다.</p>
        <p> 구매 후, 취소 시, 사용한 포인트는 환불되지 않을 수 있으며 포인트의 유효기간 내 환불 요청 시에만 복구 가능할 수 있습니다. 자세한 정책은 고객센터를 통해 확인하시기 바랍니다.</p>
        <p> 내일의 집 포인트 관련 혜택은 별도 안내 없이 변경될 수 있으며, 일부 상품은 포인트 사용이 불가능할 수 있습니다. 또한 이벤트성으로 지급된 포인트의 경우 유효기간이 따로 설정될 수 있습니다.</p>
    </div>
</body>
</html>