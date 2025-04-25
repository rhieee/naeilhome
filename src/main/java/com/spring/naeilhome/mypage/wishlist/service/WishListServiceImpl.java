package com.spring.naeilhome.mypage.wishlist.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.naeilhome.mypage.wishlist.dao.WishListDAO;
import com.spring.naeilhome.product.domain.ProductDomain;

@Service("wishListServiceImpl")
@Transactional(propagation = Propagation.REQUIRED)
public class WishListServiceImpl implements WishListService{
	
	@Autowired
	private WishListDAO wishListDAO;
	@Autowired
	private ProductDomain productDomain;

	// 찜 목록
	@Override
	public Map<String, Object> wishList(Map<String, Object> map) throws Exception {
		
		if(map.get("section") == null) {
			map.put("section", 1);
			map.put("pageNum", 1);
		}
		
		// 찜 수 가져옴.
		String memberId = (String) map.get("memberId");
		int recNum = allwishListCount(memberId);
		
		// 가져온 상품 총 개수(중복제외) 20을 나누고 Math의 ceil로 소수점을 올림처리 = 페이지 수
		// 여기서 20d는 한 페이지에 몇개의 상품을 표시할 것 인지
		int pageNO = (int)Math.ceil(recNum/9d);
		
		// 페에지 수에서 10을 나누고 Math의 ceil로 소수점을 올림처리 = 섹션
		// 여기서 20d는 한 섹션에 페이지 수를 몇개 표시할 건지
		int lastSection = (int)Math.ceil(pageNO/10d);
		if(pageNO != 1) {
			map.put("recNum", recNum);
			map.put("pageNO", pageNO);
			map.put("lastSection", lastSection);
		}
		
		List<ProductDomain> list = wishListDAO.wishList(map);
		
		map.put("list", list);
		
		return map;
	}

	@Override
	public int allwishListCount(String memberId) throws Exception {
		return wishListDAO.allwishListCount(memberId);
	}

	// 선택 삭제
	@Override
	public void deleteWishLists(Map<String, Object> deleteWishList) throws Exception {
		wishListDAO.deleteWishLists(deleteWishList);
	}
	
	// 찜하기
	@Override
	public String isWishList(int productNo, String memberId, String check, String productName) throws Exception {
		
		Map<String, Object> wishListCheck = new HashMap<>();
		
		wishListCheck.put("productNo", productNo);
		wishListCheck.put("memberId", memberId);
		wishListCheck.put("productName", productName);
		
		String isWishList = wishListDAO.isWishList(wishListCheck);
		
		if(check.equals("no")) {
			System.out.println("뭐냐 진짜  : " + isWishList);
			
		if(isWishList.equals("noWishList")) {
			addWishList(wishListCheck);
			
		}else {
			deleteWishList(wishListCheck);}
		
		}
		return isWishList;
	}	
			
	// 찜하기 삭제
	private void deleteWishList(Map<String, Object> wishListCheck) {
	wishListDAO.deleteWishList(wishListCheck);
				
				
	}
			
	// 찜하기 추가
	private void addWishList(Map<String, Object> wishListCheck) {
	wishListDAO.addWishList(wishListCheck);
	}

}
