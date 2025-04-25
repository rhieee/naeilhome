<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>

<!-- 자동완성 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<style>

    body {
        font-family: Arial, sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    
    .container {
        width: 100%;
        position: relative;
        margin-left: auto;
    	margin-right: auto;
    	min-width: 1357px;
  		max-width: 1357px;
    }

    /* 글쓰기 버튼 */
	.write-btn {
	    padding: 8px 15px; 
	    background-color: #00A9FF; 
	    color: white; 
	    font-weight: bold; 
	    font-size: 15px; 
	    border: none; 
	    border-radius: 5px; 
	    cursor: pointer; 
	}
	
	.write-btn:hover {
	background-color: #008ED6;
	}

    /* 게시글 목록 (그리드 형식) */
    .grid-wrapper {
    	margin-top:30px;
        display: flex;
        justify-content: center;
        width: 100%;
    }

    .grid-container {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 4개씩 가로 배치 */
        gap: 25px; /* 카드 간격 */
        min-width: 1357px;
  		max-width: 1357px;
  		min-height: 750px;
    }

    /* 개별 카드 스타일 */
    .card {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        transition: transform 0.2s;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        height:350px;
        border-radius: 5px; 
    }

    .card:hover {
        transform: translateY(-5px);
    }  

    .card-content {
        padding: 15px;
        text-align: center;
    }

    .card-content h3 {
        font-size: 16px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .card-content p {
        font-size: 14px;
        color: #666;
        margin: 5px 0;
    }

    .card-content a {
        text-decoration: none;
        font-weight: bold;
        color: #007bff;
    }
	/* 썸네일 스타일 */
    .thumbnail {
        width: 100%;
        height: 200px; /* 원하는 썸네일 높이 설정 */
        overflow: hidden;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f0f0f0; /* 이미지가 없을 경우 배경색 */
    }

    .thumbnail img {
        width: auto;  /* 가로 비율 유지 */
        height: 200px; 
        object-fit: cover; /* 넘치는 부분 자름 */
    }
	
	.top-bar {
    display: flex;
    justify-content: space-between; /* 양쪽 끝으로 배치 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 20px;
	}
	
	.left-top {
	  display: flex;
	  align-items: center;
	  gap: 30px; /* 필터랑 버튼 사이 여백 */
	}
	
	/* 페이징*/	
	.pagination {
	    display: flex;
	    justify-content: center;
	    list-style: none;
	    margin: 20px 0; /* 위아래 여백 추가 */
	    padding: 10px 0;
	}
	
	.pagination a {
	    text-decoration: none;
	    color: black;
	    font-size: 16px;
	    margin: 0 4px; /* 좌우 간격 추가 */
	    padding: 5px 10px; /* 클릭 영역 확장 */
	}
	
	.pagination a:hover {
	    color: #555;
	}
	
	.pagination a.active {
	    font-weight: bold;
	    color: #00A9FF;
	}
	
	/* 필터링 */
	.filtering {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  gap: 10px;
	}
	.filtering select {
	  padding: 5px 5px;        
	  font-size: 15px;
	  border: none;                    
	  border-radius: 6px;              
	  background-color: #f7f7f7;      
	  color: #333;
	  cursor: pointer;
	  box-shadow: 0 0 2px rgba(0, 0, 0, 0.05); /* 약간의 그림자 */
	  transition: background-color 0.2s;
	  text-align: center;
	}
	
	.filtering select:hover {
	  background-color: #eeeeee;       /* 마우스 올리면 살짝 진해짐 */
	}
	
	#resetBtn {
	padding: 5px 10px;
	font-size: 15px;
	border: none; 
	border-radius: 6px;
	background-color: #99E0FF;
	cursor: pointer;
	box-shadow: 0 0 2px rgba(0, 0, 0, 0.05);
	}
	
	#resetBtn:hover {
	  background-color: #66CEFF;
	}
		
	
	
</style>

</head>


<body>
    
<div class="container">
	<div class="top-bar">
	<div class="left-top">
	    <!-- 필터링 토글 -->
		<div class="filtering">
		  <select name="sortType" id="sortType">
		    <option value="">정렬</option>
		    <option value="최신순">최신순</option>
		    <option value="인기순">인기순</option>
		    <option value="과거순">과거순</option>
		  </select>
		 <select name="boardMyhomeHousingType" id="boardMyhomeHousingType">
		    <option value="">주거형태</option>
		    <option value="원룸">원룸</option>
		    <option value="아파트">아파트</option>
		    <option value="단독주택">단독주택</option>
		    <option value="사무공간">사무공간</option>
		    <option value="상업공간">상업공간</option>
		  </select>
		  <select name="boardMyhomeHomeSize" id="boardMyhomeHomeSize">
		    <option value="">평수</option>	
		    <option value="9평 미만">9평 미만</option>
		    <option value="10평대">10평대</option>
		    <option value="20평대">20평대</option>
		    <option value="30평대">30평대</option>
		    <option value="40평 이상">40평 이상</option>
		   </select>
		 </div>
		 <button type="button" id="resetBtn">초기화</button>
	  	</div>
	    <!-- 글쓰기 버튼 -->
	    <c:if test="${isLogOn == true && member != null}">
	        <a href="/board/board_myhome/myHomeForm.do" class="write-btn">글쓰기</a>
	    </c:if>
	</div>

<div class="grid-wrapper">
            <c:choose>
                <c:when test="${not empty myhomeList}">
        <div class="grid-container">
                    <c:forEach var="article" items="${myhomeList}">
                        <div class="card">
                           <!-- 썸네일 자리 -->
                            <div class="thumbnail">
                                <c:choose>
                                    <c:when test="${not empty article.boardMyhomeArticleNo}"> 
                                    <a href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
                                        <img src="/board/board_myhome/myHomeCoverImages.do?articleNo=${article.boardMyhomeArticleNo}&image=${article.imageFileName}" alt="커버 이미지">
                                    </c:when>
                                    <c:otherwise>(이미지 없음)</c:otherwise>
                                </c:choose>
                            </div>

                            <!-- <!-- 게시글 정보 -->
					<div class="card-content">
						<h3>
							<a
								href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
								${article.boardMyhomeTitle} </a>
						</h3>
						<c:if test="${article.memberId != '탈퇴회원'}">
                        	<p><b>${article.memberNickName}</b></p>
                        </c:if>
                        <c:if test="${article.memberId == '탈퇴회원'}">
                        	<p><b>탈퇴회원</b></p>
                        </c:if>
                        <p>👍🏻${article.boardMyhomeLikes} | 👀 ${article.boardMyhomeViews} | 💬${article.totalReply}</p>
						<p>${article.boardMyhomeUpdated}</p>
					</div>
				</div>
			</c:forEach>
        </div>
                </c:when>
                <c:otherwise>
                    <p>게시글이 없습니다.</p>
                </c:otherwise>
            </c:choose>
    </div> 
</div>


<!-- 페이징 -->
<ul class="pagination">
	<c:if test="${totalArticles != null }" >
        <c:set var="startPageNum" value="${(section - 1) * 10 + 1}" />
        <c:set var="endPageNum" value="${startPageNum + 9}" />
        <c:if test="${endPageNum > totalPages}">
            <c:set var="endPageNum" value="${totalPages}" />
        </c:if>

        <!-- 이전 버튼 -->
        <c:if test="${section > 1}">
            <a href="?section=${section-1}&pageNo=1"> ‹ </a>
        </c:if>

        <!-- 페이지 번호 -->
        <c:forEach var="i" begin="${startPageNum}" end="${endPageNum}">
                <a href="?section=${section}&pageNo=${i}" class="${i == pageNo ? 'active' : ''}">
                    ${i}
                </a>
        </c:forEach>

        <!-- 다음 버튼 -->
        <c:if test="${endPageNum < totalPages}">
            <a href="?section=${section+1}&pageNo=1"> › </a>
        </c:if>
        
	</c:if>
</ul>

<script>
function filteringSort() {
    const housingType = $('#boardMyhomeHousingType').val();
    const homeSize = $('#boardMyhomeHomeSize').val();
    const sortType = $('#sortType').val();

    $.ajax({
        type: "GET",
        url: "/board/board_myhome/filterList.do",
        data: {
        	housingType: housingType,
        	homeSize: homeSize,
        	sortType : sortType
        },
        success: function(html) {
            $('.grid-wrapper').html(html); // 게시글 영역만 교체
        },
        error: function() {
            alert('게시글 필터링 실패');
        }
    });
}

$(document).ready(function() {
    $('#boardMyhomeHousingType, #boardMyhomeHomeSize,#sortType').on('change', function() {
        filteringSort();
    });
});

// 필터링 초기화 버튼
$('#resetBtn').on('click',function(){ 
	$('#boardMyhomeHousingType').val('');
	$('#boardMyhomeHomeSize').val('');
	$('#sortType').val('');
	// 전체리스트 다시 불러오기
	filteringSort();
});

</script>


</body>
</html>
