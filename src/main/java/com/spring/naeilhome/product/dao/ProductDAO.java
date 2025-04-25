package com.spring.naeilhome.product.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.image.ImageDomain;
import com.spring.naeilhome.product.domain.ProductDomain;

public interface ProductDAO {
	
	// 상품 목록
	public List<ProductDomain> selectAllproduct(Map<String, Object> map) throws Exception;
	// 상품 목록 전체 수량 가져오기 위함(중복제외)
	public int allProductCount(Map<String, Object> map) throws Exception;
	// 상품 상세 정보
	public List<ProductDomain> selectProduct(String productName) throws Exception;
	// 상품상세페이지 썸네일
	public ImageDomain selectThumnail(int productNO) throws Exception;
	// 상품상세페이지 썸네일 외 다른이미지
	public List<ImageDomain> selectThumnailTwo(int productNO) throws Exception;
	
	// 상품 검색
	public List<ProductDomain> productSearching(String keyword) throws DataAccessException;
	
	// 문의사항 상품 불러오기
	ProductDomain selectProductByNo(int productNo);
}
