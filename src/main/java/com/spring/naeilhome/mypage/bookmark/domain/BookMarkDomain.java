package com.spring.naeilhome.mypage.bookmark.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("bookMarkDomain")
public class BookMarkDomain {
	
	private String memberId;       //회원 아이디(FK)
	private int articleNo;	       //게시글 번호(FK)
	private Date bookmarkUpdated;  //등록일
	
	
	public BookMarkDomain() {
	}
	public BookMarkDomain(String memberId, int articleNo, Date bookmarkUpdated) {
		this.memberId = memberId;
		this.articleNo = articleNo;
		this.bookmarkUpdated = bookmarkUpdated;
	}
	@Override
	public String toString() {
		return "BookMarkDomain [memberId=" + memberId + ", articleNo=" + articleNo + ", bookmarkUpdated="
				+ bookmarkUpdated + "]";
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getArticleNo() {
		return articleNo;
	}
	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}
	public Date getBookmarkUpdated() {
		return bookmarkUpdated;
	}
	public void setBookmarkUpdated(Date bookmarkUpdated) {
		this.bookmarkUpdated = bookmarkUpdated;
	}

}
