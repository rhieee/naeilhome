package com.spring.naeilhome.order.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.order.domain.OrderDomain;
import com.spring.naeilhome.order.domain.OrderJoinDomain;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public OrderDomain getUserInfo(String memberId) {
		return sqlSession.selectOne("mapper.order.loginById", memberId); // order.xml�� "loginById" ������ ȣ��
	}

	// ��ǰ���� ��ȸ ����
	@Override
	public OrderDomain getProductInfo(int productNO) {
		return sqlSession.selectOne("mapper.order.getProductInfo", productNO);
	}
	
	@Override
	public OrderDomain getBasketInfo(OrderDomain domain) {
		return sqlSession.selectOne("mapper.order.getBasketInfo", domain);
	}

	// �ֹ����� DB�Է� ����
	@Override
	public int insertOrder(OrderDomain orderDomain) {
		return sqlSession.insert("mapper.order.insertOrder", orderDomain);
	}
	
	// 주문 상품(ordersJoin) 삽입 메서드
	@Override
    public int insertOrdersJoin(OrderJoinDomain orderJoinDomain) {
        return sqlSession.insert("mapper.order.insertOrdersJoin", orderJoinDomain);
    }
}
