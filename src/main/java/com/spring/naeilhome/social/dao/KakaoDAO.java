package com.spring.naeilhome.social.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.member.domain.MemberDomain;

@Repository("kakaoDAO")
public class KakaoDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public int findKakaoMemberCount(Map<String,Object> userInfo) {
		return sqlSession.selectOne("mapper.social.findSocialMemberCount", userInfo);
	}

	public MemberDomain findKakaoMember(Map<String,Object> userInfo) {
		return sqlSession.selectOne("mapper.social.findSocialMember", userInfo);
	}

}
