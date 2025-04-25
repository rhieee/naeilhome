package com.spring.naeilhome.mypage.follow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.follow.service.FollowService;

@Controller("followController")
@RequestMapping("/mypage/follow")
public class FollowController {

	@Autowired
	MemberDomain memberDomain;

	@Autowired
	FollowService followService;
	
	// 팔로워 리스트 - 송현오
	@RequestMapping("/followerList.do")
	public String followerList(HttpSession session, Model model) {

		// 세션에 있는 상대방 정보 지우기
		session.removeAttribute("yourIdInfo");

		// 세션에서 현재 로그인 아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		// 맵 생성
		Map<String, Object> followId = new HashMap<>();

		// 멤버 아이디 넣기
		followId.put("memberId", memberId);

		try {
			// checkFollow 팔로우 체크, followList 명단
			if (followService.followList(followId) != null) {
				Map<String, Object> followLists = followService.followList(followId);
				model.addAttribute("followLists", followLists);

				System.out.println("followLists 어떤 식으로 들어 오니?" + followLists);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/mypage/follow/follower";
	}

//	// 팔로우 하기, 팔로우 취소하기
//	@RequestMapping(value="/follow.do", method=RequestMethod.POST)
//	public String follower(@RequestParam("followId") String followId,
//	                       HttpSession session) throws Exception {
//	    
//	    System.out.println("followId야 들어 옴? " + followId);
//	    
//	    // 세션에서 현재 로그인 아이디 가져오기
//	    MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
//	    String memberId = memberDomain.getMemberId();
//	    
//	    // 맵에 회원 아이디와 팔로우 아이디 넣기
//	    Map<String, Object> followIds = new HashMap<>();
//	    followIds.put("followId", followId);
//	    followIds.put("memberId", memberId);
//	    
//	    // 팔로우 상태 확인
//	    boolean isFollowing = false;
//	    
//	    if(followService.followList(followIds) != null) {
//	    
//	    // {checkFollow=[{FOLLOWERID=naeilhome, CHECKFOLLOW=true}], followerList=[com.spring.naeilhome.member.domain.MemberDomain@7c804655]}
//	    Map<String, Object> checkFollowList = followService.followList(followIds);
//	    
//	    // 위에서 checkFollow이거 꺼낸 거
//		List<Map<String, String>> checkFollows = (List<Map<String, String>>) checkFollowList.get("checkFollow");
//	    
//		System.out.println("checkFollowList 들어오니? " + checkFollowList);
//		System.out.println("checkFollows 들어오니? " + checkFollows);
//		
//	    // checkFollows에서 현재 팔로우 상태 확인
//	    for (Map<String, String> followInfo : checkFollows) {
//	        if (followInfo.get("FOLLOWERID").equals(followId)) {
//	            isFollowing = Boolean.parseBoolean(followInfo.get("CHECKFOLLOW"));
//	            break;
//	        }
//	    }
//	    
//	    try {
//	        if (isFollowing) {
//	            // 언팔
//	            followService.deleteFollow(followIds);
//	        } else {
//	            // 팔로우
//	            followService.addFollow(followIds);
//	        }
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    
//	    }
//	    return "/mypage/follow/follower";
//	}

	// 게시판에서나 상대방 페이지에서 팔로우 팔로잉 클릭할때 추가, 삭제 - 송현오
	@ResponseBody
	@RequestMapping(value = "/follow.do", method = RequestMethod.POST)
	public String boardfollow(@RequestParam("followId") String followId, HttpSession session, Model model)
			throws Exception {

		// 세션에서 현재 로그인 아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		// 맵에 회원 아이디와 팔로우 아이디 넣기
		Map<String, Object> followIds = new HashMap<>();
		followIds.put("followId", followId);
		followIds.put("memberId", memberId);

		String checkBoardFollow = "false";

		if (followService.checkBoardFollow(followIds) != null) {
			checkBoardFollow = followService.checkBoardFollow(followIds);
		}

		System.out.println("팔로우 컨트롤러에서 checkBoardFollow : " + checkBoardFollow);

		if (checkBoardFollow.equals("true")) {
			// 언팔
			followService.deleteFollow(followIds);

		} else {

			// 팔로우
			followService.addFollow(followIds);
		}

		model.addAttribute("checkBoardFollow", checkBoardFollow);

		// 팔로우 팔로잉 수
		int followCount = followService.followCount(memberId);
		int followingCount = followService.followingCount(memberId);

		session.setAttribute("followCount", followCount);
		session.setAttribute("followingCount", followingCount);

		return "success"; // 리턴할 값이 딱히 없어서..
	}

	// 팔로잉 리스트 - 송현오
	@RequestMapping("/followingList.do")
	public String followingList(HttpSession session, Model model) {

		// 세션에 있는 상대방 정보 지우기
		session.removeAttribute("yourIdInfo");

		// 세션에서 현재 로그인 아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		// 맵 생성
		Map<String, Object> followId = new HashMap<>();

		// 멤버 아이디 넣기
		followId.put("memberId", memberId);

		try {
			List<MemberDomain> followLists = followService.followingList(followId);
			model.addAttribute("followLists", followLists);

			System.out.println("followLists 어떤 식으로 들어 오니?" + followLists);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/mypage/follow/following";
	}

}
