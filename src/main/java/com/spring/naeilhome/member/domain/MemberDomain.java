package com.spring.naeilhome.member.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("memberDomain")
public class MemberDomain {

	// 회원 정보
	private String memberId; // 아이디
	private String memberPw; // 비밀번호
	private String memberName; // 이름
	private String memberBirth1; // 주민번호 앞자리
	private String memberBirth2; // 주민번호 뒷자리
	private String memberGender; // 성별
	private String memberPhone1; // 핸드폰번호 010
	private String memberPhone2; // 핸드폰 중간 번호 0000
	private String memberPhone3; // 핸드폰 끝번호 0000
	private String memberNickname; // 닉네임
	private String memberImage; // 프로필사진
	private String memberEmail1; // 이메일 주소1
	private String memberEmail2; // 이메일 주소2
	private String memberZip1; // 우편번호
	private String memberZip2; // 도로명주소
	private String memberZip3; // 나머지주소
	private Date memberJoindate; // 가입날짜
	private Date memberUpdated; // 수정일
	private String memberEmailReceotion; // 이메일 수신여부
	private String memberSmsReceotion; // 문자 수신여부
	
	private int emailCount;

	public MemberDomain(String memberId, String memberPw, String memberName, String memberBirth1, String memberBirth2,
			String memberGender, String memberPhone1, String memberPhone2, String memberPhone3, String memberNickname,
			String memberImage, String memberEmail1, String memberEmail2, String memberZip1, String memberZip2,
			String memberZip3, Date memberJoindate, Date memberUpdated, String memberEmailReceotion,
			String memberSmsReceotion, int emailCount) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberBirth1 = memberBirth1;
		this.memberBirth2 = memberBirth2;
		this.memberGender = memberGender;
		this.memberPhone1 = memberPhone1;
		this.memberPhone2 = memberPhone2;
		this.memberPhone3 = memberPhone3;
		this.memberNickname = memberNickname;
		this.memberImage = memberImage;
		this.memberEmail1 = memberEmail1;
		this.memberEmail2 = memberEmail2;
		this.memberZip1 = memberZip1;
		this.memberZip2 = memberZip2;
		this.memberZip3 = memberZip3;
		this.memberJoindate = memberJoindate;
		this.memberUpdated = memberUpdated;
		this.memberEmailReceotion = memberEmailReceotion;
		this.memberSmsReceotion = memberSmsReceotion;
		this.emailCount = emailCount;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberBirth1() {
		return memberBirth1;
	}

	public void setMemberBirth1(String memberBirth1) {
		this.memberBirth1 = memberBirth1;
	}

	public String getMemberBirth2() {
		return memberBirth2;
	}

	public void setMemberBirth2(String memberBirth2) {
		this.memberBirth2 = memberBirth2;
	}

	public String getMemberGender() {
		return memberGender;
	}

	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}

	public String getMemberPhone1() {
		return memberPhone1;
	}

	public void setMemberPhone1(String memberPhone1) {
		this.memberPhone1 = memberPhone1;
	}

	public String getMemberPhone2() {
		return memberPhone2;
	}

	public void setMemberPhone2(String memberPhone2) {
		this.memberPhone2 = memberPhone2;
	}

	public String getMemberPhone3() {
		return memberPhone3;
	}

	public void setMemberPhone3(String memberPhone3) {
		this.memberPhone3 = memberPhone3;
	}

	public String getMemberNickname() {
		return memberNickname;
	}

	public void setMemberNickname(String memberNickname) {
		this.memberNickname = memberNickname;
	}

	public String getMemberImage() {
		return memberImage;
	}

	public void setMemberImage(String memberImage) {
		this.memberImage = memberImage;
	}

	public String getMemberEmail1() {
		return memberEmail1;
	}

	public void setMemberEmail1(String memberEmail1) {
		this.memberEmail1 = memberEmail1;
	}

	public String getMemberEmail2() {
		return memberEmail2;
	}

	public void setMemberEmail2(String memberEmail2) {
		this.memberEmail2 = memberEmail2;
	}

	public String getMemberZip1() {
		return memberZip1;
	}

	public void setMemberZip1(String memberZip1) {
		this.memberZip1 = memberZip1;
	}

	public String getMemberZip2() {
		return memberZip2;
	}

	public void setMemberZip2(String memberZip2) {
		this.memberZip2 = memberZip2;
	}

	public String getMemberZip3() {
		return memberZip3;
	}

	public void setMemberZip3(String memberZip3) {
		this.memberZip3 = memberZip3;
	}

	public Date getMemberJoindate() {
		return memberJoindate;
	}

	public void setMemberJoindate(Date memberJoindate) {
		this.memberJoindate = memberJoindate;
	}

	public Date getMemberUpdated() {
		return memberUpdated;
	}

	public void setMemberUpdated(Date memberUpdated) {
		this.memberUpdated = memberUpdated;
	}

	public String getMemberEmailReceotion() {
		return memberEmailReceotion;
	}

	public void setMemberEmailReceotion(String memberEmailReceotion) {
		this.memberEmailReceotion = memberEmailReceotion;
	}

	public String getMemberSmsReceotion() {
		return memberSmsReceotion;
	}

	public void setMemberSmsReceotion(String memberSmsReceotion) {
		this.memberSmsReceotion = memberSmsReceotion;
	}

	public int getEmailCount() {
		return emailCount;
	}

	public void setEmailCount(int emailCount) {
		this.emailCount = emailCount;
	}

	public MemberDomain() {
		super();
	}
	
	

	
}
