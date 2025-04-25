package com.spring.naeilhome.mypage.point.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.mypage.point.domain.PointDomain;

@Repository("pointDAO")
public class PointDAOImpl implements PointDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public PointDomain selectPointByMemberId(String memberId) {
		return sqlSession.selectOne("mapper.point.selectPointByMemberId", memberId);
	}

	// 구매확정 +
	@Override
	public List<PointDomain> selectPointPlusHistory(String memberId) {
		return sqlSession.selectList("mapper.point.selectPointPlusHistory", memberId);
	}

	// 포인트 -
	@Override
	public List<PointDomain> selectPointMinusHistory(String memberId) {
		return sqlSession.selectList("mapper.point.selectPointMinusHistory", memberId);
	}

	// 리뷰 작성시 +150P
	@Override
	public List<PointDomain> selectPointReview(String memberId) {
		return sqlSession.selectList("mapper.point.selectPointReview", memberId);
	}

	// 회원가입 +1000P
	@Override
	public List<PointDomain> newMembergood(String memberId) {
		return sqlSession.selectList("mapper.point.newMembergood", memberId);
	}
}
