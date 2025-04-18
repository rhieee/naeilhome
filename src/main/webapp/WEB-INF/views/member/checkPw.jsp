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
    <title>비밀번호 찾기</title>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <style>
        body {
            overflow: hidden;
            height: 100vh;
            font-family: Arial, sans-serif;
        }

        input {
            width: 280px;  /* 동일한 크기로 설정 */
            height: 30px;  /* 크기 일치 */
            padding: 5px;
            margin: 5px 0;
        }

#pwdform {
    position: absolute;
    top: 45%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: left;
    margin: auto;
    padding: 20px; /* 왼쪽 짤림 방지용 */
    box-sizing: border-box;
    max-width: 400px;
    width: 100%;
}
#btn {
    background-color: #00A9FF;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}

/* 확인 버튼 */
#btn {
    width: 300px;
    height: 40px;
    margin-top: 10px;
}
#btn:hover {
    background-color: #008ED6;
}
        
        .input-group {
            margin-bottom: 15px;
        }
        
        label {
            font-size: 16px;
            margin-bottom: 5px;
        }

        .phone-input-group input {
            width: 74px; 
            display: inline-block;
        }


    </style>
</head>
<body>

<div id="pwdform">
    <h2>비밀번호 수정</h2>

    <form action="/member/checkPw.do" method="POST">
        <div class="input-group">
            <label for="memberPw">새 비밀번호</label><br>
            <input type="password" name="memberPw" id="memberPw" required />
        </div>

        <div class="input-group">
            <label for="newPwd">새 비밀번호 확인</label><br>
            <input type="password" name="newPwd" id="newPwd" required />
        </div>

        <!-- 확인 버튼 -->
        <button type="submit" id="btn">비밀번호 변경</button>
    </form>
</div>


<!-- Flash Attribute를 올바르게 표시 -->
<c:if test="${not empty error}">
    <script>
        alert("${error}");
    </script>
</c:if>

</body>
</html>