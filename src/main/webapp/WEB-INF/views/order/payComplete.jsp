<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 완료 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>

body {
font-family: Arial, sans-serif;
}

.containerComplete {
	width: 100%;
	max-width: 500px;
	margin: 60px auto;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 6px;
	padding: 30px;
	text-align: center;
}

/* 주문 완료 타이틀 */
.title {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
}
/* 결제 금액 */
.amount {
	font-size: 20px;
	color: #ff4d4d;
	margin-bottom: 30px;
}
/* 주문 상세 정보 박스 */
.order-box {
	text-align: left;
	margin: 0 auto;
	display: inline-block;
	width: 100%;
	border-top: 1px solid #eee;
	border-bottom: 1px solid #eee;
	padding: 20px 0;
	margin-bottom: 20px;
}

.order-box p {
	margin-bottom: 8px;
	line-height: 1.5;
}

.order-label {
	font-weight: bold;
	display: inline-block;
	width: 80px;
}

.order-value {
	display: inline-block;
}
/* 홈으로 버튼 */
.home-buttonComplete {
	display: inline-block;
	padding: 12px 30px;
	background-color: #00A9FF;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
}

.home-buttonComplete:hover {
	background-color: #008ED6;
}

.product-box {
	border: 1px solid #ccc;
	padding: 10px;
	width: 438px; /* 박스 너비 */
	margin-bottom: 15px;
	display: flex; /* 가로 배치 */
	align-items: center;
}

.product-box img {
	width: 130px;
	height: 130px;
	object-fit: cover; /* 이미지 비율 유지 */
	margin-right: 15px; /* 이미지와 텍스트 사이 간격 */
}

.form-group {
	margin-bottom: 20px;
	text-align: left;
}
</style>
</head>

<body>
	<div class="containerComplete">
		<!-- 주문 완료 타이틀 -->
		<div class="title">주문 완료</div>
			<c:forEach var="productList" items="${productList}">
			<div class="product-box">
				<!-- 이미지 -->
				<img src="/product/productThumbnail.do?articleNO=${productList.productNo }&image=${productList.imageFileName }" />
				<div style="display: flex; flex-direction: column;">
					<div class="form-group" style="margin: 0; padding: 0;">
						<p style="margin: 10px 0;"><strong>상품명: </strong>${productList.productName}</p>
					</div>
					
					<div class="form-group" style="margin: 0; padding: 0;">
						<p style="margin: 10px 0;"><strong>옵션: </strong>${productList.orderProductOptions}</p>
					</div>
					<div class="form-group" style="margin: 0; padding: 0;">
						<p style="margin: 10px 0;"><strong>수량: </strong>${productList.orderQty}개</p>
					</div>
				</div>
			</div>
			</c:forEach>
			
		<!-- 결제 금액 -->
		<div class="amount">
			<p><strong>총 결제금액:</strong> <fmt:formatNumber value="${orderInfo.orderAmount}" type="number" pattern="#,##0" /> 원</p>
		</div>

		<!-- 주문 상세 정보 -->
		<div class="order-box">
			<!-- 주문번호 -->
			<div class="order-value">
				<p><strong>주문번호</strong> ${orderInfo.joinNo}</p>
			</div>
			<br>
			<!-- 결제방식 -->
			<div class="order-value">
				<p><strong>결제방식</strong> ${orderInfo.orderPaytype}</p>
			</div>
			<br>
			<!-- 배송지 -->
			<div class="order-value">
				<p><strong>배송지</strong> <%-- ${orderInfo.orderZip1} --%>${orderInfo.orderZip2}${orderInfo.orderZip3}
				</p>
			</div>
			<br>
		</div>

		<!-- 홈으로 버튼 (메인 페이지로 이동) -->
		<a href="/" class="home-buttonComplete">홈으로</a>

	</div>
</body>
</html>