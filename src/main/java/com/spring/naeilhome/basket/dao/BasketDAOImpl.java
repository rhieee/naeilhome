package com.spring.naeilhome.basket.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.spring.naeilhome.basket.domain.BasketDomain;
import com.spring.naeilhome.basket.vo.BasketVO;

@Repository("basketDAO")
@Transactional // 오류 발생 시 롤백
public class BasketDAOImpl implements BasketDAO {

	@Autowired
	SqlSession sqlSession;
	
	// 장바구니 목록 - 임현규
	@Override
	public List<BasketDomain> myBasketList(String memberId) throws Exception {
		return sqlSession.selectList("mapper.basket.myBasketList", memberId);
	}
	
	// 장바구니 제품 삭제  - 임현규
	@Override
	public void deleteBasket(Map map) throws Exception {
		sqlSession.delete("mapper.basket.deleteMyBasket", map);
	}

	// 장바구니 상품 추가 - 박찬희
	@Override
	public int addBasket(BasketDomain addBasket) throws Exception {
		return sqlSession.insert("mapper.basket.addBasket", addBasket);
	}
	
	// 장바구니에 상품 추가 시 기존에 존재하는 제품이면 수량 증가 - 임현규
	@Override
	public int updateBasket(BasketDomain addBasket) throws Exception{
		return sqlSession.update("mapper.basket.updateBasket", addBasket);
	}
	
	// 구매 시 변경된 장바구니 제품 수량 update - 임현규
	@Override
	public void finalUpdateBasket(BasketVO basketVO) throws Exception{
		sqlSession.update("mapper.basket.finalUpdateBasket", basketVO);
	}

}
