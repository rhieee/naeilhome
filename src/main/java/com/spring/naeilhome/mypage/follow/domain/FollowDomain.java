package com.spring.naeilhome.mypage.follow.domain;

import org.springframework.stereotype.Component;

@Component("followDomain")
public class FollowDomain {
	
	private String memberId;   //회원 아이디(FK)
	private String FollowerId; //팔로워 아이디
	
	public FollowDomain() {
		
	}
	
	public FollowDomain(String memberId, String followerId) {
		super();
		this.memberId = memberId;
		FollowerId = followerId;
	}
	
	@Override
	public String toString() {
		return "FollowDomain [memberId=" + memberId + ", FollowerId=" + FollowerId + "]";
	}

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getFollowerId() {
		return FollowerId;
	}
	public void setFollowerId(String followerId) {
		FollowerId = followerId;
	}
}
