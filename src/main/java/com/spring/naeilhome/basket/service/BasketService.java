package com.spring.naeilhome.basket.service;

import java.util.List;
import java.util.Map;

import com.spring.naeilhome.basket.domain.BasketDomain;
import com.spring.naeilhome.basket.vo.BasketVO;

public interface BasketService {
	
	public List<BasketDomain> myBasketList(String memberId) throws Exception;
	public void deleteBasket(Map map) throws Exception;
	public int addBasket(BasketDomain addBasket) throws Exception;
	public int updateBasket(BasketDomain addBasket) throws Exception;
	public void finalUpdateBasket(List<BasketVO> list) throws Exception;

}
