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
<form action="/member/updatePassword.do" method="POST">
    <img src="/resources/image/naeilhomeLogo3.png" width="280px" style="margin-top:30px; margin-left:3px;"/><br><br><br>

    <b>기존 비밀번호 입력</b><br>
    <input type="password" name="currentMemberPw" id="currentPwd"/><br><br>

    <b>새 비밀번호 입력</b><br>
    <input type="password" name="newMemberPw" id="newPwd1"/><br><br>

    <b>새 비밀번호 확인</b><br>
    <input type="password" name="newMemberPw2" id="newPwd2" oninput="pwdCheck()"/><br>
    <p id="pwdMsg"></p>

    <button type="submit" onclick="return updatePassword()">비밀번호 수정하기</button>
</form>
</div>
</body>
<script>
const memberPwd = `${member.memberPw}`;

$(document).ready(function() {
    $('#newPwd1, #newPwd2').on('input', function() {
        pwdCheck();
    });
});

function updatePassword() {
    var currentPwdInput = $('#currentPwd').val();
    var newPwdInput = $('#newPwd1').val();
    var newPwdConfirm = $('#newPwd2').val();

    if (newPwdInput === memberPwd) {
        alert("새 비밀번호는 기존 비밀번호와 같을 수 없습니다.");
        return false;
    }

    if (currentPwdInput === memberPwd && newPwdInput === newPwdConfirm && newPwdInput !== "") {
        return true; 
    } else if (currentPwdInput !== memberPwd) {
        alert("기존 비밀번호가 잘못되었습니다.");
        return false;
    } else {
        alert("새 비밀번호가 일치하지 않거나 비밀번호가 비어 있습니다.");
        return false;
    }
}

function pwdCheck() {
    var newPwdInput = $('#newPwd1').val();
    var newPwdConfirm = $('#newPwd2').val();
    var pwdMsg = $('#pwdMsg');
    var pwdLengthCheck = newPwdInput.length;

    // 비밀번호 길이 체크
    if (pwdLengthCheck < 4 || pwdLengthCheck > 16) {
        pwdMsg.text("비밀번호는 4~16자 입니다.");
        return;
    } else {
        pwdMsg.text("");
    }

    // 비밀번호 확인 체크
    if (newPwdConfirm !== newPwdInput) {
        pwdMsg.text("입력하신 비밀번호와 다릅니다.");
    } else if (newPwdInput === "" || newPwdConfirm === "") {
        pwdMsg.text("");
    } else {
        pwdMsg.text("");
    }
}
</script>
</html>