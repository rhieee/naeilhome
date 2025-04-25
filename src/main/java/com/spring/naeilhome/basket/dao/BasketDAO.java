package com.spring.naeilhome.basket.dao;

import java.util.List;
import java.util.Map;

import com.spring.naeilhome.basket.domain.BasketDomain;
import com.spring.naeilhome.basket.vo.BasketVO;

public interface BasketDAO {
	
	public List<BasketDomain> myBasketList(String memberId) throws Exception;
	public void deleteBasket(Map map) throws Exception;
	public int addBasket(BasketDomain addBasket) throws Exception;
	public int updateBasket(BasketDomain addBasket) throws Exception;
	public void finalUpdateBasket(BasketVO basketVO) throws Exception;

}
