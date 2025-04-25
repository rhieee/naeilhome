package com.spring.naeilhome.review.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.review.dao.ReviewDAO;
import com.spring.naeilhome.review.domain.ReviewDomain;


@Service("reviewService")
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
    private ReviewDAO reviewDAO;
	
	//리뷰 게시글 조회
	public Map<String, Object> selectReviewList(String memberId) throws Exception {
		Map<String, Object> myReviewMap = new HashMap();
		List<ReviewDomain> myReviewList = reviewDAO.selectReviewList(memberId); //게시글목록

		myReviewMap.put("myReviewList", myReviewList);
		return myReviewMap;
	}
	
	//리뷰작성시 상품이름 조회
	@Override
	public String selectProductName(int productNo) throws Exception {
		return reviewDAO.selectProductName(productNo);
	}

	//리뷰 저장
	@Override
	public void addReview(ReviewDomain reviewDomain) throws Exception {
		reviewDAO.addReview(reviewDomain);
	}
	
	//리뷰에 저장된 reviewNo을 받아옴
	@Override
	public int selectCurrVal() throws Exception {
		return reviewDAO.selectCurrVal();
	}

	//리뷰이미지 저장
	@Override
	public void addImage(Map<String, Object> imageMap) throws Exception {
		reviewDAO.addImage(imageMap);
	}
	
	// 상세페이지에서 상품에 대한 모든 리뷰 조회
	public List<ReviewDomain> reviewsList(String productName) throws Exception {
		return reviewDAO.reviewsList(productName);
	}
	
}