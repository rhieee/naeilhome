package com.spring.naeilhome.mypage.point.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.mypage.point.dao.PointDAO;
import com.spring.naeilhome.mypage.point.domain.PointDomain;

@Service("pointService")
public class PointServiceImpl implements PointService {

	@Autowired
	private PointDAO pointDAO;

	@Override
	public PointDomain getPointByMemberId(String memberId) {
		return pointDAO.selectPointByMemberId(memberId);
	}

	// 구매내역 +
	@Override
	public List<PointDomain> getPointPlusHistory(String memberId) {
		return pointDAO.selectPointPlusHistory(memberId);
	}

	// 포인트 -
	@Override
	public List<PointDomain> getPointMinusHistory(String memberId) {
		return pointDAO.selectPointMinusHistory(memberId);
	}

	// 리뷰 작성시 +150P
	@Override
	public List<PointDomain> getSelectPointReview(String memberId) {
		return pointDAO.selectPointReview(memberId);
	}

	// 회원가입 +1000P
	@Override
	public List<PointDomain> getNewMembergood(String memberId) {
		return pointDAO.newMembergood(memberId);
	}
}
