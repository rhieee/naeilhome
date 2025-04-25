package com.spring.naeilhome.main.service;

import java.util.List;

import com.spring.naeilhome.main.domain.MainDomain;

public interface MainService {
	// 최신 상품 리스트 반환
	public List<MainDomain> getNewProducts();

	// 베스트 게시글 조회
	public List<MainDomain> getBestBoardPosts();

	// 베스트 상품 리스트 반환
	public List<MainDomain> getBestProducts();
	
	// 검색 관련 추가
    public List<MainDomain> searchProducts(String keyword);
    public List<MainDomain> searchBoardArticles(String keyword);
    
    // 자동완성
    public List<String> autoComplete(String keyword);
}