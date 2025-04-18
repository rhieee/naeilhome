package com.spring.naeilhome.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.naeilhome.member.dao.MemberDAO;
import com.spring.naeilhome.member.domain.MemberDomain;

@Service("memberService")
@Transactional(propagation = Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	// 로그인
	@Override
	public MemberDomain login(MemberDomain memberDomain) throws Exception {
		return memberDAO.loginById(memberDomain);
	}

	// 회원 탈퇴 메서드
	@Override
	public void deleteMember(String memberId) throws Exception {
		memberDAO.deleteMember(memberId);
	}

	// 아이디 중복확인 - 임현규
	@Override
	public String idCheck(String memberId) throws Exception {
		return memberDAO.idCheck(memberId);
	}

	// 닉네임 중복확인 - 임현규
	@Override
	public String nickCheck(String nickName) throws Exception {
		return memberDAO.nickCheck(nickName);
	}

	// 회원 정보 수정
	@Override
	public void updateMember(MemberDomain memberDomain) throws Exception {
		memberDAO.updateMember(memberDomain);
	}

	// 회원 가입 - 임현규
	@Override
	public void addMember(MemberDomain member) throws Exception {
		memberDAO.addMember(member);
	}

	// 비밀번호 수정
	@Override
	public void updatePwd(Map<String, String> updatePw) throws Exception {
		memberDAO.updatePwd(updatePw);
	}

	// memberId에 맞는 모든 회원정보 조회
	@Override
	public MemberDomain selectMemberId(String memberId) throws Exception {
		return memberDAO.selectMemberId(memberId);
	}

	// 아이디 찾기
	@Override
	public String findId(MemberDomain memberDomain) throws Exception {
		return memberDAO.findId(memberDomain);
	}

	// 비밀번호 찾기
	@Override
	public String findPw(MemberDomain memberDomain) throws Exception {
		return memberDAO.findPw(memberDomain);
	}

	@Override
	public int useEmail(Map<String, Object> map) throws Exception {
		return memberDAO.useEmail(map);
	}

	@Override
	public String phoneCheck(String phone) throws Exception {
		return memberDAO.phoneCheck(phone);
	}

}
