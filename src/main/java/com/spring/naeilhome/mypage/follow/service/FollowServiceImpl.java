package com.spring.naeilhome.mypage.follow.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.follow.dao.FollowDAO;
import com.spring.naeilhome.mypage.follow.domain.FollowDomain;

@Service("followService")
public class FollowServiceImpl implements FollowService{

	@Autowired
	FollowDAO followDAO;
	 
	@Autowired
	MemberDomain memberDomain;
	
	@Autowired
	FollowDomain followDomain;

	// 팔로우
	@Override
	public void addFollow(Map<String, Object> followIds) throws Exception {
		followDAO.addFollow(followIds);
	}
	
	// 언팔
	@Override
	public void deleteFollow(Map<String, Object> followIds) throws Exception {
		followDAO.deleteFollow(followIds);
	}

	// 팔로우 리스트
	@Override
	public Map<String, Object> followList(Map<String, Object> followIds) throws Exception {
		
		System.out.println("followIds" + followIds);
		
		// 해당 회원의 팔로워 아이디 리스트
		List<String> followerIdList = followDAO.followerIdList(followIds);
		
		// 회원의 팔로워 아이디 리스트의 정보
		List<MemberDomain> followerList = followDAO.followerList(followIds);
		    
		// 맵 만들어서 팔로우 id 리스트와 맴버 id 담기
		Map<String, Object> followIdListMap = new HashMap<>();
		
		String memberId = (String) followIds.get("memberId");
		
		followIdListMap.put("followerIdList", followerIdList);
		followIdListMap.put("memberId", memberId);
		
		// 해당 맴버 회원의 팔로윙 목록을 조회
		// 팔로윙 목록에 팔로우한 회원이 없다면 false(팔로우 버튼 활성화 핑크색) 있다면 true(팔로잉 버튼으로 회색)
		if(followerIdList != null && !followerIdList.isEmpty()) {
		List<Map<String, String>> checkFollows = followDAO.checkFollow(followIdListMap);	
		
		System.out.println(checkFollows);
		
		Map<String, Object> followLists = new HashMap<>();
		
		followLists.put("checkFollow", checkFollows);
		followLists.put("followerList", followerList);
		
		return followLists;
		
		}else {
			
			return new HashMap<>();
		}
	}

	// 게시판이나 상대방 페이지에서 팔로우 여부 체크
	@Override
	public String checkBoardFollow(Map<String, Object> followIds) throws Exception {
		return followDAO.checkBoardFollow(followIds);
	}

	// 팔로잉 조회
	@Override
	public List<MemberDomain> followingList(Map<String, Object> followIds) throws Exception {
		// 회원의 팔로워 아이디 리스트의 정보
		List<MemberDomain> followerList = followDAO.followingList(followIds);
		return followerList;
	}

	@Override
	public int followCount(String memberId) throws Exception {
		return followDAO.followCount(memberId);
	}

	@Override
	public int followingCount(String memberId) throws Exception {
		return followDAO.followingCount(memberId);
	}
	
	

}
