<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%
   request.setCharacterEncoding("UTF-8");
%>    
<html>
  <head>
    <meta charset="UTF-8">
    <title>글 쓰기 창</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.9.0/lang/summernote-ko-KR.min.js"></script>
    
    
    <script>
 // 서머노트 파일 업로드 수정!!!!!
    function uploadSummernoteImageFile(file, el) {

	 var writer = 'writer';
	 
        let data = new FormData();
        
        data.append("file", file);
        data.append("writer", writer);
        
        $.ajax({
            data : data,
            type : "POST",
            url : "/board/board_myhome/uploadSummernoteImageFile.do",
            contentType : false,
            enctype : 'multipart/form-data',
            processData : false,
            success : function(data) {
                if(data.responseCode == "success") {
                    setTimeout(function () {
                    	                          // 톰켓 서버.xml에 로컬 경로 설정한 변수명 + 파일명 = 로컬 주소
                        $(el).summernote('insertImage', "/board_myhome" + data.fileName, function ($image) {
                            $image.css('width', "20%");
                        });
                    }, 0);
                }else if(data.responseCode == "extension"){
                	alert("gif,jpg,png만 가능합니다.");
                    return false;
                }else{
                	alert("파일 업로드에 실패 하였습니다.");
                    return false;
                }
            }
        });
    }
 
 // 썸머노트 이미지 삭제 함수 수정!!!!
    function deleteFile(fileName) {
    	var writer = 'writer';
    	
  	    $.ajax({
  	        url: "/board/board_myhome/deleteSummernoteImageFile.do",  // 서버에 요청을 보낼 URL
  	        type: "POST",
  	        data: { file: fileName,
  	        	  writer: writer},
  	        success: function(response) {
  	            let data = JSON.parse(data);  // 서버에서 받은 JSON 응답 처리
  	            if (data.responseCode === "success") {
  	                alert("이미지가 삭제되었습니다.");
  	                // 본문에서 이미지 삭제
  	                $("img[src$='" + fileName + "']").remove();
  	            } else {
  	                alert("이미지 삭제에 실패하였습니다.");
  	            }
  	        }
  	    });
  	}

    // 글 저장
    function boardWrite() {
    	
        if ($("#title").val() == "") {
            alert("제목을 입력하세요");
            return false;
        }

        if ($('#summernote').summernote('isEmpty')) {
            alert("내용을 입력하세요");
            return false;
        }

        var previewContainer = document.getElementById("previewContainer");
        if (previewContainer.innerHTML.trim() === "") {
            alert("커버 이미지를 업로드해주세요.");
            return false;
        }
        
        if ($("#housingType").val() == "") {
            alert("주거형태를 선택하세요");
            return false;
        }
        
        if ($("#homeSize").val() == "") {
            alert("평수를 선택하세요");
            return false;
        }

        // FormData 객체 생성
        var formData = new FormData($("#articleForm")[0]);
        
        // 상품검색 데이터 추가 - 제이슨 타입을 문자열로 바꿔서
        formData.append("selectedProducts", JSON.stringify(selectedProducts));

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            url: "/board/board_myhome/insertBoard.do",
            data: formData,
            dataType: "text", // 변경
            success: function(response) {
                    if (response === "success") {
                        alert("게시글이 성공적으로 작성되었습니다.");
                        // 게시글 목록으로 리다이렉트
                        window.location.href = "/board/board_myhome/myHomeList.do";
                    } else {
                        alert("게시글 작성 중 오류가 발생하였습니다.");
                    }
            }
        });
    }
    </script>
    
    <style>

    body {
    display: flex;
    justify-content: center;
    align-items: flex-start; /* 위쪽이 잘리지 않게 조정  */
    height: 100vh;
    margin: 0;
    background-color: white;
	}
	
	.container {
	    display: flex;
	    flex-direction: column; 
	    align-items: center; 
	    width: 90%;
	    max-width: 1200px;
	    padding: 20px;
	    background-color: white;
	    border-radius: 10px;
	    gap: 20px; /* 위아래 간격 추가 */
	    margin-left:auto;
	    margin-right:auto;
	}
	
	.filtering {
	    display: flex;
	    flex-direction: column; 
	    margin: 10px auto;
	    gap: 10px; 
	    padding: 20px;
	    border: 1px solid #dcdcdc;
	    border-radius: 5px;
	    width: 300px; 
	    text-align: center;
	    margin-bottom: 30px;
	}
	
	.filtering select {
	    width: 100%; /* 셀렉트 박스를 부모 크기만큼 확장 */
	    padding: 8px;
	    border-radius: 5px;
	    border: 1px solid #ccc;
	    text-align: center;
	}
	select option:first-child {
    color: gray;
    
	}
	
	.main {
	    width: 100%;
	    max-width: 800px;
	    padding: 20px;
	    background-color: white;
	    border-radius: 10px;
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
	
	.drag-drop-area {
    width: 80%;
    max-width: 800px;
    height: 200px;
    border: 2px dashed #ccc;
    background-color: #f8f8f8;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    font-size: 18px;
    color: #666;
    margin: 20px 0;
    border-radius: 10px;
	}

	.drag-drop-area.dragover {
	    background-color: #e0e0e0;
	    border-color: #aaa;
	}
	
	.preview-container {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 10px;
	    margin-top: 10px;
	}
	
	#previewContainer img {
	    max-width: 100%; /* 드롭 영역을 넘지 않도록 */
	    max-height: 300px; /* 세로 최대 크기 제한 */
	    width: auto; /* 원본 비율 유지 */
	    height: auto; /* 원본 비율 유지 */
	    display: block;
	    margin: 10px auto; /* 가운데 정렬 */
	    border-radius: 10px; /* 둥근 테두리 추가 */
	}
    
    /* 제목 */
    #title { 
        width: 100%; 
        height: 70px; 
        padding: 10px; 
        border: none; 
        border-radius: 5px; 
        box-sizing: border-box; 
        font-size: 16px; 
        text-align: center; 
    }
     #title:focus {
       outline: 1px solid #dcdcdc; /* 포커스 시 아웃라인 색상 변경*/
    }
    
     #writeBtn {
     background-color:  #00A9FF; 
     color: white; 
     font-weight: bold; 
     font-size: 15px; 
     padding: 10px 20px; /* 버튼의 안쪽 여백 */
     margin: 15px;
     border: none; 
     border-radius: 5px; 
     cursor: pointer; 
    }
    #writeBtn:hover {
	background-color: #008ED6;
	}
    
    /* 모달창  */
	.modal {
	    display: none;
	    position: fixed;
	    top: 20%;
	    left: 50%;
	    transform: translateX(-50%);
	    width: 400px;
	    background: white;
	    border: 1px solid #ccc;
	    padding: 20px;
	    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
	    border-radius: 10px;
	    z-index: 9999;
	}

	.modal-header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 10px;
	}

	.modal-close {
	    border: none;
	    color: black;
	    background: white;
	    font-size: 20px;
	    cursor: pointer;
	}
	
	.modal-body {
	    display: flex;
	    flex-direction: column;
	    gap: 10px;
	}
	
	.search-input {
	    width: 95%;
	    padding: 8px;
	    border: 1px solid #ddd;
	    border-radius: 4px;
	    margin-top: 15px;
	    margin-bottom: 20px;
	}

	.search-results {
	    margin-top: 10px;
	    max-height: 200px;
	    overflow-y: auto; /* 스크롤 자동생성 */
	    border-top: 1px solid #eee;
	}
	
	.prodHeader {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  position: relative;
	  margin-top:30px;
	  margin-bottom: 15px;
	}
	
	
	#prodSearchBtn {
    background-color: #00A9FF ;
    color: white;
    font-weight: bold;
    padding: 8px 10px;
    border-radius: 6px;
    border: none;
    cursor: pointer;
    transition: background-color 0.2s;
    position: absolute;
  	left: 0;
	}
	
	#prodSearchBtn:hover {
	background-color: #008ED6 ;
	}
	
	#modalprodSearchBtn {
	  padding: 8px 16px;
	  background-color: #f0f0f0; /* 연회색 */
	  color: #333;
	  font-weight: bold;
	  border: 1px solid #ddd;
	  border-radius: 6px;
	  cursor: pointer;
	  transition: all 0.15s ease-in-out;
	  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
	}
	
	#modalprodSearchBtn:hover {
	  background-color: #e4e4e4; 
	  transform: scale(1.01); 
	}



    
    
</style>
    
  </head>
  
  <body>
   <div class="container">
      
      <!-- 커버사진 및 썸네일 이미지 -->
      <div class="drag-drop-area" id="dropZone">
   		 커버 사진을 이곳에 드래그하세요.
		</div>
	<div class="preview-container" id="previewContainer"></div>
	
	
      <!-- 글 작성 -->
    <div class="main">
    	<form id="articleForm">
    	
	    	<!-- 필터링 영역 (주거형태 선택) -->
	     	 <div class="filtering">
	        	주거형태    <select name="housingType" id="housingType">
	          <option value="" selected hidden>--- 주거형태를 선택하세요 ---</option>
	          <option value="원룸">원룸</option>
	          <option value="아파트">아파트</option>
	          <option value="단독주택">단독주택</option>
	          <option value="사무공간">사무공간</option>
	          <option value="상업공간">상업공간</option>
	        </select>
	          	평수    <select name="homeSize" id="homeSize">
	          <option value="" selected hidden>--- 평수를 선택하세요 ---</option>	
	          <option value="9평 미만">9평 미만</option>
	          <option value="10평대">10평대</option>
	          <option value="20평대">20평대</option>
	          <option value="30평대">30평대</option>
	          <option value="40평 이상">40평 이상</option>
	        </select>
	      </div>	
    	
        	<div class="form-group">
            	<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요." maxlength="30" required>
            </div>
            <div class="form-group">
            	<textarea class="form-control" name="content" id="summernote"></textarea>
            </div>          	
            				
				<!-- 모달창 -->
				<div id="prodSearchModal" class="modal">
				    <div class="modal-header">
				        <strong>🛒 제품 검색</strong>
				        <button type="button" onclick="closeProdSearch()" class="modal-close">&times;</button>
				    </div>
				
				    <div class="modal-body">
				        <input type="text" id="searchKeyword" placeholder="상품명을 입력하세요" class="search-input">
				        <button type="button" id="modalprodSearchBtn" onclick="searchProduct()"> 검색🔍</button>
				        <div id="productResults" class="search-results"></div>
				    </div>
				</div>
				
				<div class="prodHeader">
					<!-- 상품 검색 버튼 -->
					<button type="button" id="prodSearchBtn" onclick="openProdSearch()">제품 검색</button>
	            	<!-- 미리보기 -->
	            	<h3>우리집에 사용된 제품</h3>
	            </div>
	            <div id="prodPreview" class="prodPreview"></div>
            	

            	<button type="button" id="writeBtn" onclick="boardWrite()">작성 완료</button>
         </form>
    </div>
</div>


<script>
// 상품검색 모달창

document.getElementById("searchKeyword").addEventListener("keydown", function(event) {
    if (event.key === "Enter") {
        event.preventDefault(); // 기본 동작 방지
        searchProduct(); // 검색 함수 실행
    }
});


function openProdSearch() {
  document.getElementById('prodSearchModal').style.display = 'block';
}

function closeProdSearch() {
  document.getElementById('prodSearchModal').style.display = 'none';
}

function searchProduct(){
	const keyword = document.getElementById('searchKeyword').value;
	
	 $.ajax({
	      type: "GET", 
	        url: "/product/productSearch.do", 
	        data: {keyword: keyword},
	        dataType: "json",   
	        success: function(response) {  	
	            const resultDiv = document.getElementById("productResults");
	            resultDiv.innerHTML = "";
	            
	            if (response.products && response.products.length > 0) {
	                const products = response.products;
	                
	                for (let i = 0; i < products.length; i++) {
	                    const product = products[i];

	                    const div = document.createElement("div");
	                    div.className = "prodList";
	                    div.style.cursor = "pointer";
	                    
	                    const img = document.createElement("img");
	                    img.className = "prodImage";
	                    img.src = "/product/productThumbnail.do?articleNO=" + product.productNO + "&image=" + encodeURIComponent(product.imageFileName);
	                    img.alt = product.productName;
	                    img.width = 60;

	                    const nameP = document.createElement("p");
	                    nameP.className = "prod";
	                    nameP.style.marginTop = "5px";
	                    nameP.innerHTML = "<font size=3>" + product.productName + "</font>";

	                    div.appendChild(img);
	                    div.appendChild(nameP);

	                    div.onclick = function () {
	                        prodPreView(product);
	                        closeProdSearch();
	                    };

	                    resultDiv.appendChild(div);
	                }
	            } else {
	                resultDiv.innerText = "검색 결과가 없습니다.";
	            }
	        },

	        error: function(xhr, status, error) {
	            console.log("오류 발생:", error);
	            alert("서버와 통신 중 문제가 생겼습니다.");
	        }
	    });
	}

//선택된 상품 미리보기
let selectedProducts = []; 

function prodPreView(product) {
    const previewArea = document.getElementById("prodPreview");
    
    // 중복선택 방지
    for (let i = 0; i < selectedProducts.length; i++) {
        if (selectedProducts[i].productNO === product.productNO) {
            alert("이미 선택한 상품입니다!");
            return;
        }
    }
    
        selectedProducts.push(product);
        
        // 기존 "선택한 상품이 없습니다." 메시지가 있다면 지움
        const existingMsg = document.getElementById("noProdMsg");
        if (existingMsg) {
            previewArea.removeChild(existingMsg);
        }

    
    
        const container = document.createElement("div");
        container.style.display = "flex";
        container.style.alignItems = "center";
        container.style.gap = "10px";
        container.style.marginTop = "10px";

        // 썸네일 이미지
        const img = document.createElement("img");
        img.src =  "/product/productThumbnail.do?articleNO=" + product.productNO + "&image=" + encodeURIComponent(product.imageFileName);
        img.alt = product.productName;
        img.width = 60;

        // 상품 이름
        const name = document.createElement("span");
        name.innerText = product.productName;
        
        // 삭제 버튼
        const delBtn = document.createElement("button");
        delBtn.innerText = "X";
        delBtn.style.marginLeft = "auto";
        delBtn.style.background = "none";
        delBtn.style.border = "none";
        delBtn.style.color = "#4D4D4D";
        delBtn.style.cursor = "pointer";
        delBtn.onclick = function(){
        	  selectedProducts = selectedProducts.filter(p => p.productNO !== product.productNO);
        	  previewArea.removeChild(container);
        	  
        	  // 상품 다 지워졌으면 메시지 다시 보여주기
              if (selectedProducts.length === 0) {
                  const noProd = document.createElement("p");
                  noProd.id = "noProdMsg"; // 메시지 id 부여!
                  noProd.innerText = "선택한 상품이 없습니다.";
                  previewArea.appendChild(noProd);
              }      	     
        };
        container.appendChild(img);
        container.appendChild(name);
        container.appendChild(delBtn);
        previewArea.appendChild(container);  
}

document.addEventListener("DOMContentLoaded", function () {
    const previewArea = document.getElementById("prodPreview");
    const noProd = document.createElement("p");
    noProd.id = "noProdMsg";
    noProd.innerText = "선택한 상품이 없습니다.";
    previewArea.appendChild(noProd);
});

	
</script>

 
 <script>
    $("#summernote").summernote({
        // 에디터 높이
        height: 600,
        placeholder:"여기에 내용을 입력하세요.",
        // 에디터 한글 설정
        lang: "ko-KR",
        // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
        focus : true,
        toolbar: [
        	// 스타일 설정
        	['style', ['style']],
            // 글꼴 설정
            ['fontname', ['fontname']],
            // 글자 크기 설정
            ['fontsize', ['fontsize']],
            // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
            ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
            // 글자색
            ['color', ['forecolor','color']],
            // 표만들기
            ['table', ['table']],
            // 글머리 기호, 번호매기기, 문단정렬
            ['para', ['ul', 'ol', 'paragraph']],
            // 줄간격
            ['height', ['height']],
            // 그림첨부, 링크만들기, 동영상첨부
            ['insert',['picture','link','video']],
            // 코드보기, 확대해서보기, 도움말
            ['view', ['codeview','fullscreen', 'help']]
        ],
        callbacks : {
            onImageUpload : function(files, editor, welEditable) { // 파일 업로드(다중업로드를 위해 반복문 사용)
                for (var i = files.length - 1; i >= 0; i--) {
                    uploadSummernoteImageFile(files[i], this);
                }
            },
            onMediaDelete: function($target) {
                if (confirm("이미지를 삭제하시겠습니까?")) {
                    let fileName = $target.attr('src').split('/').pop();
                    deleteFile(fileName);
                }
            },
        },
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'], // 추가한 글꼴
        // 추가한 폰트사이즈
        fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
    });
</script>

<script>
// 드래그앤 드롭 API

document.addEventListener("DOMContentLoaded", function () {
    var dropZone = document.getElementById("dropZone");
    var previewContainer = document.getElementById("previewContainer");

    dropZone.addEventListener("dragover", function (event) { // 드래그 중일때 이벤트
        event.preventDefault(); // 기본동작 방지
        dropZone.classList.add("dragover");
    });

    dropZone.addEventListener("dragleave", function () { // dragzone 벗어났을 때 이벤트
        dropZone.classList.remove("dragover");
    });

    dropZone.addEventListener("drop", function (event) { // drop이벤트
        event.preventDefault();
        dropZone.classList.remove("dragover");

        var files = event.dataTransfer.files;
        handleFile(files[0]); // 파일 하나만 업로드 가능하도록 제한
        
        // 파일을 FormData에 추가하여 서버로 전송
        var formData = new FormData();
        formData.append("coverImage", files[0]); // 드래그 앤 드롭된 파일
        
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            url: "/board/board_myhome/coverImageUpload.do",  // 파일 업로드를 처리할 URL
            data: formData,
            success: function(response) {
                console.log(response); 
                if (response === "success") {
                    alert("파일이 성공적으로 업로드되었습니다.");
                } else {
                    alert("파일 업로드 중 오류가 발생했습니다.");
                }
            }
        });
    });

    function handleFile(file) {
        if (!file.type.startsWith("image/")) { // 파일의 MIME타입이 image인지 확인
            alert("이미지 파일만 업로드 가능합니다!");
            return;
        }

        previewContainer.innerHTML = "";  // 기존 미리보기 삭제

        var reader = new FileReader(); //FileReader:파일 읽는 API
        reader.onload = function (e) {
            var img = document.createElement("img");
            img.src = e.target.result; // 읽어온 파일의 url
            previewContainer.appendChild(img); // 미리보기에 이미지 삽입
        };
        reader.readAsDataURL(file);
    }
});

</script>


  </body>
</html>