package com.spring.naeilhome.mypage.delivery.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;

@Repository("deliveryDAO")
public class DeliveryDAOImpl implements DeliveryDAO{
	
	@Autowired
    private SqlSession sqlSession;
	
	// 주문배송목록 (임현규)
	@Override
	public List<DeliveryDomain> ordersList(String memberId) throws DataAccessException {
		List<DeliveryDomain> list = sqlSession.selectList("mapper.delivery.ordersList", memberId);
		return list;
	}
	
	// 주문배송목록 - 구매확정 (임현규)
	@Override
	public void buyCompleteDelivery(Map<String, Object> map) throws DataAccessException {
		sqlSession.update("mapper.delivery.buyCompleteDelivery", map);
	}


}
