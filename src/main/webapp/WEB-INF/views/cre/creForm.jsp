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
<title>취소/반품/교환 신청 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

</script>
<style>
body{
font-family: Arial, sans-serif;
}
.creContainer{
	margin: auto;
	width: 800px;
}
.prod{
	display: flex;
	justify-content: space-between;
	flex-direction: row;
	align-items : center;
	margin-left: 20px;
	margin-right: 20px;
	padding: 20px;
    border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
#fileInput{
	display: none;
}
#cre-select{
	margin: 20px;
	width: 65%;
	padding: 10px;
	border: 1px solid #e4e4e4;
	border-radius: 8px;
	background-color: white;
	font-size: 14px;
	cursor: pointer;
	text-align: center; 
}
.creItems p b{	
	font-size: 20px;
}
.crePrice b p{
	margin: 5px;
	font-size: 20px;
}
.reasonItem textarea{
	resize : none; /* textarea 크기조정 막기 */
	width: 513px;
	height: 170px;
}
.addImageBtn{
	background-color: #00A9FF;
    color: white; 
    font-size: 18px;
    padding:5px 10px
    border: none; 
    border-radius: 5px; 
    cursor: pointer;
    padding: 2px 10px 2px 10px;
}
.deleteImageBtn{
	background-color: #f0f0f0;
    font-size: 18px;
    padding:5px 10px
    border: none; 
    border-radius: 5px; 
    cursor: pointer;
    padding: 2px 10px 2px 10px;
}

.deleteImageBtn:hover{
	background-color: #e4e4e4;
}
.deleteBtnDiv{
	text-align: right;
	align-self: right;
	
}
#preview_uploadFiles{
    border: 1px solid #e4e4e4;
	min-height: 150px;
	height: auto;
}
#uploadFiles{
	display: flex;
    flex-wrap: nowrap; /* 이미지들이 한 줄로 나열되도록 설정 */
    overflow-x: auto; /* 가로 스크롤 추가 */
    padding: 10px 0;
    width: 100%; /* 컨테이너의 가로 크기 설정 */
    gap: 10px; /* 이미지 간 간격 */
}
/* 미리보기 감싼 부모 - 자식 : 이미지, 파일명, X버튼 */
#uploadFiles div{ 
	width: 150px; /* 이미지 크기 고정 */
    display: flex;
    flex-direction: column;
    align-items: center;
}
/* 미리보기 - 파일명 */
.previewFileName{
	width: 150px; /* 고정 너비 */
    white-space: nowrap; /* 텍스트가 한 줄로 유지되도록 */
    overflow: hidden; /* 넘치는 텍스트는 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트는 '...'으로 표시 */
    text-align: center; /* 텍스트 가운데 정렬 */
    font-size: 12px; /* 텍스트 크기 조정 */
}
/* 미리보기 - 이미지 */
.previewImage{
	width: 150px;
	height: 150px;
	object-fit: cover; /* 이미지 비율 맞추기 */
}
.fileCounter{
	align: right;
}
.upload{
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 20px 0 5px 0;
	width: 100%;
	height: 30px;
	text-align: left;
}
.addCreBtn{
	background-color: #00A9FF;
    color: white; 
    font-size: 20px;
    font-weight: bold;
    border: none; 
    border-radius: 6px; 
    cursor: pointer;
    width: 25%;
    height: 50px;
    margin-top: 10px;
}
.addCreBtn:hover, .addImageBtn:hover{
	background-color: #008ED6;
}
</style>
</head>
<body>
<div class="creContainer">
<form action="/cre/addCre.do" method="post" enctype="multipart/form-data">
<div class="prod">
	<input type="hidden" name="memberId" value="${deliveryList.memberId }" />
	<input type="hidden" name="orderNo" value="${deliveryList.orderNO }" />
	<input type="hidden" name="productNo" value="${deliveryList.productNO }" />
	<div class="creIamge">
		<img src="/product/productThumbnail.do?articleNO=${deliveryList.productNO }&image=${deliveryList.imageFilename }" width="150px">
	</div>
	<div class="creItems">
		<p><b>${deliveryList.productName }</b></p>
		<p>${deliveryList.orderProductOptions }</p>
	</div>
	<div class="crePrice">
		<b><p>${deliveryList.orderQty }개</p><p><fmt:formatNumber value="${deliveryList.orderAmount }" pattern="#,#00" />원</p></b>
	</div>
</div>
<div>
<select name="creType" id="cre-select">
	<c:if test="${creStatement == '취소'}">
		<option class="creOptions" value="${creStatement }">${creStatement }</option>
	</c:if>
	<c:if test="${creStatement == '반품/교환신청'}">
		<option class="creOptions" value="반품">반품</option>
		<option class="creOptions" value="교환">교환</option>		
	</c:if>
</select>
</div>
<div class="reasonItem">
	<textarea name="creReason" placeholder="사유를 적어주세요."></textarea>
</div>
<script>
var fileArr = new Array(); // 파일 저장하기 위한 배열
var maxFileUpload = 10; // 최대 올릴 수 있는 파일 수

function addImage(){
	$('#fileInput').click(); // input 호출
}

function fileInput1(files) {

	var count = 0;
	let arr = Array.from(files); // Array.from() -> 파일 객체 배열을 배열로 바꿔줌 / 일반적인 파일 객체 배열은 추가변경이 안된다 함
	
	for(var i = 0; i < files.length; i++){ // 확장자 검사
	var lastDot = files[i].name.lastIndexOf('.');
    var fileLen = files[i].name.length;
    var fileName = files[i].name;
    var fileDotName = files[i].name.substring(lastDot, fileLen).toLowerCase();
    var useFileDotName = [".gif", ".jpg", ".png", ".jpeg"];
    var exists = useFileDotName.some(item => item == fileDotName);
	    if(!exists){
			alert(fileName + '은 올릴 수 없습니다. .gif, .jpg, .png, .jpeg 확장자만 가능합니다.');
			arr = arr.filter(item => item.name !== fileName); // 적용시킨 확장자 외 파일이 올라올 시 걸러서 저장
			continue;
		}
	}
	
	// 미리보기 넣을 곳
	const fileList = document.getElementById('uploadFiles');
	
    if(fileArr.length > maxFileUpload){
    	alert("최대 " + maxFileUpload + "개의 이미지만 업로드할 수 있습니다.");
    } else{
	    for(let i=0; i<arr.length; i++) { // let 써야함 let - 스코프 내 고정
	    	if(fileArr.length >= maxFileUpload){ 
	    		fileArr.splice(maxFileUpload); // splice로 maxFileUpload에 대입한 숫자만큼 뒤에 내용을 자름
	    		alert("최대 " + maxFileUpload + "개의 이미지만 업로드할 수 있습니다.");
	    		break;
	    	} else{
	    		console.log("else");
				fileArr.push(arr[i]); // 실질적으로 저장되는 파일들
				const item = document.createElement('div');
				const item1 = document.createElement('p');
				item1.setAttribute('class', 'previewFileName');
				const fileName = document.createTextNode(arr[i].name);
				const previewImage = document.createElement('img');
				previewImage.setAttribute('class', 'previewImage');
				previewImage.setAttribute('src', '#');
				const deleteButton = document.createElement('button');
				deleteButton.addEventListener('click', (event) => { // 버튼에 클릭시 어떤 이벤트 발생시킬지 저장
					item.remove();
					event.preventDefault();
					deleteFile(arr[i]);
				});
				deleteButton.innerText="X";
				item.appendChild(previewImage);
				item.appendChild(item1);
				item1.appendChild(fileName);
				item.appendChild(deleteButton);
				fileList.appendChild(item);
	    	}
		}
    }
      
	var inputFile = document.querySelector('input[name="imageFile"]');
	var dataTransfer = new DataTransfer(); // 일반 배열을 파일 객체 배열로 바꿔주는 애
	fileArr.forEach(file => {
		dataTransfer.items.add(file);
		displayImages(file, count);
		count++;
	})
	
	inputFile.files = dataTransfer.files; // 일반배열 -> 파일객체 배열로 바꾼애를 input type=file 태그에 넣음
	$(".nowFileCount").text(document.getElementById('fileInput').files.length); // 현재 업로드된 파일 수
}

// 미리보기 기능에서 onload가 비동기처리라 이미지 출력이 섞일때가 있다고 함.
// ex) 첫번쨰 이미지 읽을 동안 두번째 이미지도 읽기 시작 -> 두번째가 먼저 로딩되면 src에 먼저 넣어버리기떄문에 이미지 순서가 섞임
// 해결방법으론 async/await + Promise 로 첫번쨰 로딩되면 두번째 로딩 방식으로 돌아간다함.
// 근데 reader를 따로 빼서 돌렸을 떄 문제가 없어서 안바꿈
// 만약 돌리다가 문제있으면 얘기 좀 부탁
function displayImages(file, imgClassIndex) {
	const reader = new FileReader();
    reader.onload = function(e) {
        const img = document.getElementsByClassName('previewImage')[imgClassIndex]; // 해당 인덱스의 이미지 선택
        img.src = e.target.result; // 파일의 미리보기 src로 설정
    };
    reader.readAsDataURL(file); // 파일을 DataURL로 읽기
}

function deleteFile(deleteFiles) {
    var inputFile = document.querySelector('input[name="imageFile"]');
    var dataTransfer = new DataTransfer();
    fileArr = fileArr.filter(file => file !== deleteFiles);
    fileArr.forEach(file => {
        dataTransfer.items.add(file);
    })
    inputFile.files = dataTransfer.files;
    $(".nowFileCount").text(document.getElementById('fileInput').files.length); // 현재 업로드된 파일 수
}

$(document).ready(function(){
	if(${creStatement != '취소'}){
		$(".nowFileCount").text(document.getElementById('fileInput').files.length); // 현재 업로드된 파일 수
		$(".maxFileCount").text(maxFileUpload); // 최대 업로드 가능 파일 수
	}
});

// 전체삭제
function deleteImage(){
	fileArr=[];
	$('#fileInput').val('');
	fileInput1(fileArr);
	$('#uploadFiles').empty();
}
</script>
<c:if test="${creStatement != '취소'}">
<div class="upload">
	<div>
		<p onclick="addImage()" class="addImageBtn" style="display:inline;">사진 추가</p>
	</div>
	<div class="fileCounter">
			<b>
				<p class="nowFileCount" style="display:inline;"></p>
				<p style="display:inline;">/</p>
				<p class="maxFileCount" style="display:inline;"></p>
			</b>
			<p onclick="deleteImage()" class="deleteImageBtn" style="display:inline;">전체삭제</p>
	</div>
</div>
<div id="preview_uploadFiles">
	<div id="uploadFiles">
	</div>
</div>
</c:if>
	<input type="file" class="inputFile" name="imageFile" id="fileInput" onchange="fileInput1(this.files)" multiple accept=".gif,.jpg,.png,.jpeg"/>
	<button class="addCreBtn" onclick="addCRE()">작성완료</button>
</form>
</div>
</body>
</html>