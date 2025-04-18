package com.spring.naeilhome.mypage.wishlist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.product.domain.ProductDomain;

public interface WishListDAO {

	int allwishListCount(String memberId) throws DataAccessException;

	List<ProductDomain> wishList(Map<String, Object> map) throws DataAccessException;

	void deleteWishLists(Map<String, Object> deleteWishList)throws DataAccessException;
	
	// 찜 하기
	public String isWishList(Map<String, Object> wishListCheck) throws DataAccessException;
	public void deleteWishList(Map<String, Object> wishListCheck) throws DataAccessException;
	public void addWishList(Map<String, Object> wishListCheck) throws DataAccessException;

}
