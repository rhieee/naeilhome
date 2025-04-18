package com.spring.naeilhome.basket.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.basket.dao.BasketDAO;
import com.spring.naeilhome.basket.domain.BasketDomain;
import com.spring.naeilhome.basket.vo.BasketVO;

@Service("basketService")
public class BasketServiceImpl implements BasketService {

	@Autowired
	BasketDAO basketDAO;
	@Autowired
	BasketVO basketVO;
	
	// 장바구니 목록 - 임현규
	@Override
	public List<BasketDomain> myBasketList(String memberId) throws Exception {
		return basketDAO.myBasketList(memberId);
	}
	
	// 장바구니 제품 삭제  - 임현규
	@Override
	public void deleteBasket(Map map) throws Exception {
		basketDAO.deleteBasket(map);
	}

	// 장바구니 상품 추가 - 박찬희
	@Override
	public int addBasket(BasketDomain addBasket) throws Exception {
		return basketDAO.addBasket(addBasket);
	}
	
	// 장바구니에 상품 추가 시 기존에 존재하는 제품이면 수량 증가 - 임현규
	@Override
	public int updateBasket(BasketDomain addBasket) throws Exception {
		return basketDAO.updateBasket(addBasket);
	}
	
	// 구매 시 변경된 장바구니 제품 수량 update - 임현규
	@Override
	public void finalUpdateBasket(List<BasketVO> list) throws Exception {
		for(BasketVO basketVO : list) {
			basketDAO.finalUpdateBasket(basketVO);			
		}
	}

}
