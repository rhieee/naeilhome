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
<title>게시글 상세페이지</title>

<!-- 썸머노트 CSS와 JS 파일 추가 -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.9.0/lang/summernote-ko-KR.min.js"></script>
     <!-- 카카오톡 공유하기 -->
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.4/kakao.min.js"
  		integrity="sha384-DKYJZ8NLiK8MN4/C5P2dtSmLQ4KwPaoqAfyA/DfmEc1VDxu4yyC7wy6K1Hs90nka" crossorigin="anonymous"></script>
  	<script>
  		Kakao.init('5ff589f7091052bd813bcb52440ea4f1'); // naeilhome js 키 
	</script>
    
<script>
  // 썸머노트 이미지 업로드 함수
  function uploadSummernoteImageFile(file, el) {
    let data = new FormData();
    data.append("file", file);
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
          }, 2000);
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
	        data: { file: fileName 
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

    var formData = new FormData($("#articleForm")[0]);
    $.ajax({
      type: "POST",
      enctype: 'multipart/form-data',
      processData: false,
      contentType: false,
      url: "/board/board_myhome/insertBoard.do",
      data: formData,
      dataType: "text",
      success: function(response) {
        if (response === "success") {
          alert("게시글이 성공적으로 작성되었습니다.");
          window.location.href = "/board/board_myhome/myHomeList.do";
        } else {
          alert("게시글 작성 중 오류가 발생하였습니다.");
        }
      }
    });
  }
  
  
  /* 댓글 작성 */
   $(document).ready(function() {
       $('#replyForm').on('submit', function(event) {
    	   
             // 페이지가 새로 고침되지 않도록 하며, 페이지를 새로 고침하지 않고도 데이터를 처리할 수 있음.
             event.preventDefault();

             var reply = $('#replyContents').val();

             if (${isLogOn == true && member != null}){
             if (reply) {
             $.ajax({
                 url: "/board/reply/addReply.do",
                 type: 'POST',
                 data: {reply: reply,
                	 boardMyhomeArticleNo : ${selectMyHome.boardMyhomeArticleNo}},
                 success: function() {
                	 
                     // 댓글 목록 업데이트
                     alert('댓글 작성 완료');
                     $('#replyContents').val(''); // addReply의 value 비우기
                     replyList();
                 },
                 error: function(status) {
                	  alert('댓글 작성 실패');
                     alert(status);
                 }
             });
             } else {
                 alert('댓글 내용을 입력해 주세요.');
             }
         }else {
         	 alert('로그인 후에 작성하실 수 있습니다.');
         }
         });
     });
  
  
let data = {
    boardMyhomeArticleNo: `${selectMyHome.boardMyhomeArticleNo}`,
    memberIdCheck : `${member.memberId}`,
    isLogOn : `${isLogOn}`,
    member : `${member}`,    
}; // 원글 번호랑 로그인 아이디 가져오기(이렇게 안하면 세션에 있는 아이디가 안받아짐 ㅜㅜ)
			
// 댓글 조회
function replyList(section, pageNum) {
	// 댓글 목록 요청
    $.ajax({
        url: '/board/reply/replyList.do',
        type: 'POST',
        data: { boardMyhomeArticleNo: `${selectMyHome.boardMyhomeArticleNo}`,
        		section: section,	
        		pageNum: pageNum},    
        success: function(replyList) {
        	
        	
            var totalReplys = replyList.totalReplys;
            var totalPages = replyList.totalPages;
            var startPage = replyList.startPage;
            var endPage = replyList.endPage;
            var section = replyList.section;
            var pageNum = replyList.pageNum;
            
            var memberIdCheck = data.memberIdCheck;
            var isLogOn = data.isLogOn;
            var member = data.member;
            
            console.log(memberIdCheck);
            console.log(isLogOn);
            console.log(member);
            
            console.log(totalReplys);
            console.log(totalPages);
            console.log(startPage);
            console.log(endPage);
            console.log('section : ' + section);
            console.log('pageNum : ' + pageNum);

            $('#reply').empty(); // 기존 댓글을 지우기
            
            replyList.replyList.forEach(function(reply) {
            	
            	var replyImageUrl = '/memberProfileImage/' + reply.memberId + '/';
            	var replyImageName = reply.memberImage;
            	
            	// 댓글 사진 URL
            	if(reply.memberImage==null){
                replyImageUrl = '/resources/image/';
                replyImageName = 'mypage.png';
            	}
            	
            	var memberNickname = reply.memberNickname;
            	if(reply.memberNickname==null){
            		memberNickname = '탈퇴회원';
            	}
            	
            	
                var str = '';
                
                
                // <a id="yourPage" onclick="yourPage()">${selectMyHome.memberNickName}</a>
        		// <form id="yourPageForm" action="/mypage/myhome/yourPageMyHomeList.do" method="POST">
        		// <input id="yourId" name="yourId" type="hidden" value="${selectMyHome.memberId}"/>
        		// </form>
                

                // LVL에 따른 padding 설정
                var paddingLeft = reply.LVL > 1 ? (reply.LVL - 1) * 15 : '0';
                var replyimage = reply.LVL > 1 ? '<img style="width: 20px;" src="/resources/image/downRightArrow.png" />' : '';

                // 댓글 출력
                str += '<div style="margin-bottom: 10px; border-bottom: 1px solid rgba(0, 0, 0, 0.1); padding-left: ' + paddingLeft + 'px;">' +
                       '<div style="display: flex; justify-content: space-between; align-items: flex-start;">' +
                       '<div style="display: flex; align-items: center;">' +
                       replyimage + 
                       '<a style="display: flex; align-items: center;" id="yourPage" onclick="replyYourPage(\'' + reply.memberId + '\')">' + 
                       '<img id="replyImage" src="' + replyImageUrl + replyImageName + '" style="width: 35px; height: 35px; border-radius: 50%; margin-bottom:5px;"/>' +
                       '&nbsp;' + // 이미지와 닉네임 사이에 공백 추가
                       '<span style="font-weight: bold;">' + memberNickname + '</span>' +
                       '<form id="replyYourPageForm" action="/mypage/myhome/yourPageMyHomeList.do" method="POST">' + 
                       '<input class="replyYourId" name="yourId" type="hidden" value=""/>' +
                       '</form>' +
                       '</a>' +
                       '&nbsp;' +
                       '<span style="font-weight: bold; font-size: 12px;">' + reply.replyUpdated + '</span>' +
                       '</div>';

                    // 로그인 id와 글 id 비교
                       if (memberIdCheck == reply.memberId) {
                           str += '<div class="buttons">' +
                                   '<button type="button" class="editButton" onclick="updateReplyToggle(this)" value="' + reply.replyNo + '">수정</button>' +
                                   '<button name="deleteRereply" class="deleteRereply" type="button" value="' + reply.replyNo + '" onclick="deleteRereply(' + reply.replyNo + ', this)">삭제</button>' +
                                   '</div>';
                       }
                    
                str += '</div>'; // 닫는 flex div

                // 댓글 내용
                str += '<div class="replyContent" style="margin-top: 5px; font-size: 16px; line-height: 1.5; text-align: left;" data-original-content="' + reply.replyContents + '">' +
                       reply.replyContents +
                       '</div>';

                // 로그인한 사용자에게만 대댓글 버튼 보이기
                if (isLogOn == 'true' && member != null) {
                	if(reply.memberNickname != null){
                    str += '<div class="buttons" style="text-align: left; margin-top: 10px;">' +
                            '<button class="rereToggle" value="대댓글 작성" onclick="rereToggle(' + reply.replyNo + ', this)">답변</button>' +
                            '</div>';
                	}
                }

                // 대댓글 작성 폼
                if (isLogOn == 'true' && member != null) {
                    str += '<div class="rereplyForm" style="display: none; margin-top: 10px;">' +
                        '<textarea class="rereplyContents" placeholder="여기에 작성해 주세요." style="width: 100%;"></textarea>' +
                        '<button class="addRereply" type="button" onclick="addRereply(' + reply.replyNo + ', this)">등록</button>' +
                        '<button class="cancelAddRereply" type="button" onclick="cancelAddRereply()">취소</button>' +
                        '</div>';
                }

                str += '</div>'; // 닫는 댓글 div
                // 댓글을 추가
                $('#reply').append(str);
            });

            // 페이징 기능
            var pagingStr = '';
            pagingStr += '<div class="paging">';

            // 글이 있나 없나
            if (totalReplys != 0) {
            
            // 맨 처음으로 이동
            if (section > 1 && pageNum > 10) {
                pagingStr += '<a href="#" onclick="updatePage(' + 1 + ',' +  1 + ')">&nbsp; ◀◀ </a>';
            }
            
            
            // 뒤로 이동            
            var pageNumCheck = pageNum;
            
            if (section > 1 && pageNum > 10 && (pageNum % 10) == 0) {
            	pageNumCheck = Math.floor((pageNum / 10) - 1);
                pagingStr += '<a href="#" class="pagingLink" onclick="updatePage(' + (section - 1) + ',' +  (pageNumCheck * 10) + ')">&nbsp; ◀ </a>';
            }
            
            // 뒤로 이동 10으로 나누어 지지 않는 경우
            if ((section > 1 && pageNum > 10) && (pageNum % 10) != 0) {
            	pageNumCheck = Math.floor((pageNum / 10));
                pagingStr += '<a href="#" class="pagingLink" onclick="updatePage(' + (section - 1) + ',' +  (pageNumCheck * 10) + ')">&nbsp; ◀ </a>';
            }
            
         // 현재 페이지를 변수로 저장
            var currentPage = pageNum;

         // 페이지 출력
            var pagingStr = '<div class="pagingContainer">'; // 컨테이너 시작
            for (var page = startPage; page <= endPage; page++) {
                if (page === currentPage) {
                    pagingStr += '<span class="pagingLink active" onclick="updatePage(' + section + ',' + page + ')">' + page + '</span>';
                } else {
                    pagingStr += '<span class="pagingLink" onclick="updatePage(' + section + ',' + page + ')">' + page + '</span>';
                }
            }
            pagingStr += '</div>'; // 컨테이너 끝
            
            // 다음 섹션으로 이동
            if(page>=10 && page<=endPage){
            if ((page % 10) == 0 && (totalPages / 10) != section) {
            	pagingStr += '<a href="#" class="pagingLink" onclick="updatePage(' + (section + 1) + ',' +  (page + 1) + ')">&nbsp; ▶ </a>';
            }
            }
            
            // 맨 끝 페이지로 이동
            var sectionCheck = section;
            
            if(totalPages>10){
            if ((page % 10) == 0 && (totalPages / 10) != section) {
            	sectionCheck = Math.floor(totalPages / 10);
                pagingStr += '<a href="#" class="pagingLink" onclick="updatePage(' + sectionCheck + ',' +  totalPages + ')">&nbsp; ▶▶ </a>';
            }
            if ((totalPages % 10) != 0) {
            	sectionCheck = Math.floor((totalPages / 10) + 1);
                pagingStr += '<a href="#" class="pagingLink" onclick="updatePage(' + sectionCheck + ',' +  totalPages + ')">&nbsp; ▶▶ </a>';
            }
            }
            
           
            pagingStr += '</div>';
            
            $('#reply').append(pagingStr);
            }
        },
        error: function() {
            alert('댓글 목록 실패');
        }
    });
}

function updatePage(section, pageNum) {
    // 댓글 목록 새로 고침
    replyList(section, pageNum);

    // 새로고침 되면 지정했던 곳으로 이동
    setTimeout(() => {
    	
        // 원하는 위치 지정
        const targetElement = document.getElementById('replyList');
        if (targetElement) {
            const targetPosition = targetElement.getBoundingClientRect().top + window.scrollY;
            window.scrollTo({top: targetPosition}); // behavior: 'smooth'  부드럽게 스크롤
        }
    }, 0); // 비동기적으로 실행
}


/* 버튼 클릭했던 곳을 저장해서 거기로 이동하는 방법
 setTimeout(() => {
        const scrollPosition = localStorage.getItem('scrollPosition');
        if (scrollPosition) {
            window.scrollTo(0, scrollPosition);
            localStorage.removeItem('scrollPosition'); // 복원 후 삭제
        }
    }, 0); // 비동기적으로 실행
*/

$(document).ready(function() {
	replyList(1, 1);
});

    
// 대댓글 작성 클릭시 숨겨져 잇던 rereplyForm 두두 등장
function rereToggle(replyNo, button) {
	$(button).css("display", "none");
	$(button).closest('div').next('.rereplyForm').css("display", "block");
	
	$(".editButton").css("display", "none");
	$(".deleteRereply").css("display", "none");
	$(".cancelAddRereply").css("display", "inline-block");
}

// 대댓글 등록
function addRereply(replyNo, button) {
	$(".rereToggle").css("display", "block");
	$(button).closest('div').next('.rereplyForm').css("display", "none");
	
	$(".editButton").css("display", "inline-block");
	$(".deleteRereply").css("display", "inline-block");
	$(".cancelAddRereply").css("display", "none");
	
    var rereplyContents = $(button).siblings('.rereplyContents').val(); // 텍스트 영역의 값 가져오기

    var isLogOn = data.isLogOn;
    var member = data.member;
    
    if (isLogOn == 'true' && member != null){
        if (rereplyContents) {
            $.ajax({
                url: '/board/reply/addRereply.do',
                type: 'POST',
                data: {
                    replyNo: replyNo,
                    rereplyContents: rereplyContents,
                    boardMyhomeArticleNo: `${selectMyHome.boardMyhomeArticleNo}`
                },
                success: function() {
                    alert('대댓글이 등록되었습니다.');
                    replyList(); // 댓글 목록을 새로 고침
                },
                error: function() {
                    alert('대댓글 등록 실패');
                }
            });
        } else {
            alert('대댓글 내용을 입력해 주세요.');
        }
    }else {
    	 alert('로그인 후에 작성하실 수 있습니다.');
    }
    }

// 댓글 취소 시
function cancelAddRereply(){
	$(".rereToggle").css("display", "block");
	$(".rereplyForm").css("display", "none");
	
	$(".cancelAddRereply").css("display", "none");
	$(".editButton").css("display", "inline-block");
	$(".deleteRereply").css("display", "inline-block");
}

/* 댓글 삭제 */
    $(document).on('click', '.deleteRereply', function(event) {
 	   
          // 페이지가 새로 고침되지 않도록 하며, 페이지를 새로 고침하지 않고도 데이터를 처리할 수 있음.
          event.preventDefault();

          var replyNo = $(this).val();

          $.ajax({
              url: "/board/reply/deleteRereply.do",
              type: 'POST',
              data: {replyNo: replyNo},
              success: function() {
             	 
                  alert('댓글 삭제 완료');
                  // 댓글 목록 업데이트
                  replyList();
              },
              error: function(status) {
            	  alert('댓글 삭제 실패');
              }
          });
      });

 // 수정 버튼 관련
    function updateReplyToggle(button) {
	 
        var replyDiv = $(button).closest('div').parent().parent();

        // 수정 버튼과 삭제 버튼 숨김
        $(replyDiv).find('.buttons').hide();

        // 기존 댓글 가져옴
        var replyContent = $(replyDiv).find('.replyContent').data('original-content');

        var replyNo = $(button).val(); // replyNo를 가져오기

        // 수정 입력란과 기존 댓글 내용 저장 취소버튼 추가
        var editForm = '<div class="editForm" style="margin-top: 10px;">' +
                '<textarea class="editReplyContents" style="width: 100%;">' + replyContent + '</textarea>' +
                '<button class="saveEdit" type="button" data-reply-no="' + replyNo + '" onclick="saveEdit(' + replyNo + ', this)">저장</button>' +
                '<button class="cancelEdit" type="button" onclick="cancelEdit(this)">취소</button>' +
                '</div>';
        // 기존 댓글 내용을 숨기고 수정 입력란을 추가
        $(replyDiv).find('.replyContent').hide(); // 기존 댓글 내용 숨기기
        $(replyDiv).append(editForm); // 수정 입력란 추가
    }

    function saveEdit(replyNo, button) {
        // 수정된 내용 가저오기
        var updateRereplyContents = $(button).siblings('.editReplyContents').val();
        
        console.log('replyNo:', replyNo);
        console.log('updateRereplyContents:', updateRereplyContents);
        
        if (updateRereplyContents) {
            $.ajax({
                url: "/board/reply/modRereply.do",
                type: 'POST',
                data: {
                    replyNo: replyNo,
                    updateRereplyContents: updateRereplyContents
                },
                success: function() {
                    alert('댓글 수정 완료');
                    // 댓글 목록 업데이트
                    replyList();
                },
                error: function(status) {
                    alert('댓글 수정 실패');
                    alert(status);
                }
            });

            // 수정 완료 후 댓글 내용을 바꾸고 입력란 숨기기
            var replyDiv = $(button).closest('div').parent();
            $(replyDiv).find('.replyContent').text(updateRereplyContents).data('original-content', updateRereplyContents).show();
            $(replyDiv).find('.editForm').remove();
            $(replyDiv).find('.buttons').show();
        } else {
            alert('빈 내용으로는 수정할 수 없습니다.');
        }
    }

    function cancelEdit(button) {
        // 수정 입력란을 숨기고 버튼을 보이기
        var replyDiv = $(button).closest('div').parent(); 
        $(replyDiv).find('.editForm').remove();
        $(replyDiv).find('.replyContent').show();
        $(replyDiv).find('.buttons').show();
    }

    
    /* 북마크 추가 */
    function addBookMark(button, event) {
        var bookMark = $(button).closest('form');

        // 로그인 여부 확인
        if (isLogOn == 'true' && isLogOn != null) {
        	var boardMyhomeArticleNo = $("#bookMarkArticleNo").val();
        	$.ajax({
                url: "/mypage/bookmark/bookMark.do",
                type: 'POST',
                data: {
                    boardMyhomeArticleNo: boardMyhomeArticleNo
                },
                success: function() {
                	location.reload();
                },
                error: function(status) {
                }
            });
        } else {
            // 비로그인 시 로그인 페이지로 이동 여부 묻고 확인 누르면 이동
            if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
                window.location.href = '/member/loginForm.do';
            }
        }
    }
    
    /* 좋아요 추가 */
    function like(button, event) {
    	
        var like = $(button).closest('form');

        // 로그인 여부 확인
        if (isLogOn == 'true' && isLogOn != null) {
        	var boardMyhomeArticleNo = $("#likeArticleNo").val();
        	$.ajax({
                url: "/mypage/like/likes.do",
                type: 'POST',
                data: {
                    boardMyhomeArticleNo: boardMyhomeArticleNo
                },
                success: function() {
                	location.reload();
                },
                error: function(status) {
                }
            });
        } else {
            // 비로그인 시 로그인 페이지로 이동 여부 묻고 확인 누르면 이동
            if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
                window.location.href = '/member/loginForm.do';
            }
        }
    }  
    
 // 팔로우 팔로잉 버튼
    function follow(button, event){
	 
    	var followId = $("#followId").val();
    	
    	if (isLogOn == 'true' && isLogOn != null) {
    		
        	$.ajax({
                url: "/mypage/follow/follow.do",
                type: 'POST',
                data: {
                	followId: followId
                },
                success: function() {
                	location.reload();
                },
                error: function(status) {
                }
            });
        } else {
            // 비로그인 시 로그인 페이지로 이동 여부 묻고 확인 누르면 이동
            if (confirm("로그인 후에 이용이 가능합니다. 로그인 페이지로 이동하시겠습니까?")) {
                window.location.href = '/member/loginForm.do';
            }
        }
    }  
 
 /* 너의 페이지로 */
function yourPage(){
	 
	 var yourId = $("#yourId").val();
	 var memberIdCheck = data.memberIdCheck;
	 
	 if(yourId == memberIdCheck){
		 $("#yourPageForm").attr("action", "/mypage/myhome/myPageMyHomeList.do");
		 $("#yourPageForm").submit();
		 
	 }else{
		 $("#yourPageForm").submit();
	 }
	 
 }
 
 /* 너의 페이지로 */
function replyYourPage(yourId){
	 
	 $(".replyYourId").val(yourId);
	 
	 var memberIdCheck = data.memberIdCheck;
	 
	 if(yourId == memberIdCheck){
		 $("#replyYourPageForm").attr("action", "/mypage/myhome/myPageMyHomeList.do");
		 $("#replyYourPageForm").submit();
		 $("#replyYourPageForm").attr("action","");
		 
	 }else{
		 $("#replyYourPageForm").attr("action", "/mypage/myhome/yourPageMyHomeList.do");
		 $("#replyYourPageForm").submit();
		 $("#replyYourPageForm").attr("action","");
	 }
	 
 }
 
</script>

<!-- 스타일 -->
<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
}

#articleContainer {
    min-width: 1357px;
    max-width: 1357px;
    display: flex; 
    flex-direction: column; 
    justify-content: center; 
    align-items: center; 
    margin: 0 auto;
}

/* 댓글 창 스타일 */
#replyContents, #rereplyContents, textarea {
    width: 98.2%;  
    height: 80px; 
    resize: none; 
    border: 1px solid #ccc; 
    border-radius: 5px; 
    font-size: 14px;
    background-color: #f9f9f9; 
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); 
}

/* 댓글 작성 폼 스타일  */
#replyForm {
	width: 98.2%; 
    background: #fff;
    padding: 15px;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

/* 버튼 스타일  */
.button, .deleteButton, #addReply{
    background-color: #00A9FF; 
    color: white;
    border: none;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    border-radius: 5px; 
    cursor: pointer;
    transition: background-color 0.3s;
}

.button:hover, .deleteButton:hover, #addReply:hover{
    background-color: #008ED6;
}

.updateRereplyComplete, .cancelUpdate, .rereToggle, .addRereply, .cancelAddRereply{
    background-color: #99E0FF; 
    color: white;
    border: none;
    padding: 3px 5px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    border-radius: 5px;
    cursor: pointer; 
    transition: background-color 0.3s; /* 배경색 변화 효과 */
}

.editButton, .deleteRereply, .saveEdit, .cancelEdit{
	background-color: #4D4D4D;
	opacity:0.5;
    color: white;
    border: none;
    padding: 3px 5px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 12px;
    border-radius: 5px;
    cursor: pointer; 
    transition: background-color 0.3s; /* 배경색 변화 효과 */
}

.saveEdit{
	margin-right:2px;
}

.editButton:hover, .deleteRereply:hover, .saveEdit:hover, .cancelEdit:hover{
	background-color: #4D4D4D;
	opacity:1;
}

.updateRereplyComplete:hover, .cancelUpdate:hover, .rereToggle:hover, .addRereply:hover, .cancelAddRereply:hover {
    background-color: #66CEFF; 
}

#followButton{
 background-color: #99E0FF; 
    color: white;
    border: none;
    padding: 5px 13px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin-left: 5px;
    border-radius: 5px;
    cursor: pointer; 
    transition: background-color 0.3s; /* 배경색 변화 효과 */
    border-radius: 5px;
}

#followButton:hover{
background-color: #66CEFF; 
}

#nofollowButton{
 background-color: #4D4D4D; 
    color: white;
    border: none;
    padding: 5px 13px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin-left: 5px;
    border-radius: 5px;
    cursor: pointer; 
    transition: background-color 0.3s; /* 배경색 변화 효과 */
    border-radius: 5px;
}

#nofollowButton:hover{
background-color: #666666; 
}

/* 댓글 리스트 스타일 */
#replyList {
width: 98.2%; 
    background: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    padding: 15px;
}

#reply {
    list-style-type: none;
    padding: 0;
}

#reply li {
    border-bottom: 1px solid #eee; 
    text-align: left;
    margin-top:0px;
}

#reply li:last-child {
    border-bottom: none;
}

/* 댓글 작성자 및 내용 스타일 */
.replyContent {
    font-size: 14px; 
    color: #555; 
}

.replyAuthor {
    font-weight: bold; 
    color: #333; 
}

/* 페이징 스타일 */
.pagingContainer {
    text-align: center; 
    box-sizing: border-box; 
    display: flex; 
    justify-content: center;
}

.pagingLink {
    background-color: #99E0FF;
    color: white; 
    border-radius: 5px;
    transition: background-color 0.3s; 
    display: inline-block; 
    margin: 0 3px; 
    padding: 5px;
}

.pagingLink:hover {
    background-color: #66CEFF; 
    cursor: pointer;
}

.active {
    color: black;
    font-weight: bold;
}

/* 글내용 쪽 스타일 */
.info-row {
	min-width: 1357px;
  	max-width: 1357px;
    display: flex;
    justify-content: space-between;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 5px;
    margin-bottom: 10px;
}

.info-row2 {
    display: flex;
    justify-content: space-between;
}

.label {
    font-weight: bold;
    color: #333;
    width: 100px; 
}

.content {
    color: #666;
    flex-grow: 1; 
}

.horizontal-row {
    display: flex;
    justify-content: space-between; /* 왼쪽과 오른쪽으로 배치 */
    margin-bottom: 3px;
}

.no-content {
    text-align: center;
    color: #999;
    font-size: 18px;
}

.title {
    font-size: 35px;
    font-weight: bold;
    margin-bottom: 10px;
}

/* 프로필 사진 */
#profileImage {
    width: 35px;
    height: 35px;
    border-radius: 50%; /* 동그라미 만들기 */
    object-fit: fill;
}

/* 댓글 프로필 사진 */
#replyImage {
    width: 25px;
    height: 25px;
    border-radius: 50%; /* 동그라미 만들기 */
    margin-top:3px;
    object-fit: fill;
}

/* 버튼 컨테이너 스타일 */
.buttonContainer {
	width: 100%;
    display: flex;
    justify-content: flex-end; 
    padding: 20px 0; 
    border-top: 1px solid #ddd; 
    gap: 5px;  /* 버튼 간 간격 추가 */
}

/* 커버이미지 */
.coverImage {
    width: 100%;
    max-height: 500px; 
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
}

.coverImage img {
    width: auto; /* 강제 확대 방지 */
    max-width: 100%; /* 부모 크기보다 커지지 않도록 설정 */
    height: auto; /* 원본 비율 유지 */
    object-fit: contain;
    display: block;
}

/* 필터링  */

.hometype {
  font-size: 14px;
  margin-right: 3px;
  color: #999999;
}

.hometypeVal {
  font-weight: bold;
  color: #00A9FF; 
}


/* 좋아요 버튼 스타일 */
#likeButton {
background-color: #4D4D4D; /* 기본 색 */
color: white;
border: none;
border-radius: 5px;
cursor: pointer;
font-size: 14px;
transition: background-color 0.3s;
margin-right:2px;
}

#likeButton:hover {
background-color: #666666; 
}

/* no좋아요 버튼 스타일 */
#nolikeButton {
background-color: #99E0FF; /* 기본 색 */
color: white;
border: none;
border-radius: 5px;
cursor: pointer;
font-size: 14px;
transition: background-color 0.3s;
margin-right:2px;
}

#nolikeButton:hover {
background-color: #66CEFF; 
}

/* URL 버튼 스타일 */
.share-btns {
padding: 2px 10px;
font-size: 14px;
cursor: pointer;
border: none;
background-color: #99E0FF;
color: white;
border-radius: 5px;
border: 1.5px solid white;
}
.share-btns:hover {
cursor: pointer;
background-color: #66CEFF;
}

#share-options {
  display: none;
  position: absolute;
  top: 100%;         /* 버튼 위로 붙이기 */
  left: 0;
  margin-top: 10px;  /* 버튼과 간격 */
  background: white;
  padding: 10px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
  flex-direction: row;
  gap: 10px;
  z-index: 999;
}

/* 공유 아이콘 공통 (URL,카카오톡 공유) */
.share-icon {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  border: none;
  background: none;
  padding: 0;
  margin: 5px;
  cursor: pointer;
  vertical-align: middle;
}

.share-icon-link {
  display: inline-block;
  cursor: pointer;
  vertical-align: middle;
}



#yourPage {
	cursor: pointer;
}

/* 이 게시글에 사용된 제품 */
.myhomeProduct {
    margin-top: 30px;
    padding: 20px;
    border: none;
    margin-right: auto;
    margin-left: auto;
}

.myhomeProduct h3 {
    font-size: 1.4em;
    margin-bottom: 20px;
    color: #333;
    font-weight: 600;
}

.productSliderWrap {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.arrow img {
    width: 55px;
    height: 80px;
    cursor: pointer;
    margin: 30px
}

.productGrid {
    display: flex;
    flex-wrap: nowrap; /* 스크롤 안 생기게 고정 */
    gap: 20px;
}

.productGrid {
    display: flex;
    flex-wrap: wrap;
    gap: 25px;
}

.productItem {
    width: 200px;
    text-align: center;
    background: #fafafa;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 10px;
    transition: transform 0.2s;
}


.prodImage {
    width: 180px;
    height: 180px;
    object-fit: cover;
    border-radius: 4px;
    margin-bottom: 10px;
}

.productName {
    font-size: 0.95em;
    color: #444;
    font-weight: 500;
    line-height: 1.4;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.noProduct {
    font-size: 1em;
    color: #666;
    margin-top: 15px;
}



</style>
</head>
<body>
<div id="articleContainer">
<div id="article">
    <c:choose>
        <c:when test="${not empty selectMyHome}">
        <!-- 썸네일 커버 이미지 -->
<div class="coverImage">
    <c:choose>
        <c:when test="${not empty selectMyHome.boardMyhomeArticleNo}">                                                        
            <img src="/board/board_myhome/myHomeCoverImages.do?articleNo=${selectMyHome.boardMyhomeArticleNo}&image=${selectMyHome.imageFileName}" alt="커버 이미지">						       
        </c:when>
        <c:otherwise>커버 이미지가 없습니다.</c:otherwise>
    </c:choose>
</div>
            
            <div class="title">${selectMyHome.boardMyhomeTitle}</div>
            
            
            <div class="horizontal-row">
                <div class="info-row2" style="flex: 1;">
                <table>
                <tr>
                <td>
                
                <c:if test="${selectMyHome.memberImage==null}">
                <a id="yourPage" onclick="yourPage()">
                <img id="profileImage" src="/resources/image/mypage.png"/></a>
     			</c:if>
     			<c:if test="${selectMyHome.memberImage!=null}">
     			<a id="yourPage" onclick="yourPage()">
     			<img id="profileImage" src="/memberProfileImage/${selectMyHome.memberId}/${selectMyHome.memberImage}"/><br> <!-- 프로필 사진 넣기 -->
     			</a>
     			</c:if>
                
                </td>
                <td>
                <c:choose>
        		<c:when test="${selectMyHome.memberNickName!=null}">
        		<a id="yourPage" onclick="yourPage()">${selectMyHome.memberNickName}</a>
        		<form id="yourPageForm" action="/mypage/myhome/yourPageMyHomeList.do" method="POST">
        		<input id="yourId" name="yourId" type="hidden" value="${selectMyHome.memberId}"/>
        		</form>
        		</c:when>
                <c:otherwise>
               	 탈퇴회원
                </c:otherwise>
                </c:choose>
                </td>
                
                
                <!-- 조건문 넣어서 팔로우 팔로잉 버튼 만들어야함. -->
                <c:if test="${member.memberId != selectMyHome.memberId}">
                <c:if test="${checkBoardFollow =='false' || checkBoardFollow == null}">
                <td><button id="followButton" onclick="follow(this,event)">팔로우</button></td>
                </c:if>
                <c:if test="${checkBoardFollow =='true' && checkBoardFollow != null}">
                <td><button id="nofollowButton" onclick="follow(this,event)">팔로잉</button></td>
                </c:if>
                <input id="followId" type="hidden" name="followId" value="${selectMyHome.memberId}" />
                </c:if>
                </tr>
                </table>
                </div>
                
                
                <div class="info-row2">
                <table>
                <tr>
                <td>
				  <span class="hometype"><b>평수</b></span>
				  <span class="hometypeVal">${selectMyHome.boardMyhomeHomeSize}</span>
				</td>
				<td>
				  <span class="hometype"><b>주거형태</b></span>
				  <span class="hometypeVal">${selectMyHome.boardMyhomeHousingType}</span>
				</td>
                </tr>
                </table>
                </div>
                
            </div>
            
<div class="info-row">
    <div class="content">${selectMyHome.boardMyhomeContents}</div>
</div>
<div class="horizontal-row">
    <table style="width: 100%;">
        <tr>
        
        
<!-- 23 수정됨. -->        
<td style="display: flex; justify-content: flex-start; text-align: left;">
        <c:choose>
            <c:when test="${likeChcek=='like' && isLogOn == 'true'}">
                <!--❤️ 좋아요 버튼 (POST 방식으로 서버에 요청) -->
                <div>
                    <input id="likeArticleNo" type="hidden" name="boardMyhomeArticleNo" value="${selectMyHome.boardMyhomeArticleNo}" />
                    <button id="likeButton" onclick="like(this,event)">
                        	👍🏻 좋아요
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <!--❤️ 좋아요 버튼 (POST 방식으로 서버에 요청) -->
                <div>
                    <input id="likeArticleNo" type="hidden" name="boardMyhomeArticleNo" value="${selectMyHome.boardMyhomeArticleNo}" />
                    <button id="nolikeButton" onclick="like(this,event)">
                       	👍🏻 좋아요
                    </button>
                </div>
            </c:otherwise>
        </c:choose>


    <!-- 북마크 추가 -->
    <c:choose>
        <c:when test="${bookCheck=='book' && isLogOn == 'true'}">
            <!-- 북마크 버튼 (POST 방식으로 서버에 요청) -->
            <div>
                <input id="bookMarkArticleNo" type="hidden" name="boardMyhomeArticleNo" value="${selectMyHome.boardMyhomeArticleNo}" />
                <button id="likeButton" onclick="addBookMark(this,event)">
                   	🔖 북마크
                </button>
            </div>
        </c:when>
        <c:otherwise>
            <!-- 북마크 버튼 (POST 방식으로 서버에 요청) -->
            <div>
                <input id="bookMarkArticleNo" type="hidden" name="boardMyhomeArticleNo" value="${selectMyHome.boardMyhomeArticleNo}" />
                <button id="nolikeButton" onclick="addBookMark(this,event)">
                    	🔖 북마크
                </button>
            </div>
        </c:otherwise>
    </c:choose>
    
    <!-- 공유하기 버튼 -->
	<div class="share-wrapper" style="position: relative; display: inline-block;">
	  <!-- 공유 옵션들 (버튼 위로 뜨게 만들기) -->
	  <div id="share-options">
	    <!-- URL 복사 버튼 -->
	    <button type="button" class="share-icon" onclick="clip();">
	      <img src="/resources/image/link_round.png" style="width: 100%; height: 100%;" />
	    </button>
	
	    <!-- 카카오톡 공유 -->
	    <a id="kakaotalk-sharing-btn" href="javascript:;">
	      <img src="https://developers.kakao.com/assets/img/about/logos/kakaotalksharing/kakaotalk_sharing_btn_medium.png"
	        alt="카카오톡 공유" class="share-icon" />
	    </a>
	  </div>
	
	  <!-- 공유하기 버튼 -->
	  <button type="button" class="share-btns" onclick="toggleShareOptions()">공유하기</button>
	</div>
		
</td>

<!-- 🔖 북마크 -->
<!-- ❤️ 좋아요 -->
	
    <!-- 댓글수 -->
            <td style="text-align: right;">
			좋아요 ${selectMyHome.boardMyhomeLikes} 
			조회수 ${selectMyHome.boardMyhomeViews} 
			<!-- 댓글수 --> <span id="likeViewReply"></span>
			</td>
        </tr>
    </table>
</div>
        </c:when>
        <c:otherwise>
            <div class="no-content">내용이 없습니다.</div>
        </c:otherwise>
    </c:choose>
</div>

<!-- 이 게시물에 사용된 제품 --> 
<div class="myhomeProduct">
	<h3>이 게시글에 사용된 제품</h3>
	
	<div class="productSliderWrap">
	    <c:if test="${not empty productInfo}">
		    <div class="arrow" id="prevArrow">
		      <img src="/resources/image/prev.png">
		    </div>
		    
	        <div class="productGrid">
	            <c:forEach var="prod" items="${productInfo}">
	            	<a href="/product/selectProduct.do?productNO=${prod.productNO}&productName=${prod.productName}" class="productItem">              
	                    <img class="prodImage" src="/product/productThumbnail.do?articleNO=${prod.productNO}&image=${prod.prodImageName}" />
	                    <p class="productName">${prod.productName}</p>
	                </a>
	            </c:forEach>
	        </div>
	              
		    <div class="arrow" id="nextArrow">
		      <img src="/resources/image/next.png">
		    </div> 	        
	    </c:if>
	
	    <c:if test="${empty productInfo}">
	        <p class="noProduct">소개할 상품이 없어요 😢</p>
	    </c:if> 
		
	</div>		
</div> 
  <!-- 프로덕트 여기까지 -->
  
  
<div class="buttonContainer">
    <c:if test="${selectMyHome.memberId == member.memberId}">
        <!-- 수정 버튼 -->
        <form action="/board/board_myhome/myHomeModForm.do" method="post">
            <input type="submit" value="수정" class="button">
        </form>
        <!-- 삭제 버튼 -->
        <form action="/board/board_myhome/myHomeDelete.do" method="post">
            <input type="hidden" name="boardMyhomeArticleNo" value="${selectMyHome.boardMyhomeArticleNo}" />
            <input type="submit" value="삭제" class="deleteButton">
        </form>
    </c:if>
    
</div>
  
<!-- 댓글 작성 -->
<form id="replyForm">
    <textarea id="replyContents" name="replyContents" placeholder="댓글을 작성해주세요." required></textarea>
    <button id="addReply" type="submit">댓글 등록</button>
</form>
<div id="replyList">
    <ul id="reply"></ul>
</div>
<div class="pagingContainer">
</div>
</div>

<script>
// 이 게시글에 사용된 제품 페이징
    const itemsPerPage = 4;
    let currentPage = 0;

    const allItems = Array.from(document.querySelectorAll('.productItem'));
    const totalPages = Math.ceil(allItems.length / itemsPerPage);

    const prevArrow = document.getElementById('prevArrow');
    const nextArrow = document.getElementById('nextArrow');
    
    if (totalPages <= 1) {
        prevArrow.style.display = 'none';
        nextArrow.style.display = 'none';
    }

    function renderPage(page) {
        // 전체 숨기기
        allItems.forEach(item => item.style.display = 'none');

        // 현재 페이지의 항목만 보이게
        const start = page * itemsPerPage;
        const end = start + itemsPerPage;
        const currentItems = allItems.slice(start, end);

        currentItems.forEach(item => item.style.display = 'block');

        // 버튼 상태 업데이트
        prevArrow.disabled = page === 0;
        nextArrow.disabled = page === totalPages - 1;
    }

    prevArrow.addEventListener('click', () => {
        // 현재 첫 페이지면 마지막으로 이동
        if (currentPage === 0) {
            currentPage = totalPages - 1;
        } else {
            currentPage--;
        }
        renderPage(currentPage);
    });

    nextArrow.addEventListener('click', () => {
        // 현재 마지막 페이지면 처음으로 이동
        if (currentPage === totalPages - 1) {
            currentPage = 0;
        } else {
            currentPage++;
        }
        renderPage(currentPage);
    });
    
    // 첫 페이지 렌더링
    renderPage(currentPage);
</script>

<script>
// URL 복사

 function clip() {
			    var url = window.document.location.href;  // 현재 URL을 가져옵니다.
			    var textarea = document.createElement("textarea");
			    textarea.value = url;
			    document.body.appendChild(textarea);
			    textarea.select();
			    document.execCommand("copy");  // 클립보드에 복사합니다.
			    document.body.removeChild(textarea);
			    alert("URL이 클립보드에 복사되었습니다.");
			  }

// 카카오톡 공유하기

//var likeNum = parseInt(selectMyHome.boardMyhomeLikes) ||0;  // 작동이 안됨.. boot에서 다시 테스트 해보기!
//var commentNum = parseInt(selectMyHome.boardMyhomeViews) ||0;

  Kakao.Share.createDefaultButton({
    container: '#kakaotalk-sharing-btn',
    objectType: 'feed',
    content: {
      title: `${selectMyHome.boardMyhomeTitle}`,
      description: '우리집을 소개합니다.',  // 게시글 내용 넣을지 고민? 일단 문구 통일해둠
      imageUrl:  // 테스트 이미지 삽입, 커버이미지로 바꾸면 됨.(현재 로컬이미지라 불가)
        'https://images.pexels.com/photos/271743/pexels-photo-271743.jpeg',
      link: {  // 등록한 사이트 도메인과 일치해야 함
        webUrl: 'http://localhost:8090',
      },	
    },
    social: {
 //     likeCount: likeNum,   
 //     commentCount: commentNum, 
    },
    buttons: [
      {
        title: '홈페이지 바로가기',
        link: {
          webUrl: 'http://localhost:8090/board/board_myhome/myHomeSelect.do?boardMyhomeArticleNo='+`${selectMyHome.boardMyhomeArticleNo}`,
        },
      },
    ],
  });
  
  
//공유 옵션 토글 함수
  function toggleShareOptions() {
	event.stopPropagation(); // 이벤트 버블링 방지 (외부 클릭과 충돌 방지)
    var shareOptions = document.getElementById("share-options");
    if (shareOptions.style.display === "none") {
      shareOptions.style.display = "flex";
    } else {
      shareOptions.style.display = "none";
    }
  }  
  
//외부 클릭 시 공유 옵션 닫기
  document.addEventListener('click', function (event) {
    const shareWrapper = document.querySelector('.share-wrapper');
    const shareOptions = document.getElementById('share-options');

    // 공유 옵션이 보이고 있고, 클릭한 대상이 shareWrapper 바깥이면 닫기
    if (shareOptions.style.display === 'flex' && !shareWrapper.contains(event.target)) {
      shareOptions.style.display = 'none';
    }
  });
  
</script>


</body>
</html>
