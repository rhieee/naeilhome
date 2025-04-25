 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>상품 상세 정보</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 카카오톡 공유하기 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js"
	integrity="sha384-DKYJZ8NLiK8MN4/C5P2dtSmLQ4KwPaoqAfyA/DfmEc1VDxu4yyC7wy6K1Hs90nka" crossorigin="anonymous"></script>
<script> Kakao.init('5ff589f7091052bd813bcb52440ea4f1'); </script>

<style>

body {
	font-family: Arial, sans-serif;
}

.container {
	display: flex;
	justify-content: space-between;
	width: 100%;
	margin-left: auto;
	margin-right: auto;
	min-width: 1357px;
	max-width: 1357px;
}

/* 상품 정보를 왼쪽 정렬  */
.right-section {
	width: 50%;
	text-align: left;
}

.product-title {
	font-size: 24px;
	font-weight: bold;
	text-align: left;
}

.product-price {
	font-size: 20px;
	color: black;
	margin-top: 10px;
	text-align: left;
}

.product-description {
	margin-top: 15px;
	color: black;
	text-align: left;
}

.thumbnail {
	width: 100%;
	height: auto;
	border: 1px solid #ddd;
}

.additional-images {
	display: flex;
	gap: 10px;
	margin-top: 10px;
	color: black;
}

.additional-images img {
	width: 70px;
	height: auto;
	cursor: pointer;
}

.right-section {
	margin-top: 90px;
	margin-left: 50px;
	width: 50%;
}

.product-title {
	font-size: 24px;
	font-weight: bold;
}

.product-price {
	font-size: 20px;
	color: black;
	margin-top: 10px;
}

.product-description {
	margin-top: 15px;
	color: black;
}
/* 리뷰, 배송비  */
.review-text, .shipping-text {
	margin-top: 10px;
	font-weight: bold;
	font-size: 20px;
}
/* 수량 */
.quantity-container, .option-container {
	margin-top: 15px;
	display: flex;
	align-items: center;
	gap: 10px;
}

/* 수량버튼 색상 변경 */
.quantity-btn {
	padding: 3px 8px;
	font-size: 15px;
	cursor: pointer;
 	border: 1px solid #8c8c8c;
    background-color: white;
	color: black;
	border-radius: 5px;
}

.quantity-btn:hover {
	  background-color: #e4e4e4;
}

/* 옵션 선택 */
.option-container {
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	margin-top: 15px;
	width: 100%;
}

.option-label {
	font-weight: bold;
	margin-bottom: 5px;
}

#option-select {
	width: 65%;
	padding: 10px;
	border: 1.5px solid #4D4D4D;
	border-radius: 10px;
	background-color: white;
	font-size: 14px;
	cursor: pointer;
}

.button-container {
	margin-top: 20px;
}

.basket-btn, .order-btn, .ask-btn {
	width: 32%;
	padding: 10px;
	font-size: 16px;
	cursor: pointer;
	border: none;
}

.basket-btn {
	border: 1.5px solid #4D4D4D;
	background-color: white;
	color: black;
	border-radius: 10px;
}
.basket-btn:hover, .ask-btn:hover{
	background-color: #f9faf7;
}

.order-btn {
	border: 1.5px solid #00A9FF;
	background-color: #00A9FF;
	color: white;
	border-radius: 10px;
}
.order-btn:hover {
	background-color: #008ED6;
}

.ask-btn {
	border: 1.5px solid #4D4D4D;
	background-color: white;
	color: black;
	border-radius: 10px;
	margin-bottom: 50px;
	display: inline-block; /* inline-block으로 설정 */
	margin-left: auto;
	margin-right: auto;
}

.tab-container {
	margin-top: 100px;
	display: flex;
	justify-content: space-around;
	margin-bottom: 15px;
	border: 1.5px solid #4D4D4D;
}
/* 기본 탭 버튼 스타일 */
.tab-button {
	background-color: white;
	color: black;
	padding: 10px;
	text-align: center;
	display: inline-block;
	width: 25%;
	border: 1px solid #4D4D4D;
	cursor: pointer;
}

.tab-button.active {
	background-color: #4D4D4D; /* 선택된 탭 색상 */
	color: white;
}

.tab-button:hover {
	background-color: #4D4D4D;
	color: white;
}

.detail-section {
	margin-top: 30px;
	padding: 20px;
	border: 1px solid #ddd;
	min-height: 200px;
	text-align: center;
}

.share-btns {
	padding: 2px 10px;
	font-size: 14px;
	cursor: pointer;
	border: none;
	background-color: #99E0FF;
	color: white;
	border-radius: 5px;
	border: 1.5px solid white;
}

.share-btns:hover {
	background-color: #66CEFF;
}

#share-options {
  display: none;
  position: absolute;
  bottom: 100%;         /* 버튼 위로 붙이기 */
  left: 0;
  margin-bottom: 10px;  /* 버튼과 간격 */
  background: white;
  padding: 10px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
  flex-direction: row;
  gap: 10px;
  z-index: 999;
}


/* 공유 아이콘 공통 (URL,카카오톡 공유) */
.share-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  border: none;
  background: none;
  padding: 0;
  margin: 5px;
  cursor: pointer;
  vertical-align: middle;
}

.share-icon-link {
  display: inline-block;
  cursor: pointer;
  vertical-align: middle;
}

.button-container {
	display: flex; /* 두 버튼을 가로로 나란히 배치 */
	align-items: center; /* 버튼의 세로 정렬 */
	gap: 15px; /* 버튼 사이 간격 */
}

/* 상품 리뷰 제목 */
.review-title {
	font-size: 24px;
	font-weight: bold;
	margin-top: 20px;
	text-align: left; /* 중앙 정렬 */
}

/* 전체 별점과 별점 항목들을 하나의 박스에 중앙 정렬 */
.review-summary {
	display: flex;
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	gap: 50px; /* 왼쪽과 오른쪽 간 간격 */
	width: 100%; /* 부모 요소에 맞게 전체 너비 사용 */
}

/* 리뷰 박스 (전체 정렬) */
.review-box {
	display: flex;
	justify-content: center; /* 왼쪽과 오른쪽 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	width: 100%;
	gap: 100px; /* 내부 간격 */
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 20px;
	border-radius: 5px;
	background-color: #f9f9f9;
}

/* 총 별점 박스 */
.total-stars {
	display: flex;
	flex-direction: column;
	align-items: center; /* 왼쪽 정렬 */
	gap: 10px; /* 총 별점과 리뷰 개수 사이의 간격 */
}

/* 별점 이미지 영역 */
.product-rating-box {
	display: flex;
	flex-direction: column;
	align-items: flex-end; /* 오른쪽 정렬 */
	justify-content: center;
	padding: 10px; /* 박스 안쪽 여백 */
	border: 1px solid #ccc; /* 박스 테두리 */
	border-radius: 8px; /* 둥근 테두리 */
	background-color: #f9f9f9; /* 박스 배경색 */
}

.product-rating {
	display: flex;
	justify-content: center; /* 별점 이미지들 가운데 정렬 */
	gap: 5px; /* 별점 간 간격 */
}

.product-rating img {
	width: 23px; /* 별 이미지 크기 */
}

.rating-info {
	display: flex;
	justify-content: center;
	gap: 10px; /* 평균 별점과 리뷰 개수 사이 간격 */
	font-size: 16px;
	color: #333;
}

/* 별점 항목들 */
.rating-details {
	display: flex;
	flex-direction: column; /* 별점 항목들 수직 정렬 */
	gap: 3px; /* 항목 간 간격 */
}

/* 개별 별점 항목 */
.rating-item {
	display: flex;
	align-items: center; /* 텍스트와 별점 이미지를 수평으로 정렬 */
	gap: 10px; /* 텍스트와 별점 사이 간격 */
}

/* 별점 이미지 영역 */
.stars {
	display: flex;
	gap: 5px; /* 별점 간 간격 */
}

/* 별점 항목 텍스트 스타일 */
.rating-label {
	font-size: 18px;
	font-weight: bold;
}

/* 리뷰 섹션 */
.review-section {
	margin-top: 20px;
}

/* 각 리뷰의 스타일 */
.review-item {
	border: 1px solid #ddd;
	padding: 15px;
	margin-bottom: 20px;
	border-radius: 5px;
	background-color: #f9f9f9;
}

/* 프로필 사진 */
#profileImage {
	width: 35px;
	height: 35px;
	border-radius: 50%;      /* 동그란 형태 */
	object-fit: cover;       /* 비율 유지하면서 채우기 */
	display: inline-block;   /* 줄바꿈 방지 */
	vertical-align: middle;  /* 텍스트 기준 수직 정렬 */
}

/* 작성자 이름 */
.review-author {
	display: flex;           /* 수평 정렬 */
	align-items: center;     /* 수직 중앙 정렬 */
	font-size: 18px;
	font-weight: bold;
	text-align: left;
	margin-bottom: 5px;
	padding-top: 10px;
	padding-left: 5px;
	gap: 10px;                /* 이미지와 닉네임 사이 간격 */
}

.review-author .member-nickname {
	display: inline-block;
	vertical-align: middle;
}


/* 별점과 날짜를 한 줄로 나열하고 왼쪽 정렬 */
.review-stars-date {
	display: flex;
	justify-content: flex-start; /* 왼쪽 정렬 */
	gap: 10px; /* 별점과 날짜 간의 간격 */
	align-items: center;
	padding-left: 5px; /* 왼쪽 여백 추가 */
}

/* 별점 */
.review-stars {
	display: flex;
	gap: 5px;
}

/* 리뷰 날짜 */
.review-date {
	font-size: 16px;
	color: #888;
}

/* 리뷰 내용과 이미지가 같은 줄에 표시되도록 flex 사용 */
.review-content-wrapper {
	display: flex;
	justify-content: space-between; /* 내용과 이미지를 좌우로 배치 */
	align-items: flex-start; /* 수직 정렬을 위로 맞춤 */
	gap: 10px; /* 내용과 이미지 간 간격 */
	text-align: left;
}

/* 리뷰 내용 */
.review-content {
	display: flex; /* 왼쪽정렬 안돼서 flex로 줌 */
	font-size: 18px;
	color: #333;
	margin-bottom: 10px; /* 내용과 이미지 사이 간격 */
	padding-left: 5px; /* 왼쪽 여백 추가 */
}

.review-image {
	width: 150px;
	height: 150px;
	object-fit: contain; /* 원본 비율 유지 */
	background-color: #f3f3f3;
	border: 1px dashed #ccc;
	border-radius: 5px;
	margin-right: 20px;
	cursor: pointer; /* 클릭할 수 있음을 표시 */
	transition: transform 0.3s ease; /* 이미지 크기 변화를 부드럽게 */
}

/* 이미지 없는 경우 스타일(myReviewList.jsp와 동일) */
.review-img.placeholder {
	width: 150px;
	height: 150px;
	background-color: #f3f3f3;
	border: 1px dashed #ccc;
	border-radius: 5px;
	margin-right: 20px;
}

/* 이미지 띄우는 모달 스타일 */
.modal {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 1; /* 최상위 */
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
	overflow: auto; /* 필요시 스크롤 */
	padding-top: 60px;
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
}

/* 모달 안의 이미지 스타일 */
.modal-content {
	margin: auto;
	display: block;
	width: 80%;
	max-width: 700px;
}

/* 모달의 닫기 버튼 */
.close {
	position: absolute;
	top: 15px;
	right: 35px;
	color: white;
	font-size: 40px;
	font-weight: bold;
	transition: 0.3s;
}

.close:hover, .close:focus {
	color: #f1f1f1;
	text-decoration: none;
	cursor: pointer;
}

/* 배너 이미지 */
.additional-images {
	display: flex;
	align-items: center;
	justify-content: center;
	margin-top: 10px;
}

/* 이미지 슬라이드 컨테이너 */
.image-slider-container {
	display: flex;
	align-items: center; /* 세로 정렬 */
	justify-content: center; /* 가로 정렬 */
	gap: 10px; /* 버튼과 이미지 간격 */
	margin-top: 10px;
	margin-right: 80px;
}

/* 이미지 슬라이더 */
.image-slider {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 550px;
	height: 550px;
	overflow: hidden;
	position: relative;
}

/* 추가 이미지 (초기에는 숨김) */
.slider-image {
	width: 550px;
	height: 550px;
	display: none;
}

/* 이전/다음 버튼 (이미지 좌우 배치) */
.prevButton, .nextButton {
	background-color: transparent;
	border: none;
	font-size: 30px; /* 화살표 크기 키우기 */
	font-weight: bold;
	cursor: pointer;
	transition: 0.3s;
	color: #333; /* 기본 색상 */
	padding: 10px;
}

/* 마우스 올릴 때 버튼 강조 */
.prevButton:hover, .nextButton:hover {
	color: #000;
	opacity: 0.7;
}

/* 좋아요 버튼 스타일 */
#likeButton {
	background-color: #4D4D4D; /* 기본 색 */
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s;
}

/* no좋아요 버튼 스타일 */
#nolikeButton {
	background-color: #99E0FF; /* 기본 색 */
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s;
}
#nolikeButton:hover{
	background-color: #66CEFF;
}

/* 배송교환반품버튼누르면실행되게 해야해서 */
.hidden {
	display: none;
} /* 초기에 숨기기 */

/* 상품상세페이지 위/아래 버튼 만들기 추가 04.05 -찬희 */
.move_btns{
	font-size: 15px;
	color: white;
	font-weight: bold;
	cursor: pointer;
}
.move_top{
	background-color: #00A9FF;
	border-radius: 5px;
	padding: 10px;
	position: fixed;
	bottom: 120px;
	right: 50px;
	width: 20px;
}
.move_bottom{
	background-color: #00A9FF;
	border-radius: 5px;
	padding: 10px;
	position: fixed;
	bottom: 70px;
	right: 50px;
	width: 20px;
}
.move_top:hover{
	background-color: #008ED6;
}
.move_bottom:hover{
	background-color: #008ED6;
}
</style>
<script>
   
   /* 찜 추가 */
   function wishButton(button, event) {
       event.preventDefault();
       var isLogOn = `${isLogOn}`;
       var wishCheck = $(button).closest('form');

       // 로그인 여부 확인
       if (isLogOn === 'true' && isLogOn !== null) {
    	  var productNo = $("#wishProductNo").val();
    	  var productName = $("#wishProductName").val();
       	$.ajax({
               url: "/mypage/wishlist/wishLists.do",
               type: 'POST',
               data: {
            	   productNo: productNo,
            	   productName : productName
               },
               success: function() {
            	   if (button.id === "likeButton") {
                       button.id = "nolikeButton";
                   } else {
                       button.id = "likeButton";
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

</head>
<body>

	<!-- 이전/다음 버튼을 눌러서 이미지를 넘기는 기능을 추가하고싶다. -->
	<!-- 썸네일만 가져옴 -->
	<div class="container">
		<div class="left-section">
			<!-- 왼쪽 -->
			<!-- 이미지 슬라이드 컨테이너 -->
			<div class="image-slider-container">
				<button class="prevButton" onclick="prevImage()">
					<img src="/resources/image/prev.png" />
				</button>
				<div class="image-slider">
					<!-- 썸네일 포함하여 이미지 출력 -->
					<img
						src="/product/selectThumnail.do?productNO=${productNo}&image=${selectThumnail.imageFilename}"
						class="slider-image" />
					<c:forEach var="image" items="${selectThumnailTwo}">
						<img
							src="/product/selectThumnail.do?productNO=${productNo}&image=${image.imageFilename}"
							class="slider-image" />
					</c:forEach>
				</div>
				<button class="nextButton" onclick="nextImage()">
					<img src="/resources/image/next.png" />
				</button>
			</div>
		</div>


		<!-- 오른쪽: 상품 정보 -->
		<div class="right-section">
			<!-- 오른쪽 -->

			<div class="button-container">
				<!-- 찜버튼 추가 -->
				<div>
					<c:choose>
						<c:when test="${wishListCheck=='wishList' && isLogOn == 'true'}">
							<!-- 찜 버튼 (POST 방식으로 서버에 요청) -->
							<div>
								<input id="wishProductNo" type="hidden" name="productNo"
									value="${productDomain.productNO}" /> <input
									id="wishProductName" type="hidden" name="productName"
									value="${productDomain.productName}" />
								<button id="likeButton" onclick="wishButton(this,event)">
									❤️ 찜하기</button>
							</div>
						</c:when>
						<c:otherwise>
						<!-- 찜 버튼 (POST 방식으로 서버에 요청) -->
						<div>
							<input id="wishProductNo" type="hidden" name="productNo"
								value="${productDomain.productNO}" /> <input
								id="wishProductName" type="hidden" name="productName"
								value="${productDomain.productName}" />
							<button id="nolikeButton" onclick="wishButton(this,event)">
								❤️ 찜하기</button>
						</div>
						</c:otherwise>
					</c:choose>
				</div>
				
			    <!-- 공유하기 버튼 -->
				<div class="share-wrapper" style="position: relative; display: inline-block;">
				  <!-- 공유 옵션들 (버튼 위로 뜨게 만들기) -->
				  <div id="share-options">
				    <!-- URL 복사 버튼 -->
				    <button type="button" class="share-icon" onclick="clip();">
				      <img src="/resources/image/link_round.png" style="width: 100%; height: 100%;" />
				    </button>
				
				    <!-- 카카오톡 공유 -->
				    <a id="kakaotalk-sharing-btn" href="javascript:;">
				      <img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
				        alt="카카오톡 공유" class="share-icon" />
				    </a>
				  </div>
				
				  <!-- 공유하기 버튼 -->
				  <button type="button" class="share-btns" onclick="toggleShareOptions()">공유하기</button>
				</div>
				
			</div>
			
			<div class="product-title">
				<p>${productDomain.productName}</p>
			</div>
			<fmt:formatNumber value="${productDomain.productPrice}" type="number"
				var="price" />
			<p class="product-price">${price}원</p>
			<div class="product-description">${productDomain.productDescription}</div>

			<div class="shipping-text">배송비 3,500원</div>

			<!-- 수량 설정 -->
			<div class="quantity-container">
				<button class="quantity-btn" onclick="changeQuantity(-1)">-</button>
				<input type="text" id="quantity" value="1" size="2" readonly>
				<button class="quantity-btn" onclick="changeQuantity(1)">+</button>
			</div>

			<!-- 옵션 선택 -->
			<div class="option-container">
				<label class="option-label">옵션 선택</label>
				<!-- 그냥 텍스트 -->
				<select id="option-select">
					<!-- 옵션선택창 -->
					<c:forEach var="option" items="${productList}">
						<!-- 옵션가져옴 -->
						<option class="productOptions" value="${option.productNO }">${option.productOptions}</option>
						<!-- 옵션보여줌 -->
					</c:forEach>
				</select>
				<!-- 옵션선택창 끝-->
			</div>

			<!-- 버튼 -->
			<div class="button-container">
				<button class="basket-btn" onclick="toBasket()">장바구니 담기</button>
				<button class="order-btn" onclick="toOrder()">바로 구매</button>
			</div>

		</div>
	</div>
	<!-- 뒤에서 두번째가 오른쪽 상품정보 마지막div -->


	<!-- 네비게이션 탭 -->
	<div class="tab-container">
		<a class="tab-button productInfoBtn active">상품정보</a>
		<a	class="tab-button productReview" href="#reviewTitle">리뷰</a>
		<a class="tab-button productAsk" href="#ask">문의</a> 
		<a class="tab-button productCreBtn">배송 / 교환 / 반품</a>
	</div>

	<div class="move_btns">  <!-- 04.05 추가 - 찬희 -->
		<div class="move_top" onclick="moveTop()">▲</div>
		<div class="move_bottom" onclick="moveBottom()">▼</div>
	</div>

	<!-- 배송/교환/반품 정보 (처음엔 안 보이게) -->
	<div class="productCreContent" style="display: none;"></div>


	<!-- 상세 이미지 -->
	<div class="detail-section">
		<img
			src="/product/selectProductDetailImage.do?productNO=${productDomain.productNO}&image=${selectThumnail.imageFilename}"
			style="width: 1300px; height: auto; display: block; margin: 0 auto;" />
	</div>



	<div class="review-title" id="reviewTitle">상품 리뷰</div>

	<!-- 리뷰 전체 영역 -->
	<div class="review-summary">
		<!-- 총 별점과 별점 항목들을 하나의 박스에 합치기 -->
		<div class="review-box">
			<!-- review-box 추가 -->
			<!-- 왼쪽: 총 별점 -->
			<div class="total-stars">
				<!-- 평균 별점 계산 -->
				<c:set var="averageStars" value="${averageStars}" />
				<!-- 평균 별점 -->
				<c:set var="reviewCount" value="${reviewCount}" />
				<!-- 리뷰 개수 -->

				<!-- 반올림된 별점 대신 소수점 기준으로 별점 계산 -->
				<c:set var="roundedStars" value="${roundedStars}" />
				<!-- Java에서 전달받은 반올림된 별점 -->

				<!-- 별점 출력 -->
				<div class="product-rating">
					<c:forEach var="i" begin="1" end="5">
						<c:choose>
							<c:when test="${i <= roundedStars}">
								<img src="/resources/image/iconStar1.png"
									width="23px" alt="노란별" />
							</c:when>
							<c:otherwise>
								<img src="/resources/image/iconStar2.png"
									width="23px" alt="까만별" />
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</div>
				<div class="rating-info">
					<span class="average-rating">평균 ${averageStars}점
						(${reviewCount}개의 리뷰)</span>
				</div>
			</div>

			<!-- 오른쪽: 별점 항목들 -->
			<div class="rating-details">
				<div class="rating-item">
					<span class="rating-label">내구성&nbsp;&nbsp;&nbsp;</span>
					<div class="stars">
						<!-- 내구성 별점, 초기값을 0으로 설정 -->
						<c:set var="durabilityStars"
							value="${totalDurability eq 0 ? 0 : totalDurability / reviewCount}" />
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= durabilityStars}">
									<img src="/resources/image/iconStar1.png"
										width="15px" alt="노란별" />
								</c:when>
								<c:otherwise>
									<img src="/resources/image/iconStar2.png"
										width="15px" alt="까만별" />
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>

				<div class="rating-item">
					<span class="rating-label">가성비&nbsp;&nbsp;&nbsp;</span>
					<div class="stars">
						<!-- 가성비 별점, 초기값을 0으로 설정 -->
						<c:set var="priceStars"
							value="${totalPrice eq 0 ? 0 : totalPrice / reviewCount}" />
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= priceStars}">
									<img src="/resources/image/iconStar1.png"
										width="15px" alt="노란별" />
								</c:when>
								<c:otherwise>
									<img src="/resources/image/iconStar2.png"
										width="15px" alt="까만별" />
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>

				<div class="rating-item">
					<span class="rating-label">디자인&nbsp;&nbsp;&nbsp;</span>
					<div class="stars">
						<!-- 디자인 별점, 초기값을 0으로 설정 -->
						<c:set var="designStars"
							value="${totalDesign eq 0 ? 0 : totalDesign / reviewCount}" />
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= designStars}">
									<img src="/resources/image/iconStar1.png"
										width="15px" alt="노란별" />
								</c:when>
								<c:otherwise>
									<img src="/resources/image/iconStar2.png"
										width="15px" alt="까만별" />
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>

				<div class="rating-item">
					<span class="rating-label">배송만족</span>
					<div class="stars">
						<!-- 배송 만족 별점, 초기값을 0으로 설정 -->
						<c:set var="deliveryStars"
							value="${totalDelivery eq 0 ? 0 : totalDelivery / reviewCount}" />
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= deliveryStars}">
									<img src="/resources/image/iconStar1.png"
										width="15px" alt="노란별" />
								</c:when>
								<c:otherwise>
									<img src="/resources/image/iconStar2.png"
										width="15px" alt="까만별" />
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>
				</div>
			</div>


		</div>
	</div>



<!-- 리뷰 내용 -->
<div class="review-section">
	<c:forEach var="review" items="${reviews}">
	<div class="review-item">
		<!-- 작성자 이름 -->
		<%-- <div class="review-author">${review.memberId}</div> --%>
		<div class="review-author">

			<!-- 변수 초기화 -->
		<c:set var="matchedMember" value="" />
              <c:forEach var="member" items="${memberList}">
                  <c:if test="${member.memberId == review.memberId}">
                      <c:set var="matchedMember" value="${member}" />
                  </c:if>
              </c:forEach>

              <c:choose>
                  <c:when test="${empty matchedMember.memberImage}">
                      <img id="profileImage" src="/resources/image/mypage.png" />
                  </c:when>
                  <c:otherwise>
                      <!-- 프로필 이미지가 있는 경우 이미지 출력 -->
                      <a href="/board/board_myhome/yourPageMyHomeList.do?yourId=${matchedMember.memberId}">
                          <img id="profileImage" src="/memberProfileImage/${matchedMember.memberId}/${matchedMember.memberImage}" />
                      </a>
                  </c:otherwise>
              </c:choose>

			<c:if test="${matchedMember.memberNickname != null}">
              <div class="member-nickname">
                  ${matchedMember.memberNickname}
              </div>
              </c:if>
              
              <c:if test="${matchedMember.memberNickname == null}">
              <div class="member-nickname">
                 탈퇴회원
              </div>
              </c:if>

		</div>


				<!-- 별점과 리뷰 날짜 한 줄로 표시 -->
				<div class="review-stars-date">
					<!-- 별점 -->
					<div class="review-stars">
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= review.reviewStarAvg}">
									<img src="/resources/image/iconStar1.png"
										width="15px" alt="노란별" />
								</c:when>
								<c:otherwise>
									<img src="/resources/image/iconStar2.png"
										width="15px" alt="까만별" />
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</div>

					<!-- 리뷰 날짜 -->
					<div class="review-date">
						<fmt:formatDate value="${review.reviewUpdated}"
							pattern="yyyy-MM-dd" />
					</div>
				</div>

				<!-- 리뷰 본문 내용과 이미지 (같은 줄로 배치) -->
				<div class="review-content-wrapper">
					<!-- 리뷰 내용 왼쪽 -->
					<div class="review-content">
						<p>${review.reviewContents}</p>
					</div>


					<!-- 리뷰 이미지 -->
					<div class="review-image-box">
						<c:set var="hasImage" value="false" />
						<c:forEach var="image" items="${imageList}">
							<c:if
								test="${image.articleNO == review.reviewNo && not empty image.imageFilename}">
								<!-- 이미지를 보여줍니다. -->
								<img
									src="/review/imagesReview.do?reviewNo=${review.reviewNo}&imageName=${image.imageFilename}"
									alt="Review Image" class="review-image"
									onclick="reviewImageSize(this)" />
								<!-- 클릭시 이미지 띄우는거임 밑에 스크립트 -->
								<div id="imageModal" class="modal">
									<span class="close" onclick="closeModal()">&times;</span> <img
										class="modal-content" id="modalImage">
									<div id="caption"></div>
								</div>


								<c:set var="hasImage" value="true" />
							</c:if>
						</c:forEach>

						<!-- 이미지 없을 때 기본 이미지 표시 -->
						<c:if test="${not hasImage}">
							<div class="review-img placeholder"></div>
							<!-- 기본 이미지 표시 -->
						</c:if>
					</div>



				</div>
			</div>
		</c:forEach>
	</div>
	<c:if test="${empty reviews}">
		<div class="no-reviews" style="font-size: 15px;">작성된 리뷰가 없습니다.</div>
		<br>
	</c:if>

	<div class="button-container">
        <a href="/board/board_question/questionForm.do?productNO=${productDomain.productNO}"
           class="ask-btn" id="ask" onclick="return productInquiry();">상품문의</a>
    </div>

<script type="text/javascript">

      function productInquiry() {
        // 세션에 memberId가 존재하면 그 값을, 없으면 빈 문자열("")로 출력
        var memberId = '<%= (session.getAttribute("member") != null ? session.getAttribute("member") : "") %>';
        if (memberId === "") {
          // 세션에 memberId가 없으면 confirm 창을 띄워 로그인 페이지로 이동할지 물어봄
          if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
            window.location.href = '/member/loginForm.do';
          }
          // false를 리턴하여 기본 링크 이동을 막음
          return false;
        } else {
          // 로그인 되어 있을 경우, 상품문의 페이지로 이동
          window.location.href = '/board/board_question/questionForm.do?productNO=${productDomain.productNO}';
          return false;
        }
      }
</script>

<script>
// [로그인 여부 확인] (04.05 추가 - 찬희)
const isLogin = ${sessionScope.member != null ? 'true':'false'};

   // 장바구니 추가
   // 장바구니 추가(찬희)
function toBasket() {
	
	//로그인확인 얼럿 띄우기
	if(!isLogin) {
		alert("로그인 후 이용할 수 있습니다.");
		location.href= "/member/loginForm.do";
		return;
	}
    var basketProductQty = document.getElementById("quantity").value;
    var options = document.getElementById("option-select").value;
    location.href = "/basket/addBasket.do?productNO=" + options
                      + "&basketProductQty=" + basketProductQty
 // 품절 여부 확인 (콘솔창에 띄우기)
    var isQtyZero = "${isQtyZero}";
    if (isQtyZero === "true") {
        alert("이 상품은 품절되었습니다.");
        return;
    }
}
   
// 바로구매(찬희)
function toOrder() {
	//로그인확인 얼럿 띄우기
	if(!isLogin) {
		alert("로그인 후 이용할 수 있습니다.");
		location.href= "/member/loginForm.do";
		return;
	}
	var options = document.getElementById("option-select").value;
    var productQty = document.getElementById("quantity").value;
    location.href = "/addOrder.do?productNO=" + options
    + "&productQty=" + productQty;
}
   
   
//수량 증감(찬희)
//최대수량 제한(04.05 수정 - 찬희)
const maxQty = ${productDomain.productQty}; // 최대수량 변수선언
console.log("최대 수량 (maxQty)=", maxQty);

//수량변경함수
function changeQuantity(change){
	const qtyInput = document.getElementById("quantity"); //수량
	let currentQty = parseInt(qtyInput.value) || 1;       //현재수량 (아님1)
	
	let newQty = currentQty+change; //현재수량+입력된수량
	if(newQty < 1){ newQty = 1;}    //수량 최소값
	if(newQty > maxQty){
		alert("재고수량을 초과할 수 없습니다.");
		newQty = maxQty;            //수량 최대값
	}
	qtyInput.value = newQty; //최종수량
}
   
       
//상세이미지 (넘겨서 나오는 이미지들)
let currentIndex = 0;

function showImages(index) {
    let images = document.querySelectorAll(".slider-image");
    let totalImages = images.length;

    if (totalImages === 0) return; // 이미지가 없으면 실행 안 함
 // 인덱스가 범위를 벗어나지 않도록 설정
    if (index < 0) {
        currentIndex = totalImages - 1;
    } else if (index >= totalImages) {
        currentIndex = 0;
    } else {
        currentIndex = index;
    }
 // 모든 이미지 숨기고 현재 인덱스 이미지만 보이게 함
    images.forEach((img, i) => {
        img.style.display = (i === currentIndex) ? "block" : "none";
    });
}

function prevImage() { //이전이미지
    showImages(currentIndex - 1);
}

function nextImage() { //다음이미지
    showImages(currentIndex + 1);
}

// 페이지 열리면, 초기 실행되는 함수
window.onload = function() {
    showImages(currentIndex);
};
    
//modal 모달 띄우는거 이미지클릭시 창 띄우는거(04.02 추가 - 찬희)
function reviewImageSize(image){
	var modal = document.getElementById("imageModal");
	var modalImage = document.getElementById("modalImage");
modal.style.display="block"; //모달띄움
modalImage.src =image.src;   //클릭된걸 모달에적용

}

function closeModal() {
	var modal = document.getElementById("imageModal");
	modal.style.display="none"; //모달숨김
}
 
//배송교환반품 안내문구 ajax (04.04 추가 - 찬희)
$(document).ready(function(){
    let productCreLoaded = false;   //변수

    $(".productCreBtn").click(function(){   //배송/교환/반품 버튼클릭시 실행
        const $productCreContent = $(".productCreContent"); //안내문구
        const $detailSection = $(".detail-section");        //상세
        const $reviewTitle = $(".review-title");            //'상품리뷰'글자
        const $reviewSummary = $(".review-summary");        //리뷰별점
        const $reviewSection = $(".review-section");        //리뷰
        const $noReviews = $(".no-reviews");                //리뷰없을때
        const $askBtn = $(".ask-btn");                      //'상품문의' 버튼

        if (!productCreLoaded) {
            $.ajax({
                url: "/product/productCre",
                type: "GET",
                dataType: "json",
                success: function(response) {
                    $productCreContent.html(response.message).slideDown(); //이미지 부드럽게
                    $detailSection.hide();   //상세이미지 숨김
                    $reviewTitle.hide();     //리뷰(제목) 숨김
                    $reviewSummary.hide();   //리뷰(별점) 숨김
                    $reviewSection.hide();   //리뷰(목록) 숨김
                    $noReviews.hide();       //리뷰(리뷰없을때 글자) 숨김
                    $askBtn.hide();          //상품문의 숨김
                    productCreLoaded = true; //재요청 방지
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 오류 발생: ", error);
                }
            });
        } else {
            $productCreContent.slideDown();  //ajax없이 토글만
            $detailSection.hide();
            $reviewTitle.hide();
            $reviewSummary.hide();
            $reviewSection.hide();
            $noReviews.hide();
            $askBtn.hide();
        }
    });

    // 상품정보 탭 클릭
    $(".productInfoBtn").click(function() {
        $(".tab-button").removeClass("active");
        $(this).addClass("active");

        $(".productCreContent").slideUp();  //배송교환환불 안내문구 닫기
        $(".review-title").slideUp();
        $(".review-summary").slideUp();
        
        $(".detail-section").slideDown();   //상세이미지 다시 보이게
        $(".review-title").slideDown();
        $(".review-summary").slideDown();
        $(".review-section").slideDown();
        $(".no-reviews").slideDown();
        $(".ask-btn").slideDown();
    });
    

    // 리뷰 탭 클릭
    $(".productReview").click(function() {
        $(".tab-button").removeClass("active");
        $(this).addClass("active");

        $(".productCreContent").slideUp();   //배송교환환불 안내문구 닫기
        $(".detail-section").slideUp();
        
        //$(".detail-section").slideDown();  //상세이미지 다시 보이게
        $(".review-title").slideDown();
        $(".review-summary").slideDown();
        $(".review-section").slideDown();
        $(".no-reviews").slideDown();
        $(".ask-btn").slideDown();
    });
 
 // 문의 탭 클릭 (04.05 추가 - 찬희)
    $(".productAsk").click(function() {
        $(".tab-button").removeClass("active");
        $(this).addClass("active");

        $(".productCreContent").slideUp();   //배송교환환불 안내문구 닫기
        $(".detail-section").slideUp();
        
        //$(".detail-section").slideDown();  //상세이미지 다시 보이게
        $(".review-title").slideDown();
        $(".review-summary").slideDown();
        $(".review-section").slideDown();
        $(".no-reviews").slideDown();
        $(".ask-btn").slideDown();
    });
    
}); //배송교환반품 안내문구 ajax End

//상품정보/리뷰/문의/배송교환반품 탭클릭시 -> 이벤트리스너발생 (active제거하고 새로 띄우는거) (04.04 추가 - 찬희)
document.addEventListener("DOMContentLoaded", function () {
    const tabs = document.querySelectorAll(".tab-button"); // 탭 버튼 요소 가져오기

    tabs.forEach(tab => {
        tab.addEventListener("click", function () {
            // 모든 탭에서 active 클래스 제거
            tabs.forEach(t => t.classList.remove("active"));

            // 클릭한 탭에 active 클래스 추가
            this.classList.add("active");
        });
    });
}); //addEventListener End

//맨위로가기 맨밑으로가기
function moveTop(){
	window.scrollTo({top: 0, behavior: "smooth"});
};
function moveBottom(){
	window.scrollTo({top: document.body.scrollHeight, behavior: "smooth"});
};

</script>

<script>
// URL 복사

 function clip() {
			    var url = window.document.location.href;  // 현재 URL을 가져옵니다.
			    var textarea = document.createElement("textarea");
			    textarea.value = url;
			    document.body.appendChild(textarea);
			    textarea.select();
			    document.execCommand("copy");  // 클립보드에 복사합니다.
			    document.body.removeChild(textarea);
			    alert("URL이 클립보드에 복사되었습니다.");
			  }

// 카카오톡 공유하기

  Kakao.Share.createDefaultButton({
    container: '#kakaotalk-sharing-btn',
    objectType: 'feed',
    content: {
      title: `${productDomain.productName}`,
      description: `${productDomain.productDescription}`, 
      imageUrl:  // 테스트 이미지 삽입, 썸네일이미지로 바꾸면 됨.(현재 로컬이미지라 불가)
        'https://images.pexels.com/photos/271743/pexels-photo-271743.jpeg',
      link: {  // 등록한 사이트 도메인과 일치해야 함
        webUrl: 'http://localhost:8090',
      },	
    },
    social: {

    },
    buttons: [
      {
        title: '홈페이지 바로가기',
        link: {
          webUrl: 'http://localhost:8090/product/selectProduct.do?productNO='+`${productDomain.productNO}`+'&productName='+`${productDomain.productName}`,
        },
      },
    ],
  });
  
  
  // 공유 옵션 토글 함수
  function toggleShareOptions() {
	event.stopPropagation(); // 이벤트 버블링 방지 (외부 클릭과 충돌 방지)
    var shareOptions = document.getElementById("share-options");
    if (shareOptions.style.display === "none") {
      shareOptions.style.display = "flex";
    } else {
      shareOptions.style.display = "none";
    }
  }  
  
//외부 클릭 시 공유 옵션 닫기
  document.addEventListener('click', function (event) {
    const shareWrapper = document.querySelector('.share-wrapper');
    const shareOptions = document.getElementById('share-options');

    // 공유 옵션이 보이고 있고, 클릭한 대상이 shareWrapper 바깥이면 닫기
    if (shareOptions.style.display === 'flex' && !shareWrapper.contains(event.target)) {
      shareOptions.style.display = 'none';
    }
  });
  

   
   

  
</script>

</body>
</html>