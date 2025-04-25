package com.spring.naeilhome.mypage.point.domain;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("pointDomain")
public class PointDomain {

	private String memberId; // 회원 아이디(FK)
	private int pointEarned; // 적립 포인트
	private int pointDeduct; // 차감 포인트
	private int pointRemain; // 잔여 포인트

	// 구매확정 +
	private int joinNo; //
	private Date orderJoinDate; // 구매확정일
	private String productName; // 상품이름
	private int productPoint; // 적립 포인트

	// 포인트 -
	private Date orderDate; // 주문일

	// 회원가입 +1000P
	private Date memberJoindate;

	// 리뷰
	private Date reviewUpdated;
	private String reviewContents;

	// 리스트 통합
	private Date historyDate; // 일시
	private String historyType; // 구매확정, 포인트사용, 리뷰작성, 회원가입
	private String historyContent; // 내역 내용
	private String pointChange; // 포인트 변동 내역

	// getter, setter

	public String getMemberId() {
		return memberId;
	}

	public Date getHistoryDate() {
		return historyDate;
	}

	public void setHistoryDate(Date historyDate) {
		this.historyDate = historyDate;
	}

	public String getHistoryType() {
		return historyType;
	}

	public void setHistoryType(String historyType) {
		this.historyType = historyType;
	}

	public String getHistoryContent() {
		return historyContent;
	}

	public void setHistoryContent(String historyContent) {
		this.historyContent = historyContent;
	}

	public String getPointChange() {
		return pointChange;
	}

	public void setPointChange(String pointChange) {
		this.pointChange = pointChange;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getPointEarned() {
		return pointEarned;
	}

	public void setPointEarned(int pointEarned) {
		this.pointEarned = pointEarned;
	}

	public int getPointDeduct() {
		return pointDeduct;
	}

	public void setPointDeduct(int pointDeduct) {
		this.pointDeduct = pointDeduct;
	}

	public int getPointRemain() {
		return pointRemain;
	}

	public void setPointRemain(int pointRemain) {
		this.pointRemain = pointRemain;
	}

	public int getJoinNo() {
		return joinNo;
	}

	public void setJoinNo(int joinNo) {
		this.joinNo = joinNo;
	}

	public Date getOrderJoinDate() {
		return orderJoinDate;
	}

	public void setOrderJoinDate(Date orderJoinDate) {
		this.orderJoinDate = orderJoinDate;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getProductPoint() {
		return productPoint;
	}

	public void setProductPoint(int productPoint) {
		this.productPoint = productPoint;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public Date getReviewUpdated() {
		return reviewUpdated;
	}

	public void setReviewUpdated(Date reviewUpdated) {
		this.reviewUpdated = reviewUpdated;
	}

	public String getReviewContents() {
		return reviewContents;
	}

	public void setReviewContents(String reviewContents) {
		this.reviewContents = reviewContents;
	}

	public Date getMemberJoindate() {
		return memberJoindate;
	}

	public void setMemberJoindate(Date memberJoindate) {
		this.memberJoindate = memberJoindate;
	}

}
