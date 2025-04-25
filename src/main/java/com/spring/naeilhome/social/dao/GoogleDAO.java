package com.spring.naeilhome.social.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.member.domain.MemberDomain;

@Repository("googleDAO")
public class GoogleDAO {

    @Autowired
    SqlSession sqlSession;

    // Google 회원 수 조회
    public int findGoogleMemberCount(Map<String, Object> userInfo) {
        return sqlSession.selectOne("mapper.social.findSocialMemberCount", userInfo);
    }

    // Google 회원 정보 조회
    public MemberDomain findGoogleMember(Map<String, Object> userInfo) {
        return sqlSession.selectOne("mapper.social.findSocialMember", userInfo);
    }
}