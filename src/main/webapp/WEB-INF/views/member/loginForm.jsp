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
<title>로그인창</title>

<style>
body, html {
    height: 110%;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
}

.container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 100%; 
}

.logo {
    margin-top: 8%;
    margin-left: 25px;
}

#loginForm {
    padding: 20px;
    width: 100%;
    margin-bottom: 5px;
}

.idPwd {
    width: 30%;
    height: 25px; 
    font-size: 16px;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid black;
}

.idPwd:focus {
    outline: 0.5px solid rgba(0,0,0,0.3);
}

.ioginButton {
    width: 32.5%;
    height: 45px;
    font-size: 18px;
    padding: 10px;
    border-radius: 5px;
    margin-top: 15px;
    margin-bottom: 15px;
    background-color: #99E0FF;
    border: none;
    font-weight: bold;
    color:white;
}

.ioginButton:hover {
    background-color: #66CEFF;
    cursor: pointer;
}

.nav td a {
    margin-right: 50px;
    font-weight: bold;
}

.snsNav {
    background-color: #F5F5F5;
    width: 32.5%;
    height: 110px;
    border-radius: 5px;
    margin-left: auto; 
    margin-right: auto; 
}

.snsNav td {
    font-weight: bold;
}

.snsNav img {
    width: 40px;
}

a {
    text-decoration: none;
    color: black;
</style>

<script>
// 윈도우가 로그되면 해당 위치로 즉시 스크롤됨.
/*     window.onload = function() {
        document.getElementById('start').scrollIntoView({ behavior: 'auto' });
    }; */
    
	// 현재 url에서 쿼리 파라미터를 가져온다.
    const loginCheckParams = new URLSearchParams(window.location.search);
	// 컨트롤러에서 넘어온 값 비교
    if (loginCheckParams.get('result') === 'loginFailed') {
        alert('아이디 혹은 비밀번호가 다릅니다.');
    }
	
</script>

</head>
<body>
    <div class="container">
        <div class="logo">
            <a href="/">
                <img src="/resources/image/naeilhomeLogo3.png" width="280px"  style="margin-right:26.5px;"/>
            </a>
        </div>

        <div id="loginForm">
            <form name="frmLogin" method="post" action="/member/login.do">
                <table style="width:100%">
                    <tr align="center">
                        <td>
                            <input class="idPwd" type="text" name="memberId" value="" placeholder="아이디" required>
                        </td>
                    </tr>
                    <tr align="center">
                        <td>
                            <input class="idPwd" type="password" name="memberPw" value="" placeholder="비밀번호" required>
                        </td>
                    </tr>
                    <tr align="center">
                        <td colspan="2">
                            <input class="ioginButton" type="submit" value="로그인">
                        </td>
                    </tr>
                    <tr class="nav">
                        <td>
                            <a style="margin-left:50px;" href="/member/findId.do">ID찾기</a>
                            <a href="/member/findPw.do">비밀번호찾기</a>
                            <a href="/member/memberForm.do">회원가입</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        <div class="snsNav">
            <table style="width:100%">
                <tr>
                    <td style="padding-top:15px;">SNS계정으로 간편하게 로그인</td>
                </tr>
                <tr>
                    <td style="padding-top:15px">
                        <a href="/kakao/kakaoLogin.do" style="display: inline-block; margin-right:5px;">
                            <img src="/resources/image/Kakaotalk_icon.png">
                        </a>
                        <a href="${contextPath}/naver/login.do" style="display: inline-block; margin-right:5px;">
                            <img src="${contextPath}/resources/image/Naver_icon.png">
                        </a>
                         <a href="${contextPath}/google/login.do" style="display: inline-block; margin-right:5px;">
                            <img src="${contextPath}/resources/image/Google_icon.png">
                        </a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
<!-- 비밀번호변경시 얼럿 -->
<c:if test="${not empty message}">
<script>
    alert("${message}");
</script>
</c:if>
    
</body>
</html>
