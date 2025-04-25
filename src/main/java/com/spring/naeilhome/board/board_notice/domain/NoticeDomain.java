package com.spring.naeilhome.board.board_notice.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("noticeDomain")
public class NoticeDomain {

    private int boardNoticeArticleNo; // 공지글 번호
    private String boardNoticeTitle; // 제목
    private String boardNoticeContents; // 내용
    private String boardNoticeImage; // 사진
    private int boardNoticeViews; // 조회수
    private Date boardNoticeUpdated; // 등록일
    
	public NoticeDomain(int boardNoticeArticleNo, String boardNoticeTitle, String boardNoticeContents,
			String boardNoticeImage, int boardNoticeViews, Date boardNoticeUpdated) {
		this.boardNoticeArticleNo = boardNoticeArticleNo;
		this.boardNoticeTitle = boardNoticeTitle;
		this.boardNoticeContents = boardNoticeContents;
		this.boardNoticeImage = boardNoticeImage;
		this.boardNoticeViews = boardNoticeViews;
		this.boardNoticeUpdated = boardNoticeUpdated;
	}
	public NoticeDomain() {
	}
	public int getBoardNoticeArticleNo() {
		return boardNoticeArticleNo;
	}
	public void setBoardNoticeArticleNo(int boardNoticeArticleNo) {
		this.boardNoticeArticleNo = boardNoticeArticleNo;
	}
	public String getBoardNoticeTitle() {
		return boardNoticeTitle;
	}
	public void setBoardNoticeTitle(String boardNoticeTitle) {
		this.boardNoticeTitle = boardNoticeTitle;
	}
	public String getBoardNoticeContents() {
		return boardNoticeContents;
	}
	public void setBoardNoticeContents(String boardNoticeContents) {
		this.boardNoticeContents = boardNoticeContents;
	}
	public String getBoardNoticeImage() {
		return boardNoticeImage;
	}
	public void setBoardNoticeImage(String boardNoticeImage) {
		this.boardNoticeImage = boardNoticeImage;
	}
	public int getBoardNoticeViews() {
		return boardNoticeViews;
	}
	public void setBoardNoticeViews(int boardNoticeViews) {
		this.boardNoticeViews = boardNoticeViews;
	}
	public Date getBoardNoticeUpdated() {
		return boardNoticeUpdated;
	}
	public void setBoardNoticeUpdated(Date boardNoticeUpdated) {
		this.boardNoticeUpdated = boardNoticeUpdated;
	}
    
	
    
}