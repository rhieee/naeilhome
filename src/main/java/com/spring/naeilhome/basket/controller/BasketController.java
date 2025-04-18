package com.spring.naeilhome.basket.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.basket.domain.BasketDomain;
import com.spring.naeilhome.basket.service.BasketService;
import com.spring.naeilhome.basket.vo.BasketVO;
import com.spring.naeilhome.member.domain.MemberDomain;

@Controller("basketController")
@RequestMapping("/basket")
public class BasketController {

	@Autowired
	BasketService basketService;
	@Autowired
	MemberDomain memberDomain;
	@Autowired
	BasketDomain basketDomain;

	// 장바구니 목록 - 임현규
	@RequestMapping(value = "/myBasket.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView myBasket(HttpSession session, HttpServletRequest requ, HttpServletResponse resp)
			throws Exception {
		ModelAndView mav = new ModelAndView("/basket/myBasket");
		boolean logResult = false;
		Map<String, Object> map = new HashMap<>();
		try {
			memberDomain = (MemberDomain) session.getAttribute("member");
			String memberId = memberDomain.getMemberId();
			logResult = (Boolean) session.getAttribute("isLogOn");
			List<BasketDomain> basketList = basketService.myBasketList(memberId);
			map.put("logResult", logResult);
			map.put("basketList", basketList);
			mav.addObject("map", map);
		} catch (NullPointerException e) {
			map.put("logResult", logResult);
			mav.addObject("map", map);
		}
		return mav;
	}

	// 장바구니 제품 삭제  - 임현규
	@RequestMapping(value = "/deleteBasket.do", method = RequestMethod.POST)
	public String deleteBasket(@RequestParam Map<String, Object> map) throws Exception {
		basketService.deleteBasket(map);
		return "/basket/myBasket";
	}
	
	// 장바구니 상품 추가 - 박찬희
	@RequestMapping(value = "/addBasket.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView addToBasket(@RequestParam("productNO") int productNO,
			@RequestParam("basketProductQty") int basketProductQty,
			// @RequestParam("basketProductOptions") String basketProductOptions,
			HttpSession session, HttpServletRequest requ, HttpServletResponse resp) throws Exception {

		ModelAndView mav = new ModelAndView("redirect:/basket/myBasket.do");
		MemberDomain member = (MemberDomain) session.getAttribute("member");
		int resultUpdate = 0; // 장바구니에 있는 제품인지 새로운 제품인지 구분하기 위한 디폴트값
		if (member == null) {
			mav.setViewName("redirect:/member/loginForm.do");
			return mav;
		}
		String memberId = member.getMemberId();
		List<BasketDomain> basketList = basketService.myBasketList(memberId); // memberId 기준 장바구니 조회
		basketDomain.setMemberId(memberId);
		basketDomain.setProductNO(productNO);
		basketDomain.setBasketProductQty(basketProductQty);
		// basketDomain.setBasketProductOptions(basketProductOptions);

		for (BasketDomain bs : basketList) { // 조회한 장바구니 하나씩 꺼냄
			// memberId 기준 장바구니 테이블에 존재하는 productNO과 상품 상세 페이지에서 받아온 productNO 비교
			if (bs.getProductNO() == basketDomain.getProductNO()) {
				// 비교 후 있다면 업데이트 실행 및 바뀐 행 수 저장
				basketDomain.setBasketProductQty(bs.getBasketProductQty() + basketDomain.getBasketProductQty());
				resultUpdate = basketService.updateBasket(basketDomain); // 장바구니에 상품 추가 시 기존에 존재하는 제품이면 수량 증가 - 임현규
			}
		}

		if (resultUpdate == 0) { // 업데이트가 실행이 되지 않았을 시
			basketService.addBasket(basketDomain);
		}

		return mav;
	}

	// 구매 시 변경된 장바구니 제품 수량 update - 임현규
	@RequestMapping(value = "/updateBasket.do", method = RequestMethod.POST)
	public String updateBasket(HttpServletRequest requ, @RequestBody String send_chk_items) throws Exception {

		// JSON
		JSONArray arr = new JSONArray(send_chk_items);
		List<BasketVO> list = new ArrayList<>();
		for (int i = 0; i < arr.length(); i++) {
			JSONObject obj = arr.getJSONObject(i);
			BasketVO basketVO = new BasketVO();
			basketVO.setProductNO(obj.getInt("productNO"));
			basketVO.setProductQty(obj.getInt("productQty"));
			basketVO.setProductPrice(obj.getInt("productPrice"));
			basketVO.setMemberId(obj.getString("memberId"));
			list.add(basketVO);
		}
		// 수정
		basketService.finalUpdateBasket(list);
		// 확인용
//		for(BasketVO d : list) {
//			System.out.println(d.getProductNO());
//			System.out.println(d.getProductQty());
//			System.out.println(d.getProductPrice());
//		}

		// Gson 방식 ( Google Json )
//		Gson gson = new Gson();
//		List<BasketVO> list = gson.fromJson(send_chk_items, new TypeToken<List<BasketVO>>() {}.getType());
//		// 확인용
//		for(basketVO d : list) {
//			System.out.println(d.getProductNO());
//			System.out.println(d.getProductQty());
//			System.out.println(d.getProductPrice());
//		}

		return "main";

	}

}
