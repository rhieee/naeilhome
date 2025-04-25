package com.spring.naeilhome.mypage.follow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.follow.domain.FollowDomain;

@Repository("FollowDAO")
public class FollowDAOImpl implements FollowDAO{

	@Autowired
    private SqlSession sqlSession;
	
    @Autowired
    private MemberDomain memberDomain;

    // 팔로우 추가
	@Override
	public void addFollow(Map<String, Object> followIds) throws DataAccessException {
		sqlSession.insert("mapper.follow.addFollow", followIds);
	}

	// 팔로우 삭제
	@Override
	public void deleteFollow(Map<String, Object> followIds) throws DataAccessException {
		sqlSession.delete("mapper.follow.deleteFollow", followIds);
	}
	
	// 팔로워 리스트 조회
	@Override
	public List<MemberDomain> followerList(Map<String, Object> followIds) throws DataAccessException {
		return sqlSession.selectList("mapper.follow.followerList", followIds);
	}
	
	// 팔로워 id 리스트 조회
	@Override
	public List<String> followerIdList(Map<String, Object> followIds) throws DataAccessException {
		return sqlSession.selectList("mapper.follow.followerIdList", followIds);
	}
	

	// 팔로윙 리스트 조회
	@Override
	public List<MemberDomain> followingList(Map<String, Object> followIds) throws DataAccessException {
		return sqlSession.selectList("mapper.follow.followingList", followIds);
	}

	// 해당 맴버 회원의 팔로윙 목록을 조회
	// 팔로윙 목록에 팔로우한 회원이 없다면 false(팔로우 버튼 활성화 핑크색) 있다면 true(팔로잉 버튼으로 회색)
	@Override
	public List<Map<String, String>> checkFollow(Map<String, Object> followIdListMap) throws DataAccessException {
	    return sqlSession.selectList("mapper.follow.checkFollow", followIdListMap);
	}

	@Override
	public String checkBoardFollow(Map<String, Object> followIds) throws DataAccessException {
		return sqlSession.selectOne("mapper.follow.checkBoardFollow", followIds);
	}

	@Override
	public List<String> followingIdList(Map<String, Object> followIds) throws DataAccessException {
		return sqlSession.selectList("mapper.follow.followingIdList", followIds);
	}

	@Override
	public List<Map<String, String>> checkfollowing(Map<String, Object> followIdListMap) throws DataAccessException {
		return sqlSession.selectList("mapper.follow.checkfollowing", followIdListMap);
	}

	@Override
	public int followCount(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.follow.followCount", memberId);
	}

	@Override
	public int followingCount(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.follow.followingCount", memberId);
	}

}
