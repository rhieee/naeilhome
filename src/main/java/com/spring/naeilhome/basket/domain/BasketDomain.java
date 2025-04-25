package com.spring.naeilhome.basket.domain;

import java.util.Date;

import org.springframework.stereotype.Component;

import oracle.sql.DATE;

@Component("basketDomain")
public class BasketDomain {

	private String memberId; // 사용자ID
	private int productNO; // 상품번호
	private int basketProductQty; // 상품 수량
	private Date basketUpdated; // 최근 등록일
	private String basketProductOptions; // 상품 옵션

	private String imageFileName; // 장바구니 상품 썸네일 이미지 이름
	private String productName; // 장바구니 상품명
	private int productPrice; // 상품 금액
	private int productQty; // 현재 재고 수량

	public BasketDomain(int productNO, int basketProductQty, int productPrice) {
		this.productNO = productNO;
		this.basketProductQty = basketProductQty;
		this.productPrice = productPrice;
	}

	public BasketDomain(String memberId, int productNO, int basketProductQty, Date basketUpdated,
			String basketProductOptions, String imageFileName, String productName, int productPrice, int productQty) {
		this.memberId = memberId;
		this.productNO = productNO;
		this.basketProductQty = basketProductQty;
		this.basketUpdated = basketUpdated;
		this.basketProductOptions = basketProductOptions;
		this.imageFileName = imageFileName;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productQty = productQty;
	}

	public BasketDomain() {
	}

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

	public int getBasketProductQty() {
		return basketProductQty;
	}

	public void setBasketProductQty(int basketProductQty) {
		this.basketProductQty = basketProductQty;
	}

	public Date getBasketUpdated() {
		return basketUpdated;
	}

	public void setBasketUpdated(Date basketUpdated) {
		this.basketUpdated = basketUpdated;
	}

	public String getBasketProductOptions() {
		return basketProductOptions;
	}

	public void setBasketProductOptions(String basketProductOptions) {
		this.basketProductOptions = basketProductOptions;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
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

}