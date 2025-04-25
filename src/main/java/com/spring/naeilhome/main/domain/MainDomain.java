package com.spring.naeilhome.main.domain;

import java.util.Date;

public class MainDomain {

	// 신상품
	private int productNo;
	private String productCategory;
	private String productName;
	private String productDescription;
	private int productPrice;
	private int productQty;
	private Date productUpdated;
	private String productOptions;

	private String imageFileName;

	// 베스트 게시글
	private int boardMyhomeArticleNo;
	private String boardMyhomeTitle;
	private String memberId;
	private String memberNickName;
	private int boardMyhomeLikes;
	private int boardMyhomeViews;
	private Date boardMyhomeUpdated;

	private int totalReply;

	// getter, setter
	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductQty() {
		return productQty;
	}

	public void setProductQty(int productQty) {
		this.productQty = productQty;
	}

	public Date getProductUpdated() {
		return productUpdated;
	}

	public void setProductUpdated(Date productUpdated) {
		this.productUpdated = productUpdated;
	}

	public String getProductOptions() {
		return productOptions;
	}

	public void setProductOptions(String productOptions) {
		this.productOptions = productOptions;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public int getBoardMyhomeArticleNo() {
		return boardMyhomeArticleNo;
	}

	public void setBoardMyhomeArticleNo(int boardMyhomeArticleNo) {
		this.boardMyhomeArticleNo = boardMyhomeArticleNo;
	}

	public String getBoardMyhomeTitle() {
		return boardMyhomeTitle;
	}

	public void setBoardMyhomeTitle(String boardMyhomeTitle) {
		this.boardMyhomeTitle = boardMyhomeTitle;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getBoardMyhomeLikes() {
		return boardMyhomeLikes;
	}

	public void setBoardMyhomeLikes(int boardMyhomeLikes) {
		this.boardMyhomeLikes = boardMyhomeLikes;
	}

	public int getBoardMyhomeViews() {
		return boardMyhomeViews;
	}

	public void setBoardMyhomeViews(int boardMyhomeViews) {
		this.boardMyhomeViews = boardMyhomeViews;
	}

	public Date getBoardMyhomeUpdated() {
		return boardMyhomeUpdated;
	}

	public void setBoardMyhomeUpdated(Date boardMyhomeUpdated) {
		this.boardMyhomeUpdated = boardMyhomeUpdated;
	}

	public int getTotalReply() {
		return totalReply;
	}

	public void setTotalReply(int totalReply) {
		this.totalReply = totalReply;
	}

	public String getMemberNickName() {
		return memberNickName;
	}

	public void setMemberNickName(String memberNickName) {
		this.memberNickName = memberNickName;
	}

}
