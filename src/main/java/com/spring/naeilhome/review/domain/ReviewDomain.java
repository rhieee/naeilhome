package com.spring.naeilhome.review.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("reviewDomain")
public class ReviewDomain {

	private int reviewNo;              // 리뷰 번호
	private int orderNo;
	private String memberId;           // 사용자 아이디
    private int productNo;             // 상품 번호
    private String productName;        // 상품 이름
    
    private String reviewContents;     // 리뷰 내용
    private Date reviewUpdated;        // 리뷰등록일
    private int reviewStarAvg;         // 별점 평균
    private int reviewStarDurability;  // 별점 내구성
    private int reviewStarPrice;       // 별점 가성비
    private int reviewStarDesign;      // 별점 디자인
    private int reviewStarDelivery;    // 별점 배송만족

    public ReviewDomain() {
	}

	public ReviewDomain(int reviewNo, int orderNo, String memberId, int productNo, String productName,
			String reviewContents, Date reviewUpdated, int reviewStarAvg, int reviewStarDurability, int reviewStarPrice,
			int reviewStarDesign, int reviewStarDelivery) {
		super();
		this.reviewNo = reviewNo;
		this.orderNo = orderNo;
		this.memberId = memberId;
		this.productNo = productNo;
		this.productName = productName;
		this.reviewContents = reviewContents;
		this.reviewUpdated = reviewUpdated;
		this.reviewStarAvg = reviewStarAvg;
		this.reviewStarDurability = reviewStarDurability;
		this.reviewStarPrice = reviewStarPrice;
		this.reviewStarDesign = reviewStarDesign;
		this.reviewStarDelivery = reviewStarDelivery;
	}

	@Override
	public String toString() {
		return "ReviewDomain [reviewNo=" + reviewNo + ", orderNo=" + orderNo + ", memberId=" + memberId + ", productNo="
				+ productNo + ", productName=" + productName + ", reviewContents=" + reviewContents + ", reviewUpdated="
				+ reviewUpdated + ", reviewStarAvg=" + reviewStarAvg + ", reviewStarDurability=" + reviewStarDurability
				+ ", reviewStarPrice=" + reviewStarPrice + ", reviewStarDesign=" + reviewStarDesign
				+ ", reviewStarDelivery=" + reviewStarDelivery + "]";
	}

	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getReviewContents() {
		return reviewContents;
	}
	public void setReviewContents(String reviewContents) {
		this.reviewContents = reviewContents;
	}
	public Date getReviewUpdated() {
		return reviewUpdated;
	}
	public void setReviewUpdated(Date reviewUpdated) {
		this.reviewUpdated = reviewUpdated;
	}
	public int getReviewStarAvg() {
		return reviewStarAvg;
	}
	public void setReviewStarAvg(int reviewStarAvg) {
		this.reviewStarAvg = reviewStarAvg;
	}

	public int getReviewStarDurability() {
		return reviewStarDurability;
	}
	public void setReviewStarDurability(int reviewStarDurability) {
		this.reviewStarDurability = reviewStarDurability;
	}
	public int getReviewStarPrice() {
		return reviewStarPrice;
	}
	public void setReviewStarPrice(int reviewStarPrice) {
		this.reviewStarPrice = reviewStarPrice;
	}
	public int getReviewStarDesign() {
		return reviewStarDesign;
	}
	public void setReviewStarDesign(int reviewStarDesign) {
		this.reviewStarDesign = reviewStarDesign;
	}
	public int getReviewStarDelivery() {
		return reviewStarDelivery;
	}
	public void setReviewStarDelivery(int reviewStarDelivery) {
		this.reviewStarDelivery = reviewStarDelivery;
	}
	

}