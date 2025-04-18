package com.spring.naeilhome.product.service;

import java.util.List;
import java.util.Map;

import com.spring.naeilhome.image.ImageDomain;
import com.spring.naeilhome.product.domain.ProductDomain;

public interface ProductService {
	
	//상품 목록
	public Map<String, Object> selectAllPorduct(Map<String, Object> map) throws Exception;
	//상품상세정보
	public List<ProductDomain> selectProduct(String productName) throws Exception;
	// 상품상세페이지 썸네일
	public ImageDomain selectThumnail(int productNO) throws Exception;
	// 상품상세페이지 썸네일 외 이미지
	public List<ImageDomain> selectThumnailTwo(int productNO) throws Exception;
	// 상품 검색
	public List<ProductDomain> productSearching(String keyword) throws Exception;
	// 문의사항 상품 불러오기
	ProductDomain getProductByNo(int productNo);
	
}
