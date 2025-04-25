<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%>     
<%
	// controller에서 설정한 boardQuestionType1 값을 가져옴
    String inquiryType = (String) request.getAttribute("boardQuestionType1");
%>
<!-- style="text-decoration-line:none" -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>문의 작성</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
body {
font-family: "Noto Sans KR", sans-serif;
margin: 0;
padding: 0;
}
.container {
width: 600px;
margin: 30px auto;
border: 1px solid #ddd;
padding: 20px;
}
h1 {
margin-bottom: 20px;
text-align: center;
}
.form-group {
margin-bottom: 15px;
text-align: left;
}
label {
display: inline-block;
width: 120px;
font-weight: bold;
vertical-align: top;
}
select, input[type="text"], textarea {
width: 300px;
padding: 6px;
font-size: 14px;
}
textarea {
height: 80px;
resize: none;
}
input[type="file"] {
width: 300px;
padding: 6px;
font-size: 14px;
}
.file-guide {
font-size: 12px;
color: #888;
margin-top: 5px;
}
.questionFrom-btn {
display: block;
width: 30%;
padding: 10px 0;
background-color: #f0f0f0;
border: none;
border-radius: 4px; 
cursor: pointer;
font-size: 15px;
font-weight: bold;
margin-top: 20px;
margin: 20px auto;
}
.questionFrom-btn:hover {
background-color: #e4e4e4;
}
.product-container {
    display: flex;             /* Flexbox 사용 */
    align-items: center;       /* 세로축 가운데 정렬 */
    border: 1px solid #ddd;    /* 테두리 */
    padding: 20px;             /* 안쪽 여백 */
    margin-bottom: 20px;       /* 바깥 여백 */
}

.product-image {
    width: 150px;
    height: 150px;
    background-color: #f9f9f9; 
    display: flex;
    justify-content: center;   /* 수평 가운데 정렬 */
    align-items: center;       /* 수직 가운데 정렬 */
    overflow: hidden;          /* 이미지가 영역 벗어나면 잘림 */
    margin-right: 20px;        /* 이미지와 상품명 사이 간격 */
}

.product-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: cover;         /* 이미지 비율 유지하며 영역 맞춤 */
}

.product-name p {
    font-size: 16px;
    font-weight: bold;
    margin: 0;                 /* 기본 여백 제거 */
}
</style>
<body>
<div class="container">
	<h1>문의 작성</h1>
    <form action="questionForm.do" method="post" enctype="multipart/form-data">
		<!-- 문의 유형 자동 입력 (상품문의 또는 1:1문의) -->
		<div class="form-group">		
			<label for="boardQuestionType1">문의유형</label>
	        <input type="text" name="boardQuestionType1" value="${boardQuestionType1}" readonly />
        </div>
        
        
        <!-- 문의 세부사항 -->
        <div class="form-group">
            <label for="inquiryDetail">문의 세부사항</label>
	            <select name="boardQuestionType2" id="boardQuestionType2" required>
			        <option value="">선택해주세요</option>
			        <%-- 문의유형이 상품문의이면 상품 불량/파손, 배송, 기타 출력 --%>
			        <% if("상품문의".equals(inquiryType)) { %>
			            <option value="상품 불량/파손">상품 불량/파손</option>
			            <option value="배송">배송</option>
			            <option value="기타">기타</option>
			        <% } else if("1:1문의".equals(inquiryType)) { %>
			            <%-- 문의유형이 1:1문의이면 불편사항, 버그제보, 기타 출력 --%>
			            <option value="불편사항">불편사항</option>
			            <option value="버그제보">버그제보</option>
			            <option value="기타">기타</option>
			        <% } %>
			    </select>
            <input type="hidden" id="boardQuestionType2" name="boardQuestionType2"/>
        </div>
        
        <div class="form-group">
            <label for="boardQuestionContents">문의 내용</label>
            <textarea id="boardQuestionContents" name="boardQuestionContents" required></textarea>
        </div>
        
        <!-- 파일 업로드 -->
        <div class="form-group">
            <label for="uploadFile">첨부 이미지</label>
            <input type="file" name="uploadFile" id="uploadFile">
            <div class="file-guide">필요시 이미지를 첨부하세요.</div>
        </div>
        
        <!-- 상품문의인 경우 productNo도 함께 전송 -->
        <c:if test="${not empty product}">
			<input type="hidden" name="productNo" value="${product.productNO}" />
        </c:if>
        
        <!-- 상품문의인 경우 상품 정보 출력 -->
        <c:if test="${not empty product}">
        	<div class="product-container">
        		<div class="product-image">
					<img src="/product/productThumbnail.do?articleNO=${product.productNO }&image=${product.imageFileName }"/>
              	</div>
              	<div class="product-name">
                	<p>${product.productName}</p>
                </div>
            </div>
        </c:if>

        <div>
        	<a href="/board/board_question/myQuestionList.do">
            	<button type="submit" class="questionFrom-btn">문의 등록</button>
            </a>
        </div>
    </form>
</div>
</body>
</html>