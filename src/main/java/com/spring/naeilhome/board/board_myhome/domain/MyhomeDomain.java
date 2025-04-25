package com.spring.naeilhome.board.board_myhome.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("myhomeDomain")
public class MyhomeDomain {

	private int boardMyhomeArticleNo; // 게시글번호
	private String memberId; // 작성자 아이디
	private String memberNickName; // 작성자 닉네임
	private String memberImage; // 작성자 프로필 사진
	private String boardMyhomeTitle; // 제목
	private String boardMyhomeContents; // 내용
	private int boardMyhomeLikes; // 좋아요
	private int boardMyhomeViews; // 조회수
	private Date boardMyhomeUpdated; // 등록일
	private String boardMyhomeHomeSize; // 평수 카테고리
	private String boardMyhomeHousingType; // 주거형태 카테고리
	private String imageFileName; // 커버이미지 파일이름
	private int totalReply; // 게시글 별 댓글 수
	private String productName; // 게시글 내 제품 이름
	private int productNO; // 게시글 내 제품번호
	private String prodImageName; // 상품 이미지파일네임 (커버랑 안겹치게 별도로 생성)

	public MyhomeDomain() {

	}
	
	public MyhomeDomain(int boardMyhomeArticleNo, String memberId, String memberNickName, String memberImage,
			String boardMyhomeTitle, String boardMyhomeContents, int boardMyhomeLikes, int boardMyhomeViews,
			Date boardMyhomeUpdated, String boardMyhomeHomeSize, String boardMyhomeHousingType, String imageFileName,
			int totalReply, String productName, int productNO, String prodImageName) {
		super();
		this.boardMyhomeArticleNo = boardMyhomeArticleNo;
		this.memberId = memberId;
		this.memberNickName = memberNickName;
		this.memberImage = memberImage;
		this.boardMyhomeTitle = boardMyhomeTitle;
		this.boardMyhomeContents = boardMyhomeContents;
		this.boardMyhomeLikes = boardMyhomeLikes;
		this.boardMyhomeViews = boardMyhomeViews;
		this.boardMyhomeUpdated = boardMyhomeUpdated;
		this.boardMyhomeHomeSize = boardMyhomeHomeSize;
		this.boardMyhomeHousingType = boardMyhomeHousingType;
		this.imageFileName = imageFileName;
		this.totalReply = totalReply;
		this.productName = productName;
		this.productNO = productNO;
		this.prodImageName = prodImageName;
	}

	@Override
	public String toString() {
		return "MyhomeDomain [boardMyhomeArticleNo=" + boardMyhomeArticleNo + ", memberId=" + memberId
				+ ", memberNickName=" + memberNickName + ", memberImage=" + memberImage + ", boardMyhomeTitle="
				+ boardMyhomeTitle + ", boardMyhomeContents=" + boardMyhomeContents + ", boardMyhomeLikes="
				+ boardMyhomeLikes + ", boardMyhomeViews=" + boardMyhomeViews + ", boardMyhomeUpdated="
				+ boardMyhomeUpdated + ", boardMyhomeHomeSize=" + boardMyhomeHomeSize + ", boardMyhomeHousingType="
				+ boardMyhomeHousingType + ", imageFileName=" + imageFileName + ", totalReply=" + totalReply
				+ ", productName=" + productName + ", productNO=" + productNO + ", prodImageName=" + prodImageName
				+ "]";
	}

	public String getProdImageName() {
		return prodImageName;
	}

	public void setProdImageName(String prodImageName) {
		this.prodImageName = prodImageName;
	}

	public int getProductNO() {
		return productNO;
	}

	public void setProductNO(int productNO) {
		this.productNO = productNO;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getMemberNickName() {
		return memberNickName;
	}

	public void setMemberNickName(String memberNickName) {
		this.memberNickName = memberNickName;
	}

	public String getMemberImage() {
		return memberImage;
	}

	public void setMemberImage(String memberImage) {
		this.memberImage = memberImage;
	}

	public int getTotalReply() {
		return totalReply;
	}

	public void setTotalReply(int totalReply) {
		this.totalReply = totalReply;
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

	public String getBoardMyhomeTitle() {
		return boardMyhomeTitle;
	}

	public void setBoardMyhomeTitle(String boardMyhomeTitle) {
		this.boardMyhomeTitle = boardMyhomeTitle;
	}

	public String getBoardMyhomeContents() {
		return boardMyhomeContents;
	}

	public void setBoardMyhomeContents(String boardMyhomeContents) {
		this.boardMyhomeContents = boardMyhomeContents;
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

	public String getBoardMyhomeHomeSize() {
		return boardMyhomeHomeSize;
	}

	public void setBoardMyhomeHomeSize(String boardMyhomeHomeSize) {
		this.boardMyhomeHomeSize = boardMyhomeHomeSize;
	}

	public String getBoardMyhomeHousingType() {
		return boardMyhomeHousingType;
	}

	public void setBoardMyhomeHousingType(String boardMyhomeHousingType) {
		this.boardMyhomeHousingType = boardMyhomeHousingType;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

}