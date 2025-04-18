package com.spring.naeilhome.mypage.point.dao;

import java.util.List;

import com.spring.naeilhome.mypage.point.domain.PointDomain;

public interface PointDAO {

	// 로그인한 회원의 포인트 정보를 조회
	public PointDomain selectPointByMemberId(String memberId);

	// 구매확정 +
	public List<PointDomain> selectPointPlusHistory(String memberId);

	// 포인트 -
	public List<PointDomain> selectPointMinusHistory(String memberId);

	// 리뷰 작성시 +150P
	public List<PointDomain> selectPointReview(String memberId);

	// 회원가입 +1000P
	public List<PointDomain> newMembergood(String memberId);

}
