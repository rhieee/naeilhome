package com.spring.naeilhome.mypage.wishlist.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface WishListService {

	Map<String, Object> wishList(Map<String, Object> map) throws Exception;
	public int allwishListCount(String memberId) throws Exception;
	void deleteWishLists(Map<String, Object> deleteWishList) throws Exception;
	// 상품 찜하기
	public String isWishList(int productNo, String memberId, String check, String productName) throws Exception;

}
