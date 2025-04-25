<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%>     
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>나의 장바구니</title>
	<c:set var="basketList" value="${map.basketList }"/>
	<c:set var="logResult" value="${map.logResult }"/>
<script src="http://code.jquery.com/jquery-latest.min.js">
</script>
<script>

// 장바구니 제품 삭제
function deleteBasket(productNO, memberId) { 
    $.ajax({
        url: '/basket/deleteBasket.do',
        type: 'POST',
        data: { 'productNO': productNO, 'memberId': memberId },
        success: function(data) {
            location.reload();
        },
        error: function(xhr, status, error) {
            alert('오류 발생');
        }
    });
}

// 비로그인 장바구니 진입 시 loginForm으로 보냄
window.onload = function() {
	var result = document.getElementById('logResult').value;
	if(result == 'false'){
    alert('로그인 후 가능한 서비스 입니다.');
    location.href='/member/loginForm.do';
	};
};

// 전체선택 이벤트(체크박스)
function chk_all(){
	if($('input[name=selectAll]').is(':checked')){
		$('input[name=selectBasket]').prop('checked', true);
	} else {
		$('input[name=selectBasket]').prop('checked', false);
	}
	chk_one(); // 개별선택 실시간 업데이트
}

var all_prod = new Array(); // 장바구니 상품들 저장된 배열
var chk_items = new Array(); // 선택된 장바구니 상품 저장할 배열
const dechk_items = new Array(); // 선택했다 취소한 장바구니 상품 저장할 배열
var index = 0;
var index1 = 0;
// 개별선택 이벤트(체크박스)
function chk_one(){
	if($('input[name=selectBasket]').is(':checked')){
		let sum = 0;
		chk_items = [];
		const selectBasketAllCount = $("input[name='selectBasket']").length; // 개별 체크박스 전체 수
		const selectBasketNowCount = $("input[name='selectBasket']:checked").length; // 현재 활성화된 개별 체크박스 수
		
		if(selectBasketAllCount > selectBasketNowCount){ 
			$('input[name=selectAll]').prop('checked', false);
		} else {
			$('input[name=selectAll]').prop('checked', true);			
		}

		$('input[name=selectBasket]:checked').each(function(){
			index = $(this).val();
			const chk_prod = all_prod[index];
			
			// some : 논리연산자OR / 하나라도 true면 true 반환
			const exists = chk_items.some(item => item.productNO === chk_prod.productNO);
			
			if(!exists){
				chk_items.push({
					productNO : chk_prod.productNO,
					productQty : chk_prod.productQty,
					productPrice : chk_prod.productPrice,
					memberId : chk_prod.memberId
				});
			};
		});
		
		// 배열 정렬 (오름차)
		chk_items.sort((a, b) => a.productNO - b.productNO);
		
		$('input[name=selectBasket]:not(:checked)').each(function(){
			index1 = $(this).val();
			const dechk_prod = all_prod[index1];
			chk_items = chk_items.filter(item => item.productNO !== dechk_prod.productNO);
		});
		
		var checkBoxes = document.querySelectorAll("input[type='checkbox']");
		var qty = 0;
		
		$('input[name=selectBasket]:checked').each(function(){
			index = $(this).val();
			sum += (all_prod[index].productPrice * all_prod[index].productQty);
			qty += (all_prod[index].productQty);
		});
		
		document.getElementById('selectedSum').innerText = sum.toLocaleString() + "원";
		document.getElementById('selectedAllSum').innerText = (sum+3500).toLocaleString() + "원";
		document.getElementById('selectedProductCount').innerText = qty;

	} else {
		$('input[name=selectAll]').prop('checked', false);
		sum = 0;
		document.getElementById('selectedSum').innerText = sum + "원";
		document.getElementById('selectedAllSum').innerText = sum + "원"
		document.getElementById('selectedProductCount').innerText = sum;
	}; // if end

	if($('input[name=selectBasket]:checked').length == 0){
		chk_items = [];
	}
}

// 수량 변경
function changeQuantity(quantity, productNO, productPrice, productQty) {
    var qtyInput = document.getElementById("quantity"+productNO);
    var currentQty = parseInt(qtyInput.value); // 기존 값
    var Quantity = currentQty + quantity; // 기존값에 바꾸려는 값 더하기
    if (Quantity < 1) Quantity = 1; // 1보다 아래로 못가게 막는거
	
    // 장바구니 전체 상품 정보 들어있는 배열의 수량 변경
    all_prod = all_prod.map((item) => item.productNO == productNO ? {...item, productQty:Quantity } : item);
    // 배열 productNO 기준 매개변수로 가져온 productNO과 같은 배열의 인덱스 값 뽑음
    var changePriceIndex = all_prod.findIndex((item) => item.productNO === productNO);
    // 수량 증감 시 출력할 제품 금액
    var changePrice = Quantity * all_prod[changePriceIndex].productPrice;
 	// 값을 넣을 태그의 name을 찾음
    var name = 'productPrice'+productNO;
 	// 제품 금액 출력
    document.getElementById(name).innerText = changePrice.toLocaleString();
 	// 체크박스로 선택한 상품 있을 시 총 구매 금액 실시간 업데이트
    chk_one();
 	// 제품 수량 변경 출력
 	if(productQty > qtyInput.value){ 		
    	qtyInput.value = Quantity;
 	} else if (quantity == -1){
    	qtyInput.value = Quantity;
 	} else{ 		
 		alert('최대 선택가능 수량을 넘을 수 없습니다.');
 	}
}

function sendChk_items(send_chk_items){
	if(chk_items.length == 0){
		alert('제품을 선택해주세요');
	} else {
		var string = JSON.stringify(send_chk_items);
		$.ajax({
	        url: '/basket/updateBasket.do',
	        type: 'POST',
	        contentType: 'application/json; charset=utf-8',
            data: string,
            /* traditional: true, */
	        success: function(data) {
	        	const orderForm = document.createElement('form');
	        	orderForm.setAttribute('method', 'post');
	        	orderForm.setAttribute('action', '/addOrder.do');
	        	
	        	if(send_chk_items == 0){
	        		$('#parent').empty();
	        	}
	        	
	        	var parent = document.getElementById("checkItemsList");
	        	
	        	for(var i = 0; i<send_chk_items.length; i++){
	        		var productNO = document.createElement('input');
	        		productNO.setAttribute('type', 'hidden');
	        		productNO.setAttribute('name', 'productNO');
	        		productNO.setAttribute('value', send_chk_items[i].productNO);
	        	
	        		var productQty = document.createElement('input');
	        		productQty.setAttribute('type', 'hidden');
	        		productQty.setAttribute('name', 'productQty');
	        		productQty.setAttribute('value', send_chk_items[i].productQty);
	        	
		        	orderForm.appendChild(productNO);
		        	orderForm.appendChild(productQty);
	        	}
	        	
	        	parent.appendChild(orderForm);
	        	
	        	orderForm.submit();
	        	
	        },
	        error: function(xhr, status, error) {
	            console.log("status : " + status);
	            console.log("error : " + error);
	        }
	    });
	};
}

</script>
</head>
<style>

body{
font-family: Arial, sans-serif;
}

#allBasket{
	width: 1165px;
	margin-left: auto;
	margin-right: auto;
}
.basket{
    align:center;
}
.basketQty{
	width: 50px;
	height: 20px;
	font-size: 17px;
	text-align: center;
}

.addProductBtn{
	background-color: #00A9FF;
    color: white; 
    font-size: 18px;
    border: none; 
    border-radius: 5px; 
    cursor: pointer;
    padding: 5px 12px 5px 12px;
    margin: 3px;
    margin-top: 10px;
}

.addProductBtn:hover{
	background-color: #008ED6;
}

#basket1{
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.basket{
	display: flex;
	width: 70%;
	flex-direction: column;
}

#selectAllBtn{
	background-color: rgba(240, 240, 240, 0.25);
	box-shadow:0 0 2px rgba(0,0,0, 0.2);
	line-height: 50px;
	height: 50px;
	border: none; 
    border-radius: 5px; 
	padding-left: 10px;
	margin-right: 20px;
	margin-bottom: 20px;
	font-size: 20px;
	text-align: left;
	/* box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
}
#selectAllBtn input{
	transform : scale(1.5);
	margin-right: 10px;
}

.basketContents{
	background-color: rgba(240, 240, 240, 0.25);
	box-shadow:0 0 2px rgba(0,0,0, 0.2);
	border: none; 
    border-radius: 5px; 
	padding-left: 10px;
	margin-right: 20px;
	margin-bottom: 20px;
}

#price{
	position: absolute;
	right: 230px;
	display: flex;
	width: 350px;
	background-color: rgba(240, 240, 240, 0.25);
	box-shadow:0 0 2px rgba(0,0,0, 0.2);
	border: none; 
    border-radius: 5px;
    height: 333px;
    /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
    top: 200px;
}
#priceAll{
	text-align: left;
	margin: 15px;
}
#priceCount{
	color: red;
}
.chkBox_deleteBtn{
	margin-top: 10px;
	display: flex;
	justify-content: space-between;
}
.chkBox{
	text-align: left;
	font-size: 20px;
}
.chkBox input{
	transform : scale(1.5);
	margin-right: 10px;
}
.deleteBtn button{
	margin-right: 10px;
	border: none;
	font-size: 20px;
	cursor: pointer;
	background-color: rgba(240, 240, 240, 0);
}

.prodImg_basketItems{
	display: flex;
	justify-content: space-between;
}
.prodImg img{
	margin-top: 10px;
	width: 150px;
	height: 150px;
}
.basketItems{
	display: flex;
	flex-direction: column;
	justify-content: center;
	width:400px;
}
.basketItems input{
	font-size: 20px;
	height: 30px;
	text-align: center;
	width: 400px;
	border: none;
	cursor: pointer;
	background-color: rgba(240, 240, 240, 0);
}
.quantity_price{
	display: flex;
	flex-direction: column;
	justify-content: center;
}
.quantity-container{
	font-size: 20px;
	margin-right: 20px;
}
.quantity-container p{
	margin: 0px;
}
.quantity-container button{
	transform : scale(1.5);
	width: 22px;
	border: 1px solid #8c8c8c;
	border-radius: 4px;
	background-color: white;
}

.quantity-container button:hover {
	background-color: #99E0FF;
	cursor:pointer;
}
.quantity-container input{
	width: 23px;
	height: 24.5px;
	margin: 5px;
	text-align: center;
	border: 1px solid #8c8c8c;
	border-radius: 4px;

}
.prodPrice{
	text-align: right;
	font-size: 30px;
	margin-right: 10px;
	margin-bottom: 10px;
}
.buyItems{
	font-size: 20px;
	display:flex;
	justify-content: space-between;
}
.buyProduct{
	font-size: 23px;
}
#buyItems{
	margin: 0px;
	margin-top: 20px;
}
#buyItems1{
	margin: 0px;
}
#totalBuyItems{
	margin-top: 100px;
}
#buyBtnDiv{
	text-align: center;
}
#buyBtn{
	background-color: #00A9FF;
    color: white; 
    font-size: 20px;
    border: none; 
    border-radius: 5px; 
    padding: 5px;
    cursor: pointer;
    width: 320px;
    margin-top: 20px;
}
#buyBtn:hover {
  background-color: #008ED6;
}
.basketItems input:focus{
	outline: none;
}
</style>
<body>
<div id="allBasket">
<c:choose>
	<c:when test="${basketList == null || empty basketList }">
		<h1> 장바구니에 상품이 존재하지 않습니다. </h1>
		<a href="/product/productList.do" class="addProductBtn">상품 담으러 가기</a>
	</c:when>
	<c:otherwise>
	<div id="basket1">
		<div class="basket">
				<div id="selectAllBtn">
					<input type="checkbox" name="selectAll" onclick="chk_all()" /><b>전체선택</b>
				</div>
			<c:forEach var="basket" items="${basketList }" varStatus="basketNum">
				<div class="basketContents">
					<script>
						var count = ${basketNum.count - 1};
						all_prod[count] = {"productNO":${basket.productNO},"productQty":${basket.basketProductQty}
											 ,"productPrice":${basket.productPrice },"memberId":'${basket.memberId}'};
					</script>
					<div class="chkBox_deleteBtn">
						<div class="chkBox">
							<input type="checkbox" name="selectBasket" value="${basketNum.count - 1}" onclick="chk_one()" /><b>선택</b>
						</div>
						<div class="deleteBtn">
							<button type="button" onclick="deleteBasket('${basket.productNO}','${basket.memberId }')"><b>X</b></button>
						</div>
					</div>
					<div class="prodImg_basketItems">
						<div class="prodImg">
						<a href="/product/selectProduct.do?productNO=${basket.productNO }&productName=${basket.productName }">
							<img src="/product/productThumbnail.do?articleNO=${basket.productNO }&image=${basket.imageFileName }"/>
						</a>
						</div>
						<div class="basketItems">
						<a href="/product/selectProduct.do?productNO=${basket.productNO }&productName=${basket.productName }">
							<lable name="productName"></lable>
							<input type="text" name="productName" value="${basket.productName }" readOnly style="font-size:25px; font-weight:bold;"/>
							<lable name="options"></lable>
							<input tpye="text" name="options" value="${basket.basketProductOptions }" readOnly />
						</a>
						</div>
						<div class="quantity_price">
							<div class="quantity-container">
								<p style="font-size: 0.8em;"><b></b></p>
		                		<button class="quantity-btn" onclick="changeQuantity(-1, ${basket.productNO}, ${basket.productPrice }, ${basket.productQty } )">-</button>
		                		<input type="text" id="quantity${basket.productNO }" value="${basket.basketProductQty }" size="2" readonly>
		                		<button class="quantity-btn" onclick="changeQuantity(1, ${basket.productNO}, ${basket.productPrice }, ${basket.productQty } )">+</button>
		            		</div>
						</div>
					</div>
		            <div class="prodPrice">
						<fmt:formatNumber var="price" value="${basket.basketProductQty * basket.productPrice }" pattern="#,###"/>
						<b id="productPrice${basket.productNO }">${price }</b><b>원</b>
					</div>
				</div>
			</c:forEach>
		</div>
		<div id="price">
			<div id="priceAll">
				<div class="buyProduct">
					<b>결제할 상품 </b>
					<b id="priceCount">총 <b id="selectedProductCount">0</b>개</b>
				</div>
				<div class="buyItems" id="buyItems">
					<p style="display: inline; margin:0px; font-weight: bold;">총 상품 금액</p>
					<p style="display: inline; margin:0px;" id="selectedSum">0원</p>
				</div>
				<div class="buyItems" id="buyItems1">
					<p style="display: inline; margin:0px; font-weight: bold;" >총 배송비</p>
					<p style="display: inline; margin:0px;" >+3,500원</p>
				</div>
				<div class="buyItems" id="totalBuyItems">
					<b>결제 금액</b>
					<b id="selectedAllSum">0원</b>
				</div>
				<form>
				<div id="buyBtnDiv">
					<input type="button" id="buyBtn" value="구매하기" onclick="sendChk_items(chk_items)" />
				</div>
				</form>
			</div>
		</div>
	</div>
	</c:otherwise>
</c:choose>
</div>
<input type="hidden" id="logResult" value="${logResult }" />
<div id="checkItemsList">
</div>
</body>
<script>

var floatPosition = parseInt($("#price").css('top'));

//scroll 인식
$(window).scroll(function() {

 // 현재 스크롤 위치
 var currentTop = $(window).scrollTop();
 var bannerTop = currentTop + floatPosition + "px";

 //이동 애니메이션
 $("#price").stop().animate({
   "top" : bannerTop
 }, 300);

});
</script>
</html>