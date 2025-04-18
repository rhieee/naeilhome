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
<title>공지사항</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
    // 공지사항 클릭 시 토글
    $(".notice-title").click(function () {
        $(this).toggleClass("open");
        $(this).next(".notice-content").slideToggle();
    });
});
</script>
<style>
body{
font-family: Arial, sans-serif;
}
.category-menu button.active {
font-weight: bold;
color: #cc0000;
text-decoration: underline;
}
.notice-item {
border-bottom: 1px solid #ddd;
padding: 10px 0;
margin: 5px;
text-align: left;
}
.notice-title {
margin-top: 30px;
cursor: pointer;
font-weight: bold;
position: relative;
padding-right: 20px;
font-size: 22px;
}
.notice-title p{
margin-top: 5px;
}
.notice-title::after {
content: '▼';
position: absolute;
top: 5px;
right: 0;
transition: 0.3s;
}
.notice-title.open::after {
transform: rotate(180deg);
}
.notice-content {
display: none;
margin-top: 5px;
}
.notice-title p{
	float: right;
	font-weight: normal;
	font-size: 15px;
	color: #e4e4e4;
	margin-right: 10px;
}
</style>
</head>
<body >
<h1 align="left" style="margin-left: 5px;">공지사항</h1>
<c:forEach var="noticeList" items="${noticeList }">
<div class="notice-item" >
	<div class="notice-title">${noticeList.boardNoticeTitle }<p>${noticeList.boardNoticeUpdated }</p></div>
	<div class="notice-content">${noticeList.boardNoticeContents }</div>
</div>
</c:forEach>
</body>
</html>