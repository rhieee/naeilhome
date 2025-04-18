<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="grid-container">
	<c:choose>
		<c:when test="${not empty myhomeList}">
			<c:forEach var="article" items="${myhomeList}">
				<div class="card">
					<!-- 썸네일 -->
					<div class="thumbnail">
						<c:choose>
							<c:when test="${not empty article.boardMyhomeArticleNo}">
								<a
									href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
									<img
									src="/board/board_myhome/myHomeCoverImages.do?articleNo=${article.boardMyhomeArticleNo}&image=${article.imageFileName}"
									alt="커버 이미지">
								</a>
							</c:when>
							<c:otherwise>
                                (이미지 없음)
                            </c:otherwise>
						</c:choose>
					</div>

					<!-- 게시글 정보 -->
<div class="card-content">
						<h3>
							<a
								href="/board/board_myhome/viewCount.do?boardMyhomeArticleNo=${article.boardMyhomeArticleNo}">
								${article.boardMyhomeTitle} </a>
						</h3>
						<c:if test="${article.memberId != '탈퇴회원'}">
                        	<p><b>${article.memberNickName}</b></p>
                        </c:if>
                        <c:if test="${article.memberId == '탈퇴회원'}">
                        	<p><b>탈퇴회원</b></p>
                        </c:if>
                        <p>👍🏻${article.boardMyhomeLikes} | 👀 ${article.boardMyhomeViews} | 💬${article.totalReply}</p>
						<p>${article.boardMyhomeUpdated}</p>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<p>해당 조건에 맞는 게시글이 없습니다.</p>
		</c:otherwise>
	</c:choose>
</div>
