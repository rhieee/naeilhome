package com.spring.naeilhome.order.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.naeilhome.order.dao.OrderDAO;
import com.spring.naeilhome.order.domain.OrderDomain;
import com.spring.naeilhome.order.domain.OrderJoinDomain;

@Service("orderService")
@Transactional
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDAO orderDAO;

	@Override
	public OrderDomain getUserInfo(String memberId) {
		return orderDAO.getUserInfo(memberId);
	}

	@Override
	public List<OrderDomain> getProductInfo(int productNO) {
		List<OrderDomain> list = new ArrayList<>();
		System.out.println("OrderService getProductInfo productNO : " + productNO);
		list.add(orderDAO.getProductInfo(productNO));
		return list;
	}

	@Override
	public List<OrderDomain> getBasketInfo(String memberId, int[] arr1) {
		int productNO;
		List<OrderDomain> list = new ArrayList<>();
		for (int i = 0; i < arr1.length; i++) {
			OrderDomain o = new OrderDomain();
			productNO = arr1[i];
			o.setMemberId(memberId);
			o.setProductNo(productNO);
			System.out.println("OrderService getProductInfo productNO : " + productNO);
			list.add(orderDAO.getBasketInfo(o));
		}
		return list;
	}

	@Override
	public int completeOrder(OrderDomain orderDomain) {
		// 대표 상품번호 설정: productNoList가 있으면 첫번째 값을 대표 상품번호로 사용
		if (orderDomain.getProductNoList() != null && !orderDomain.getProductNoList().isEmpty()) {
			orderDomain.setProductNo(orderDomain.getProductNoList().get(0));
		} else {
			orderDomain.setProductNo(0); // 또는 예외 처리
		}

		// null 체크
		List<Integer> productNoList = orderDomain.getProductNoList();
		List<Integer> productPriceList = orderDomain.getProductPriceList();
		List<Integer> orderQtyList = orderDomain.getOrderQtyList();

		// 총 상품 금액 계산
		int shippingFee = 3500;
		int productTotal = 0;
		for (int i = 0; i < productNoList.size(); i++) {
			Integer price = productPriceList.get(i) != null ? productPriceList.get(i) : 0;
			Integer qty = orderQtyList.get(i) != null ? orderQtyList.get(i) : 0;
			productTotal += price * qty;
		}

		// 최종 결제금액 = (상품총액 + 배송비) - 사용포인트
		int usedPoints = orderDomain.getOrderPoints(); // addOrder.jsp에서 입력받은 사용포인트 값
		int finalAmount = shippingFee + productTotal - usedPoints;
		orderDomain.setOrderAmount(finalAmount);

		// 포인트 적립 (총 상품금액의 0.01% 적립)
		int productPoint = (int) (productTotal * 0.01);
		orderDomain.setProductPoint(productPoint);

		// 주문 헤더(orders 테이블) 입력
		int headerResult = orderDAO.insertOrder(orderDomain);

		if (headerResult > 0) {
			int joinNo = orderDomain.getOrderNo();
			orderDomain.setJoinNo(joinNo);

			// 리스트 null, 크기 확인
			if (productNoList == null || productPriceList == null || orderQtyList == null) {
				throw new IllegalArgumentException("상품 정보 리스트 중 하나 이상이 null 입니다.");
			}

			if (productNoList.size() != productPriceList.size() || productNoList.size() != orderQtyList.size()) {
				throw new IllegalArgumentException("상품 정보 리스트의 크기가 일치하지 않습니다.");
			}

			// 각 상품별 주문 상세 정보를 ordersJoin 테이블에 삽입
			int allocatedSum = 0;
			for (int i = 0; i < productNoList.size(); i++) {
				// 각 요소가 null이면 예외 발생 (상품 번호는 반드시 있어야 함)
				Integer prodNo = productNoList.get(i);
				if (prodNo == null) {
					throw new IllegalArgumentException("상품 번호가 null입니다.");
				}
				// 가격과 수량은 null이면 기본값 0으로 처리
				Integer price = productPriceList.get(i);
				Integer qty = orderQtyList.get(i);
				if (price == null) {
					price = 0;
				}
				if (qty == null) {
					qty = 0;
				}
				int orderItemAmount = price * qty;

				OrderJoinDomain joinDomain = new OrderJoinDomain();
				joinDomain.setJoinNo(joinNo);
				joinDomain.setProductNo(prodNo);
				joinDomain.setOrderQty(qty);
				joinDomain.setOrderAmount(orderItemAmount);
				joinDomain.setOrderStatement("결제완료");
				
				// orderProductOptionsList가 null이거나 크기가 부족할 경우 빈 문자열로 처리
				String orderOption = (orderDomain.getOrderProductOptionsList() != null
						&& i < orderDomain.getOrderProductOptionsList().size())
								? orderDomain.getOrderProductOptionsList().get(i)
								: "";

				joinDomain.setOrderProductOptions(orderOption);

				// 비율분배 방식으로 사용포인트 계산
				int allocatedPoints;
				if (i < productNoList.size() - 1) {
					// 각 상품에 대해 할당 = round(사용포인트 * (상품금액 / productTotal))
					allocatedPoints = (int) Math.round((double) usedPoints * orderItemAmount / productTotal);
					allocatedSum += allocatedPoints;
				} else {
					// 마지막 상품: 할당되지 않은 나머지 포인트 할당
					allocatedPoints = usedPoints - allocatedSum;
				}
				joinDomain.setOrderPoints(allocatedPoints);

				orderDAO.insertOrdersJoin(joinDomain);
			}
			return headerResult;
		} else {
			return 0;
		}
	}

}
