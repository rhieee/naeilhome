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
  <title>메인 페이지</title>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  
  <!-- 자동완성 -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
  
<style>
body{
font-family: Arial, sans-serif;
	margin-left:auto;
	margin-right:auto;
}

.container {
    display: flex;
    flex-direction: column;
    align-items: center; /* 수평 가운데 정렬 */
    justify-content: center; /* 수직 가운데 정렬 */
    height: 100%; /* 전체 화면 높이로 설정 */
    width: 100%;
}

/* 04.08 수정 */
#imageContainer {
    position: relative;
    width: 100%;
    min-height: 500px; /* 세로 길이  */
    max-height: 500px; /* 세로 길이  */
    overflow: hidden; /*이미지가 컨테이너를 넘지 않도록 설정 */
    min-width: 2440px;
    max-width: 2440px;
}

/* 04.08 수정 */
#banners {
 	width: 100%; /* 고정된 너비 */
 	min-height: 500px; /* 세로 길이  */
    max-height: 500px; /* 세로 길이  */
 	object-fit:fill;
}

.button {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(255, 255, 255, 0.0); /* 맨 뒤는 투명도 */
    border: none;
    padding: 20px; /* 버튼의 패딩을 줄여서 클릭 영역을 줄임 */
    cursor: pointer;
    font-size: 16px;
    border-radius: 5px;
    z-index: 1; /* 버튼이 배너 위에 표시되도록 설정  포토샵으로 치면 레이아웃 같은거 */ 
}

#bannerCount {
    position: absolute; 
    left: 50%;
    bottom: 10px;
    transform: translateX(-50%);
    color: white;
    font-size: 18px;
    background-color: rgba(0, 0, 0, 0.5);
    padding: 3px;
    border-radius: 5px;
    z-index: 10;
}

/* 04.08 수정 */
#prevButton {
    left: 260px;
}

/* 04.08 수정 */
#nextButton {
    right: 260px;
}

/* 동그라미 카테고리 */
.categorySlider {
    display: flex;
    align-items: center; /* 수직 정렬 */
}

.arrow {
    cursor: pointer; /* 마우스 커서 포인터로 변경? */
    margin: 0 10px 0px 10px; /* 화살표 간격 조정 */
}

.categoryContainer {
    display: flex;
    overflow: hidden;
    width: 300%;
}

.category {
    display: flex;
    flex-direction: column;
    align-items: center; 
    margin: 0 0px 0 0px;
    min-width: 170px;
}

.category img {
    width: 50%;
}

.category div {
    margin-top: 10px;
    font-size:large;
    font-weight:bold;
}

/* 베스트 상품 */
.bestAndNew {
    position: relative;
    width: 100%;
}

.viewAll {
    position: absolute; /* 버튼을 절대 위치로 설정 */
    top: 3px;
    right: 10px;
    background-color: gray;
    color: white;
    border: none;
    padding: 5px 5px 5px 5px;
    cursor: pointer;
    border-radius: 5px; /* 모서리 둥글게 */
    margin-bottom:19.92px;
}

.viewAll:hover {
    background-color: darkgray; /* 호버 시 색상 변경 */
}

.bestAndNewView {
    display: flex;
    justify-content: flex-start;
    flex-wrap: wrap;
    
}

.view {
    margin: 5px 25px 5px 25px;
    max-width: calc(35% - 10px);
    box-sizing: border-box;
    width: 224px;
    box-shadow:0 0 3px rgba(0,0,0, 0.2);
    background-color: rgba(160, 160, 160, 0.02);
    border-radius: 5px; 
}

.view img {
    width: 100%;
}

.prodImage{
width: 100%; /* 이미지의 너비를 100%로 설정 */
object-fit: cover;
transition: transform 0.3s ease; /* 변환 효과 설정 */
border-radius: 5px;
background-size:cover;
height:224px;
}

.prodImage:hover{
transform: scale(0.95); /* 마우스 호버 시 10% 확대 */
}

.viewName {
  width: 208px;
  display: inline-block;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-weight: bold;
  margin: 7px auto 7px auto;
}

</style>

<script>
/* 
    // 만약 관리자 페이지에서 배너 등록 페이지를 만들게 된다면 사용. 자바에서 리스트에 파일 이름과 상품번호 혹은 이벤트 게시글 번호를 넘겨 받았을때 배열에 담을 수 있는 방법
    // 돌려보진 않아서 정상 작동하는지 확인 못함.(기존 사용하던 배열은 주석처리하고 사용해야 함.)
    // 이론상 가능할 것 같음.
    
    // 이미지 이름 받기 확장자 명까지 가져와야 됨.
    if (${fileName} == null) {
    const bannerImages = []; // 배열 생성
    ${fileName}.forEach(function(image) {
        bannerImages.push(image); // ${fileName}의 각 요소를 bannerImages에 추가
    }); 
   }
    // 이벤트 게시글 번호 받기
    if (${boardNoticeArticleNo} == null) {
    const bannerEventNo = []; // 배열 생성
    ${boardNoticeArticleNo}.forEach(function(eventNo) {
        bannerImages.push(eventNo); // ${fileName}의 각 요소를 bannerImages에 추가
    });
   }
    // 상품 번호 받기
    if (${productNo} == null) {
    const bannerProductNo = []; // 배열 생성
    ${productNo}.forEach(function(productNo) {
        bannerImages.push(productNo); // ${fileName}의 각 요소를 bannerImages에 추가
    });
   }
    
    const bannerLinks = []; // 링크 배열 생성
    
    // 경로 설정
    const bannerImagesUrl = '/resources/image/';
	const bannerEventLinks = '/board/notice_board/eventNoticleList.do?boardNoticeArticleNo=';
	const bannerProductUrl = '/product/productSelect.do?productNO=';
    
   // 링크 배열에 이벤트 번호 URL 추가
   if (bannerEventNo.length > 0) {
    bannerEventNo.forEach(function(eventNo) {
        const eventUrl = bannerEventLinks + eventNo; // 이벤트 URL 생성
        bannerLinks.push(eventUrl); // bannerImages에 추가
    });
   }
    
    // 링크 배열에 상품 번호 URL 추가
    if (bannerProductNo.length > 0) {
    bannerProductNo.forEach(function(productNo) {
        const productUrl = bannerProductUrl + productNo; // 상품 URL 생성
        bannerLinks.push(productUrl); // bannerImages에 추가
    });
   }
     */
     
     document.addEventListener("DOMContentLoaded", function() {
    	    const bannerImagesUrl = '/resources/image/';
    	    const bannerProductUrl = '/product/productList.do';
    	    
    	    const bannerImages = [
    	        bannerImagesUrl + 'banner1.png',
    	        bannerImagesUrl + 'banner2.png',
    	        bannerImagesUrl + 'banner3.png',
    	        bannerImagesUrl + 'banner4.png',
    	        bannerImagesUrl + 'banner5.png',
    	        bannerImagesUrl + 'banner6.png',
    	        bannerImagesUrl + 'banner7.png'
    	    ];

    	    const bannerLinks = [
    	        bannerProductUrl,
    	        bannerProductUrl,
    	        bannerProductUrl,
    	        bannerProductUrl,
    	        bannerProductUrl,
    	        bannerProductUrl,
    	        bannerProductUrl
    	    ];

    	    let currentIndex = 0;
    	    let bannerTime = 4000; // bannerTime
    	    let interval;

    	    const bannerImageElement = document.getElementById('banners');
    	    const bannerLinkElement = document.getElementById('bannerLink');
    	    const bannerCountElement = document.getElementById('bannerCount');

    	    // 초기 배너 설정
    	    bannerImageElement.src = bannerImages[currentIndex];
    	    bannerLinkElement.href = bannerLinks[currentIndex];
    	    updateBannerCount();

    	    function changeImage() {
    	        currentIndex = (currentIndex + 1) % bannerImages.length;
    	        updateBanner();
    	    }

    	    function updateBanner() {
    	        bannerImageElement.src = bannerImages[currentIndex];
    	        bannerLinkElement.href = bannerLinks[currentIndex];
    	        updateBannerCount();
    	    }

    	    function PreviousBanner() {
    	        currentIndex = (currentIndex - 1 + bannerImages.length) % bannerImages.length;
    	        updateBanner();
    	    }

    	    function NextBanner() {
    	        currentIndex = (currentIndex + 1) % bannerImages.length;
    	        updateBanner();
    	    }

    	    function updateBannerCount() {
    	        bannerCountElement.textContent = (currentIndex + 1) + ' / ' + bannerImages.length;
    	    }
    	    
    	    // 4초마다 배너 변경
    	    // setInterval : 설정한 시간마다 함수 실행
    	    interval = setInterval(changeImage, bannerTime);
    	    
    	    // 버튼 클릭 이벤트 리스너 추가
    	    document.getElementById('prevButton').addEventListener('click', PreviousBanner);
    	    document.getElementById('nextButton').addEventListener('click', NextBanner);

    	    // 마우스 오버 시 배너 시간 변경
    	    // clearInterval : setInterval에 설정한값 지우기
    	    $("#banners").hover(
    	        function() {
    	            clearInterval(interval); // 이전에 설정한 값 자우기
    	            interval = setInterval(changeImage, 999999999); // 무제한
    	        },
    	        function() {
    	            clearInterval(interval);
    	            interval = setInterval(changeImage, bannerTime); // 원래 시간 4000
    	        }
    	    );
    	});
     
    // 동그라미 카테고리
document.addEventListener('DOMContentLoaded', () => {
    const categoryContainer = document.querySelector('.categoryContainer');
    const prevArrow = document.getElementById('prevArrow2');
    const nextArrow = document.getElementById('nextArrow2');

    let currentIndex = 0;
    const itemsToShow = 8; // 한 번에 보여줄 카테고리 수
    const totalItems = categoryContainer.children.length;

    updateDisplay();

    function updateDisplay() {
        for (let i = 0; i < totalItems; i++) {
            categoryContainer.children[i].style.display = 'none';
        }
        for (let i = currentIndex; i < currentIndex + itemsToShow && i < totalItems; i++) {
            categoryContainer.children[i].style.display = 'flex';
        }
    }

    nextArrow.addEventListener('click', () => {
        currentIndex = (currentIndex + itemsToShow) % totalItems;
        updateDisplay();
    });

    prevArrow.addEventListener('click', () => {
        currentIndex = (currentIndex - itemsToShow + totalItems) % totalItems;
        updateDisplay();
    });
});
    
    // 카테고리별 링크로 이동 밸류 값을 저장해서 프로덕트 페이지에서 빨간글씨로 표시됨.
    function categoryLink(category){
    	
    	str = '<form id="categoryLink" action="/product/productList.do" method="post">' +
    		  '<input id="selectedCategory" name="category" value="' + category + '" type="hidden">' +
    		  '</form>';
    	
    	$(".categoryContainer").append(str);
    	
    	if(category != null){
    		var value = $("#selectedCategory").val();
    		
    		$("#categoryLink").submit();
    		localStorage.setItem("selectedCategory", value);
    		$(".categoryContainer #categoryLink").remove(); // 폼 지우기
    		
    	}else{
    		alert("잘못된 입력입니다.");
    	}
    }

/* // 초기 표시 설정
updateDisplay(); */

</script>

</head>
<body>

  <div class="container">
   <!-- 배너 -->
  <div class="item"> 
  <div id="imageContainer">
  <a id="bannerLink" href="#">                                      
  <img id="banners" src="">
  </a>
  <button id="prevButton" class="button"><img src="/resources/image/prev.png" style="opacity: 0.5;"/></button>
  <button id="nextButton" class="button" style="margin-right:20px"><img src="/resources/image/next.png"style="opacity: 0.5;"/></button>
  <div id="bannerCount"></div>
    </div>
  </div>

<!-- 카테고리 -->
<div class="item" style="margin-top:25px;">
  <div class="categorySlider">
   <%--  <div class="arrow" id="prevArrow2">
      <img src="/resources/image/prev.png">
    </div> --%>
    <div class="categoryContainer">
        <div class="category">
            <a href="#" onclick="categoryLink('가구')">                                      
                <img src="/resources/image/categori1.png">
            </a>
            <div>가구</div>
        </div>
        
        <div class="category">
        <a href="#" onclick="categoryLink('가전')">
                <img src="/resources/image/categori6.png">
            </a>
            <div>가전</div>
        </div>
        
        <div class="category">
        <a href="#" onclick="categoryLink('데코/식물')">
                <img src="/resources/image/categori7.png">
            </a>
            <div>데코/식물</div>
        </div>
        
		<div class="category">
            <a href="#" onclick="categoryLink('생활용품')">                                     
                <img src="/resources/image/categori5.png">
            </a>
            <div>생활용품</div>
        </div>
        
        <div class="category">
        <a href="#" onclick="categoryLink('수납/정리')">
                <img src="/resources/image/categori4.png">
            </a>
            <div>수납정리</div>
        </div>
        
        <div class="category">
        <a href="#" onclick="categoryLink('조명')">
                <img src="/resources/image/categori8.png">
            </a>
            <div>조명</div>
        </div>
        
         <div class="category">
            <a href="#" onclick="categoryLink('주방용품')">                                     
                <img src="/resources/image/categori3.png">
            </a>
            <div>주방용품</div>
        </div>
        
       <div class="category">
       <a href="#" onclick="categoryLink('패브릭')">
                <img src="/resources/image/categori2.png">
            </a>
            <div>패브릭</div>
        </div>
        
<%--          <div class="category">
            <a href="/product/productList.do?productType=?">                                      
                <img src="/resources/image/categori8.png">
            </a>
            <div></div>
        </div>
        <div class="category">
            <a href="/product/productList.do?productType=?">                                      
                <img src="/resources/image/categori8.png">
            </a>
            <div></div>
        </div> --%>
    </div>
 <%--    <div class="arrow" id="nextArrow2">
      <img src="/resources/image/next.png">
    </div> --%>
  </div>
</div>

<hr style="border:0px; border-top : 3px solid #ebece8; margin:auto; width:1320px; margin-top:50px;"/>

 <!-- 베스트 상품 -->
 <div class="item">
 <div class="bestAndNew">
 <h2 style="text-align: left; margin-left:30px">베스트 상품</h2>

    <a href="/product/productList.do?productType=?"><button class="viewAll" style="margin-right:17px;">전체 보기</button></a>
    <div class="bestAndNewView">
    <c:forEach var="bestProducts" items="${bestProducts}">
    	<div class="view">
        <!-- 제품 썸네일 -->
        <a href="/product/selectProduct.do?productNO=${bestProducts.productNo}&amp;productName=${bestProducts.productName}">
        	<img class="prodImage" src="/product/productThumbnail.do?articleNO=${bestProducts.productNo}&image=${bestProducts.imageFileName}" width="400">
        </a>
        <!-- 제품 이름 -->
        <div style="text-align: center;">
        <a href="/product/selectProduct.do?productNO=${bestProducts.productNo}&amp;productName=${bestProducts.productName}">
        	<span class="viewName" style="font-weight: bold;">${bestProducts.productName}</span>
        </a>
        </div>
        <!-- 제품 가격 -->
         <div style="text-align: center;">
        <span style="display: inline-block; margin-bottom: 7px; font-weight: bold;"><fmt:formatNumber value="${bestProducts.productPrice}" type="number" pattern="#,##0" />원</span>
    	</div>
    	</div>
    </c:forEach>
    </div>
  </div>
</div>

<hr style="border:0px; border-top : 3px solid #ebece8; margin:auto; width:1320px; margin-top:50px;"/>
  
 <!-- 신상품 -->
 <div class="item">
 <div class="bestAndNew">
 <h2 style="text-align: left; margin-left:30px">신상품</h2>
    <a href="/product/productList.do?productType=?"><button class="viewAll" style="margin-right:17px">전체 보기</button></a>
    <div class="bestAndNewView">
    <c:forEach var="product" items="${newProducts}">
        <div class="view">
        	<!-- 제품 썸네일 -->
            <a href="/product/selectProduct.do?productNO=${product.productNo}&amp;productName=${product.productName}">
            	<img class="prodImage" src="/product/productThumbnail.do?articleNO=${product.productNo}&image=${product.imageFileName}" width="400">
            </a>
            <!-- 제품 이름 -->
            <div style="text-align: center;">
            <a href="/product/selectProduct.do?productNO=${product.productNo}&amp;productName=${product.productName}">
            	<span class="viewName" style="font-weight: bold;">${product.productName}</span>
            </a>
            </div>
            <!-- 제품 가격 -->      
             <div style="text-align: center;">      
            <span style="display: inline-block; margin-bottom: 7px; font-weight: bold;"><fmt:formatNumber value="${product.productPrice}" type="number" pattern="#,##0" />원</span>
            </div>
        </div>
	</c:forEach>
    </div>
    </div>
  </div><br>
  </div>

  
  <!-- 한장짜리 배너 -->
  <div class="item">
  <img src="/resources/image/bottombanner.png" style="min-width: 1357px; max-width: 1357px; min-height:380px; max-height:380px;"/>
  </div>
  
  <!-- 베스트 게시글 -->
 <div class="item">
 <div class="bestAndNew">
 <h2 style="text-align: left; margin-left:30px">베스트 게시글</h2>
    <a href="/board/board_myhome/myHomeList.do?myHomeType=?"><button class="viewAll" style="margin-right:17px">전체 보기</button></a>
    <div class="bestAndNewView">
    <c:forEach var="article" items="${bestBoardPosts}">
        <div class="view">
        	<!-- 게시글 썸네일 이미지 -->
        	<a href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
        		<img class="prodImage" src="/board/board_myhome/myHomeCoverImages.do?articleNo=${article.boardMyhomeArticleNo}&image=${article.imageFileName}">
            </a>
            <!-- 게시글 제목 -->
             <div style="text-align: center;">
            <a href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
            	<span class="viewName" style="font-weight: bold;">${article.boardMyhomeTitle}</span>
            </a>
            </div>
            <!-- 게시글 좋아요, 조회수, 총 댓글수 -->
            <div style="text-align: center;">
            <span style="display: inline-block; margin-bottom: 7px; ">👍🏻 ${article.boardMyhomeLikes} | 👀 ${article.boardMyhomeViews} | 💬${article.totalReply}</span>
			</div>
        </div>
	</c:forEach>
    </div>
  </div>
</div><br><br>

<c:if test="${not empty socialMessage}">
    <script type="text/javascript">
        alert("${socialMessage}");
    </script>
</c:if>
</body>
</html>