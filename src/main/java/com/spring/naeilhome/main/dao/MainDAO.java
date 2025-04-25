package com.spring.naeilhome.main.dao;

import java.util.List;

import com.spring.naeilhome.main.domain.MainDomain;

public interface MainDAO {

	// 최신 상품 4개를 조회 (productUpdated 내림차순)
	public List<MainDomain> selectNewProducts();

	// 베스트 게시글 조회
	public List<MainDomain> selectBestBoardPosts();

	// 베스트 상품 조회 (주문수량 합계 기준)
	public List<MainDomain> selectBestProducts();

	// 검색 관련 추가
	public List<MainDomain> searchProducts(String keyword);
	public List<MainDomain> searchBoardArticles(String keyword);

	// 자동완성
	public List<String> autoComplete(String keyword);
}