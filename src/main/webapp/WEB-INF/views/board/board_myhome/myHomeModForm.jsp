<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시글 수정페이지</title>

<!-- 썸머노트 CSS와 JS 파일 추가 -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.9.0/lang/summernote-ko-KR.min.js"></script>
    
<style>
 /* 폼 컨테이너 스타일 */
  .form-container {
    background-color: #fff;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-top: 50px;
    max-width: 50%;
    margin-left: auto;
    margin-right: auto;
  }

  label {
    font-size: 1.1rem;
    display: block;
    margin: 15px 0 5px;
    font-weight: bold;
  }

  input[type="text"], textarea {
    width: 100%;
    padding: 12px;
    border-radius: 6px;
    border: 1px solid #ccc;
    font-size: 1rem;
    box-sizing: border-box;
  }

  textarea {
    min-height: 300px;
    max-width: 50%;
  }
  
/* 드래그 앤 드롭 영역 */
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
	    margin: 20px auto;
	    border-radius: 10px;
	    position: relative;
	    background-size: cover;  
	    background-position: center; 
	    background-repeat: no-repeat; /* 반복 없음 */
	}
	.drag-drop-area::before {
	    content: "수정할 커버 사진을 이곳에 드래그하세요.";
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    font-size: 18px;
	    color: white;
	    font-weight: bold;
	    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
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
	
	 button {
     background-color:  #00A9FF; 
     color: white; 
     font-weight: bold; 
     font-size: 15px; 
     padding: 10px 20px; /* 버튼의 안쪽 여백 */
     margin: 15px;
     border: none; 
     border-radius: 5px; 
     cursor: pointer; /* 커서가 버튼 위에 있을 때 손 모양 */
    }
    
    button:hover {
    background-color:  #008ED6; 
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
	    overflow-y: auto; /* 스크롤 자동생성  */
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
	background-color: #008ED6;
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
	  background-color: #e4e4e4; /* 아주 살짝 진해짐 */
	  transform: scale(1.01); 
	}
  
  
</style>

<script>

  // 썸머노트 이미지 업로드 함수
  function uploadSummernoteImageFile(file, el) {
	
	var boardMyhomeArticleNo = ${selectMyHome.boardMyhomeArticleNo};
	  
    let data = new FormData();
    data.append("file", file);
    data.append("boardMyhomeArticleNo", boardMyhomeArticleNo);
    
    $.ajax({
      data: data,
      type: "POST",
      url: "/board/board_myhome/uploadSummernoteImageFile.do",
      contentType: false,
      enctype: 'multipart/form-data',
      processData: false,
      success: function(data) {
        if(data.responseCode == "success") {
        	
          setTimeout(function () {
            $(el).summernote('insertImage', "/board_myhome" + data.fileName, function ($image) {
              $image.css('width', "20%");
            });
          }, 0);
          
        } else if(data.responseCode == "extension") {
          alert("gif, jpg, png만 가능합니다.");
          
        } else {
          alert("파일 업로드에 실패 하였습니다.");
        }
      }
    });
  }
  
  // 썸머노트 이미지 삭제 함수 
  function deleteFile(fileName) {
	    $.ajax({
	        url: "/board/board_myhome/deleteSummernoteImageFile.do",  // 서버에 요청을 보낼 URL
	        type: "POST",
	        data: { file: fileName,
	        		boardMyhomeArticleNo:${selectMyHome.boardMyhomeArticleNo}
	        	 },
	        success: function(response) {
	            let data = JSON.parse(response);  // 서버에서 받은 JSON 응답 처리
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

  // 글 저장 함수
  function boardWrite() {
    if ($("#title").val() == "") {
      alert("제목을 입력하세요");
      return false;
    }

    if ($('#summernote').summernote('isEmpty')) {
      alert("내용을 입력하세요");
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

    var formData = new FormData($("#modForm")[0]);
    
 	// 상품검색 데이터 추가 
    formData.append("selectedProducts", JSON.stringify(selectedProducts));
    
    $.ajax({
      type: "POST",
      enctype: 'multipart/form-data',
      processData: false,
      contentType: false,
      url: "/board/board_myhome/myHomeMod.do",
      data: formData,
      dataType: "text",
      success: function(response) {
        if (response === "success") {
          alert("게시글이 성공적으로 수정되었습니다.");
          window.location.href = "/board/board_myhome/myHomeSelect.do?boardMyhomeArticleNo="+${selectMyHome.boardMyhomeArticleNo};
        } else {
          alert("게시글 작성 중 오류가 발생하였습니다.");
        }
      }
    });
  }
  
  $(document).ready(function() {
    $("#summernote").summernote({
      height: 600,
      placeholder: "여기에 내용을 입력하세요.",
      lang: "ko-KR",
      focus: true,
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
      fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
      fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
      callbacks: {
          onImageUpload: function(files, editor, welEditable) {
              for (var i = files.length - 1; i >= 0; i--) {
                  uploadSummernoteImageFile(files[i], this);
              }
          },
          onMediaDelete: function($target) {
              if (confirm("이미지를 삭제하시겠습니까?")) {
                  let fileName = $target.attr('src').split('/').pop();
                  deleteFile(fileName);
              }
          }
      }
  });
});
</script>

<script>
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
        var boardMyhomeArticleNo = ${selectMyHome.boardMyhomeArticleNo};
        var formData = new FormData();
        formData.append("coverImage", files[0]); 
        formData.append("boardMyhomeArticleNo", boardMyhomeArticleNo); // 기존 아티클넘버
        
        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            processData: false,
            contentType: false,
            url: "/board/board_myhome/coverImageUpload.do",  
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
        if (!file.type.startsWith("image/")) { 
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

document.addEventListener("DOMContentLoaded", function () {
    var dropZone = document.getElementById("dropZone");
    
    // 커버 이미지가 있으면 배경 이미지로 설정
    <c:if test="${not empty selectMyHome.imageFileName}">
        var coverImageUrl = "/board/board_myhome/myHomeCoverImages.do?articleNo=${selectMyHome.boardMyhomeArticleNo}&image=${selectMyHome.imageFileName}";
        dropZone.style.backgroundImage = "url('" + coverImageUrl + "')";
    </c:if>
});


</script>


</head>
<body>
	
	 <!-- 커버사진 및 썸네일 이미지 -->
     <div class="drag-drop-area" id="dropZone">
   		수정할 커버 사진을 이곳에 드래그하세요.
		</div>
	<div class="preview-container" id="previewContainer"></div>

<!-- 수정 폼 -->
	<div class="form-container">	
		<form id="modForm">
		
		<!-- 필터링 영역 (주거형태 선택) -->
	     	 <div class="filtering">
	        	주거형태    <select name="boardMyhomeHosingType" id="housingType">
				  <option value="" disabled selected hidden>--- 주거형태를 선택하세요 ---</option>
				  <option value="원룸" <c:if test="${selectMyHome.boardMyhomeHousingType == '원룸'}">selected</c:if>>원룸</option>
				  <option value="아파트" <c:if test="${selectMyHome.boardMyhomeHousingType == '아파트'}">selected</c:if>>아파트</option>
				  <option value="단독주택" <c:if test="${selectMyHome.boardMyhomeHousingType == '단독주택'}">selected</c:if>>단독주택</option>
				  <option value="사무공간" <c:if test="${selectMyHome.boardMyhomeHousingType == '사무공간'}">selected</c:if>>사무공간</option>
				  <option value="상업공간" <c:if test="${selectMyHome.boardMyhomeHousingType == '상업공간'}">selected</c:if>>상업공간</option>
				</select>

	          	평수    <select name="boardMyhomeHomeSize" id="homeSize">
				  <option value="" disabled selected hidden>--- 평수를 선택하세요 ---</option>
				  <option value="9평 미만" <c:if test="${selectMyHome.boardMyhomeHomeSize == '9평 미만'}">selected</c:if>>9평 미만</option>
				  <option value="10평대" <c:if test="${selectMyHome.boardMyhomeHomeSize == '10평대'}">selected</c:if>>10평대</option>
				  <option value="20평대" <c:if test="${selectMyHome.boardMyhomeHomeSize == '20평대'}">selected</c:if>>20평대</option>
				  <option value="30평대" <c:if test="${selectMyHome.boardMyhomeHomeSize == '30평대'}">selected</c:if>>30평대</option>
				  <option value="40평 이상" <c:if test="${selectMyHome.boardMyhomeHomeSize == '40평 이상'}">selected</c:if>>40평 이상</option>
				</select>
	      </div>	
		
			<input type="hidden" name="boardMyhomeArticleNo" value="${selectMyHome.boardMyhomeArticleNo}">
			<label for="boardMyhomeTitle">제목</label>
			<input type="text" id="boardMyhomeTitle" name="boardMyhomeTitle" value="${selectMyHome.boardMyhomeTitle}">
			<label for="boardMyhomeContents">내용</label>
			<textarea id="summernote" name="boardMyhomeContents">${selectMyHome.boardMyhomeContents}</textarea>
			
			
			<!-- 모달창 -->
			<div id="prodSearchModal" class="modal">
			    <div class="modal-header">
			        <strong>🛒 제품 검색</strong>
			        <button type="button" onclick="closeProdSearch()" class="modal-close">&times;</button>
			    </div>
			
			    <div class="modal-body">
			        <input type="text" id="searchKeyword" placeholder="상품명을 입력하세요" class="search-input">
			        <button type="button" id="modalprodSearchBtn" onclick="searchProduct()">검색🔍</button>
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
            

		<!-- 수정 완료 버튼 -->	
			<div>
				<button type="button" onclick="boardWrite()">수정 완료</button>
			</div>
		</form>
		

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

// 기존에 선택된 상품 미리보기


var selectedProducts = [
    <c:forEach var="prod" items="${productInfo}" varStatus="loop">
      {
        productNO: "${prod.productNO}",
        productName: "${prod.productName}",
        imageFileName: "${prod.prodImageName}"
      }<c:if test="${not loop.last}">,</c:if>
    </c:forEach>
  ];
  
console.log("프로덕트인포?",selectedProducts);


function prodPreView(product, isInitial = false) {
    const previewArea = document.getElementById("prodPreview");
    
	 // 중복선택 방지 (초기 렌더링은 제외)
	  if (!isInitial) {
		    if (selectedProducts.some(p => String(p.productNO) === String(product.productNO))) {
		        alert("이미 선택한 상품입니다!");
		        return;
		    }
		    selectedProducts.push(product);
		}
        
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
        delBtn.type = "button";
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
    console.log("초기 selectedProducts 길이:", selectedProducts.length);
    
    if (selectedProducts.length > 0) {
        selectedProducts.forEach(product => {
            prodPreView(product, true); // 기존 prodPreView
        });
    } else {
        const noProd = document.createElement("p");
        noProd.id = "noProdMsg";
        noProd.innerText = "선택한 상품이 없습니다.";
        previewArea.appendChild(noProd);
    }
});
	
</script>


</body>
</html>