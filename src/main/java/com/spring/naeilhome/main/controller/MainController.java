package com.spring.naeilhome.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.RedirectView;

import com.spring.naeilhome.main.domain.MainDomain;
import com.spring.naeilhome.main.service.MainService;

@Controller("mainController")
public class MainController {

	@Autowired
	private MainService mainService;
	
	@RequestMapping("/")
	public String home(Model model) {

		// 최신 상품 4개 조회
		List<MainDomain> newProducts = mainService.getNewProducts();
		model.addAttribute("newProducts", newProducts);

		// 베스트 게시글 4개 조회
		List<MainDomain> bestBoardPosts = mainService.getBestBoardPosts();
		model.addAttribute("bestBoardPosts", bestBoardPosts);

		// 베스트 상품 4개 조회 (주문 수량 합계 기준)
		List<MainDomain> bestProducts = mainService.getBestProducts();
		model.addAttribute("bestProducts", bestProducts);

		return "main";
	}

	// 검색 - 정희준
	@RequestMapping("/search.do")
	public String search(@RequestParam("keyword") String keyword, Model model) {
		// 상품 검색 결과
		List<MainDomain> productResults = mainService.searchProducts(keyword);
		model.addAttribute("productResults", productResults);

		// 게시글 검색 결과
		List<MainDomain> boardResults = mainService.searchBoardArticles(keyword);
		model.addAttribute("boardResults", boardResults);
		
		System.out.println("검색 키워드 : " + keyword);

		// 검색 키워드도 전달 (뷰에서 보여줄 용도)
		model.addAttribute("keyword", keyword);

		// searchResult.jsp 뷰로 포워딩
		return "searchResult";
	}

	// 자동완성 - 정희준
	@RequestMapping(value = "/autoComplete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<String> autoComplete(@RequestParam("keyword") String keyword) {
		return mainService.autoComplete(keyword);
	}
}
