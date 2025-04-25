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


<style>
	#checkId{
    position: absolute;
    top: 45%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: left;
    margin: auto;
	}
/* 확인 버튼 */
#btn {
    width: 300px;
    height: 40px;
    margin-top: 10px;
}
#btn {
    background-color: #00A9FF;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}
#btn:hover {
    background-color: #008ED6;
}
</style>


</head>
<body>


<div id="checkId">
<h2>아이디 확인 결과</h2>
    <c:choose>
        <c:when test="${not empty id}">
            <p>회원님의 아이디는 <strong>${id}</strong> 입니다.</p>
        </c:when>
        <c:otherwise>
            <p><strong>일치하는 회원정보가 없습니다.</strong></p>
        </c:otherwise>
    </c:choose>

    
<!-- 확인 버튼 -->
<form action="/member/loginForm.do" method="POST">
<button type="submit" id="btn">확인</button>
</div>

</body>
</html>