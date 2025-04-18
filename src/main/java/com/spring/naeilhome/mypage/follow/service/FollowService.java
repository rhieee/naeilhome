package com.spring.naeilhome.mypage.follow.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.member.domain.MemberDomain;

public interface FollowService {
	
	public void addFollow(Map<String, Object> followId) throws Exception;
	
	public Map<String, Object> followList(Map<String, Object> followId) throws Exception;

	public void deleteFollow(Map<String, Object> followIds) throws Exception;

	public String checkBoardFollow(Map<String, Object> followIds) throws Exception;

	public List<MemberDomain> followingList(Map<String, Object> followId) throws Exception;

	public int followCount(String memberId) throws Exception;

	public int followingCount(String memberId) throws Exception;

}
