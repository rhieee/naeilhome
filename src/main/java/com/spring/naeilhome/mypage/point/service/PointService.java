package com.spring.naeilhome.mypage.point.service;

import java.util.List;

import com.spring.naeilhome.mypage.point.domain.PointDomain;

public interface PointService {

	// 로그인한 회원의 포인트 정보 반환
	public PointDomain getPointByMemberId(String memberId);

	// 구매내역 +
	public List<PointDomain> getPointPlusHistory(String memberId);

	// 포인트 -
	public List<PointDomain> getPointMinusHistory(String memberId);

	// 리뷰 작성시 +150P
	public List<PointDomain> getSelectPointReview(String memberId);

	// 회원가입 +1000P
	public List<PointDomain> getNewMembergood(String memberId);

}
