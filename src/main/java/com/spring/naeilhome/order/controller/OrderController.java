package com.spring.naeilhome.order.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.order.domain.OrderDomain;
import com.spring.naeilhome.order.service.OrderService;

@Controller("Order")
public class OrderController {

	@Autowired
	private OrderService orderService;

	// 장바구니 구매 - 정희준
	@RequestMapping(value = "/addOrder.do", method = RequestMethod.POST)
	public String addOrder1(@RequestParam("productNO") int productNO, @RequestParam("productQty") int orderQty,
			HttpServletRequest requ, HttpSession session, Model model) {

		String[] arr = requ.getParameterValues("productNO"); // arr[] = 장바구니에서 선택해서 구매한 상품 번호 배열로 저장
		int[] arr1 = new int[arr.length];
		int arr2;
		System.out.println("productNO : " + productNO);
		for (int i = 0; i < arr.length; i++) {
			arr2 = Integer.parseInt(arr[i]);
			arr1[i] = arr2;
			System.out.println("arr1[i] : " + arr1[i]);
		}

		ModelAndView mav = new ModelAndView("redirect:/basket/myBasket.do");

		MemberDomain memberObj = (MemberDomain) session.getAttribute("member");

		// 로그인 안되어있으면 로그인페이지로 리다이렉트 이동
		if (memberObj == null) {
			return "redirect:/member/loginForm.do";
		}

		String memberId = memberObj.getMemberId();
		// 로그인 된 경우
		if (memberObj != null) {
			System.out.println(memberId); // 디버깅
			if (memberId != null && !memberId.trim().isEmpty()) {
				OrderDomain userInfo = orderService.getUserInfo(memberId);
				model.addAttribute("userInfo", userInfo);
			} else {
				System.out.println("MemberDomain.");
			}
		} else {
			System.out.println("member.");
		}

//		List<OrderDomain> productInfo = (List<OrderDomain>) orderService.getProductInfo(arr);
		List<OrderDomain> productInfo = (List<OrderDomain>) orderService.getBasketInfo(memberId, arr1);
		for (OrderDomain d : productInfo) {
			System.out.println("controller productInfo.productNO : " + d.getProductNo());
			System.out.println("controller productInfo.orderQty : " + d.getOrderQty());
		}
		model.addAttribute("productList", productInfo);
		model.addAttribute("orderQty", orderQty); // 재고

		return "/order/addOrder";
	}

	// 바로 구매 - 정희준
	@RequestMapping(value = "/addOrder.do", method = RequestMethod.GET)
	public String addOrder2(@RequestParam("productNO") int productNO, @RequestParam("productQty") int orderQty,
			HttpServletRequest requ, HttpSession session, Model model) {

		System.out.println("productNO : " + productNO);
		System.out.println("productQty : " + orderQty);

		ModelAndView mav = new ModelAndView("redirect:/basket/myBasket.do");

		MemberDomain memberObj = (MemberDomain) session.getAttribute("member");

		// 로그인 안되어있으면 로그인페이지로 리다이렉트 이동
		if (memberObj == null) {
			return "redirect:/member/loginForm.do";
		}

		String memberId = memberObj.getMemberId();
		// 로그인 된 경우
		if (memberObj != null) {
			System.out.println(memberId); // 디버깅
			if (memberId != null && !memberId.trim().isEmpty()) {
				OrderDomain userInfo = orderService.getUserInfo(memberId);
				model.addAttribute("userInfo", userInfo);
			} else {
				System.out.println("MemberDomain.");
			}
		} else {
			System.out.println("member.");
		}

		List<OrderDomain> productInfo = orderService.getProductInfo(productNO);
		// 상품 가격과 수량을 기반으로 주문 총 금액 계산
		int totalAmount = 0;
		for (OrderDomain product : productInfo) {
			product.setOrderQty(orderQty); // 주문 수량 설정
			totalAmount += product.getProductPrice() * orderQty;
			System.out.println("controller productInfo.productNO : " + product.getProductNo());
			System.out.println("controller productInfo.orderQty : " + product.getOrderQty());
			System.out.println("controller productInfo.orderQty : " + product.getImageFileName());
		}
//		for (OrderDomain d : productInfo) {
//			System.out.println("controller productInfo.productNO : " + d.getProductNo());
//			System.out.println("controller productInfo.orderQty : " + d.getOrderQty());
//			System.out.println("controller productInfo.orderQty : " + d.getImageFileName());
//		}
		model.addAttribute("productList", productInfo);
		model.addAttribute("orderQty", orderQty); // 재고

		return "/order/addOrder";
	}

	// 결제 완료 - 정희준
	@RequestMapping(value = "/completeOrder.do", method = RequestMethod.POST)
	public String completeOrder(@ModelAttribute OrderDomain orderDomain,
			@RequestParam("productNoList") List<Integer> productNoList,
			@RequestParam("productPriceList") List<Integer> productPriceList,
			@RequestParam("orderQtyList") List<Integer> orderQtyList,
			@RequestParam("orderProductOptionsList") List<String> orderProductOptionsList, // 옵션 추가
			HttpSession session, Model model) {
		System.out.println("completeOrder invoked, orderDomain: " + orderDomain);

		// 폼에서 전달된 상품 정보를 OrderDomain에 세팅
		orderDomain.setProductNoList(productNoList);
		orderDomain.setProductPriceList(productPriceList);
		orderDomain.setOrderQtyList(orderQtyList);
		orderDomain.setOrderProductOptionsList(orderProductOptionsList); // 옵션 리스트 추가

		// orderProductOptionsList가 null이면 빈 리스트로 초기화
		if (orderProductOptionsList == null || orderProductOptionsList.isEmpty()) {
			orderProductOptionsList = new ArrayList<>();
			for (int i = 0; i < productNoList.size(); i++) {
				orderProductOptionsList.add(""); // 빈 옵션 추가
			}
		}
		orderDomain.setOrderProductOptionsList(orderProductOptionsList);

		// 총 주문금액 계산
		int shippingFee = 3500;
		int totalAmount = shippingFee;
		if (productPriceList != null && orderQtyList != null) {
			// 리스트 크기가 동일한지 확인 (불일치 시 예외 처리 또는 로그 남기기)
			int size = productPriceList.size();
			for (int i = 0; i < size; i++) {
				// 각 요소가 null이면 기본값 0으로 처리
				Integer price = productPriceList.get(i);
				Integer qty = orderQtyList.get(i);
				if (price == null) {
					price = 0;
				}
				if (qty == null) {
					qty = 0;
				}
				totalAmount += price * qty;
			}
		}
		orderDomain.setOrderAmount(totalAmount);
		System.out.println("Computed Order Amount: " + totalAmount);

		try {
			int result = orderService.completeOrder(orderDomain);
			System.out.println("Insert order result: " + result);
			if (result > 0) {
				List<OrderDomain> productInfoList = new ArrayList<>();
				for (int i = 0; i < productNoList.size(); i++) {
					OrderDomain product = orderService.getProductInfo(productNoList.get(i)).get(0);
					product.setOrderQty(orderQtyList.get(i)); // 각 상품에 대한 수량 설정
					product.setOrderProductOptions(orderProductOptionsList.get(i)); // 옵션 설정
					productInfoList.add(product);
				}

				// 모델에 주문정보와 상품정보를 모두 담아 payComplete.jsp로 전달
				model.addAttribute("orderInfo", orderDomain);
				model.addAttribute("productList", productInfoList);

				System.out.println("주문성공");
				return "/order/payComplete";
			} else {
				model.addAttribute("error", "주문 등록에 실패하였습니다.");
				return "redirect:/addOrder.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "주문등록중예외발생: " + e.getMessage());
			return "redirect:/addOrder.do";
		}
	}
}
