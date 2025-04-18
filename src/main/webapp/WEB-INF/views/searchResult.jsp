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
  <title>검색 결과</title>
<style>

body{
font-family: Arial, sans-serif;
}

.result-section { 
margin-bottom: 30px; 
}
.result-item img { 
width: 100%;
  height: 100%; 
object-fit: contain; 
}
.prodImage{
width: 100%; /* 이미지의 너비를 100%로 설정 */
object-fit: cover;
transition: transform 0.3s ease; /* 변환 효과 설정 */
border-radius: 5px;
background-size:cover;
height:280px;
}
.prodImage:hover{
transform: scale(0.95); /* 마우스 호버 시 10% 확대 */
}
.viewAll {
top: 10px;
right: 10px;
background-color: gray;
color: white;
border: none;
padding: 5px 5px 5px 5px;
cursor: pointer;
border-radius: 5px; /* 모서리 둥글게 */
}
.viewAll:hover {
background-color: darkgray; /* 호버 시 색상 변경 */
}
.section-header {
display: flex;
justify-content: space-between;
align-items: center;
margin-bottom: 20px;
}
.product-grid {
display: grid;
grid-template-columns: repeat(4, minmax(300px, 1fr));
gap: 20px 30px;
margin-left: auto;
margin-right: auto;
min-width: 1357px;
max-width: 1357px;
}
.product-box {
background: #fff;
border: 1px solid #ddd;
box-sizing: border-box;
padding: 10px;
display: flex;
flex-direction: column;
justify-content: space-between;
aspect-ratio: 3 / 4; /* 고정비율3/4 */
border-radius: 5px; /* 모서리 둥글게 */
}

.product-box p {
  margin: 4px 0;  /* 위아래 간격을 4px로 줄임 */
  font-size: 14px; /* 필요하면 글자 크기도 조절 가능 */
  color: #333;
}

</style>
</head>
<body>
  <h2>🔎' <c:out value="${keyword}" /> '</h2>

  <!-- 상품 검색 결과 -->
  <div class="result-section">
  <div class="section-header">
    <h3 style="text-align: left; margin-left:30px" >상품 목록</h3>
    <a href="/product/productList.do?productType=?"><button class="viewAll" style="margin-right:17px">전체 보기</button></a>
  </div>
    <c:if test="${empty productResults}">
      <p>검색 결과가 없습니다.</p>
    </c:if>
    <div class="product-grid">
    <c:forEach var="prod" items="${productResults}">
      <div class="product-box">
      <a href="/product/selectProduct.do?productNO=${prod.productNo}&amp;productName=${prod.productName}">
        <img class="prodImage" src="/product/productThumbnail.do?articleNO=${prod.productNo}&amp;image=${prod.imageFileName}" alt="${prod.productName}" />
      </a>
      <a href="/product/selectProduct.do?productNO=${prod.productNo}&amp;productName=${prod.productName}">
        <h3>${prod.productName}</h3>
       </a>
        <%-- <p>${prod.productDescription}</p> --%>
        <p><fmt:formatNumber value="${prod.productPrice}" pattern="#,##0" />원</p>
      </div>
    </c:forEach>
    </div>
  </div>
  
  <!-- 게시글 검색 결과 -->
  <div class="result-section">
  <div class="section-header">
    <h3 style="text-align: left; margin-left:30px" >커뮤니티</h3>
    <a href="/board/board_myhome/myHomeList.do?myHomeType=?"><button class="viewAll" style="margin-right:17px">전체 보기</button></a>
  </div>
    <c:if test="${empty boardResults}">
      <p>검색 결과가 없습니다.</p>
    </c:if>
    <div class="product-grid">
    <c:forEach var="board" items="${boardResults}">
      <div class="product-box">
      <a href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${board.boardMyhomeArticleNo}">
        <img class="prodImage" src="/board/board_myhome/myHomeCoverImages.do?articleNo=${board.boardMyhomeArticleNo}&amp;image=${board.imageFileName}" alt="${board.boardMyhomeTitle}" />
      </a>
      <a href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${board.boardMyhomeArticleNo}">
        <h3>${board.boardMyhomeTitle}</h3>
      </a>
        <p><b>${board.memberNickName}</b></p>
        <p>❤️ ${board.boardMyhomeLikes} | 👀 ${board.boardMyhomeViews} | 💬${board.totalReply}</p>
        <p>작성일: <fmt:formatDate value="${board.boardMyhomeUpdated}" pattern="yyyy-MM-dd"/></p>
      </div>
    </c:forEach>
    </div>
  </div>
  
</body>
</html>