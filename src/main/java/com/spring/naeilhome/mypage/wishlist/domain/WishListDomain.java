package com.spring.naeilhome.mypage.wishlist.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("wishListDomain")
public class WishListDomain {
	
	private String memberId;      //회원 아이디(FK)
	private int productNo;        //상품번호(FK)
	private Date wishlistUpdated; //등록일
	
	
	public WishListDomain() {
	}
	public WishListDomain(String memberId, int productNo, Date wishlistUpdated) {
		this.memberId = memberId;
		this.productNo = productNo;
		this.wishlistUpdated = wishlistUpdated;
	}
	@Override
	public String toString() {
		return "WishListDomain [memberId=" + memberId + ", productNo=" + productNo + ", wishlistUpdated="
				+ wishlistUpdated + "]";
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
	public Date getWishlistUpdated() {
		return wishlistUpdated;
	}
	public void setWishlistUpdated(Date wishlistUpdated) {
		this.wishlistUpdated = wishlistUpdated;
	}
	
}
