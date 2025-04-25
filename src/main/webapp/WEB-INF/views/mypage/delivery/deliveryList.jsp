<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
  request.setCharacterEncoding("UTF-8");
%>     
<!-- style="text-decoration-line:none" -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
<c:set var="orderStatementCount" value="${orderStatementCount }" />
<c:set var="ordersListSize" value="${ordersListSize }" />
<c:set var="ordersList" value="${ordersList }" />
<c:set var="logResult" value="${logResult }" />
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
var allJoinNO = new Array();
var duplicationJoinNO = new Array();

$(document).ready(function(){
    $('.nav1_ul_li').mouseenter(function(){
        $(this).children('.sub-ul').children('.sub-ul_li').stop().slideDown(400);
    });
    $('.nav1_ul_li').mouseleave(function(){
        $(this).children('.sub-ul').children('.sub-ul_li').stop().slideUp(400);
    });
});

window.onload = function() {
	if(${logResult} == false){
	    alert('로그인 후 가능한 서비스 입니다.');
	    location.href='/member/loginForm.do';
	}
};
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
    border-width: 0px 0px 1px 0px;
    border-color: #00A9FF;
}
.sub-nav_a:hover {
    color: #00A9FF;
}



li{
	font-weight:bold;
}
.divTable{
	margin-top: 55px;
}
.table{
	table-layout: fixed;
	width:100%;
	padding:50px 40px 50px 40px;
	border: 1.5px solid #ccc;
}
.table tr{
}
.table tr td{
	padding-top: 20px;
	padding-bottom: 20px;
	font-size: 21px;
	display: table-cell;
}
.ordersListContainer{
	text-align: left;
}
.ordersListItems{
	display: flex;
	justify-content: space-between;
	flex-direction: row;
	margin: 0px;
	padding: 0px;
	align-items : center;
}
.ordersBody {
	display: flex;
	justify-content: space-between;
	flex-direction: row;
	margin: 0px;
	padding: 0px;
	align-self: left;
	align-items : center;
}
.orderBodyContent{
	margin-left: 10px;
}
.completeBtn{
	/* align-self: right; */
	display: flex;
	text-align: center;
	font-weight: bold;
	font-size: 20px;
	width: 25%;
	justify-content: center;
	align-items : center;
	flex-direction: column;
}
.orderContentProdName, .orderContentOrderOption, .orderContentOrderAmount{
	margin: 0px;
	padding: 0px;
}
.orderContentProdName{ /* 제품명 폰트 설정 */
	font-size: 25px;
	font-weight: bold;
}
.orderContentOrderOption, .orderContentOrderAmount{ /* 제품옵션, 금액, 수량 폰트 설정 */
	font-size: 20px;
}
.deli_btn1{
	background-color: #00A9FF;
    color: white; 
    font-size: 20px;
    border: none; 
    border-radius: 5px; 
    cursor: pointer;
    width: 150px;
    padding-left: 5px;
    padding-right: 5px;
    margin: 3px;
}
.reviewComplete{
	background-color: #f0f0f0;
    font-size: 20px;
    border: none; 
    border-radius: 5px; 
    width: 150px;
    padding-left: 5px;
    padding-right: 5px;
    margin: 3px;
    align-items: center;
    font-weight: lighter;
}
.deli_btn1:hover, .deli_btn3:hover{
	background-color: #008ED6;
}
.deli_btn2{
	background-color: #f0f0f0;
    font-size: 20px;
    border: none; 
    border-radius: 5px; 
    cursor: pointer;
    width: 150px;
    padding-left: 5px;
    padding-right: 5px;
    margin: 3px;
}
.deli_btn2:hover{
	background-color: #e4e4e4;	
}
.deli_btn3{
	background-color: #00A9FF;
    color: white; 
    font-size: 20px;
    border: none; 
    border-radius: 5px; 
    cursor: pointer;
    width: 200px;
    height: 50px;
    padding-left: 5px;
    padding-right: 5px;
    margin: 3px;
}
.notHave{
	margin-top: 30%;
}
body{
	font-family: Arial, sans-serif;
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
</nav>
<div class="divTable">
<table class="table" align="center">
	<tr class="tableHead">
		<td>결제완료</td>
		<td></td>
		<td>배송준비</td>
		<td></td>
		<td>배송중</td>
		<td></td>
		<td>배송완료</td>
		<td></td>
		<td>구매확정</td>
	</tr>
	<tr class="tableItems">
		<td style="color: #00A9FF;">
			<p id="completePayCount" style="display:inline;">0</p>
		</td>
		<td style="color: #ccc;"><b>></b></td>
		<td style="color: #00A9FF;">
			<p id="deliveryReadyCount" style="display:inline;">0</p>
		</td>
		<td style="color: #ccc;"><b>></b></td>
		<td style="color: #00A9FF;">
			<p id="inDeliveryCount" style="display:inline;">0</p>
		</td>
		<td style="color: #ccc;"><b>></b></td>
		<td style="color: #00A9FF;">
			<p id="completeDeliveryCount" style="display:inline;">0</p>
		</td>
		<td style="color: #ccc;"><b>></b></td>
		<td style="color: #00A9FF;">
			<p id="buyConfirmationCount" style="display:inline;">0</p>
		</td>
	</tr>
</table>
</div>
<p>
<script>
$(document).ready(function(){
	// 묶음 구매 상품의 날짜를 출력하기 위한 로직
	allJoinNO = [];
	duplicationJoinNO = [];
	var index = 0;
	for(var i = 0; i<${ordersListSize}; i++){ // 서버에서 ordersList의 size를 가져옴
		allJoinNO.push({joinNO : document.getElementsByClassName('joinNO')[i].value,
						date : document.getElementsByClassName('orderDate')[i].value}); // 1. ordersList 전체의 joinNo과 orderDate를 배열에 저장 
		const check = allJoinNO[i]; // 2. 1번에 저장된 내용을 하나씩 빼서 저장
		
		const exists = duplicationJoinNO.some(item => item.joinNO == check.joinNO); // 3. allJoinNO과 check에 저장된 joinNO이 같을 시 true 반환
		
		if(!exists){ // 4. false일 때 실행 - 중복된 값을 제외하고 저장
			duplicationJoinNO.push({joinNO : document.getElementsByClassName('joinNO')[i].value, // 구분하기위한 joinNO
									index : i, // style 및 date를 넣기위한 index(태그의 이름을 class로 지정)
									date : document.getElementsByClassName('orderDate')[i].value});
		}
	}
	for (var i = 0; i < duplicationJoinNO.length; i++) {
	    var index = duplicationJoinNO[i].index; // 위에서 저장한 index 호출
	    var date = new Date(duplicationJoinNO[i].date); // Date 포멧팅 - 출력 : YYYY.MM.DD
	    var formattedDate = date.getFullYear() + '.' + 
	                        ('0' + (date.getMonth() + 1)).slice(-2) + '.' +
	                        ('0' + date.getDate()).slice(-2);
	    document.getElementsByClassName('date')[index].innerText = formattedDate;
	    if(index != 0){
	    	document.getElementsByClassName('date')[index].style.borderTop = '3px solid #ccc';
	    }
	    document.getElementsByClassName('date')[index].style.borderBottom = '3px solid #ccc';
	    document.getElementsByClassName('date')[index].style.marginTop = '15px';
	    document.getElementsByClassName('date')[index].style.paddingLeft = '10px';
	    document.getElementsByClassName('date')[index].style.marginBottom = '15px';
	    document.getElementsByClassName('date')[index].style.paddingTop = '20px';
	    document.getElementsByClassName('date')[index].style.paddingBottom = '10px';
	    document.getElementsByClassName('date')[index].style.fontWeight = 'bold';
	    document.getElementsByClassName('date')[index].style.fontSize = '20px';
	}
	var div = document.getElementsByClassName('ordersListContainer');
	var lastDivIndex = div.length - 1;
	div[lastDivIndex].style.paddingBottom = '15px';
	div[lastDivIndex].style.marginBottom = '50px';
	div[lastDivIndex].style.borderBottom = '3px solid #ccc';
});


var status = ["결제완료", "배송준비", "배송중", "배송완료", "구매확정"];
var statusAll = new Array();
$(document).ready(function(){ // html 전체의 "결제완료", "배송준비", "배송중", "배송완료", "구매확정" 텍스트 개수 계산 
	var statusText = document.querySelectorAll('.statusText');
	statusText.forEach(function(element){
		statusAll.push(element.innerText);
	})
	var filterStatus = statusAll.filter(item => status.includes(item));
	var completePayCount = filterStatus.filter(item => item === "결제완료").length;
	$('#completePayCount').text(completePayCount);
	var deliveryReadyCount = filterStatus.filter(item => item === "배송준비").length;
	$('#deliveryReadyCount').text(deliveryReadyCount);
	var inDeliveryCount = filterStatus.filter(item => item === "배송중").length;
	$('#inDeliveryCount').text(inDeliveryCount);
	var completeDeliveryCount = filterStatus.filter(item => item === "배송완료").length;
	$('#completeDeliveryCount').text(completeDeliveryCount);
	var buyConfirmationCount = filterStatus.filter(item => item === "구매확정").length;
	$('#buyConfirmationCount').text(buyConfirmationCount);
});

</script>
<div class="body">
<c:choose>
<c:when test="${not empty ordersList }">
<h1 align="left" style="margin-top: 45px; margin-left: 10px;">주문내역</h1>
<c:forEach var="ordersList" items="${ordersList }" varStatus="c">
<div class="ordersListContainer">
<script>
	var index = ${c.count - 1};
</script>
	<input type="hidden" class="orderDate" value="${ordersList.orderDate }" />
	<input type="hidden" class="joinNO" value="${ordersList.joinNO }" />
	<p class="date"></p>
		<div class="ordersListItems">
			<a href="/product/selectProduct.do?productNO=${ordersList.productNO }&productName=${ordersList.productName }">
			<div class="ordersBody">
				<img src="/product/productThumbnail.do?articleNO=${ordersList.productNO }&image=${ordersList.imageFilename }" width="150px" height="150px" style="margin-left:10px">
				<div class="orderBodyContent">
					<p class="orderContentProdName">${ordersList.productName }</p>
					<p class="orderContentOrderOption">${ordersList.orderProductOptions }</p>
					<p class="orderContentOrderAmount">
					<fmt:formatNumber value="${ordersList.orderAmount }" pattern="#,#00" />원
					, ${ordersList.orderQty }개</p>
				</div>
			</div>
			</a>
			<div class="completeBtn">
				<c:choose>
				<c:when test="${empty ordersList.deliveryStatus && ordersList.orderStatement == '결제완료' }">
					<div class="statusText">${ordersList.orderStatement }</div>
					<form action="/cre/creForm.do" method="post">
						<input type="hidden" name="orderNO" value="${ordersList.orderNO}" />
						<input type="hidden" name="memberId" value="${ordersList.memberId }" />
						<input type="hidden" name="productNO" value="${ordersList.productNO }" />
						<input type="hidden" name="creStatement" value="취소" />
						<button class="deli_btn1">주문 취소</button>
					</form>
				</c:when>
				<c:when test="${ordersList.deliveryStatus == '배송준비' }">
					<div class="statusText">${ordersList.deliveryStatus }</div>
				</c:when>
				<c:when test="${ordersList.deliveryStatus == '배송중' }">
					<div class="statusText">${ordersList.deliveryStatus }</div>
				</c:when>
				<c:when test="${ordersList.deliveryStatus == '배송완료' && ordersList.orderStatement == '결제완료' }">
					<div class="statusText">${ordersList.deliveryStatus }</div>
					<form action="/mypage/delivery/buyCompleteDelivery.do" method="post">
						<input type="hidden" name="orderNO" value="${ordersList.orderNO}" />
						<input type="hidden" name="memberId" value="${ordersList.memberId }" />
						<input type="hidden" name="productNO" value="${ordersList.productNO }" />
						<input type="hidden" name="orderStatement" value="구매확정" />
						<button class="deli_btn1">구매확정</button>
					</form>
					<form action="/cre/creForm.do" method="post">
						<input type="hidden" name="orderNO" value="${ordersList.orderNO}" />
						<input type="hidden" name="memberId" value="${ordersList.memberId }" />
						<input type="hidden" name="productNO" value="${ordersList.productNO }" />
						<input type="hidden" name="creStatement" value="반품/교환신청" />
						<button class="deli_btn2">반품/교환신청</button>
					</form>
				</c:when>
				<c:when test="${ordersList.orderStatement == '구매확정'}">
					<div class="statusText">${ordersList.orderStatement }</div>
					<c:if test="${ordersList.mi == 'null' }">
						<form action="/review/reviewForm.do" method="get">
							<input type="hidden" name="productNo" value="${ordersList.productNO }" />
							<input type="hidden" name="orderNo" value="${ordersList.orderNO }" />
							<input type="hidden" name="orderStatement" value="리뷰작성" />
							<button class="deli_btn1">리뷰작성</button>
						</form>
					</c:if>
					<c:if test="${ordersList.mi != 'null' }">
						<div class="reviewComplete">리뷰 작성 완료</div>
					</c:if>
				</c:when>
				<c:otherwise>
					<div class="statusText">${ordersList.orderStatement }</div>				
				</c:otherwise>
				</c:choose>
			</div>
		</div>
</div>
</c:forEach>
</c:when>
<c:otherwise>
<div class="notHave">
	<h1 align="center">아직 주문한 상품이 없어요.</h1>
	<form action="/product/productList.do" >
		<button class="deli_btn3">상품 담으러 가기</button>
	</form>
</div>
</c:otherwise>
</c:choose>
</div>
</body>
</html>