package com.spring.naeilhome.mypage.delivery.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.mypage.delivery.dao.DeliveryDAO;
import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;

@Service("deliveryService")
public class DeliveryServiceImpl implements DeliveryService {
	
	@Autowired
	DeliveryDAO deliveryDAO;
	@Autowired
	DeliveryDomain deliveryDomain;
	
	// 주문배송목록 (임현규)
	@Override
	public List<DeliveryDomain> ordersList(String memberId) throws Exception {
		List<DeliveryDomain> list = deliveryDAO.ordersList(memberId);
		return list;
	}
	
	// 주문배송목록 - 구매확정 (임현규)
	@Override
	public void buyCompleteDelivery(Map<String, Object> map) throws Exception{
		deliveryDAO.buyCompleteDelivery(map);
	}

}
