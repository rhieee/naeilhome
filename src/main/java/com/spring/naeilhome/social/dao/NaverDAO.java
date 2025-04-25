package com.spring.naeilhome.social.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.member.domain.MemberDomain;

@Repository("naverDAO")
public class NaverDAO {

    @Autowired
    SqlSession sqlSession;

    public int findNaverMemberCount(Map<String, Object> userInfo) {
        return sqlSession.selectOne("mapper.social.findSocialMemberCount", userInfo);
    }

    public MemberDomain findNaverMember(Map<String, Object> userInfo) {
        return sqlSession.selectOne("mapper.social.findSocialMember", userInfo);
    }
}