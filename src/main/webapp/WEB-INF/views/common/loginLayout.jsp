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
    display: flex; /* Flexbox 사용 */
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    margin: 0; /* 기본 margin 제거 */
}

#container {
    width: 100%;
    text-align: center;
    position: relative; 
    min-height: 700px;
    min-width: 1370px;
    max-width: 1370px;
}

#content {
    min-width: 986px;
    max-width: 986px;
    margin: auto; 
    align-self: center;
} 
    </style>
    <title><tiles:insertAttribute name="title" /></title>
  </head>
    <body>
    <div id="container">
      <div id="content">
          <tiles:insertAttribute name="body"/>
      </div>
    </div>
  </body>
</html>