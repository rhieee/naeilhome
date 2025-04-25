package com.spring.naeilhome.mypage.wishlist.controller;

import java.net.URLEncoder;
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

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.wishlist.service.WishListService;
import com.spring.naeilhome.product.domain.ProductDomain;

@Controller("wishListController")
@RequestMapping("/mypage/wishlist")
public class WishListController {
	
	
	@Autowired
	private WishListService wishListService;
	@Autowired
	private ProductDomain productDomain;
	
	// 찜 목록 - 송현오
	@RequestMapping(value = "/wishList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView wishList(HttpServletRequest requ, HttpServletResponse resp, 
								 @RequestParam Map<String, Object> map,
								 HttpSession session) throws Exception {
		
		// 세션에서 아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();
		
		// 찜 숫자를 세션에 담기
  	  	int wishListTotal =  wishListService.allwishListCount(memberId);
  	  	session.setAttribute("wishListTotal", wishListTotal);
		
		map.put("memberId", memberId);
		
		Map<String, Object> productMap = wishListService.wishList(map);
		ModelAndView mav = new ModelAndView("/mypage/wishlist/wishList");
		
		System.out.println("상품 목록아 들어왔니? "  + productMap);
		
		mav.addObject("productMap", productMap);
		return mav;
	}
	
	// 선택 삭제 - 송현오
	@RequestMapping(value = "/deleteWishList.do", method = RequestMethod.POST)
	public String deleteWishList(HttpSession session, @RequestBody String checkedValArray) throws Exception{

		// 제이슨으로 객체에 담기
	    JSONObject jsonObject = new JSONObject(checkedValArray);
	    
	    // 제이슨 객체에 있는거 배열로 바꾸기
	    JSONArray checkedVal = jsonObject.getJSONArray("checkedVal");
	    
	    // 배열에 담기
	    List<String> checkedVals = new ArrayList<>();
	    
	    // 하나씩 빼보기
	    for (int i = 0; i < checkedVal.length(); i++) {
	    	checkedVals.add(checkedVal.getString(i));
	    }
	    
	    // 리스트에 잘 들어 갓나 확인.
	    for(String asd:checkedVals) {
	    	System.out.println("리스트에 잘 들어갔니? " + asd);
	    }
	    
	    // 세션에서 아이디 가져오고 맵에 선택한 글 번호들과 아이디 저장
	    Map<String, Object> deleteWishList = new HashMap<>();
	    
	    MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
    	String memberId = memberDomain.getMemberId();
    	
    	deleteWishList.put("memberId", memberId);
    	deleteWishList.put("checkedVals", checkedVals);
	    
    	wishListService.deleteWishLists(deleteWishList);
	    
		return "/mypage/wishlist/wishList";
	}
	
	// 찜 추가 - 송현오
   	@RequestMapping(value = "/wishLists.do", method = {RequestMethod.GET, RequestMethod.POST})
   	public String wishList(@RequestParam("productNo") int productNo,
   						   @RequestParam("productName") String productName,
   						   HttpSession session) throws Exception {
   	        
   		
   		System.out.println("찜 상품 번호 : " + productNo);
   		System.out.println("찜 상품 이름 : " + productName);
   		
		// 세션에서 아이디 가져오기
   		if((MemberDomain) session.getAttribute("member") != null) {
	  	MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
	  	String memberId = memberDomain.getMemberId();
	  	
	  	System.out.println("상품에서 아이디 확인 : " + memberId);
	  	
	  	// no는 찜 추가,삭제 작업, yes는 리스트 조회할때 찜 여부만 가져오기
	  	String check = "no";
	  	
	  	// 찜 여부 확인하여 추가 삭제
	  	wishListService.isWishList(productNo, memberId, check, productName);
	  	
	  	// 찜 숫자를 세션에 담기
  	  	int wishListTotal =  wishListService.allwishListCount(memberId);
  	  	session.setAttribute("wishListTotal", wishListTotal);
	  	
   		}
   		
   		// productName이 깨져서 url로 들어가 utf-8로 다시 인코딩.
   		String encProductName = URLEncoder.encode(productName, "UTF-8");
   		
		return "redirect:/product/selectProduct.do?productNO=" + productNo + "&productName=" + encProductName;
   		
   	}

}
