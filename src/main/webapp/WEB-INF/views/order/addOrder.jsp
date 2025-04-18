<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"   isELIgnored="false"  %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
  request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
  	<meta charset="UTF-8">
  	<title>구매 페이지</title>
  	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
	
	window.onload = function() {
		var social = "social";
		if(${userInfo.orderReceiverEmail2} === social){
			var email = "${userInfo.orderReceiverEmail1}";
			var emailAll = email.split("@");
			for(var i = 0; i<emailAll.length; i++){
				var a = "orderReceiverEmail"+(i+1);
				document.getElementById(a).value = emailAll[i];
				
			}
		}else{
			console.log("false");
		}
	};
	
	document.addEventListener('DOMContentLoaded', function() {
	    // 배송비 고정값
	    var shippingFee = parseInt(document.getElementById('shippingFee').value) || 3500;
	
	    function updateCalculation() {
	        var totalProductAmount = 0;
	        // 모든 상품 박스 (.product-row)를 순회
	        var productRows = document.querySelectorAll('.product-row');
	        productRows.forEach(function(row, index) {
	            // 상품 단가: data-price 속성
	            var price = parseFloat(row.getAttribute('data-price')) || 0;
	            // 사용자가 변경한 수량 (보여주기용 input)
	            var visibleInput = row.querySelector('.visibleQty');
	            var qty = parseInt(visibleInput.value) || 0;
	            // 소계 계산
	            var subtotal = price * qty;
	            totalProductAmount += subtotal;
	            // 해당 행에 있는 hidden 수량 필드 업데이트
	            var hiddenInputs = document.querySelectorAll('.hiddenQty');
	            if (hiddenInputs[index]) {
	                hiddenInputs[index].value = qty;
	            }
	        });
	        
	        // 사용포인트 입력값 (할인금액)
	        var usedPoints = parseInt(document.getElementById('orderPoints').value) || 0;
	        
	        // 최종 결제금액 = (총상품금액 + 배송비) - 할인금액
	        var finalAmount = totalProductAmount + shippingFee - usedPoints;
	        
	        // 주문 요약 영역 업데이트
	        document.getElementById('totalProductDisplay').textContent = totalProductAmount.toLocaleString();
	        document.getElementById('shippingDisplay').textContent = shippingFee.toLocaleString();
	        document.getElementById('discountDisplay').textContent = usedPoints.toLocaleString();
	        document.getElementById('finalAmountDisplay').textContent = finalAmount.toLocaleString();
	        
	        // 폼 전송용 hidden 필드 업데이트
	        document.getElementById('finalAmountHidden').value = finalAmount;
	    }
	    
	    // visible 수량 입력 필드에 이벤트 리스너 등록
	    document.querySelectorAll('.visibleQty').forEach(function(input) {
	        input.addEventListener('input', updateCalculation);
	    });
	    // 사용포인트 입력 필드에 이벤트 리스너 등록
	    document.getElementById('orderPoints').addEventListener('input', updateCalculation);
	    
	    // 페이지 로드시 초기 계산
	    updateCalculation();
	});
</script>

<script type="text/javascript">
	function validateOrderForm() {
		var orderPointsInput = document.getElementById("orderPoints");
		var enteredPoints = parseInt(orderPointsInput.value, 10);
		var maxPoints = parseInt(orderPointsInput.getAttribute("max"), 10);
		
		// 만약 입력한 사용 포인트가 누적 포인트보다 크다면
		if (enteredPoints > maxPoints) {
		    alert("사용 포인트가 누적 포인트(" + maxPoints + ")보다 큽니다. 다시 입력해 주세요.");
		    // 입력값 초기화 및 포커스 이동
		    orderPointsInput.value = "";
		    orderPointsInput.focus();
		    return false;  // 폼 제출 중단
		  }
		  return true; // 검증 통과 시 폼 제출 진행
	}
</script>

  <style>
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
            background: #fdfdfd;
        }
        .container {
            width: 1100px;
            margin: 0 auto;
            display: flex;
            padding: 20px 0;
        }
        .left-section {
            width: 70%; /* 원하는 너비로 설정 */
    		margin: 0 auto;
        }
        .order-title {
            font-size: 24px;
            margin-bottom: 20px;
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            display: inline-block;
            width: 100px;
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 300px;
            padding: 5px;
            box-sizing: border-box;
        }
        .form-group textarea {
            height: 80px;
            resize: none;
        }
        .phone-input input[type="text"] {
            width: 80px;
            margin-right: 5px;
            text-align: center;
        }
        .phone-input .separator {
            margin-right: 5px;
        }
        .address-input input[type="text"] {
            margin-bottom: 5px;
            display: block;
        }
        .summary {
            border-top: 1px solid #ddd;
            padding-top: 10px;
            margin-top: 20px;
        }
        .summary p {
            margin: 5px 0;
        }
        .summary h3 {
            margin: 15px 0;
        }
        .order-btn {
            display: inline-block;
            padding: 13px 25px;
            background-color: #00A9FF;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            border-radius: 4px; 
        }
        .order-btn:hover {
            background-color: #008ED6;
        }
        .right-section h3 {
            margin-bottom: 10px;
        }
        .customer-center {
            margin-top: 30px;
        }
        .customer-center p {
            margin: 4px 0;
        }
        /* 주문 상품 */
        .product-box {
            border: 1px solid #ccc;
            padding: 10px;
            width: 700px;  /* 박스 너비 */
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
        
    </style>
</head>

<body>
	<div class="container">
        <!-- 좌측 주문/결제 영역 -->
        <div class="left-section">
            <h2 class="order-title">주문/결제</h2>
            <form action="/completeOrder.do" method="post">
 
                <!-- 주문자 정보 -->
                <p style="text-align: left; font-size: 24px;">주문자</p>
                <div class="form-group">
                    <label>이름</label>
                    <!-- 로그인한 사용자의 이름 -->
                    <input type="text" style="width:80px; text-align: center;" value="${userInfo.orderReceiver}"required readonly/>
                </div>
                
                <div class="form-group" >    
                    <div class="phone-input">
                    <label>전화번호</label>
                        <!-- 전화번호를 세 부분으로 나누어 받음 -->
                        <input type="text" name="orderReceiverPhone1" value="${userInfo.orderReceiverPhone1}" maxlength="3" required readonly/>
                        <span class="separator">-</span>
                        <input type="text" name="orderReceiverPhone2" value="${userInfo.orderReceiverPhone2}" maxlength="4" required readonly/>
                        <span class="separator">-</span>
                        <input type="text" name="orderReceiverPhone3" value="${userInfo.orderReceiverPhone3}" maxlength="4" required readonly/>
                    </div>
                </div>
                
                <div class="form-group" style="white-space: nowrap;">
                    <label>이메일</label>
                    <input type="text" id="orderReceiverEmail1" name="orderReceiverEmail1" style="width:120px; text-align: center;" value="${userInfo.orderReceiverEmail1}" required readonly/>
                    <span style="margin:0 5px;">@</span>
                    <input type="text" id="orderReceiverEmail2" name="orderReceiverEmail2" style="width:120px; text-align: center;" value="${userInfo.orderReceiverEmail2}" required readonly/>
                </div>
                
                <!-- 배송지 정보 -->
                <p style="text-align: left; font-size: 24px;">배송지</p>
                <div class="form-group">
                	<label>우편번호</label>
                	<input type="text" name="zip1" value="${userInfo.orderZip1}" required readonly/>
                </div>
                <div class="form-group">
            		<label>주소</label>
            		<input type="text" name="zip2" value="${userInfo.orderZip2}" required readonly/>
        		</div>
        		<div class="form-group">
            		<label>상세주소</label>
            		<input type="text" name="zip3" value="${userInfo.orderZip3}" required readonly/>
        		</div>
                
                <!-- 주문 상품 정보 -->
                <p style="text-align: left; font-size: 24px;">주문상품</p>
	                <c:forEach var="productInfo" items="${productList}" >
		                <div class="product-box product-row" data-price="${productInfo.productPrice}">
		                	<img src="/product/productThumbnail.do?articleNO=${productInfo.productNo }&image=${productInfo.imageFileName }"/>
		               		<div style="display:flex; flex-direction:column;">
		               			<div class="form-group" style="margin-bottom:10px;">
		                    		<label >상품명</label>
									<input type="text" value="${productInfo.productName}" required readonly/>
								</div>
								<div class="form-group" style="margin-bottom:10px;">
									<label>옵션</label>
									<input type="text" value="${productInfo.orderProductOptions}" required readonly/>
		                		</div>
		                		<!-- 수량 조절 입력 -->
                                <div class="form-group" style="margin-bottom:10px;">
                                    <label for="orderQty">수량</label>
                                    <input type="number" class="orderQty visibleQty" value="${productInfo.orderQty != 0 ? productInfo.orderQty : orderQty}" min="1" required readonly/>
                                </div>
		        			</div>
		                </div>
		                <input type="hidden" name="productNoList" value="${productInfo.productNo}" />
					    <input type="hidden" name="productPriceList" value="${productInfo.productPrice}" />
					    <input type="hidden" class="hiddenQty" name="orderQtyList" value="${productInfo.orderQty}" />
					    <input type="hidden" name="orderProductOptionsList" value="${productInfo.orderProductOptions}" />
	                </c:forEach>

                <!-- 요청사항 (메시지) -->
                <div class="form-group">
                    <label>요청사항</label>
                    <textarea name="orderMessage" placeholder="배송 시 요청사항을 입력하세요."></textarea>
                </div>
                
                <!-- 결제 방식 -->
                <p style="text-align: left; font-size: 24px;">할인</p>
                <div class="form-group">
                    <label>결제방식</label>
                    <select name="orderPaytype" required style="width:120px; text-align: center;">
                        <option value="card">신용카드</option>
                        <option value="kakao">카카오페이</option>
                        <option value="naver">네이버페이</option>
                    </select>
                </div>
                
                <!-- 포인트 사용 -->
                <div class="form-group">              	
                    <label>사용 포인트</label>
                    	<input type="number" name="orderPoints"  id="orderPoints" value="0" step="1" min="0" max="${userInfo.pointRemain}" placeholder="사용포인트" style="width:100px; text-align: center;" required 
                    				onkeydown="if(['e','E','+','-'].indexOf(event.key)!== -1){ event.preventDefault(); }" 
           							oninput="this.value = this.value.replace(/[^0-9]/g, '');"/> <!-- 입력된 전체 값에서 정규식 /[^0-9]/g를 이용해 숫자가 아닌 문자를 모두 제거 -->
                </div>
                <div class="form-group"> 
                	<label>누적 포인트</label>
                    	<input type="text" name="pointRemain" id="pointRemain" readonly value="${userInfo.pointRemain}" style="width:100px; text-align: center;"/>
                </div>

                <!-- 결제금액 정보 -->
                <div class="summary">
                    <p>총상품금액: <span id="totalProductDisplay"></span> 원</p> 
					<p>배송비: <span id="shippingDisplay"></span> 원</p>
					<p>할인금액: <span id="discountDisplay"></span> 원</p> 
				    <p><strong>최종결제금액: <span id="finalAmountDisplay"></span> 원</strong></p><br>
                    
                    <!-- 뷰에서 전달 안되는 값(hidden 필드로 전달) -->
        			<input type="hidden" name="productPoint" value="0" />
        			<input type="hidden" name="memberId" value="${member.memberId}" />
        			<input type="hidden" name="orderReceiver" value="${member.memberName}" />
        			<input type="hidden" name="orderStatement" value="주문완료" />
        			<input type="hidden" name="orderPoints" value="0" />
        			<input type="hidden" name="orderZip1" value="${userInfo.orderZip1}" />
					<input type="hidden" name="orderZip2" value="${userInfo.orderZip2}" />
					<input type="hidden" name="orderZip3" value="${userInfo.orderZip3}" />
					<input type="hidden" name="imageFileName" value="${order.imageFileName}" />
					<input type="hidden" id="shippingFee" value="3500" />
					<input type="hidden" id="finalAmountHidden" name="orderAmount" value="0" />
					
					<c:forEach var="productInfo" items="${productList}">
				        <input type="hidden" name="orderProductOptions" value="${productInfo.orderProductOptions}" />
				        <input type="hidden" name="imageFileName" value="${productInfo.imageFileName}" />
				        <input type="hidden" name="productName" value="${productInfo.productName}" />
					</c:forEach>
                    
                    <!-- 결제하기 버튼 -->
                    <button type="submit" class="order-btn" >결제하기</button>

                </div>               
            </form>
        </div>
	</div>   
</body>
</html>