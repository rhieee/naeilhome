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
    width: 280px;
    height: 30px;
    padding: 5px;
    margin: 5px 0;
}

#pwdform {
    position: absolute;
    top: 55%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: left;
    margin: auto;
    padding: 20px;
    box-sizing: border-box;
    max-width: 400px;
    width: 100%;
}

#btn, #mailCheckBtn {
    background-color: #00A9FF;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    
}

#btn {
    width: 294px;
    height: 40px;
    margin-top: 10px;
}

#mailCheckBtn{
	background-color: #00A9FF;
	border-radius: 5px; 
	border:none; 
	color: white;
	margin-right:65px;
}

#btn:hover,
#authBtn:hover,
#mailCheckBtn:hover,
.checkBtn:hover {
    background-color: #008ED6;
}

.input-group {
    margin-bottom: 10px;
}

label {
    font-size: 16px;
    margin-bottom: 5px;
}

.email-input-group input {
    width: 125px;
    display: inline-block;
}

.radio-group {
    margin-bottom: 20px;
    display: flex;
    justify-content: left;
    align-items: center;
}

.radio-group input[type="radio"] {
    width: 15px;
    height: 15px;
    margin-right: 10px;
}

.input-group-with-button {
    display: flex;
    gap: 10px;
    align-items: center;
    margin-bottom: 15px;
}

.input-group-with-button input {
    width: 150px;
}

.input-group-with-button button {
    width: 120px;
}

/* 이메일 라벨과 버튼 정렬용 flex 추가 */
.email-title-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

#emailCheck {
    font-weight: bold;
    margin-right: 10px;
    font-size: 15px;
    vertical-align: middle;
}
#memberEmail1{
	WIDTH: 250PX;
}
#memberEmail2{
	WIDTH: 170PX;
}
#selectEmail2{
	HEIGHT:43PX;
}
.mailCheck {
	display: flex;
    align-items: center;
    justify-content: flex-start;
}
.checkBtn{
	 width: 294px;
    height: 40px;
    background-color: #00A9FF;
    border-radius: 5px; 
	border:none; 
	color: white;
}

    </style>
    
<script>
//이메일 도메인 선택/직접입력
function choiceEmail(value){
    if(value === '직접입력'){
        document.getElementsByName("memberEmail2")[0].value = "";
        document.getElementsByName("memberEmail2")[0].readOnly = false;
    } else {
        document.getElementsByName("memberEmail2")[0].value = value;
        document.getElementsByName("memberEmail2")[0].readOnly = true;
        document.getElementById('emailMsg1').innerText = ""; // 도메인 선택했으면 경고메시지 초기화
        document.getElementById('emailMsg2').innerText = "";
    }
    if(document.getElementsByName("memberEmail2")[0].value != ""){InputEmail2StatusCheck = true;}
    else{InputEmail2StatusCheck = false;}
};
</script>

</head>
<body>


<div id="pwdform">
    <h2>비밀번호 찾기</h2>
        <!-- 라디오 버튼 -->
    	<form action="/member/findPwSearch.do" method="POST" onsubmit="return valdateForm()">
    	<!-- <input type="hidden" name="memberId" id="memberId" value="memberId"/> --> <!-- 입력한 멤버아이디를 히든으로 넣기 -->
    	
        <div class="radio-group">
            <input type="radio" value="phone" checked> 
            <label for="phone">회원정보에 등록한 이메일로 인증</label>
        </div>

        <!-- 이름 입력 -->
        <div class="input-group">
            <label for="memberName">이름</label><br>
            <input type="text" name="memberName" id="memberName" />
        </div>
        
        <!-- 아이디 입력 -->
        <div class="input-group">
            <label for="memberId">아이디</label><br>
            <input type="text" name="memberId" id="memberId" />
        </div>
        
        <!-- <p style="display: flex; justify-content: space-between; align-items: center;">
		    이메일<b id="emailCheck"></b>
		    <button type="button" id="mailCheckBtn" onclick="mailCheck()">본인인증</button>
		</p> -->
		
		<p style="display: flex; justify-content: space-between; align-items: center; margin-bottom:2px;">
    이메일<b id="emailCheck"></b>
    <button type="button" id="mailCheckBtn" onclick="mailCheck()">본인인증</button>
</p>
		
		
		
		<!-- 이메일 입력란 -->
		<div id="email">
		<input id="memberEmail1" type="text" name="memberEmail1" onkeyup="deInputKo(event)" oninput="resetEmailAuth()" value="${member.memberEmail1}" required/>
		&nbsp;@&nbsp;
		<input id="memberEmail2" type="text" name="memberEmail2" onkeyup="deInputKo(event)" oninput="resetEmailAuth()" value="${member.memberEmail2}" required/>
		
		<select style="margin-left:15px;" id="selectEmail2" onchange="choiceEmail(this.value)"> 
		<option class="email2Select" value="직접입력">직접입력</option>
		<option class="email2Select" value="gmail.com">gmail.com</option>
		<option class="email2Select" value="naver.com">naver.com</option>
		<option class="email2Select" value="daum.net">daum.net</option>
		<option class="email2Select" value="yahoo.com">yahoo.com</option>
		</select>
		</div>
		<p id="emailMsg1"></p>
		<p id="emailMsg2"></p>
		
		
		<!-- 메일 인증 -->
		<div class="mailCheck" style="display:none;">
		<div class="mailCheckBox">
		<input class="mailCheckInput" placeholder="인증번호 6자리를 입력해주세요." maxlength="6" style="margin-top:0px;">
		<input class="checkBtn" onclick="authNumberCheck()" type="button" value="인증 확인" style="display:none;"/>
		</div>
		</div>

        <!-- 확인 버튼 -->
        <button type="submit" id="btn">확인</button>
    </form>
</div>

</body>

<script>

//공백이면 얼럿
function valdateForm(){
	var memberName = document.getElementById("memberName").value.trim();
	var memberId = document.getElementById("memberId").value.trim();
	
	if(memberName === "") {
		alert("이름을 입력해주세요.");
		document.getElementById("memberName").focus();    //memberName에 포커스
		return false;
	}
	if(memberId === "") {
		alert("아이디를 입력해주세요.");
		document.getElementById("memberId").focus();    //memberId에 포커스
		return false;
	}
	
	  console.log("폼 제출 성공"); // 폼이 정상적으로 제출될 때 로그 출력
	    return true;
	
}

//조회 후 null이나 공백이면 alert띄우기
window.onload =function() {
	var errorMsg ="${error}"; //컨트롤러에서 전달된 메시지
	if(errorMsg && errorMsg !="") {
		alert(errorMsg);
	}
};




//이메일 인증
function mailCheck() {
    const email1 = $('#memberEmail1').val();
    const email2 = $('#memberEmail2').val();
    const email = email1 + '@' + email2; // 이메일 수정
	const memberEmail1 = `${member.memberEmail1}`;
	const memberEmail2 = `${member.memberEmail2}`;
    const memberEmail = memberEmail1 + '@' + memberEmail2;
	
    // 이메일 유효성 검사
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
   if(email != memberEmail){
    if (emailRegex.test(email)) {
        $.ajax({
            type: 'POST',
            url: '/mail/mailCheck2.do',
            data: {"memberEmail1": email1, "memberEmail2":email2 },
            dataType: 'json',
            success: function (data) {
                var useEmailCount = data.useEmailCount;
                
                if(useEmailCount > 0){
                	$(".mailCheckInput").attr('disabled', false);
                    $(".mailCheck").css("display","block");
                    $(".mailCheckInput").attr('required',true);
                    alert('인증번호가 발송되었습니다.');
                    
                } else{
                	
                    alert('가입되지 않은 이메일입니다.');
                }
            },
            error: function (error) {
            }
        });
    } else {
        alert("올바른 이메일을 입력해 주세요.");
    }
   }else{
	   alert("올바른 이메일을 입력해 주세요.");
   }
}

// 확인 버튼 활성화
$('.mailCheckInput').on('input', function() {
    const inputVal = $(this).val();
    if (inputVal.length === 6) { 
        $(".checkBtn").show();
        $(".checkBtn").attr("disabled", false);
    } else {
        $(".checkBtn").hide();
        $(".checkBtn").attr("readonly", true);
    }
});

// 인증번호 비교하러 서버로
function authNumberCheck() {
    const email1 = $('#memberEmail1').val();
    const email2 = $('#memberEmail2').val();
    const email = email1 + '@' + email2;
    const authNumber = $('.mailCheckInput').val(); // 인증번호 입력값 가져오기

    $.ajax({
        type: 'POST',
        url: '/mail/authNumberCheck.do',
        data: { email: email, authNumber: authNumber }, // 이메일 및 입력한 인증번호 전송
        
        success: function (data) {
        	
            $(".mailCheckInput").attr('readonly', true);
            $(".checkBtn").attr("readonly", true);
            $("#memberEmail1").attr("readonly", true);
            $("#memberEmail2").attr("readonly", true);
            $("#selectEmail2").attr("readonly", true);
            $(".mailCheck").css("display","none");
            $("#mailCheckBtn").hide();
            $("#mailCheckBtn").attr("readonly", true);
            
            console.log(data);
            alert('인증이 완료되었습니다.');
            
            emailAuth = true;
        },
        error: function (error) {
            console.log(error);
            alert('잘못된 인증번호 입니다.');
        }
    });
}

</script>
</html>