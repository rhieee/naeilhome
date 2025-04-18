package com.spring.naeilhome.product.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Component;

import com.spring.naeilhome.image.ImageDomain;

@Component("productDomain")
public class ProductDomain {
	
	private int recNum; 				// 페이징
    private int productNO;              // 상품번호
    private String productCategory;		// 카테고리
    private String imageFileName; // 썸네일 이미지 파일 이름
    private String productName;         // 상품명
    private String productDescription;  // 상품 설명
    private int productPrice;           // 상품가격
    private int productQty;             // 상품수량
    private Date productUpdated;         // 상품등록일
    private String productOptions;		// 옵션
	public int getRecNum() {
		return recNum;
	}
	public void setRecNum(int recNum) {
		this.recNum = recNum;
	}
	public int getProductNO() {
		return productNO;
	}
	public void setProductNO(int productNO) {
		this.productNO = productNO;
	}
	public String getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
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
	public ProductDomain(int recNum, int productNO, String productCategory, String imageFileName, String productName,
			String productDescription, int productPrice, int productQty, Date productUpdated, String productOptions) {
		this.recNum = recNum;
		this.productNO = productNO;
		this.productCategory = productCategory;
		this.imageFileName = imageFileName;
		this.productName = productName;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.productQty = productQty;
		this.productUpdated = productUpdated;
		this.productOptions = productOptions;
	}
	public ProductDomain() {
	}
	@Override
	public String toString() {
		return "ProductDomain [recNum=" + recNum + ", productNO=" + productNO + ", productCategory=" + productCategory
				+ ", imageFileName=" + imageFileName + ", productName=" + productName + ", productDescription="
				+ productDescription + ", productPrice=" + productPrice + ", productQty=" + productQty
				+ ", productUpdated=" + productUpdated + ", productOptions=" + productOptions + "]";
	}

}