package com.spring.naeilhome.mypage.delivery.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;

public interface DeliveryService {

	public List<DeliveryDomain> ordersList(String memberId) throws Exception;
	public void buyCompleteDelivery(Map<String, Object> map) throws Exception;

}
