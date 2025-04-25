package com.spring.naeilhome.member.service;

import java.util.Map;

import com.spring.naeilhome.member.domain.MemberDomain;

public interface MemberService {
	
	public MemberDomain login(MemberDomain memberDomain) throws Exception;
	public void deleteMember(String memberId) throws Exception;
	public String idCheck(String memberId) throws Exception;
	public String nickCheck(String nickName) throws Exception;
	public void updateMember(MemberDomain memberDomain) throws Exception;
	public void updatePwd(Map<String, String> updatePw) throws Exception;
	public void addMember(MemberDomain member) throws Exception; 
	public MemberDomain selectMemberId(String memberId) throws Exception;
	// 아이디 찾기
	public String findId(MemberDomain memberDomain) throws Exception;
	// 비밀번호 찾기
	public String findPw(MemberDomain memberDomain) throws Exception;
	// 중복 이메일 찾기
	public int useEmail(Map<String, Object> map) throws Exception;
	// 중복 핸드폰번호 찾기
	public String phoneCheck(String phone) throws Exception;
}
