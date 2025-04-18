package com.spring.naeilhome.product.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.image.ImageDomain;
import com.spring.naeilhome.product.domain.ProductDomain;

@Repository("ProductDAO")
public class ProductDAOImpl implements ProductDAO {
	@Autowired
	private SqlSession sqlSession;
	
	//상품 목록 - 임현규
	@Override
	public List<ProductDomain> selectAllproduct(Map<String, Object> map) throws Exception {
		return sqlSession.selectList("mapper.product.selectAllProduct", map);
	}
	
	// 상품 목록 전체 수량 가져오기 위함(중복제외)
	@Override
	public int allProductCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("mapper.product.allProductCount", map);
	}

	// 상품 상세 정보
	@Override
	public List<ProductDomain> selectProduct(String productName) throws Exception {
		List<ProductDomain> list = sqlSession.selectList("mapper.product.selectProduct", productName);
		return list;
	}
	// 상품상세페이지 썸네일
	public ImageDomain selectThumnail(int productNO) throws Exception {
		return sqlSession.selectOne("mapper.product.selectThumnail", productNO);
	}
	// 상품상세페이지 썸네일 외 다른이미지
	@Override
	public List<ImageDomain> selectThumnailTwo(int productNO) throws Exception {
		return sqlSession.selectList("mapper.product.selectThumnailTwo", productNO);
	}
	
	// 상품 검색
	@Override
	public List<ProductDomain> productSearching(String keyword) throws DataAccessException {
		return sqlSession.selectList("mapper.product.searchingProd", keyword);	
	}
	
	// 문의사항 불러오기
    @Override
    public ProductDomain selectProductByNo(int productNo) {
        return sqlSession.selectOne("mapper.product.selectProductByNo", productNo);
    }

}
