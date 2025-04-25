<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>푸터</title>
  <style>
  
body {
	margin:0px;
	margin-left:auto;
	margin-right:auto;
}

.footer {
    display: flex;
    align-items: flex-start; /* 수직 정렬 */
    flex-wrap: nowrap; /* 화면 줄일때 줄 바낌 X */
    min-width: 1357px;
  	margin-left: auto;
	margin-right: auto;
	justify-content: center; /* 자식 요소들을 가운데 배치 */
}

.section {
    margin: 0 auto;
    padding: 0 75px; 
}
.footer2 {
 border-right:solid 3px rgba(211, 211, 211, 0.3);
}

ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

#footerH3 {
    color: #333;
    font-size: 24px;
    margin-bottom: 15px;
}

.section ul li {
    margin: 10px 0; /* 리스트 항목 간격 조정 */
    text-align:left;
}

.section ul li a {
    text-decoration: none; /* 링크 밑줄 제거 */
    font-weight: bold;
    font-size: 16px;
    margin: 0px;
}

.section ul li a:hover {
    text-decoration: underline; /* 링크에 마우스 오버 시 밑줄 추가 */
}
#footerLi{
	margin-top: 20px;
}
</style>
</head>
<body>
<div class="footer">
<div class="footer2">
    <div class="section"  style="padding-bottom:29px;">
        <ul>
         <li><h3 id="footerH3">고객센터</h3></li>
            <li><a href="/board/board_question/FAQList.do">FAQ</a></li>
            <li><a href="/board/board_notice/noticeMain.do">공지사항</a></li>
                <li><p style="font-size: 14px; color: #666;"><b style="font-size: 16px; color: black;">전화번호: 1644-1234 </b>운영시간: 09:00-18:00</p></li>
            <li><p style="font-size: 16px; font-weight:bold;">평일: 전체 문의 상담</p><p style="font-size: 16px; font-weight:bold; line-height:0.6em;">주말, 공휴일: 휴무</p></li>
        </ul>
    </div>
</div>
<div class="footer2">
<div class="section" style=" margin-top:30px; display: flex; justify-content: space-between; padding-bottom:25px;">
    <ul style="margin-right:120px;">
        <li><a href="#">회사소개</a></li>
        <li id="footerLi"><a href="#">채용정보</a></li>
        <li id="footerLi"><a href="#">이용약관</a></li>
        <li id="footerLi"><a href="#">개인정보 처리방침</a></li>
        <li id="footerLi"><a href="#">안전거래센터</a></li>
    </ul>
    <ul>
        <li><a href="#">입점신청</a></li>
        <li id="footerLi"><a href="#">제휴/광고 문의</a></li>
        <li id="footerLi"><a href="#">시공 파트너 안내</a></li>
        <li id="footerLi"><a href="#">파트너 개인정보 처리 방침</a></li>
        <li id="footerLi"><a href="#">상품광고 소개</a></li>
    </ul>
</div>
</div>
<div class="footer3">
    <div class="section" style="text-align:left;">
        <h3 id="footerH3">회사 정보</h3>
        <p style="font-size: 14px; color: #666;">회사명: (주)내일의 집</p>
        <p style="font-size: 14px; color: #666;">대표이사: 김가미</p>
        <p style="font-size: 14px; color: #666;">주소: 대전 서구 계룡로 637 3층, 7층</p>
        <p style="font-size: 14px; color: #666;">이메일: <a style="font-size: 14px; color: #666;" href="mailto:gami_project@naver.com">gami_project@naver.com</a></p>
        <div class="social-media">
            <a href="https://www.facebook.com/"><img src="/resources/image/faceBook.png" width="25px" alt="Facebook" /></a>
            <a href="https://www.instagram.com/"><img src="/resources/image/instagram.png" width="25px" alt="Instagram" /></a>
            <a href="https://www.youtube.com/"><img src="/resources/image/youtube.png" width="25px" alt="YouTube" /></a>
        </div>
    </div>
    </div>
</div>
</body>
</html>