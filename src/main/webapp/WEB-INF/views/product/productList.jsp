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
	<title>상품 페이지</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- 자동완성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<script>
function change_btn(event) {
	var btns = document.querySelectorAll(".category");

	// 모든 버튼에서 'selected' 클래스를 제거
	btns.forEach(function(btn) {
		btn.classList.remove("selected");
	});

	// 클릭된 버튼에 'selected' 클래스를 추가
	event.currentTarget.classList.add("selected");

	// 클릭된 버튼의 값을 localStorage에 저장 - 웹에 데이터를 저장
	localStorage.setItem("selectedCategory", event.currentTarget.value);
};

// 페이지가 로드될 때, 저장된 값을 확인하여 해당 버튼에 'selected' 클래스 적용
window.onload = function() {
	var selectedCategory = localStorage.getItem("selectedCategory");
	var category = document.getElementById("find_category").value;
	
	if (!selectedCategory || category == ''){
		selectedCategory = "all";
	}
	
	if (selectedCategory) {
		var btns = document.querySelectorAll(".category");
		btns.forEach(function(btn) {
			if (btn.value === selectedCategory) {
				btn.classList.add("selected");
			}
		});
	}
	localStorage.removeItem('selectedCategory');
};

</script>

<c:set var="section" value="${productMap.section }" />
<c:set var="pageNum" value="${productMap.pageNum }" />
<c:set var="recNum" value="${productMap.recNum }" />
<c:set var="pageNo" value="${productMap.pageNO }" />
<c:set var="lastSection" value="${productMap.lastSection }" />
<c:set var="productList" value="${productMap.list }" />
<c:set var="category" value="${productMap.category }" />
<c:set var="loopOut" value="true" />

<style>
body{
	font-family: Arial, sans-serif;
}

.product{
    display:grid;
    grid-template-columns: repeat(4, minmax(300px, 1fr));
    gap: 20px 30px;
    margin-left: auto;
    margin-right: auto;
    min-width: 1357px;
  	max-width: 1357px;
}
a {
	text-decoration-line:none;
}
a:link {
	color:black;
}
.prod_category{
	border-style: solid;
    border-color: #ebece8;
    border-top: 0px;
    border-right: 0px;
    border-left: 0px;
	padding-top: 10px;
	padding-bottom: 10px;
	margin-bottom: 40px;
	min-width: 1357px;
  	max-width: 1357px;
  	margin-left: auto;
    margin-right: auto;
}
.prod_nav{
  text-align: left;
  margin-right: 10%;
}
.nav_li{
  display:inline-block;
  font-size: 18px;
  margin-right: 20px;
}
.category{
    font-weight: 900; 
    font-size: 17px; 
    background-color: rgba(255, 255, 255, 0);
    border: none;
    cursor: pointer;
}
.category:hover{
    color: #008ED6   ;
}
.category.selected{
    color: #008ED6 ;
    border: 2px solid #00A9FF;
    border-right:0px;
    border-left:0px;
    border-top:0px;
}
.pageNum{
	font-size: 25px;
}
.paging{
	margin-top: 30px;
	margin-bottom: 30px;
}
.de_list{
	position: absolute;
  	top: 50%;
  	left: 50%;
  	transform: translate(-50%, -70%);
}
/* 현오가 추가해줌 (마우스 갔다 댔을 때 이미지 축소 + 외각그림자 + 뒷배경 회색 )*/
.prodList{
    box-shadow:0 0 3px rgba(0,0,0, 0.2);
    background-color: rgba(160, 160, 160, 0.02);
    border-radius: 5px; 
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
.prod-name {
  font-size: 22px;
  font-weight: bold;
  margin-top: 5px;
}

.product-price {
  color: #4a4a4a;
  font-size: 18px;
  font-weight: bold;
  margin-top: 3px;
}

</style>
<body>
<div class="prod_category">
	<nav class="prod_nav">
	<form action="/product/productList.do" method="post">
            <li class="nav_li" style="margin-left:3%"><button onclick="change_btn(event)" class="category" name="all" value="all">전체</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="가구">가구</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="가전">가전</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="데코/식물">데코/식물</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="생활용품">생활용품</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="수납/정리">수납/정리</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="조명">조명</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="주방용품">주방용품</button></li>
            <li class="nav_li"><button onclick="change_btn(event)" class="category" name="category" value="패브릭">패브릭</button></li>
	</form>
	</nav>
</div>
	<c:choose>
		<c:when test="${not empty productList }"> <!-- productList가 비어있지 않으면 -->
			<div class="product" align="center">
			<c:forEach  var="productList" items="${productList }" varStatus="articleNum" >
				<div class="prodList">
					<a href="/product/selectProduct.do?productNO=${productList.productNO }&productName=${productList.productName }">
							<img class="prodImage" src="/product/productThumbnail.do?articleNO=${productList.productNO }&image=${productList.imageFileName }"/>
							<p class="prod-name">${productList.productName}</p>
						<fmt:formatNumber  value="${productList.productPrice}" type="number" var="price" />
							<p class="product-price">${price} 원</p>	
					</a>
				</div>
			</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<h1 class="de_list">상품이 존재하지 않습니다.</h1>
		</c:otherwise>
	</c:choose>
<div>
	<p class="paging" align="center">
	<c:choose>
		<c:when test="${recNum != null }">
		<c:forEach var="page" begin="1" end="${pageNo }" step="1" varStatus="a">
			<c:if test="${section > 1 && page==1}">
				<a href="/product/productList.do?section=${1 }&pageNum=${1 }">처음</a>
			</c:if>
			<c:if test="${section > 1 && page==1}">
				<a href="/product/productList.do?section=${section-1}&pageNum=${(section-1)*10+page-1}">이전</a>
			</c:if>
			<c:if test="${page <= 10}">
				<c:if test="${loopOut }" >
					<a class="pageNum" href="/product/productList.do?section=${section}&pageNum=${(section-1)*10+page}">${(section-1)*10 +page}</a>
				</c:if>	
				<c:if test="${((section-1)*10+page)==pageNo }">
					<c:set var="loopOut" value="false" />
				</c:if>
			</c:if>
			<c:if test="${page == 10}">
				<c:if test="${loopOut }">
					<a href="/product/productList.do?section=${section+1}&pageNum=${(section-1)*10+page+1}">다음</a>
				</c:if>
			</c:if>
		</c:forEach>
			<c:if test="${section < lastSection}">
				<a href="/product/productList.do?section=${lastSection}&pageNum=${pageNo}">마지막</a>
			</c:if>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
	</p>
</div>
<input type="hidden" id="find_category" value="${category }" />
</body>
</html>