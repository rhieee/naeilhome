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
<title>회원 탈퇴</title>

<style>
#memberDelete{
	min-width:300px;
	max-width:720px;
	margin-left: auto;
	margin-right: auto;
	margin-top : 50px;;
}
#memberDeleteSub{
	text-align: left;
}
#memberDeleteTerms{
	text-align: left;
	border-radius: 5px;
	border: 2px solid #ccc;
}
#memberDeleteCause{
	text-align: left;
	border-radius: 5px;
	border: 2px solid #ccc;
	width : 714.5px;
	resize: none;
	height : 200px;
}
#memberDeleteSelect{
	display: flex;
    flex-direction: row;
    margin-top: 10px;
    }
#memberDeleteCancel{
width : 355.5px;
 height: 45px;
 font-size: 20px;
 padding: 10px;
 border-radius: 5px;
 margin-top:15px;
 margin-bottom:15px;
 margin-right:10px;
 background-color: #99E0FF;
 border: none;
 font-weight: bold;
}
#memberDeleteCancel:hover{
background-color: #66CEFF;
cursor: pointer;
} 
#memberDeleteButton{
width : 355.5px;
 height: 45px;
 font-size: 20px;
 padding: 10px;
 border-radius: 5px;
 margin-top:15px;
 margin-bottom:15px;
 background-color: White;
 border: none;
 font-weight: bold;
 border: 1px solid #ccc;
}

#memberDeleteButton:hover{
background-color: #f0f0f0;
cursor: pointer;
} 
</style>
</head>
<body>
<div id="memberDelete">
<c:if test="${member.memberEmail2 != 'socialNaver' && member.memberEmail2 != 'socialGoogle' && member.memberEmail2 != 'kakaoSocial'}">
<div id="memberDeleteSub">
<h2>회원 탈퇴 신청</h2>
<h3>회원탈퇴 신청에 앞서 아래 내용을 반드시 확인해주세요.</h3>
</div>
<div id="memberDeleteTerms">
<b>회원탈퇴 시 처리내용</b><br>
(주)내일의 집 포인트·쿠폰은 소멸되며 환불되지 않습니다.<br>
(주)내일의 집 구매 정보가 삭제됩니다.<br>
소비자보호에 관한 법률 제6조에 의거,계약 또는 청약철회 등에 관한 기록은 5년, 대금결제 및 재화등의 공급에 관한 기록은 5년, 소비자의 불만 또는 분쟁처리에 관한 기록은 3년 동안 보관됩니다. 동 개인정보는 법률에 의한 보유 목적 외에 다른 목적으로는 이용되지 않습니다.
<br>
<br>
<b>회원탈퇴 시 게시물 관리</b><br>
회원탈퇴 후 내일의 집 서비스에 입력한 게시물 및 댓글은 삭제되지 않으며, 회원정보 삭제로 인해 작성자 본인을 확인할 수 없으므로 게시물 편집 및 삭제 처리가 원천적으로 불가능 합니다. 게시물 삭제를 원하시는 경우에는 먼저 해당 게시물을 삭제 하신 후, 탈퇴를 신청하시기 바랍니다.<br>
<br>
<b>회원탈퇴 후 재가입 규정</b><br>
탈퇴 회원이 재가입하더라도 기존의 오늘의집 포인트는 이미 소멸되었기 때문에 양도되지 않습니다.
</div>

<!-- <h3 style="text-align: left;">회원탈퇴 후 소셜 연동 해제 안내</h3>
<div id="memberDeleteTerms">
<b>● 카카오톡(모바일)</b><br>메인 -> 더보기 -> 카카오계정 -> 연결된 서비스 관리 -> 외부 서비스 ->내일의 집 -> 연결끊기 후 진행<br>
<b>● 카카오톡(PC)</b><br><a style="color:GRAY" href="https://accounts.kakao.com/weblogin/account">카카오계정 관리 페이지(사이트로 이동)</a> -> 계정 이용 ->연결된 서비스 관리에서 외부 서비스 -> 내일의 집 -> 연결끊기 후 진행<br>
<br>
<b>● 네이버(모바일)</b> : 메인 -> 프로필 -> 상단 프로필 -> 이력관리에서 연결된 서비스 관리 -> 내일의 집 -> 서비스 동의 철회<br>
<b>● 네이버(PC)</b> : 메인 -> 프로필 -> 이력관리 -> 연결된 서비스 관리 전체보기 -> 내일의 집 -> 서비스 동의 철회<br>
<br>
<b>● 구글(모바일)</b> : 메인 -> 프로필 -> 구글 계정 관리 -> 보안 -> 서드 파티 앱 및 서비스 연결에서 모든 연결 보기 -> 내일의 집 -> 내일의 집에 대한 모든 연결 삭제<br>
<b>● 구글(PC)</b> : 메인 -> 프로필 -> 왼쪽 탭에서 보안 -> 서드 파티 앱 및 서비스 연결에서 모든 연결 보기 -> 내일의 집 -> 내일의 집에 대한 모든 연결 삭제<br>
</div> -->
</c:if>

<c:if test="${member.memberEmail2 == 'socialNaver' || member.memberEmail2 == 'socialGoogle' || member.memberEmail2 == 'kakaoSocial'}">
<div id="memberDeleteSub">
<h2>연동해제 신청</h2>
<h3>연동해제 신청에 앞서 아래 내용을 반드시 확인해주세요.</h3>
</div>
<div id="memberDeleteTerms">
<b>연동해제 시 처리내용</b><br>
(주)내일의 집 포인트·쿠폰은 소멸되며 환불되지 않습니다.<br>
(주)내일의 집 구매 정보가 삭제됩니다.<br>
소비자보호에 관한 법률 제6조에 의거,계약 또는 청약철회 등에 관한 기록은 5년, 대금결제 및 재화등의 공급에 관한 기록은 5년, 소비자의 불만 또는 분쟁처리에 관한 기록은 3년 동안 보관됩니다. 동 개인정보는 법률에 의한 보유 목적 외에 다른 목적으로는 이용되지 않습니다.
<br>
<br>
<b>연동해제 시 게시물 관리</b><br>
회원탈퇴 후 내일의 집 서비스에 입력한 게시물 및 댓글은 삭제되지 않으며, 회원정보 삭제로 인해 작성자 본인을 확인할 수 없으므로 게시물 편집 및 삭제 처리가 원천적으로 불가능 합니다. 게시물 삭제를 원하시는 경우에는 먼저 해당 게시물을 삭제 하신 후, 탈퇴를 신청하시기 바랍니다.<br>
<br>
<b>연동해제 후 재가입 규정</b><br>
탈퇴 회원이 재가입하더라도 기존의 오늘의집 포인트는 이미 소멸되었기 때문에 양도되지 않습니다.
</div>
</c:if>


<div id="memberDeleteSub">
<h3>(주)내일의 집 서비스 이용 중 어떤 부분이 불편하셨나요?</h3>
</div>
<textarea id="memberDeleteCause"  placeholder="(주)내일의 집을 떠나는 이유를 자세히 알려주시겠어요?
여러분의 소중한 의견을 반영해 더 좋은 서비스로 꼭 찾아뵙겠습니다."></textarea><br>


<div id="memberDeleteSelect" style="margin-bottom:100px;">
<c:if test="${member.memberEmail2 != 'socialNaver' && member.memberEmail2 != 'socialGoogle' && member.memberEmail2 != 'kakaoSocial'}">
<a href="/"><button id="memberDeleteCancel">탈퇴 취소</button></a>
</c:if>

<c:if test="${member.memberEmail2 == 'socialNaver' || member.memberEmail2 == 'socialGoogle' || member.memberEmail2 == 'kakaoSocial'}">
<a href="/"><button id="memberDeleteCancel">연동해제 취소</button></a>
</c:if>

<c:if test="${member.memberEmail2 != 'socialNaver' && member.memberEmail2 != 'socialGoogle' && member.memberEmail2 != 'kakaoSocial'}">
<form action="/member/memberDelete.do" method="POST">
<input name="memberId" type="hidden" value="${member.memberId}"/>
<button id="memberDeleteButton" type="submit">회원탈퇴</button>
</form>
</c:if>

<c:if test="${member.memberEmail2 == 'socialNaver'}">
<form action="/naver/memberDelete.do" method="POST">
<input name="memberId" type="hidden" value="${member.memberId}"/>
<button id="memberDeleteButton" type="submit">연동해제</button>
</form>
</c:if>

<c:if test="${member.memberEmail2 == 'socialGoogle'}">
<form action="/google/memberDelete.do" method="POST">
<input name="memberId" type="hidden" value="${member.memberId}"/>
<button id="memberDeleteButton" type="submit">연동해제</button>
</form>
</c:if>

<c:if test="${member.memberEmail2 == 'kakaoSocial'}">
<form action="/kakao/memberDelete.do" method="POST">
<input name="memberId" type="hidden" value="${member.memberId}"/>
<button id="memberDeleteButton" type="submit">연동해제</button>
</form>
</c:if>
</div>
</div>
</body>
</html>