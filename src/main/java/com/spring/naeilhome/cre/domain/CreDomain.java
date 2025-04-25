package com.spring.naeilhome.cre.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("creDomain")
public class CreDomain {         // (취소/반품/교환)
	
	private int creNo;           //처리번호 (PK)
	private String memberId;     //회원 아이디 (FK)
	private int orderNo;         //주문번호 (FK)
	private int productNo;       //상품번호 (FK)
	private String creStatement; //처리상태
	private String creReason;    //사유
	private Date creStart;       //완료일
	private Date creEnd;         //완료일
	private String creType;      //타입구분 (취소/반품/교환)
	
	public CreDomain(int creNo, String memberId, int orderNo, int productNo, String creStatement, String creReason,
			Date creStart, Date creEnd, String creType) {
		this.creNo = creNo;
		this.memberId = memberId;
		this.orderNo = orderNo;
		this.productNo = productNo;
		this.creStatement = creStatement;
		this.creReason = creReason;
		this.creStart = creStart;
		this.creEnd = creEnd;
		this.creType = creType;
	}
	public CreDomain() {
	}
	public int getCreNo() {
		return creNo;
	}
	public void setCreNo(int creNo) {
		this.creNo = creNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getCreStatement() {
		return creStatement;
	}
	public void setCreStatement(String creStatement) {
		this.creStatement = creStatement;
	}
	public String getCreReason() {
		return creReason;
	}
	public void setCreReason(String creReason) {
		this.creReason = creReason;
	}
	public Date getCreStart() {
		return creStart;
	}
	public void setCreStart(Date creStart) {
		this.creStart = creStart;
	}
	public Date getCreEnd() {
		return creEnd;
	}
	public void setCreEnd(Date creEnd) {
		this.creEnd = creEnd;
	}
	public String getCreType() {
		return creType;
	}
	public void setCreType(String creType) {
		this.creType = creType;
	}
	
	
	
}