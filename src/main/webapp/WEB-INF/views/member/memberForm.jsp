<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
	request.setCharacterEncoding("UTF-8");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입창</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

var resultMember = null;
document.addEventListener("DOMContentLoaded", function () {
	// 조회한 멤버가 없으면 true 있으면 false
	resultMember = ${resultMember};
	if(resultMember != ''){
		if(${resultMember}){
			result = "true";
			InputMemberIdStatusCheck = true;
			InputMemberIdStatusCheck2 = true;
			InputEmail1StatusCheck = true;
			InputEmail2StatusCheck = true;
			InputPwdStatusCheck = true;
			doubleCheckPwd = true;
			emailAuth = true;
			
			$('#memberId').val("${member.memberId}");
			$('#inputEmail1').val("${member.memberEmail1}");
			$('#inputEmail2').val("${member.memberEmail2}");
			
			$('#memberId').hide();
			$('#id_Check').hide();
			$('.id').hide();
			$('#inputEmail1').hide();
			$('#inputEmail2').hide();
			$('.email').hide();
			$('#selectEmail2').hide();
			$('#emailMsg1').hide();
			$('#emailMsg2').hide();
			$('#inputBirth1').hide();
			$('#inputBirth2').hide();
			$('.pwd').hide();
			$('.pwd2').hide();
			$('.birthday').hide();
			$('.at').hide();
			$('#inputPwd').hide();
			$('#chk_pwd').hide();
			
			$(".snsNav").hide();
		}
	}
});

const entries = performance.getEntriesByType("navigation")[0];
if (entries.type === "reload") {
    location.href = "/member/loginForm.do";
}

// 중복확인용 변수
var msg1; // document.getElement 쓰기 위함
var msg2; // document.getElement 쓰기 위함
var usable; // '사용가능' 문자 넣기 위함
var not_usable; // '사용불가능' 문자 넣기 위함
var de_check_requirement = ["age", "use", "collection"];
var check_requirement = new Array();
var check_Id_Now;

var result = "false"; // ajax - /member/idCheck.do 메서드랑 연관있음 / ID 중복확인 상태
var result1 = "false"; // ajax - /member/nickNameCheck.do 메서드랑 연관있음 / 닉네임 상태
var InputMemberIdStatusCheck = false; // memberId 입력 상태
var InputMemberIdStatusCheck2 = false; // memberId 중복체크 후 아이디 변경하고 중복체크 안했을 때 상태
var InputMemberNameStatusCheck = false; // memberName 입력 상태
var InputEmail1StatusCheck = false; // email1 입력 상태
var InputEmail2StatusCheck = false; // email2 입력 상태
var InputPwdStatusCheck = false; // 비밀번호 입력 상태
var doubleCheckPwd = false; // 비밀번호확인 입력 상태
var checkZip = false; // 우편번호 입력 상태
var exists = false; // 이용약관 필수 선택 상태
var emailAuth = false; // 이메일 인증 상태

// memberId 중복확인
function idCheck(){
	var memberId = document.getElementById("memberId").value;
	if(memberId.length >= 4 && InputMemberIdStatusCheck == true){ // 입력한 memberId가 4글자 이상일 때만 ajax 실행
		$.ajax({
			url: '/member/idCheck.do',
			method: 'post',
			data: {'memberId':memberId},
			dataType: 'json',
			success: function(data){
				result = data.result;
				usable = '사용가능한 아이디입니다.';
				not_usable = '존재하는 아이디입니다.';
				msg1 = document.getElementById('idMsg1');
				msg2 = document.getElementById('idMsg2');
				check_Id_Now = $('#memberId').val();
				if(result == "false"){
					msg2.innerText = "";
					msg1.innerText = not_usable;
					result = "false";
					InputMemberIdStatusCheck = false;
				}else{
					msg1.innerText = "";
					msg2.innerText = usable;
					result = "true";
					InputMemberIdStatusCheck2 = true;
				}
			},
			error: function(data){
				alert('error');
			}
		});
	} else if(InputMemberIdStatusCheck == false){
		document.getElementById('idMsg1').innerText = "영문/숫자만 입력해주세요.";
		document.getElementById('idMsg2').innerText = "";
	} else if(memberId.length < 5){
		document.getElementById('idMsg1').innerText = "4글자 이상만 가능합니다";
		document.getElementById('idMsg2').innerText = "";
	}
};

// 아이디 전용 필터
function deInputKo1(event){
	document.getElementById('idMsg1').innerText = "";
	document.getElementById('idMsg2').innerText = "";
	
	var inputId = document.getElementsByName("memberId")[0].value;
	if(inputId !== ""){InputMemberIdStatusCheck = true;}
	
	if(check_Id_Now == $('#memberId').val()){
		InputMemberIdStatusCheck2 = true;
	}else{
		InputMemberIdStatusCheck2 = false;
		document.getElementById('idMsg1').innerText = "중복체크를 해주세요.";
	}
	
	var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글
	var check1 = /[~!@#$%";'^,&*()_+|</>=>`?:{[\}]/g; // 특수문자
	var check2 = /\s+/g; // 중간중간 공백 검사
	// var check2 = /^\s+|\s+$/g // 얘는 문자 양쪽 끝만 확인
	
	if(check.test(inputId) || check1.test(inputId) || check2.test(inputId)){
		InputMemberIdStatusCheck = false;
		result = "false";
		document.getElementById('idMsg1').innerText = "영문/숫자만 입력해주세요.";
	}

};

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

//비밀번호 + 비밀번호 확인 - 한글로 입력해도 알아서 영문으로 바뀜(운영체제마다 케바케라 함)
function check_pwd(){ 
	const pwd = document.getElementsByName('memberPw')[0].value;
	const pwdLengthCheck = document.getElementsByName('memberPw')[0].value.length;
	const chk_pwd = document.getElementById('chk_pwd').value;
	if(chk_pwd !== ""){
		if(pwd == chk_pwd){
			document.getElementById('pwd_chk2').innerText = "";		
			document.getElementById('pwd_chk1').innerText = '비밀번호가 일치합니다.';
			doubleCheckPwd = true;
		}else{
			document.getElementById('pwd_chk1').innerText = "";
			document.getElementById('pwd_chk2').innerText = '비밀번호가 틀립니다.';
			/* pwdLine2.style.border = '1px solid red';
			pwdLine2.style.outline = '1px solid red'; */ // 잘못된거 input 외각선 강조
			doubleCheckPwd = false;
		}
	}else{
		document.getElementById('pwd_chk2').innerText = "";		
		document.getElementById('pwd_chk1').innerText = "";
	}
	if(pwdLengthCheck < 4 || pwdLengthCheck > 16){
		document.getElementById('pwdLengthCheck').innerText = "4글자 이상만 가능합니다.";
		InputPwdStatusCheck = false;
		if(pwd === ""){
			document.getElementById('pwdLengthCheck').innerText = "";
			InputPwdStatusCheck = false;
		}
	} else {
		document.getElementById('pwdLengthCheck').innerText = "";
		InputPwdStatusCheck = true;
	}
};

function touchZip(){
	document.getElementById("touch_zip").innerText = "우편번호 검색 버튼을 이용해주세요.";
}

// 우편번호 검색 API
function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

	      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	        extraRoadAddr += data.bname;
	      }
	      // 건물명이 있고, 공동주택일 경우 추가한다.
	      if(data.buildingName !== '' && data.apartment === 'Y'){
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	      if(extraRoadAddr !== ''){
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	      if(fullRoadAddr !== ''){
	        fullRoadAddr += extraRoadAddr;
	      }

	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementsByName('memberZip1')[0].value = data.zonecode; //5자리 새우편번호 사용
	      document.getElementsByName('memberZip2')[0].value = fullRoadAddr;
	      
	      checkZip = true;
	      document.getElementById("touch_zip").innerText = "";
	      
	    }
	  }).open();
};

//닉네임 중복확인 (실시간)
function nickNameCheck(){
	var nickName = document.getElementsByName("memberNickname")[0].value;
	msg1 = document.getElementById('nickMsg1');
	msg2 = document.getElementById('nickMsg2');
	if(nickName === ""){
		msg1.innerText = "";
		msg2.innerText = "";
		result1 = "false";
	} else if(nickName.length < 2 || nickName.length > 10){
		msg1.innerText = '2 ~ 10 글자만 가능합니다.';
		msg2.innerText = "";
		result1 = "false";
	} else{ 
		$.ajax({
			url: '/member/nickNameCheck.do',
			method: 'post',
			data: {'nickName':nickName},
			dataType: 'json',
			success: function(data){
				result1 = data.result;
				usable = '사용가능한 닉네임입니다.';
				not_usable = '중복되는 닉네임입니다.';
				if(result1 == "false"){
					msg2.innerText = "";
					msg1.innerText = not_usable;
					result1 = "false";
				}else{
					msg1.innerText = "";
					msg2.innerText = usable;
					result1 = "true";
				}
			},error: function(data){
				alert('error');
			}
		});
	}
};

//입력란 기호에 안맞는 문자 입력 필터
function deInputKo(e){
	if(!(e.keyCode >= 37 && e.keyCode <= 40)){
		
		document.getElementById('emailMsg1').innerText = ""; // 재입력 시 경고 메시지 안뜨게
		document.getElementById('emailMsg2').innerText = "";	
		document.getElementById('nameMsg1').innerText = "";
		
		var inputName = document.getElementsByName("memberName")[0].value;
		var inputEmail = document.getElementsByName("memberEmail1")[0].value;
		var inputEmail2 = document.getElementsByName("memberEmail2")[0].value;
		
		if(inputName !== ""){InputMemberNameStatusCheck = true;}
		if(inputEmail !== ""){InputEmail1StatusCheck = true;}
		if(inputEmail2 !== ""){InputEmail2StatusCheck = true;}
		
		if(inputName === ""){InputMemberNameStatusCheck = false;}
		if(inputEmail === ""){InputEmail1StatusCheck = false;}
		if(inputEmail2 === ""){InputEmail2StatusCheck = false;}
		
		var check = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 한글
		var check1 = /[~!@#$%";'^,&*()_+|</>=>`?:{[\}]/g; // 특수문자
		var check2 = /\s+/g; // 중간중간 공백 검사
		var check3 = /^\s+|\s+$/g; // 얘는 문자 양쪽 끝만 확인
		
		if(check1.test(inputName) || check2.test(inputName)){
			InputMemberNameStatusCheck = false;
			document.getElementById('nameMsg1').innerText = "공백 및 특수문자 입력이 감지되었습니다.";
		}
		if(check.test(inputEmail) || check2.test(inputEmail) || check3.test(inputEmail)){
			InputEmail1StatusCheck = false;
			document.getElementById('emailMsg1').innerText = "영문/숫자만 입력해주세요.";
		}
		if(check.test(inputEmail2) || check2.test(inputEmail2) || check3.test(inputEmail2)){
			InputEmail2StatusCheck = false;
			document.getElementById('emailMsg1').innerText = "공백 및 한글을 제외한 입력이 감지되었습니다.";
		}
	}
};

//이용약관 전체선택, 전체선택 해제
function chk_all(){
	var selectAll = $('input[id=selectAll]').is(':checked');
	if(selectAll){
		$('input[class=chk]').prop('checked', true);
	} else {
		$('input[class=chk]').prop('checked', false);
	}
	chk();
};

// 이용약관 개별선택

function chk(){
	
	var requirement = [$('input[id=age]').val(),
						$('input[id=use]').val(),
						$('input[id=collection]').val()]; // 필수 선택요소 value
						
	const chkAllCount = $('input[class=chk]').length; // class가 chk인 체크박스 전체 수
	const chkNowCount = $('input[class=chk]:checked').length; // class가 chk인 활성화된 체크박스 
	
	if(chkAllCount > chkNowCount){
		$('input[id=selectAll]').prop('checked', false); // prop = 체크박스 상태 강제 변경
	} else {
		$('input[id=selectAll]').prop('checked', true);
	}
	
	var chk_val = new Array();
	
	$('input[class=chk]:checked').each(function(){
		var val = $(this).val();
		chk_val.push(val);
	});
	
	de_check_requirement = []; // 초기화
	check_requirement = [];
	
	exists = requirement.every(val => chk_val.includes(val)); // 필수 선택요소를 선택 안했을 시 false
	
	check_requirement = requirement.filter(item => chk_val.includes(item)); // 필수 선택요소 기준 선택 한것들
	de_check_requirement = requirement.filter(item => !chk_val.includes(item)); // 필수 선택요소 기준 선택 안한것들
	
};

function addMember(event) {
	var birthCheck1 = ($('#inputBirth1').val().length == 6);
	var birthCheck2 = ($('#inputBirth2').val().length == 7);
	var phoneCheck1 = ($('#inputPhone2').val().length == 4);
	var phoneCheck2 = ($('#inputPhone3').val().length == 4);

	if(resultMember){
		InputEmail1StatusCheck = true;
	}
    // 조건을 만족하는지 체크
    if (InputMemberIdStatusCheck && InputMemberNameStatusCheck
        && InputEmail1StatusCheck && InputEmail2StatusCheck
        && InputPwdStatusCheck && doubleCheckPwd && exists && emailAuth
        && result == "true" && result1 == "true" && birthCheck1 && birthCheck2 &&
        phoneCheck1 && phoneCheck2) {
        return true;  // 폼을 정상 제출
    } else {
        var tagId = null;

        // 입력 문제 있는 곳으로 스크롤 이동
        if (!InputMemberIdStatusCheck || result == "false" || !InputMemberIdStatusCheck2) {
            tagId = document.getElementById('id');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!InputMemberNameStatusCheck || result1 == "false") {
            tagId = document.getElementById('name');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!InputEmail1StatusCheck || !InputEmail2StatusCheck || !emailAuth) {
            tagId = document.getElementById('email');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!InputPwdStatusCheck) {
            tagId = document.getElementById('pwd');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!doubleCheckPwd) {
            tagId = document.getElementById('pwd2');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!checkZip) {
            tagId = document.getElementById('zip');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!exists) {
            tagId = document.getElementById('age1');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!birthCheck1 || !birthCheck2) {
            tagId = document.getElementById('birthDay');
            tagId.scrollIntoView({ behavior: "smooth" });
        } else if (!phoneCheck1 || !phoneCheck2) {
            tagId = document.getElementById('phone');
            tagId.scrollIntoView({ behavior: "smooth" });
        }

        // 각 필드 옆에 * 표시
        if (!InputMemberIdStatusCheck || result == "false" || !InputMemberIdStatusCheck2) {
            tagId = document.getElementById('id');
            tagId.innerText = ' *';
        } else {
            tagId = document.getElementById('id');
        	tagId.innerText = '';
        	}
        if (!InputMemberNameStatusCheck) { 
            tagId = document.getElementById('name'); 
            tagId.innerText = ' *'; 
        } else { 
            tagId = document.getElementById('name'); 
            tagId.innerText = ''; 
        }

        if (!InputEmail1StatusCheck || !InputEmail2StatusCheck || !emailAuth) { 
            tagId = document.getElementById('email');
            tagId.innerText = ' *';
        } else { 
            tagId = document.getElementById('email'); 
            tagId.innerText = ''; 
        }

        if (!InputPwdStatusCheck) { 
            tagId = document.getElementById('pwd'); 
            tagId.innerText = ' *'; 
        } else { 
            tagId = document.getElementById('pwd'); 
            tagId.innerText = ''; 
        }

        if (!doubleCheckPwd) { 
            tagId = document.getElementById('pwd2'); 
            tagId.innerText = ' *'; 
        } else { 
            tagId = document.getElementById('pwd2'); 
            tagId.innerText = ''; 
        }

        if (!checkZip) { 
            tagId = document.getElementById('zip'); 
            tagId.innerText = ' *'; 
        } else { 
            tagId = document.getElementById('zip'); 
            tagId.innerText = ''; 
        }
        
        if (result1 == "false") { 
            tagId = document.getElementById('nickName'); 
            tagId.innerText = ' *'; 
        } else { 
            tagId = document.getElementById('nickName'); 
            tagId.innerText = ''; 
        }
        
        if (!birthCheck1 || !birthCheck2) { 
            tagId = document.getElementById('birthDay'); 
            tagId.innerText = ' *'; 
        } else { 
            tagId = document.getElementById('birthDay'); 
            tagId.innerText = ''; 
        } 
        
        if (!phoneCheck1 || !phoneCheck2) { 
            tagId = document.getElementById('phone'); 
            tagId.innerText = ' *'; 
        } else { 
            tagId = document.getElementById('phone'); 
            tagId.innerText = ''; 
        }

        if (!exists) {
            for (var i = 0; i < de_check_requirement.length; i++) { 
                var tag_id = de_check_requirement[i] + 1;
                tagId = document.getElementById(tag_id);
                tagId.innerText = ' *';
            }
            for (var i = 0; i < check_requirement.length; i++) { 
                var tag_id = check_requirement[i] + 1;
                tagId = document.getElementById(tag_id);
                tagId.innerText = '';
            }
        } else {
            for (var i = 0; i < check_requirement.length; i++) { 
                var tag_id = check_requirement[i] + 1;
                tagId = document.getElementById(tag_id);
                tagId.innerText = '';
            }
        }

        return false;  // 폼 제출 방지
    }
}

// DOMContentLoaded 이벤트가 발생하면 폼 제출 이벤트 리스너를 설정합니다.
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('memberForm');
    form.addEventListener('submit', function(event) {
        // 기본 폼 제출을 막고 addMember() 함수 호출
        event.preventDefault();  
        if (addMember(event)) {
            form.submit();  // 조건이 맞으면 폼 제출
        }
    });
});

function profileImage(input) {
	$('#imagesButton').click();
};

function imageButtonClick(input) {
	var lastDot = input.files[0].name.lastIndexOf('.');
	var fileLen = input.files[0].name.length;
	var fileDotName = input.files[0].name.substring(lastDot, fileLen).toLowerCase();
	var useFileDotName = [".gif", ".jpg", ".png", ".jepg"];
	var exists = useFileDotName.some(item => item == fileDotName);
	
	if(exists){
		var reader = new FileReader();
		reader.onload = function(e){
			$('#memberProfileImage').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}else{
		document.getElementsByName('memberIamge')[0].value = null;
		$('#memberProfileImage').attr('src', '/resources/image/mypage.png');
		alert('프로필 사진은 .gif, .jpg, .png, .jepg 확장자만 가능합니다.')
	}
};

</script>
<style>
body{
	font-family: Arial, sans-serif;
}
#idMsg1, #pwd_chk2, #nameMsg1, #nickMsg1, #pwdLengthCheck, #touch_zip, #emailMsg2, #emailMsg1{
	margin:0px;
	padding:0px;
	color: red;
	font-size: 13px; /* 비정상적 입력 출력메시지 */
	position:absolute;
	left: 50%;
	transform: translate(-50%, -5%);
}
#idMsg2, #pwd_chk1, #nickMsg2{
	margin:0px;
	padding:0px;
	color: green;
	font-size: 13px; /* 정상적 입력 출력메시지 */
	position:absolute;
	left: 50%;
	transform: translate(-50%, -5%);
}
#id, #name, #email, #pwd, #pwd2, #birthDay, #phone, #zip, #nickName, #age1, #use1, #collection1, #phoneMsg, #phone{
	color: red; /* *색상 */
}
.snsNav {
    background-color: #F5F5F5;
    width: 39%;
    height: 140px;
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
}
.id, .name, .pwd, .pwd2, .birthday, .phone, .zip, .image, .nickname, .email, .c{
	margin: 0px;
	margin-left: 10px;
	margin-top: 20px;
	text-align: left;
	font-size: 20px;
	font-weight: bold;
}
.image, .nickname{
	margin-top: 15px;
}
.image{
	text-align: center;
}
.at, .at1{
	display: inline;
	font-size: 20px;
}
.id{
	margin-top: 20px;
}
.inputTable{
	width: 40.5%;
}
#memberId{
	width:77%;
	height:45px;
	border-radius: 5px;
	font-size: 20px;
	border: 1px solid #ccc;
}
#id_Check{
	width:100px;
	height:50px;
	background-color: #00A9FF;
    color: white; 
    font-size: 17px; 
    border: none; 
    border-radius: 5px; 
    cursor: pointer; 
}
#inputName, #inputPwd, #chk_pwd, #inputNickname, #memberZip2, #memberZip3{
	width:530.3px;
	height:45px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 20px;
}
#inputEmail1, #inputEmail2{
	width:35.5%;
	height:45px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 20px;
}
#selectEmail2{
	width:17%;
	height:49.5px;
	font-size: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}
#inputBirth1, #inputBirth2{
	width:45.9%;
	height:45px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 20px;
}
#memberPhone1{
	width:130px;
	height:49.5px;
	font-size: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}
#inputPhone2, #inputPhone3{
	width:180px;
	height:45px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 20px;
}
#memberZip1{
	width:73.2%;
	height:45px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 20px;
}
.search{
	background-color: #00A9FF;
	padding:12.5px 10px 12.5px 10px;
    color: white; 
    font-size: 17px; 
    border: none; 
    border-radius: 5px; 
    cursor: pointer; 
}
#chk_zip{
	display:inline;
}
.checkboxClass{
	align:center;
	text-align: left;
	padding-top: 7px;
	padding-bottom: 7px;
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #ccc;
	border-radius: 5px; 
	width: 530px;
	font-size: 17px;
}
#selectAll, #age, #use, #collection, .chk{
	margin: 0px;
	margin-left: 10px;
	width: 15px;
	height: 15px;
}
#age, #use, #collection, .chk{ /* 전체선택체크박스 제외 체크박스 위치 맘에 안들면 얘 지우거나 건들면 됨 */
	margin-left: 40px;
}
#addMember123{
	margin-top: 20px;
	margin-bottom: 20px;
	width:536px;
	height:50px;
	background-color: #00A9FF;
    color: white; 
    font-size: 17px; 
    border: none; 
    border-radius: 5px; 
    cursor: pointer; 
}
#addMember123:hover, #id_Check:hover, .search:hover{
	background-color: #008ED6;
}
.imageCircle img {
    margin-top: 20px;
    width: 200px;
    height: 200px;
    border-radius: 50%; /* 동그라미 만들기 */
    object-fit: fill; /* 우겨 넣기 */
    /* object-fit: cover;  */ /* 자르기 */
    border: 1px solid #ccc;
}
.imageCircle img:hover {
	cursor: pointer;
	opacity: 0.3;
}
#mailCheckBtn{
	background-color: #00A9FF;
	border: 0px;
	border-radius: 5px; 
    cursor: pointer;
    color: white;
    text-size: 13px;
    width: 80px;
    height: 25px;
	float: right;
	margin-right: 10px;
}
.mailCheckBox{
	display:flex;
	flex-direction: column;
	margin: 5px 10px 0px 10px;
}
.mailCheckInput{
	height: 40px;
}
.checkBtn{
	height: 40px;
	background-color: #00A9FF;
	border: 0px;
	border-radius: 5px; 
    cursor: pointer;
    color: white;
    text-size: 13px;
}
#mailCheckBtn:hover, .checkBtn:hover{
	background-color: #008ED6;
}
#imageReload{
	background-color: transparent; /* 배경색 제거 */
	margin-top: 5px;
	height: 40px;
	border: 0px;
    cursor: pointer;
	font-size: 16px;
	color: rgba(0,0,0,0.5);
}
#imageReload:hover{
	color: rgba(0,0,0);
}
</style>
</head>
<body>
<div class="content">
<form action="/member/addMember.do" method="post" enctype="multipart/form-data" id="memberForm">
<c:if test="${resultMember != 'true'}">
	<h1 class="text_center" style="margin-bottom:2px;">회원 가입</h1>
	</c:if>
	<c:if test="${resultMember == 'true'}">
	<h1 class="text_center" style="margin-bottom:2px;">소셜 연동 가입</h1>
	</c:if>
		<!-- <div class="snsNav">
			<table style="width:100%">
				<tr>
					<td style="padding-top:30px;">SNS계정으로 간편하게 회원가입</td>
                </tr>
                <tr>
                    <td style="padding-top:15px">
                        <a href="/kakao/kakaoLogin.do">
                            <img src="/resources/image/Kakaotalk_icon.png">
                        </a>
                        <a href="/product/productSelect.do?productNO=1" style="display: inline-block; margin-right:15px;">
                            <img src="/resources/image/Naver_icon.png">
                        </a>
                        <a href="/product/productSelect.do?productNO=1" style="display: inline-block; margin-right:15px;">
                            <img src="/resources/image/Google_icon.png">
                        </a>
                    </td>
                </tr>
            </table>
        </div> -->
	<table class="inputTable" align="center">
		<tr>
			<td>
				<lable class="formLable"><p class="id">아이디<b id="id"></b></p>
				<input type="text" id="memberId" name="memberId" maxlength="16" onkeyup="deInputKo1(event)" placeholder="아이디를 입력해주세요."/>
				</lable>
				<input type="button" id="id_Check" value="중복체크" onclick="idCheck()"/>
				<p id="idMsg1"></p>
				<p id="idMsg2"></p>
			</td>
		</tr>
		<tr>
			<td>
				<lable class="formLable"><p class="name">이름<b id="name"></b></p>
				<input type="text" id="inputName" name="memberName" onkeyup="deInputKo(event)" placeholder="이름을 입력해주세요." maxlength="5"/>
				<p id="nameMsg1"></p>
				</lable>
			</td>
		</tr>
	    <tr>
			<td>
				<lable class="formLable"><p class="email">이메일<b id="email"></b>
					<!-- 메일 인증 -->
					<button type="button" id="mailCheckBtn" onclick="mailCheck()">본인인증</button>
				</p>
				<input type="text" id="inputEmail1" name="memberEmail1" onkeyup="deInputKo(event)" placeholder="123456"/><p class="at"> @</b>
				<input type="text" id="inputEmail2" name="memberEmail2" onkeyup="deInputKo(event)" placeholder="example.com"/>
				<select id="selectEmail2" onchange="choiceEmail(this.value)"> 
					<option class="email2Select" value="직접입력">직접입력</option>
					<option class="email2Select" value="gmail.com">gmail.com</option>
					<option class="email2Select" value="naver.com">naver.com</option>
					<option class="email2Select" value="daum.net">daum.net</option>
					<option class="email2Select" value="yahoo.com">yahoo.com</option>
				</select>
				</lable>
				<div class="mailCheckBox">
					<input class="mailCheckInput" placeholder="인증번호 6자리를 입력해주세요." disabled="disabled" maxlength="6">
					<input class="checkBtn" onclick="authNumberCheck()" type="button" value="확인" />
				</div>
				<p id="emailMsg1"></p>
				<p id="emailMsg2"></p>
			</td>
	    </tr>
	   	<tr>
			<td>
				<lable class="formLable"><p class="pwd">비밀번호<b id="pwd"></b></p>
				<input type="password" id="inputPwd" name="memberPw" maxlength="16" onkeyup="check_pwd()" placeholder="비밀번호를 입력해주세요."/>
				<p id="pwdLengthCheck"></p>
				</lable>
			</td>
	    </tr>
	   	<tr>
			<td>
				<lable class="formLable"><p class="pwd2">비밀번호확인<b id="pwd2"></b></p>
				<input type="password" id="chk_pwd" maxlength="16" onkeyup="check_pwd()" placeholder="비밀번호를 입력해주세요."/>
				<p id="pwd_chk1"></p>
				<p id="pwd_chk2"></p>
				</lable>
			</td>
	    </tr>
	   	<tr>
			<td>
				<lable class="formLable"><p class="birthday">주민등록번호<b id="birthDay"></b></p>
				<input type="text" id="inputBirth1" name="memberBirth1" maxlength='6' oninput="this.value = this.value.replace(/[^0-9]/g, '')" placeholder="123456"/>
				<p class="at">-</p>
				<input type="password" id="inputBirth2" name="memberBirth2" maxlength='7' oninput="this.value = this.value.replace(/[^0-9]/g, '')" placeholder="1234567"/>
				<p id="birthMsg"></p>
				</lable>
			</td>
	    </tr>
	    <tr>
			<td>
				<lable class="formLable"><p class="phone">핸드폰번호<b id="phone"></b></p>
				<select id="memberPhone1" name="memberPhone1"> 
					<option class="phone1Select" value="010">010</option>
					<option class="phone1Select" value="010">011</option>
					<option class="phone1Select" value="010">016</option>
				</select>
				<p class="at1">-</p>
				<input type="text" id="inputPhone2" name="memberPhone2" maxlength='4' oninput="this.value = this.value.replace(/[^0-9]/g, '')" />
				<p class="at1">-</p>	      
				<input type="text" id="inputPhone3" name="memberPhone3" maxlength='4' oninput="this.value = this.value.replace(/[^0-9]/g, '')" />
				<p id="phoneMsg"></p>
				</lable>
			</td>
	    </tr>
	    <tr>
			<td>
				<lable class="formLable"><p class="zip">주소<b id="zip"></b></p>
				<input type="text" id="memberZip1" name="memberZip1" readOnly onclick="touchZip()" placeholder="우편번호"/>
				<p id="chk_zip"><a class="search" href="javascript:execDaumPostcode()">우편번호검색</a></p>
				<p id="touch_zip"></p>
				<p><input type="text" id="memberZip2" name="memberZip2" readOnly onclick="touchZip()" placeholder="도로명 주소" /></p>	      
				<input type="text" id="memberZip3" name="memberZip3" placeholder="상세주소" />
				</lable>
			</td>
	    </tr>
	    <tr>
			<td>
				<lable class="formLable"><p class="image">프로필사진</p>
				 <div class="imageCircle">
				     <img id="memberProfileImage" src="/resources/image/mypage.png" onclick="profileImage(this)"/><br>
				     <input onchange="imageButtonClick(this)" id="imagesButton" name="memberIamge" type="file" style="display:none;" accept=".jpeg,.jpg,.png" />
				 </div>
				 <input type="button" id="imageReload" onclick="imageReloadEvn()" value="이미지 삭제"/>
				</lable>
			</td>
		</tr>
		<tr>
			<td>
				<lable class="formLable"><p class="nickname">닉네임<b id="nickName"></b></p>
				<input type="text" id="inputNickname" name="memberNickname" maxlength="10" onkeyup="nickNameCheck()" placeholder="닉네임을 입력해주세요." />
				</lable>
				<p id="nickMsg1"></p>
				<p id="nickMsg2"></p>
			</td>
	    </tr>
	    <tr>
			<td>
				<p class="c">약관동의</p>
				<div class="checkboxClass">
					<lable class="formLable">
					<p><input type="checkbox" id="selectAll" onclick="chk_all()" />
					<b>전체동의</b> (선택항목에 대한 동의 포함)</p></lable>
					<lable>
					<p><input type="checkbox" id="age" class="chk" value="age" onclick="chk()" />
					만 14세 이상입니다(필수)<b id="age1"></b></p></lable>
					<lable>
					<p><input type="checkbox" id="use" class="chk" value="use" onclick="chk()" />
					이용약관(필수)<b id="use1"></b></p></lable>
					<lable>
					<p><input type="checkbox" id="collection" class="chk" value="collection" onclick="chk()" />
					개인정보수집 및 이용동의(필수)<b id="collection1"></b></p></lable>
					<lable>
					<p><input type="checkbox" class="chk" name="memberEmailReceotion" value="Y" onclick="chk()" />
					이메일 수신(선택)</p></lable>
					<lable>
					<p><input type="checkbox" class="chk" name="memberSmsReceotion" value="Y" onclick="chk()" />
					이벤트, 특가 알림 및 SMS등 수신(선택)</p></lable>
				</div>
			</td>
	    </tr>
	</table>
<button type="submit" id="addMember123">회원가입</button>
</form>
<script>

function imageReloadEvn(){
	$('#imagesButton').val('');
	$('#memberProfileImage').attr("src",'/resources/image/mypage.png');
}

// 이메일 인증
function mailCheck() {
    const email1 = $('#inputEmail1').val();
    const email2 = $('#inputEmail2').val();
    const email = email1 + '@' + email2; // 이메일 수정

    // 이메일 유효성 검사
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    
    if (emailRegex.test(email)) {
        $.ajax({
            type: 'POST',
            url: '/mail/mailCheck.do',
            data: {"memberEmail1": email1, "memberEmail2":email2 },
            dataType: 'json',
            success: function (data) {
            	var useEmailCount = data.useEmailCount;
            	if(useEmailCount == 0){
            		/* 중복된 이메일 없음 */
            		alert('인증번호가 전송되었습니다.');
            		document.getElementsByClassName('mailCheckInput')[0].disabled = false;
            		$('.mailCheckBox').show();
            	} else{
            		/* 중복된 이메일이 있음 */
            		alert('중복된 이메일 입니다.');
            		emailAuth = false;
            	}
            },
            error: function (error) {
            }
        });
    } else {
        alert("올바른 이메일을 입력해 주세요.");
    }
}

$(function(){
	$('.mailCheckBox').hide();	
});

// 인증번호 비교하러 서버로
function authNumberCheck() {
    const email1 = $('#inputEmail1').val();
    const email2 = $('#inputEmail2').val();
    const email = email1 + '@' + email2;
    const authNumber = $('.mailCheckInput').val(); // 인증번호 입력값 가져오기

    $.ajax({
        type: 'POST',
        url: '/mail/authNumberCheck.do',
        data: { email: email, authNumber: authNumber }, // 이메일 및 입력한 인증번호 전송
        
        success: function (data) {
        	
            $(".mailCheckInput").attr('disabled', true);
            $(".checkBtn").attr("disabled", true);
            $("#inputEmail1").attr("readOnly", true);
            $("#inputEmail2").attr("readOnly", true);
            $("#selectEmail2").attr("disabled", true);
            $('.mailCheckBox').hide();
            $('#mailCheckBtn').hide();
            
            alert('인증이 완료되었습니다.');
            
            emailAuth = true;
        },
        error: function (error) {
            alert('잘못된 인증번호 입니다.');
        }
    });
}

</script>
</div>
</body>
</html>