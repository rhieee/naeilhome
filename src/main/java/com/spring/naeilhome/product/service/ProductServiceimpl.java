package com.spring.naeilhome.product.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.naeilhome.image.ImageDomain;
import com.spring.naeilhome.product.dao.ProductDAO;
import com.spring.naeilhome.product.domain.ProductDomain;

@Service("ProductService")
@Transactional(propagation = Propagation.REQUIRED)
public class ProductServiceimpl implements ProductService {

	@Autowired
	private ProductDAO productDAO;
	
	// 상품 목록 - 임현규
	@Override
	public Map<String, Object> selectAllPorduct(Map<String, Object> map) throws Exception {
		
		if(map.get("section") == null) {
			map.put("section", 1);
			map.put("pageNum", 1);
		}
		// 상품 목록 전체(중복제외) 수량 가져옴
		int recNum = productDAO.allProductCount(map);
		// 가져온 상품 총 개수(중복제외) 20을 나누고 Math의 ceil로 소수점을 올림처리 = 페이지 수
		// 여기서 20d는 한 페이지에 몇개의 상품을 표시할 것 인지
		int pageNO = (int)Math.ceil(recNum/20d);
		// 페에지 수에서 10을 나누고 Math의 ceil로 소수점을 올림처리 = 섹션
		// 여기서 20d는 한 섹션에 페이지 수를 몇개 표시할 건지
		int lastSection = (int)Math.ceil(pageNO/10d);
		if(pageNO != 1) {
			map.put("recNum", recNum);
			map.put("pageNO", pageNO);
			map.put("lastSection", lastSection);
		}
		List<ProductDomain> list = productDAO.selectAllproduct(map);
		map.put("list", list);
		
		return map;
	}

	
	// 상품 상세정보
	@Override
	public List<ProductDomain> selectProduct(String productName) throws Exception {
		List<ProductDomain> list = productDAO.selectProduct(productName);
		return list;
	}
	
	// 상품 상세페이지 썸네일
	public ImageDomain selectThumnail(int productNO) throws Exception{
		return productDAO.selectThumnail(productNO);
	}
	
	// 상품 상세페이지 썸네일 외 다른이미지
	@Override
	public List<ImageDomain> selectThumnailTwo(int productNO) throws Exception {
		return productDAO.selectThumnailTwo(productNO);
	}
	
	// 상품검색
	@Override
	public List<ProductDomain> productSearching(String keyword) throws Exception {
		return productDAO.productSearching(keyword);
	}
	
	// 문의사항 상품 불러오기
    @Override
    public ProductDomain getProductByNo(int productNo) {
        return productDAO.selectProductByNo(productNo);
    }
	
	

}