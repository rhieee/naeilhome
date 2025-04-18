<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%>     


<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    
    <style>
    .rating-row {
        display: flex;
        align-items: center; /* 별과 텍스트 수직 가운데 정렬 */
        margin: 10px 0;
    }

    .rating-label {
        display: inline-block;
        width: 100px; /* 라벨 고정 너비 */
        font-weight: bold;
    }

    .star-group img {
        cursor: pointer;
        margin-right: 4px;
        vertical-align: middle;
    }
</style>
    
</head>
<body>

<!-- 전체 wrapper -->
<div style="width: 700px; margin: auto; padding: 20px; text-align: left;">
    <h2>리뷰 쓰기</h2>

    <%-- <form action="/mypage/review/addReview.do" method="GET"> --%>
    <form action="/review/addReview.do" method="post" enctype="multipart/form-data" onsubmit="return validateRating();">
    <input type="hidden" name="productNo" value="${productNo}" />
    <input type="hidden" name="memberId" value="${sessionScope.member.memberId}" /> <!-- 컨트롤러에서 받아야함 -->
    <input type="hidden" name="orderNo" value="${orderNo}" />						<!-- 컨트롤러에서 받아야함 -->
    
    
        <!-- 상품 정보 -->
        <div style="display: flex; align-items: center; gap: 20px; margin-bottom: 40px;">
        <c:if test="${not empty productImageFileName}">
		    <img src="/review/productThumbnail.do?productNo=${productNo}&image=${productImageFileName}" width="100px" height="100px" />
		</c:if>
        <%-- <img src="/review/selectThumnail.do?productNO=${productNo}&image=${image.imageFilename}" width="100px" height="100px"/> --%>
        
            <div><strong>${productName}</strong></div>
        </div>

        <div style="margin-bottom: 40px;">
            <p style="font-size: 20px;"><strong>별점 평가</strong></p>

            <div class="rating-row">
                <span class="rating-label" >내구성</span>
                <span class="star-group" data-type="reviewStarDurability">
                    <c:forEach begin="1" end="5">
                        <img src="/resources/image/iconStar2.png" width="23px" />
                    </c:forEach>
                </span>
                <input type="hidden" name="reviewStarDurability" id="reviewStarDurability" />
            </div>

            <div class="rating-row">
                <span class="rating-label">가성비</span>
                <span class="star-group" data-type="reviewStarPrice">
                    <c:forEach begin="1" end="5">
                        <img src="/resources/image/iconStar2.png" width="23px" />
                    </c:forEach>
                </span>
                <input type="hidden" name="reviewStarPrice" id="reviewStarPrice" />
            </div>

            <div class="rating-row">
                <span class="rating-label">디자인</span>
                <span class="star-group" data-type="reviewStarDesign">
                    <c:forEach begin="1" end="5">
                        <img src="/resources/image/iconStar2.png" width="23px" />
                    </c:forEach>
                </span>
                <input type="hidden" name="reviewStarDesign" id="reviewStarDesign" />
            </div>

            <div class="rating-row">
                <span class="rating-label">배송만족</span>
                <span class="star-group" data-type="reviewStarDelivery">
                    <c:forEach begin="1" end="5">
                        <img src="/resources/image/iconStar2.png" width="23px" />
                    </c:forEach>
                </span>
                <input type="hidden" name="reviewStarDelivery" id="reviewStarDelivery" />
            </div>

            <input type="hidden" name="reviewStarAvg" id="reviewStarAvg" />
        </div>

        <div style="margin-bottom: 30px; width: 100%;">
	    <p style="font-size: 20px;"><strong>리뷰 작성</strong></p>
	    <textarea name="reviewContents"
	              style="width: 100%; height: 150px; border-radius: 10px; padding: 10px; resize: none;"
	              placeholder="리뷰를 작성해주세요"></textarea>
		</div>


        <div style="margin-bottom: 20px;">
            <label>사진 첨부</label>
            <input type="file" name="reviewImage" accept="image/*" />
        </div>

        <div style="text-align: center;">
            <button type="submit" style="width: 103%; height: 60px; background-color: #99E0FF; 
             padding: 0px; border: none; border-radius: 10px; font-size: 18px; cursor: pointer;">완료</button>
        </div>
    </form>
</div>


<script>
    // 페이지가 로딩되면 실행되는 함수
    window.onload = function () {
        const starGroups = document.querySelectorAll(".star-group");

        starGroups.forEach(function (group) {
            const type = group.getAttribute("data-type");
            const stars = group.querySelectorAll("img");

            stars.forEach(function (star, index) {
                star.addEventListener("click", function () {
                    for (let i = 0; i < stars.length; i++) {
                        if (i <= index) {
                            stars[i].src = "/resources/image/iconStar1.png";
                        } else {
                            stars[i].src = "/resources/image/iconStar2.png";
                        }
                    }

                    document.getElementById(type).value = index + 1;

                    const indexs = ["reviewStarDurability", "reviewStarPrice", "reviewStarDesign", "reviewStarDelivery"];
                    let sum = 0;
                    let count = 0;

                    indexs.forEach(function (id) {
                        const val = parseInt(document.getElementById(id).value);
                        if (!isNaN(val)) {
                            sum += val;
                            count++;
                        }
                    });

                    if (count === 4) {
                        const avg = Math.round(sum / 4);
                        document.getElementById("reviewStarAvg").value = avg;
                    }
                });
            });
        });
    };

    // 별점이 하나라도 선택되지 않았으면 폼 제출을 막는 함수
    function validateRating() {
        const ratings = [
            document.getElementById("reviewStarDurability").value,
            document.getElementById("reviewStarPrice").value,
            document.getElementById("reviewStarDesign").value,
            document.getElementById("reviewStarDelivery").value
        ];

        // 모든 별점 항목이 선택되지 않았으면 경고
        for (let i = 0; i < ratings.length; i++) {
            if (!ratings[i]) {
                alert("모든 별점 항목을 선택해주세요.");
                return false; // 폼 제출 막기
            }
        }
        return true; // 모든 항목이 선택되었으면 폼 제출
    }
</script>


</body>
</html>
