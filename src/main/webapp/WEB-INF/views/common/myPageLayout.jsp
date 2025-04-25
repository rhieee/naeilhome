<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false"
 %>
 <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=0.5"> 
    <style>
    
body {
    overflow-x: hidden; /* 가로 스크롤 숨기기 */
    overflow-y: auto; /* 세로 스크롤 유지 */
    margin-left:auto;
	margin-right:auto;
}   

#container {
	display: flex; /* flexbox 사용 */
    flex-direction: column; /* 세로 방향으로 배치 */
    align-items: center; /* 가로 방향 가운데 정렬 */
    justify-content: center; /* 세로 방향 가운데 정렬 */
    width: 100vw;
    margin: 0 auto; /* auto로 중앙 정렬 */
    text-align: center;
}

#header {
	width: 100vw; /* 전체 너비 차지 */
    margin: 0; /* 여백 제거 */
    margin-bottom: 5px;
    min-width: 1920px;
    box-sizing: border-box;
    align-self:center;
}

#footer {
    clear: both;
    width: 100vw; /* 전체 너비 차지 */
    margin: 0; /* 여백 제거 */
    background-color: #F5F5F5;
    box-sizing: border-box;
    display: flex; /* Flexbox 사용 */
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 (필요한 경우) */
    align-self:center;
}

#container2 {
	display: flex;
	flex: 1;
	margin: 0 auto; /* auto로 중앙 정렬 */
	justify-content: center; /* 가운데 정렬 */
	min-width: 1370px;
  	max-width: 1370px;
}

#container3 {
	display: flex;
	flex: 1;
	margin: 0 auto; /* auto로 중앙 정렬 */
	justify-content: center; /* 가운데 정렬 */
}

#content {
	flex: 3; /* 영역이 설정 */
	padding: 20px;
	/* background-color: #F5F5F5; */
	min-width : 986px;
	max-width : 986px;
	min-height: 1080px;
}

#side {
	flex: 1; /* 사이드바 영역 */
	margin-right: 50px;
	min-width : 280px;
	max-width : 280px;
	min-height: 1080px;
}

 /* 
 4개 추가해서 움직이는 거 방지함.
 해상도를 고정? 인듯
 width: 100%; 전체 너비 차지
 margin: 0; 여백 제거
 min-width: 1920px; 최소 너비 설정
 box-sizing: border-box; 패딩과 테두리를 포함한 너비 계산
 
  */     
    </style>
    <title><tiles:insertAttribute name="title" /></title>
  </head>
    <body>
    <div id="container">
      <div id="header">
         <tiles:insertAttribute name="header"/>
      </div>
      <div id="container2">
    <div id="side">
          <tiles:insertAttribute name="myPageSide"/>
      </div>
      <div id="content">
          <tiles:insertAttribute name="body"/>
      </div>
      </div>
      <div id="footer">
          <tiles:insertAttribute name="footer"/>
      </div>
    </div>
  </body>
</html>