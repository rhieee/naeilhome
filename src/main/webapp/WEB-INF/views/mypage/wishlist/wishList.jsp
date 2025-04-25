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
	
/* 상품 리스트  */

.product{
    display: grid;
    grid-template-columns: repeat(3, 1fr); /* 4개씩 가로 배치 */
    gap: 25px; /* 카드 간격 */
    min-width : 986px;
	max-width : 986px;
	margin-bottom:55px; /* 마이페이지 페이징과 거리둠 */
}

a {
	text-decoration-line:none;
}
a:link {
	color:black;
}
/* 현오가 추가해줌 (마우스 갔다 댔을 때 이미지 축소 + 외각그림자 + 뒷배경 회색 )*/
.prodList{
    box-shadow:0 0 3px rgba(0,0,0, 0.2);
    background-color: rgba(160, 160, 160, 0.02);
    border-radius: 5px; 
    height:350px;
}

.prodImage{
width: 100%; /* 이미지의 너비를 100%로 설정 */
transition: transform 0.3s ease; /* 변환 효과 설정 */
border-radius: 5px;
background-size:cover;
height:280px;
}
.prodImage:hover{
transform: scale(0.95); /* 마우스 호버 시 10% 확대 */
}
.pageNum{
	font-size: 25px;
}
.paging{
	margin-top: 30px;
	margin-bottom: 30px;
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

.viewName {
  width: 275px;
  display: inline-block;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-weight: bold;
  margin: 7px auto 7px auto;
}

</style>
</head>

<script>

// 체크 박스 관련 함수
function checkOpen(){
	
	// 체크박스 보이기
	$('#checkArea > *').css("display", "block");
	$('#checkArea > *').css("margin", "0 auto");
	$('#checkArea > *').css("marginBottom", "20px");
	
	// 편집버튼 숨기고 취소, 삭제 버튼 보이기
	$("#checkOpen").css("display", "none");
	$("#checkCancel").css("display", "block");
	$("#checkDelete").css("display", "block");
	$("#edit2").css("display", "flex");
	
	// 박스 크기 늘이기
	$(".prodList").css("height", "380px");
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
	
	// 박스 크기 줄이기
	$(".prodList").css("height", "350px");
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
            url: '/mypage/wishlist/deleteWishList.do',
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

<!-- 상품 리스트 변수 선언 -->
<c:set var="section" value="${productMap.section }" />
<c:set var="pageNum" value="${productMap.pageNum }" />
<c:set var="recNum" value="${productMap.recNum }" />
<c:set var="pageNo" value="${productMap.pageNO }" />
<c:set var="lastSection" value="${productMap.lastSection }" />
<c:set var="productList" value="${productMap.list }" />
<c:set var="category" value="${productMap.category }" />
<c:set var="loopOut" value="true" />


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
    </li class="nav1_ul_li"> 
    <li class="nav1_ul_li"><a href="/member/memberModifyForm.do" class="nav1_ul_li_a">설정</a></li>
     <li class="nav1_ul_li"><a href="/board/board_question/myQuestionList.do" class="nav1_ul_li_a">문의내역</a></li>
  </ul>
  	<!-- 편집버튼 -->
  	<c:if test="${not empty productList}">
  	<div id="editContainer">
    <div id="edit2">
    <p><b>전체 선택</b></p>
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

<!-- 찜한 상품 -->
   	<c:choose>
		<c:when test="${not empty productList}"> <!-- productList가 비어있지 않으면 -->
			<div class="product" align="center" style="margin-top:10px;">
			<c:forEach  var="productList" items="${productList}" varStatus="articleNum" >
				<div class="prodList">
					<a href="/product/selectProduct.do?productNO=${productList.productNO }&productName=${productList.productName }">
							<img class="prodImage" src="/product/productThumbnail.do?articleNO=${productList.productNO }&image=${productList.imageFileName }"/>
							<span class="viewName" style="font-weight: bold;">${productList.productName }</span><br>
						<fmt:formatNumber  value="${productList.productPrice}" type="number" var="price" />
							<span style="display: inline-block; margin-bottom: 7px;">${price}원</span>
					</a>
					<!-- 편집 체크 박스 -->
                                <div id="checkArea">
                                <input id="checkBox" type="checkbox" value="${productList.productName}">
                                </div>
				</div>
			</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
		<div style="text-align: left; margin-left:60px; margin-top:70px;">
    <p>상품이 존재하지 않습니다.</p>
	</div>
		</c:otherwise>
	</c:choose>
	<div>
    </div>
    
    <div>
	<p class="paging" align="center">
	<c:choose>
		<c:when test="${recNum != null }">
		<c:forEach var="page" begin="1" end="${pageNo }" step="1" varStatus="a">
			<c:if test="${section > 1 && page==1}">
				<a href="/mypage/wishlist/wishList.do?section=${1 }&pageNum=${1 }">처음</a>
			</c:if>
			<c:if test="${section > 1 && page==1}">
				<a href="/mypage/wishlist/wishList.do?section=${section-1}&pageNum=${(section-1)*10+page-1}">이전</a>
			</c:if>
			<c:if test="${page <= 10}">
				<c:if test="${loopOut }" >
					<a class="pageNum" href="/mypage/wishlist/wishList.do?section=${section}&pageNum=${(section-1)*10+page}">${(section-1)*10 +page}</a>
				</c:if>
				<c:if test="${((section-1)*10+page)==pageNo }">
					<c:set var="loopOut" value="false" />
				</c:if>
			</c:if>
			<c:if test="${page == 10}">
				<c:if test="${loopOut }">
					<a href="/mypage/wishlist/wishList.do?section=${section+1}&pageNum=${(section-1)*10+page+1}">다음</a>
				</c:if>
			</c:if>
		</c:forEach>
			<c:if test="${section < lastSection}">
				<a href="/mypage/wishlist/wishList.do?section=${lastSection}&pageNum=${pageNo}">마지막</a>
			</c:if>
		</c:when>
		<c:otherwise>
		<a class="pageNum" href="/mypage/wishlist/wishList.do?section=${1}&pageNum=${1}">${1}</a>
		</c:otherwise>
	</c:choose>
	</p>
</div>





</body>
</html>