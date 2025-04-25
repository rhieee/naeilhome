package com.spring.naeilhome.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.member.domain.MemberDomain;


public interface MemberDAO {

	 public MemberDomain loginById(MemberDomain memberDomain) throws DataAccessException;
	 public void deleteMember(String memberId) throws DataAccessException;
	 public String idCheck(String memberId) throws DataAccessException;
	 public String nickCheck(String nickName) throws DataAccessException;
	 public void updateMember(MemberDomain memberDomain) throws DataAccessException;
	 public void updatePwd(Map<String, String> updatePw)throws DataAccessException;
	 public void addMember(MemberDomain member) throws DataAccessException;   
	 public MemberDomain selectMemberId(String memberId) throws DataAccessException;
	 // 아이디 찾기
	 public String findId(MemberDomain memberDomain) throws DataAccessException;
	 // 비밀번호 찾기
	 public String findPw(MemberDomain memberDomain) throws DataAccessException;
	 public int useEmail(Map<String,Object> map) throws DataAccessException;
	 // 폰 중복 확인
	 public String phoneCheck(String phone) throws DataAccessException;
}
