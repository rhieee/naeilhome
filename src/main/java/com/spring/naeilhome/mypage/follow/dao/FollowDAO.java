package com.spring.naeilhome.mypage.follow.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.follow.domain.FollowDomain;

public interface FollowDAO {

	// 팔로우 추가
	public void addFollow(Map<String, Object> followId) throws DataAccessException;
	
	// 팔로우 삭제
	public void deleteFollow(Map<String, Object> followId) throws DataAccessException;
	
	// 팔로우 리스트
	public List<MemberDomain> followerList(Map<String, Object> followIds) throws DataAccessException;
	
	// 팔로우 id 리스트
	public List<String> followerIdList(Map<String, Object> followIds) throws DataAccessException;
	
	// 팔로잉 리스트
	public List<MemberDomain> followingList(Map<String, Object> followId) throws DataAccessException;
	
	// 팔로잉 체크
	public List<Map<String, String>> checkFollow(Map<String, Object> followId) throws DataAccessException;

	// 게시판이나 상대방 페이지에서 팔로우 여부 체크
	public String checkBoardFollow(Map<String, Object> followIds) throws DataAccessException;

	// 팔로잉 id 리스트
	public List<String> followingIdList(Map<String, Object> followIds) throws DataAccessException;

	// 팔로우 체크
	public List<Map<String, String>> checkfollowing(Map<String, Object> followIdListMap) throws DataAccessException;

	public int followCount(String memberId) throws DataAccessException;

	public int followingCount(String memberId) throws DataAccessException;
	
}
