package com.spring.naeilhome.mypage.delivery.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;
import com.spring.naeilhome.mypage.delivery.service.DeliveryService;

@Controller
@RequestMapping("/mypage/delivery")
public class DeliveryController {

	@Autowired
	DeliveryDomain deliDomain = new DeliveryDomain();
	@Autowired
	DeliveryService deliveryService;
	@Autowired
	MemberDomain memberDomain;

	// 주문배송목록 (임현규)
	@RequestMapping(value = "/deliveryList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView deliveryList(HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mypage/delivery/deliveryList");
		boolean logResult = false;
		try {
			memberDomain = (MemberDomain) session.getAttribute("member");
			String memberId = memberDomain.getMemberId();
			logResult = (Boolean) session.getAttribute("isLogOn");
			List<DeliveryDomain> ordersList = deliveryService.ordersList(memberId);
			int ordersListSize = ordersList.size();

			mav.addObject("logResult", logResult);
			mav.addObject("ordersList", ordersList);
			mav.addObject("ordersListSize", ordersListSize);
		} catch (NullPointerException e) {
			logResult = false;
			mav.addObject("logResult", logResult);
		}
		return mav;
	}

	// 주문배송목록 - 구매확정 (임현규)
	@RequestMapping(value = "/buyCompleteDelivery.do", method = RequestMethod.POST)
	public ResponseEntity buyCompleteDelvery(@RequestParam Map<String, Object> map)
			throws Exception {
		deliveryService.buyCompleteDelivery(map);
		ResponseEntity res = null;
		String msg = "<script>";
		msg += " alert('구매가 확정되었습니다.');";
		msg += " location.href='/mypage/delivery/deliveryList.do'; ";
		msg += " </script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
		return res;

	}

}
