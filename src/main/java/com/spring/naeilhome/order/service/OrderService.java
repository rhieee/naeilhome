package com.spring.naeilhome.order.service;

import java.util.List;

import com.spring.naeilhome.order.domain.OrderDomain;

public interface OrderService {

	OrderDomain getUserInfo(String memberId);

	List<OrderDomain> getProductInfo(int productNO);
	
	List<OrderDomain> getBasketInfo(String memberId, int []arr1);
	
    int completeOrder(OrderDomain orderDomain);  
    
}
