<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 내역</title>
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

a, .nav1_ul_li{
font-weight:bold;
} 

.myQuestionForm_table { 
width: 80%; 
margin: 0 auto;
border-collapse: collapse; 
}
.myQuestionForm_th, myQuestionForm_td { 
padding: 10px; 
border: 1px solid #ddd; 
}
.myQuestionForm_th { 
background-color: #f0f0f0; 
}
.myQuestionForm_tr:hover {
background-color: #f9f9f9;
}
.myQuestionForm_tr2:hover { 
text-decoration: none; 
background-color: #f9f9f9; 
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
	<li class="nav1_ul_li">나의 쇼핑
	        <ul class="sub-ul">
	            <li class="sub-ul_li"><a href="/mypage/delivery/deliveryList.do" class="sub-nav_a">주문배송목록</a></li>
	            <li class="sub-ul_li"><a href="/mypage/wishlist/wishList.do" class="sub-nav_a">상품 찜 목록</a></li>
	            <li class="sub-ul_li"><a href="/mypage/point/pointList.do" class="sub-nav_a">포인트</a></li>
	            <li class="sub-ul_li"><a href="/review/myReviewList.do" class="sub-nav_a">나의 리뷰</a></li>
	        </ul>
	    </li class="nav1_ul_li"> 
	    <li class="nav1_ul_li"><a href="/member/memberModifyForm.do" class="nav1_ul_li_a">설정</a></li>
	    <li class="nav1_ul_li"><a style="color:#00A9FF;" href="/board/board_question/myQuestionList.do" class="nav1_ul_li_a">문의내역</a></li>
	  </ul>
	</nav><br><br>

	<h1>내 문의내역</h1>
    <table class="myQuestionForm_table">
        <thead>
            <tr class="myQuestionForm_tr">
                <th class="myQuestionForm_th">문의유형</th>
                <th class="myQuestionForm_th">문의 세부사항</th>
                <th class="myQuestionForm_th">문의 내용</th>
                <th class="myQuestionForm_th">등록일</th>
                <th class="myQuestionForm_th">처리상태</th>
            </tr>
        </thead>
        <tbody>
	        <c:if test="${empty questionList}">
	    		<tr><td colspan="5" style="padding-top: 20px; font-size:20px;">작성된 문의가 없습니다.</td></tr>
			</c:if>
            <c:forEach var="q" items="${questionList}">
                <tr class="myQuestionForm_tr2">
                    <!-- 클릭 시 questionSelect.jsp로 boardQuestionArticleNo를 파라미터로 전송 -->
                    <td>
                        <a href="/board/board_question/questionSelect.do?boardQuestionArticleNo=${q.boardQuestionArticleNo}">
                            ${q.boardQuestionType1}
                        </a>
                    </td>
                    <td>
                    	<a href="/board/board_question/questionSelect.do?boardQuestionArticleNo=${q.boardQuestionArticleNo}">
                    		${q.boardQuestionType2}
                    	</a>
                    </td>
                    <td>
                    	<a href="/board/board_question/questionSelect.do?boardQuestionArticleNo=${q.boardQuestionArticleNo}">
                    		<c:choose>
					            <c:when test="${fn:length(q.boardQuestionContents) > 10}">
					                ${fn:substring(q.boardQuestionContents, 0, 10)}...
					            </c:when>
					            <c:otherwise>
					                ${q.boardQuestionContents}
					            </c:otherwise>
					        </c:choose>
                    	</a>
                    </td>
                    <td>
                    	<a href="/board/board_question/questionSelect.do?boardQuestionArticleNo=${q.boardQuestionArticleNo}">
                    		<fmt:formatDate value="${q.boardQuestionUpdated}" pattern="yyyy-MM-dd" />
                    	</a>
                    </td>
                    <td>
                    	<a href="/board/board_question/questionSelect.do?boardQuestionArticleNo=${q.boardQuestionArticleNo}">
                    		${q.boardQuestionStatement}
                    	</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>