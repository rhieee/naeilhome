package com.spring.naeilhome.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.member.domain.MemberDomain;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;

	// 로그인
	@Override
	public MemberDomain loginById(MemberDomain memberDomain) throws DataAccessException {
		MemberDomain domain = sqlSession.selectOne("mapper.member.loginById", memberDomain);
		return domain;
	}

	// 회원 탈퇴 메서드
	@Override
	public void deleteMember(String memberId) throws DataAccessException {
		sqlSession.delete("mapper.member.deleteMember", memberId);
	}

	// 닉네임 중복확인 - 임현규
	@Override
	public String nickCheck(String nickName) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.nickNameCheck", nickName);
	}

	// 아이디 중복확인 - 임현규
	@Override
	public String idCheck(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.idCheck", memberId);
	}

	// 회원 정보 수정
	@Override
	public void updateMember(MemberDomain memberDomain) throws DataAccessException {
		sqlSession.update("mapper.member.updateMember", memberDomain);
	}

	// 회원 가입 - 임현규
	@Override
	public void addMember(MemberDomain member) throws DataAccessException {
		sqlSession.insert("mapper.member.addMember", member);
	}

	// 비밀번호 수정
	@Override
	public void updatePwd(Map<String, String> updatePw) throws DataAccessException {
		sqlSession.update("mapper.member.updatePwd", updatePw);
	}

	// memberId에 맞는 모든 회원정보 조회
	public MemberDomain selectMemberId(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.selectMemberId", memberId);
	}

	// 아이디 찾기
	@Override
	public String findId(MemberDomain memberDomain) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.findId", memberDomain);
	}

	// 비밀번호 찾기
	public String findPw(MemberDomain memberDomain) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.findPw", memberDomain);
	}

	// 중복 email 확인
	@Override
	public int useEmail(Map<String, Object> map) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.useEmail", map);
	}

	@Override
	public String phoneCheck(String phone) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.phoneCheck", phone);
	}

}
