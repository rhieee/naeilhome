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
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<style>

body{
overflow: hidden;
height:100vh;
}

input{
width:280px;
height:20px;
}

#pwdform {
    position: absolute;
    top: 45%;
    left: 50%; 
    transform: translate(-50%, -50%); 
    text-align: left;
    margin: auto;
}

button{
width:290px;
height:30px;
background-color: #00A9FF; 
color: white;
border: none;
cursor: pointer;
border-radius: 5px; 
}

button:hover{
background-color: #008ED6;
}
</style>
<body>
<br>
<br>
<div id="pwdform">
    <img src="/resources/image/naeilhomeLogo3.png" width="280px" style="margin-top:30px; margin-left:3px;"/><br><br><br>

    <b>비밀번호 입력</b><br>
    <input type="password" name="memberPw" id="pwd1"/><br><br>

    <b>비밀번호 확인</b><br>
    <input type="password" name="memberPw2" id="pwd2" oninput="pwdChecck()"/><br>
    <p id="pwdMsg"></p>

    <button type="button" onclick="memberDeletePwd()">탈퇴하기</button>
</div>
</body>
<script>
    const memberPwd = `${member.memberPw}`;
    	$(document).ready(function() {
            $('#pwd2').on('input', function() {
                pwdCheck();
            });

            $('#deleteButton').on('click', function() {
                memberDeletePwd();
            });
        });

        function memberDeletePwd() {
            var pwdInput = $('#pwd1').val();
            var pwdConfirm = $('#pwd2').val();

            if (pwdInput === memberPwd && pwdConfirm === memberPwd && pwdInput === pwdConfirm) {
                alert("회원탈퇴 페이지로 이동하겠습니다.");
                opener.location.href = '/member/memberDeleteLastCh.do'; 
                window.close();
            } else {
                alert("잘못된 비밀번호입니다.");
            }
        }

        function pwdCheck() {
            var pwdInput = $('#pwd1').val();
            var pwdConfirm = $('#pwd2').val();
            var pwdMsg = $('#pwdMsg');

            if (pwdConfirm !== pwdInput) {
                pwdMsg.text("입력하신 비밀번호와 다릅니다.");
            } else if (pwdInput === "" || pwdConfirm === "") {
                pwdMsg.text("");
            } else {
                pwdMsg.text("");
            }
        }
</script>
</html>