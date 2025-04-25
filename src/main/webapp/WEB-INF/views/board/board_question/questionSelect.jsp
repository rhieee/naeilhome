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
<title>문의 내역 상세페이지</title>
<style>
.container {
border: 1px solid #ccc;
padding: 20px;
width: 600px;
margin: auto;
}
.form-group {
margin-bottom: 15px;
}
label {
display: block;
margin-bottom: 5px;
font-weight: bold;
}
.questionSelect_text, textarea {
width: 80%;
padding: 10px;
font-size: 14px;
border: 1px solid #ccc;
border-radius: 6px;
}
textarea {
height: 100px;
resize: none;
}
.product-info {
display: flex;
align-items: center;
border: 1px solid #ccc;
margin-top: 20px;
padding: 20px;
width: 600px;
margin: auto;
}
.product-info img {
width: 200px;
height: 200px;
margin-right: 20px;
}
.submit-btn {
display: block;
font-weight: bold;
background-color: #f0f0f0;
border: none;
border-radius: 6px;
padding: 10px 20px;
margin: 20px auto 0;
cursor: pointer;
font-size: 16px;
}
.submit-btn:hover {
background-color: #e4e4e4;
} 
</style>
</head>
<body>
	<h2>문의글 상세보기</h2>
	<div class="container">
	    <div class="form-group">
	    	<label >문의번호</label>
	    		<input type="text" readonly class="questionSelect_text" value="${question.boardQuestionArticleNo}"/>
	    </div>
	    <div class="form-group">
	    	<label>문의유형</label>
	    		<input type="text" readonly class="questionSelect_text" value="${question.boardQuestionType1}"/>
	    </div>
	    <div class="form-group">
	    	<label>문의세부사항</label>
	    		<input type="text" readonly class="questionSelect_text" value="${question.boardQuestionType2}"/>
	    </div>
	    <div class="form-group">
	    	<label>문의내용</label>
	    		<textarea readonly>${question.boardQuestionContents}</textarea>
	    </div>
	    <div class="form-group">
	    	<label>등록일</label>
	    		<input type="text" readonly class="questionSelect_text" value="${question.boardQuestionUpdated}"/>
	    </div>
	    <div class="form-group">
	    	<label>처리상태</label>
	    		<input type="text" readonly class="questionSelect_text" value="${question.boardQuestionStatement}"/>
	    </div>
	</div>
	
    <!-- 업로드한 이미지가 있으면 출력 (C:\naeilhome\board\board_question 에 저장된 파일) -->
    <c:if test="${not empty question.boardQuestionImage}">
        <div class="product-info">
            <img src="/board/board_question/imageDisplay.do?imageName=${question.boardQuestionImage}" alt="문의 이미지" />
            <p>첨부 이미지</p>
        </div>
    </c:if>
    
    <!-- 만약 문의유형이 '상품문의'인 경우, 해당 상품정보(상품 이미지, 상품명) 출력 -->
    <c:if test="${question.boardQuestionType1 eq '상품문의' and not empty product}">
        <div class="product-info">
            <img src="/product/productThumbnail.do?articleNO=${product.productNO}&image=${product.imageFileName}" alt="상품 썸네일" />
        	<p>상품명: ${product.productName}</p>
        </div>
    </c:if>
    
    <!-- 확인 버튼 클릭 시 문의내역으로 이동 -->
    <form action="/board/board_question/myQuestionList.do" method="get">
        <input type="submit" class="submit-btn" value="확인" /><br><br>
    </form>
</body>
</html>