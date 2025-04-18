package com.spring.naeilhome.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.review.domain.ReviewDomain;

@Repository("reviewDAO")
public class ReviewDAOImple implements ReviewDAO {

	@Autowired
	private SqlSession sqlSession;

	// 리뷰 게시글 조회
	public List<ReviewDomain> selectReviewList(String memberId) throws Exception {
		return sqlSession.selectList("mapper.review.selectReviewList", memberId);
	}

	// 리뷰작성시 상품이름 조회
	@Override
	public String selectProductName(int productNo) throws Exception {
		return sqlSession.selectOne("mapper.review.selectProductName", productNo);
	}

	// 리뷰 저장
	@Override
	public void addReview(ReviewDomain reviewDomain) throws Exception {
		sqlSession.insert("mapper.review.addReview", reviewDomain);
	}

	// 리뷰에 저장된 reviewNo을 받아옴
	@Override
	public int selectCurrVal() throws Exception {
		int reviewNo = sqlSession.selectOne("mapper.review.selectCurrVal");
		return reviewNo;
	}

	// 리뷰이미지 저장
	@Override
	public void addImage(Map<String, Object> imageMap) throws Exception {
		sqlSession.insert("mapper.review.addImage", imageMap);
	}
	
	// 상세페이지에서 상품에 대한 모든 리뷰 조회
	public List<ReviewDomain> reviewsList(String productName) throws Exception {
		return sqlSession.selectList("mapper.review.reviewsList", productName);
	}

}