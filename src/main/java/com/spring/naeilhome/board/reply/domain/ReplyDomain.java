package com.spring.naeilhome.board.reply.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("replyDomain")
public class ReplyDomain {

    private int replyNo; // 댓글 번호
    private int boardMyhomeArticleNo; // 게시글 번호
    private String memberId; // 작성자 아이디
    private String memberNickname; // 닉네임 저장
    private String memberImage; // 이미지
    private int replyParentNo; // 댓글답글 번호
    private String replyContents; // 댓글 내용
    private Date replyUpdated; // 등록일
    private int LVL; // 등록일
    
    // 댓글 페이징
    private int totalReplys;
	private int totalPages;
	private int pagePcs;
	private int startPage; 
	private int endPage;
    
    
    public ReplyDomain() {
    	
    }
    
	public ReplyDomain(int totalReplys, int totalPages, int pagePcs, int startPage, int endPage) {
		super();
		this.totalReplys = totalReplys;
		this.totalPages = totalPages;
		this.pagePcs = pagePcs;
		this.startPage = startPage;
		this.endPage = endPage;
	}

	
	
	public String getMemberImage() {
		return memberImage;
	}

	public void setMemberImage(String memberImage) {
		this.memberImage = memberImage;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public int getReplyNo() {
		return replyNo;
	}


	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}


	public int getBoardMyhomeArticleNo() {
		return boardMyhomeArticleNo;
	}


	public void setBoardMyhomeArticleNo(int boardMyhomeArticleNo) {
		this.boardMyhomeArticleNo = boardMyhomeArticleNo;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public int getReplyParentNo() {
		return replyParentNo;
	}


	public void setReplyParentNo(int replyParentNo) {
		this.replyParentNo = replyParentNo;
	}


	public String getReplyContents() {
		return replyContents;
	}


	public void setReplyContents(String replyContents) {
		this.replyContents = replyContents;
	}


	public Date getReplyUpdated() {
		return replyUpdated;
	}


	public void setReplyUpdated(Date replyUpdated) {
		this.replyUpdated = replyUpdated;
	}


	public int getLVL() {
		return LVL;
	}


	public void setLVL(int lVL) {
		LVL = lVL;
	}


	public int getTotalReplys() {
		return totalReplys;
	}


	public void setTotalReplys(int totalReplys) {
		this.totalReplys = totalReplys;
	}


	public int getTotalPages() {
		return totalPages;
	}


	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}


	public int getPagePcs() {
		return pagePcs;
	}


	public void setPagePcs(int pagePcs) {
		this.pagePcs = pagePcs;
	}


	public int getStartPage() {
		return startPage;
	}


	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	
    
}