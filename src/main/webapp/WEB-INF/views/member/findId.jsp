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
    <title>아이디 찾기</title>
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

#btn, #authBtn {
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
/* 인증번호받기 버튼 */
#authBtn {
    width: 130px;
    height: 40px;
}
#btn:hover,
#authBtn:hover {
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
            width: 74px; /* 핸드폰 번호 입력 필드 크기 조정 */
            display: inline-block;
        }

        .radio-group {
            margin-bottom: 20px;
            display: flex;
            justify-content: left; /* 중앙 정렬 */
            align-items: center;
        }

        .radio-group input[type="radio"] {
            width: 15px;  /* 라디오 버튼의 크기를 줄임 */
            height: 15px; /* 라디오 버튼의 크기를 줄임 */
            margin-right: 10px; /* 라디오 버튼과 텍스트 간의 간격 */
        }

/* 인증번호 받기 버튼과 추가 인풋 필드 배치 */
.input-group-with-button {
    display: flex;
    gap: 10px; /* input과 버튼 사이 여백 */
    align-items: center;
    margin-bottom: 15px;
}
		/* input과 버튼의 너비 조절 */
		.input-group-with-button input {
		    width: 145px;
		}
		.input-group-with-button button {
		    width: 120px;
		}


    </style>
</head>
<body>

<div id="pwdform">
    <h2>아이디 찾기</h2>

    <form action="/member/checkId.do" method="POST" onsubmit="return valdateForm()">
        <!-- 라디오 버튼 -->
        <div class="radio-group">
            <input type="radio" value="phone" checked> 
            <label for="phone">회원정보에 등록한 휴대전화로 인증</label>
        </div>

        <!-- 이름 입력 -->
        <div class="input-group">
            <label for="memberName">이름</label><br>
            <input type="text" name="memberName" id="memberName" />
        </div>

        <!-- 핸드폰 번호 입력 -->
        <div class="input-group phone-input-group">
            <label for="memberPhone">휴대전화</label><br>
            <input type="text" name="memberPhone1" id="memberPhone1" maxlength="3" /> -
            <input type="text" name="memberPhone2" id="memberPhone2" maxlength="4" /> -
            <input type="text" name="memberPhone3" id="memberPhone3" maxlength="4" />
        </div>


        <!-- 확인 버튼 -->
        <button type="submit" id="btn">확인</button>

    </form>
</div>

</body>

<script>

//공백이면 얼럿
function valdateForm(){
	var MemberName = document.getElementById("memberName").value.trim();
	var memberPhone1 = document.getElementById("memberPhone1").value.trim();
	var memberPhone2 = document.getElementById("memberPhone2").value.trim();
	var memberPhone3 = document.getElementById("memberPhone3").value.trim();
	
	if(MemberName === "") {
		alert("이름을 입력해주세요.");
		document.getElementById("memberName").focus();    //memberName에 포커스
		return false;
	}
	if(memberPhone1 === "" || memberPhone2 === "" || memberPhone3 === "") {
		alert("휴대전화를 입력해주세요.");
		document.getElementById("memberPhone1").focus();  //memberPhone1에 포커스띄움
		return false;
	}
}


</script>
</html>