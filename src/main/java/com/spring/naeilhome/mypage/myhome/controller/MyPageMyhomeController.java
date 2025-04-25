package com.spring.naeilhome.mypage.myhome.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.bookmark.service.BookMarkService;
import com.spring.naeilhome.mypage.follow.service.FollowService;
import com.spring.naeilhome.mypage.like.service.LikeService;
import com.spring.naeilhome.mypage.myhome.service.MyPageMyhomeService;
import com.spring.naeilhome.mypage.wishlist.service.WishListService;

@Controller("myPageMyhomeController")
@RequestMapping("/mypage/myhome")
public class MyPageMyhomeController {

	@Autowired
	MyhomeDomain myhomeDomain;

	@Autowired
	MyPageMyhomeService myPageMyhomeService;

	@Autowired
	LikeService likeService;

	@Autowired
	private WishListService wishListService;

	@Autowired
	BookMarkService bookMarkService;

	@Autowired
	FollowService followService;

	// 게시글 리스트 출력 - 송현오
	@RequestMapping(value = "/myPageMyHomeList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView myHomelist(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		session.removeAttribute("yourIdInfo");

		// 멤버아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		String _section = request.getParameter("section"); // 사용자가 볼 게시글수
		String _pageNum = request.getParameter("pageNum"); // 페이지번호
		int section = Integer.parseInt(((_section == null) ? "1" : _section));
		int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
		// 페이징
		int pageSize = 9; // 한페이지에 보여줄 게시글수
		int startRow = (pageNum - 1) * pageSize + 1; // 시작
		int endRow = pageNum * pageSize; // 마지막

		// Map
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("section", section);
		pagingMap.put("pageNum", pageNum);
		pagingMap.put("memberId", memberId);
		pagingMap.put("startRow", startRow); // 시작
		pagingMap.put("endRow", endRow); // 끝

		Map<String, Object> myhomeMap = myPageMyhomeService.listArticles(pagingMap); // 조회
		int likeCount = likeService.likeCount(memberId); // 좋아요 수 조회(표시하려고)

		// 총 좋아요 수
		int likeTotal = likeService.likeTotal(memberId);
		session.setAttribute("likeTotal", likeTotal);

		// 북마크 수
		int bookMarkTotal = bookMarkService.selectTotArticle(memberId);
		session.setAttribute("bookMarkTotal", bookMarkTotal);

		// 찜 수
		int wishListTotal = wishListService.allwishListCount(memberId);
		session.setAttribute("wishListTotal", wishListTotal);

		// 팔로우 팔로잉 수
		int followCount = followService.followCount(memberId);
		int followingCount = followService.followingCount(memberId);

		session.setAttribute("followCount", followCount);
		session.setAttribute("followingCount", followingCount);

		// 총 게시글 수 계산, 기본값 설정
		int totalArticles = 0;
		if (myhomeMap.get("totalArticles") != null) {
			totalArticles = (int) myhomeMap.get("totalArticles");
		}
		// 총 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalArticles / pageSize);

		ModelAndView mav = new ModelAndView("/mypage/myhome/myPageMyHomeList");
		mav.addObject("myhomeMap", myhomeMap); // "myhomeMap"라는 이름으로 JSP에 전달
		mav.addObject("likeCount", likeCount); // 좋아요수(게시글에서 표시하려고)
		mav.addObject("section", section);
		mav.addObject("memberId", memberId);
		mav.addObject("totalPages", totalPages); // 총페이지수 값을 추가

		return mav;
	}

	// 너의 게시글 리스트 출력 - 송현오
	@RequestMapping(value = "/yourPageMyHomeList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView yourMyHomelist(@RequestParam("yourId") String yourId, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		session.removeAttribute("yourIdInfo");

		// 멤버아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = null;
		if (memberDomain != null) {
		    memberId = memberDomain.getMemberId();
		}

		// 상대방 아이디 확인
		System.out.println("yourId 왔니?" + yourId);

		if (memberId == null || !memberId.equals(yourId)) {
			// 상대방 정보 조회
			Map<String, String> yourIdInfo = myPageMyhomeService.yourIdInfo(yourId);
			System.out.println("상대방 정보 들어왔니?" + yourIdInfo);
			session.setAttribute("yourIdInfo", yourIdInfo);

			String checkBoardFollow = "false";
			
			if(memberId != null) {
			// 맵에 회원 아이디와 팔로우 아이디 넣기
			Map<String, Object> followIds = new HashMap<>();
			followIds.put("followId", yourId);
			followIds.put("memberId", memberId);


			if (followService.checkBoardFollow(followIds) != null) {
				checkBoardFollow = followService.checkBoardFollow(followIds);
			}
			}
			session.setAttribute("checkBoardFollow", checkBoardFollow);
		}

		String _section = request.getParameter("section"); // 사용자가 볼 게시글수
		String _pageNum = request.getParameter("pageNum"); // 페이지번호
		int section = Integer.parseInt(((_section == null) ? "1" : _section));
		int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
		// 페이징
		int pageSize = 9; // 한페이지에 보여줄 게시글수
		int startRow = (pageNum - 1) * pageSize + 1; // 시작
		int endRow = pageNum * pageSize; // 마지막

		// Map
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("section", section);
		pagingMap.put("pageNum", pageNum);
		pagingMap.put("memberId", yourId);
		pagingMap.put("startRow", startRow); // 시작
		pagingMap.put("endRow", endRow); // 끝

		Map<String, Object> myhomeMap = myPageMyhomeService.listArticles(pagingMap); // 조회
		int likeCount = likeService.likeCount(yourId); // 좋아요 수 조회(표시하려고)

		// 북마크 수
		int bookMarkTotal = bookMarkService.selectTotArticle(yourId);
		session.setAttribute("bookMarkTotal", bookMarkTotal);

		// 찜 수
		int wishListTotal = wishListService.allwishListCount(yourId);
		session.setAttribute("wishListTotal", wishListTotal);

		// 총 게시글 수 계산, 기본값 설정
		int totalArticles = 0;
		if (myhomeMap.get("totalArticles") != null) {
			totalArticles = (int) myhomeMap.get("totalArticles");
		}
		// 총 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalArticles / pageSize);

		ModelAndView mav = new ModelAndView("/mypage/myhome/yoruPageMyHomeList");
		mav.addObject("myhomeMap", myhomeMap); // "myhomeMap"라는 이름으로 JSP에 전달
		mav.addObject("likeCount", likeCount); // 좋아요수(게시글에서 표시하려고)
		mav.addObject("section", section);
		mav.addObject("memberId", yourId);
		mav.addObject("totalPages", totalPages); // 총페이지수 값을 추가

		return mav;
	}
}
