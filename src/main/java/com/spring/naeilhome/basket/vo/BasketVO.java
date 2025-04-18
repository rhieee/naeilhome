package com.spring.naeilhome.basket.vo;

import org.springframework.stereotype.Component;

@Component("basketVO")
public class BasketVO {
	
	private String memberId;
	private int productNO;
	private int productQty;
	private int productPrice;
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getProductNO() {
		return productNO;
	}
	public void setProductNO(int productNO) {
		this.productNO = productNO;
	}
	public int getProductQty() {
		return productQty;
	}
	public void setProductQty(int productQty) {
		this.productQty = productQty;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public BasketVO(String memberId, int productNO, int productQty, int productPrice) {
		this.memberId = memberId;
		this.productNO = productNO;
		this.productQty = productQty;
		this.productPrice = productPrice;
	}
	public BasketVO() {
	}
}
