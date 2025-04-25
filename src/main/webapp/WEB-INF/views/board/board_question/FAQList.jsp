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
	<title>문의 작성</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    $(document).ready(function () {
        // 카테고리 필터
        $(".category-menu button").click(function () {
            let selected = $(this).data("category");

            $(".category-menu button").removeClass("active");
            $(this).addClass("active");

            if (selected === "all") {
                $(".faq-item").show();
            } else {
                $(".faq-item").hide();
                $('.faq-item[data-category="' + selected + '"]').show();
            }
        });

        // 질문 클릭 시 토글
        $(".faq-question").click(function () {
            $(this).toggleClass("open");
            $(this).next(".faq-answer").slideToggle();
        });
    });
</script>

<style>
body {
/* margin: 30px; 
color: #333;  */
font-family: Arial, sans-serif;
}
h2 { 
color: #00A9FF; 
}
.category-menu {
display: flex;
flex-wrap: wrap;
margin-bottom: 20px;
gap: 10px;
justify-content: center;  /* 가운데 정렬 */
}
.category-menu button {
background: none;
border: none;
font-size: 15px;
cursor: pointer;
color: #333;
}
.category-menu button.active {
font-weight: bold;
color: #00A9FF;
text-decoration: underline;
}
.faq-item {
border-bottom: 1px solid #ddd;
padding: 10px 0;
text-align: left;
}
.faq-question {
cursor: pointer;
font-weight: bold;
position: relative;
padding-right: 20px;
}
.faq-question::after {
content: '▼';
position: absolute;
right: 0;
transition: 0.3s;
}
.faq-question.open::after {
transform: rotate(180deg);
}
.faq-answer {
display: none;
margin-top: 5px;
color: #555;
}
.faq-list {
max-width: 800px;
margin: 0 auto;
}
.bottom-info {
margin-top: 20px;
color: #777;
font-size: 14px;
}
.btn-box {
margin-top: 20px;
padding: 8px 15px;
background: #f0f0f0;
border: none;
border-radius: 4px; 
cursor: pointer;
margin-right: 10px;
}
.btn-box:hover {
background-color: #e4e4e4;
}
</style>

<body>
<h2>고객센터 <span style="font-size: 14px; color: #999;">09:00 ~ 18:00<br> (점심: 12시 50분 ~ 1시 40분)</span></h2>
	<div style="color: #00A9FF; font-size: 25px;" >1644-1234</div><br>
	<!-- 카테고리 메뉴 -->
	<div class="category-menu">
	    <button class="active" data-category="all">전체</button>
	    <button data-category="order">주문/결제</button>
	    <button data-category="delivery">배송관련</button>
	    <button data-category="cancel">취소/환불</button>
	    <button data-category="return">반품/교환</button>
	    <button data-category="login">로그인/회원정보</button>
	    <button data-category="etc">서비스/기타</button>
	</div>
	
	<!-- FAQ 항목 리스트 -->
	<div class="faq-list">
	    <!-- 배송관련 -->
	    <div class="faq-item" data-category="delivery">
	        <div class="faq-question">Q. 배송비는 얼마인가요?</div>
	        <div class="faq-answer">A. 기본 배송비는 3,500원 입니다.</div>
	    </div>
	    <div class="faq-item" data-category="delivery">
	        <div class="faq-question">Q. 배송확인은 어떻게 하나요?</div>
	        <div class="faq-answer">A. 우측 상단 프로필의 마이페이지 > 나의쇼핑 > 주문배송목록에서 배송단계를 한눈에 보실 수 있습니다.</div>
	    </div>
	    <div class="faq-item" data-category="delivery">
	        <div class="faq-question">Q. 배송은 얼마나 걸리나요?</div>
	        <div class="faq-answer">A. 상품 배송 기간은 상품 유형에 따라 출고 일자 차이가 있습니다.
	        						자세한 사항은 구매하신 상품의 상세 페이지에서 확인 가능하며 평일 기준 1~3일 이내에 배송됩니다.</div>
	    </div>
	
	    <!-- 반품/교환 -->
	    <div class="faq-item" data-category="return">
	        <div class="faq-question">Q. 제품이 불량입니다. 반품 혹은 교환은 어떻게 하나요?</div>
	        <div class="faq-answer">A. 우측 상단 프로필 사진을 클릭 후 나의쇼핑 페이지에서 원하는 주문의 상세보기 버튼을 클릭 후 교환/반품 접수 후 진행 할수 있습니다.
	        						 교환/반품 접수 없이 임의로 반송한 경우에는 처리가 늦어질 수 있습니다.</div>
	    </div>
	    <div class="faq-item" data-category="return">
	        <div class="faq-question">Q. 제품의 교환 또는 반품을 할 수 있나요?</div>
	        <div class="faq-answer">A. 상품을 수령하신 후 7일이내에 교환/반품이 가능하며, 고객님의 변심에 의한 교환/반품의 경우 배송비용이 부과될 수 있습니다.</div>
	    </div>
	    <div class="faq-item" data-category="return">
	        <div class="faq-question">Q. 주문한 것과 다른 상품이 왔습니다. 어떻게 해야 하나요?</div>
	        <div class="faq-answer">A. 아래 [1대1문의]를 통해 문의주시면 확인 후 도움을 드리겠습니다.</div>
	    </div>
	
	    <!-- 주문/결제 -->
	    <div class="faq-item" data-category="order">
	        <div class="faq-question">Q. 주문내역은 어떻게 확인할 수 있나요?</div>
	        <div class="faq-answer">A. 우측 상단 프로필 사진을 클릭 후 나의쇼핑 페이지에서 확인 가능합니다.</div>
	    </div>
	    <div class="faq-item" data-category="order">
	        <div class="faq-question">Q. 결제방법은 어떤 것이 있나요?</div>
	        <div class="faq-answer">A. 신용카드 및 체크카드, 카카오페이 ,네이버페이 를 이용해 결제 가능합니다.</div>
	    </div>
	    <div class="faq-item" data-category="order">
	        <div class="faq-question">Q. 주문 후 결제방법을 변경하고 싶은데 어떻게 해야 하나요?</div>
	        <div class="faq-answer">A. 결제 후 정보 변경은 불가능합니다. 단, 입금대기 및 결제완료 단계에서는 취소 후 재주문을 통해 변경이 가능합니다.</div>
	    </div>
	
	    <!-- 서비스/기타 -->
	    <div class="faq-item" data-category="etc">
	        <div class="faq-question">Q. 제품의 자세한 정보는 어떻게 알 수 있나요?</div>
	        <div class="faq-answer">A. 각 제품의 상세 페이지에서 확인 가능하며, 더욱 자세한 정보는 제품 상세페이지 내 문의하기를 통해 문의 가능합니다.</div>
	    </div>
	    <div class="faq-item" data-category="etc">
	        <div class="faq-question">Q. "좋아요"를 누른 콘텐츠(커뮤니티 게시글)등은 어디서 볼 수 있나요?</div>
	        <div class="faq-answer">A. 우측 상단 하트 아이콘을 클릭 후 좋아요페이지에서 확인 가능합니다. </div>
	    </div>
	    
	    <!-- 취소/환불-->
	    <div class="faq-item" data-category="cancel">
	        <div class="faq-question">Q. 주문 취소는 어떻게 하나요?</div>
	        <div class="faq-answer">A. 우측 상단 프로필 사진을 클릭 후 나의쇼핑 > 주문배송목록에서 주문취소를 하실 수 있습니다.</div>
	    </div>
	    <div class="faq-item" data-category="cancel">
	        <div class="faq-question">Q. 취소 후 환불은 언제 되나요?</div>
	        <div class="faq-answer">A. 신용카드 및 체크카드의 경우 카드사에서 확인 절차를 거치는 관계로 평균 3~7일 영업일 이내 환불처리가 완료됩니다.</div>
	    </div>
	    
	    <!-- 로그인/회원정보-->
	    <div class="faq-item" data-category="login">
	        <div class="faq-question">Q. 비밀번호 변경은 어떻게 하나요?</div>
	        <div class="faq-answer">A. 우측 상단 프로필 사진을 클릭 후 설정페이지에서 비밀번호 변경이 가능합니다.</div>
	    </div>
	    <div class="faq-item" data-category="login">
	        <div class="faq-question">Q. 회원탈퇴는 어떻게 하나요?</div>
	        <div class="faq-answer">A. 우측 상단 프로필 사진을 클릭 후 설정페이지에서 탈퇴하기를 클릭 후 비밀번호 확인을 통해 탈퇴가 가능합니다.</div>
	    </div>
	</div>
	<div class="bottom-info">
	    ※ 추가문의 또는 문의내역이 궁금하다면 아래 버튼을 클릭해주세요.
	</div>
	
	<a href="/board/board_question/questionForm.do">
		<button class="btn-box" onclick="return checkLogin();">1:1 문의하기</button>
	</a>
	<a href="/board/board_question/myQuestionList.do">
		<button class="btn-box" onclick="return checkLogin();">문의내역</button>
	</a>
	
	<script type="text/javascript">
	    // 공통 로그인 체크 함수
	    function checkLogin() {
	      // 서버 세션에서 memberId가 존재하면 해당 값을, 없으면 빈 문자열("")을 출력
	      var memberId = '<%= (session.getAttribute("member") != null ? session.getAttribute("member") : "") %>';
	      if(memberId === "") {
	        // memberId가 없으면 confirm 창을 띄워 안내 후 로그인 페이지로 이동
	        if(confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
	          window.location.href = '/member/loginForm.do';
	        }
	        // false를 리턴하여 링크 기본 이동을 막음
	        return false;
	      }
	      // 로그인 되어 있으면 true를 리턴해 기본 링크 이동을 허용
	      return true;
	    }
	  </script>

</body>
</html>