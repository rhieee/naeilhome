package com.spring.naeilhome.mypage.bookmark.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.bookmark.service.BookMarkService;

@Controller
@RequestMapping("/mypage/bookmark")
public class BookMarkController {

	@Autowired
	MyhomeDomain myhomeDomain;

	@Autowired
	BookMarkService bookMarkService;

	// 목록 조회 - 송현오
	@RequestMapping(value = "/bookMarkList.do", method = RequestMethod.GET)
	public ModelAndView myBookMarkList(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		// 북마크 숫자를 세션에 담기
		int bookMarkTotal = bookMarkService.selectTotArticle(memberId);
		session.setAttribute("bookMarkTotal", bookMarkTotal);

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
		pagingMap.put("startRow", startRow); // 시작행
		pagingMap.put("endRow", endRow); // 끝행

		Map<String, Object> myhomeMap = bookMarkService.selectBookMarkList(pagingMap); // 게시글 조회

		// 총 게시글 수 계산, 기본값 설정
		int totalArticles = 0;
		if (myhomeMap.get("totalArticles") != null) {
			totalArticles = (int) myhomeMap.get("totalArticles");
		}

		// 총 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalArticles / pageSize);

		ModelAndView mav = new ModelAndView("/mypage/bookmark/bookMarkList");
		mav.addObject("myhomeMap", myhomeMap); // "myhomeMap"라는 이름으로 데이터를 JSP로 전달
		mav.addObject("section", section);
		mav.addObject("memberId", memberId);
		mav.addObject("totalPages", totalPages); // 총페이지수 값을 추가

		return mav;
	}

	// 선택 삭제 - 송현오
	@RequestMapping(value = "/deleteMyBookMarkLists.do", method = RequestMethod.POST)
	public String deleteMyBookMarkList(HttpSession session, @RequestBody String checkedValArray) throws Exception {

		// 제이슨으로 객체에 담기
		JSONObject jsonObject = new JSONObject(checkedValArray);

		// 제이슨 객체에 있는거 배열로 바꾸기
		JSONArray checkedVal = jsonObject.getJSONArray("checkedVal");

		// 배열에 담기
		List<Integer> checkedVals = new ArrayList<>();

		// 하나씩 빼보기
		for (int i = 0; i < checkedVal.length(); i++) {
			checkedVals.add(checkedVal.getInt(i));
		}

		// 리스트에 잘 들어 갓나 확인.
		for (int asd : checkedVals) {
			System.out.println("리스트에 잘 들어갔니? " + asd);
		}

		// 세션에서 아이디 가져오고 맵에 선택한 글 번호들과 아이디 저장
		Map<String, Object> deleteBookMark = new HashMap<>();

		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		deleteBookMark.put("memberId", memberId);
		deleteBookMark.put("checkedVals", checkedVals);

		bookMarkService.deleteMyBookMarkList(deleteBookMark);

		return "/mypage/bookmark/bookMarkList";
	}

	// 북마크 추가 - 송현오
	@RequestMapping(value = "/bookMark.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bookMark(@RequestParam("boardMyhomeArticleNo") int boardMyhomeArticleNo, HttpSession session)
			throws Exception {

		System.out.println("북마크 확인 : " + boardMyhomeArticleNo);

		// 세션에서 아이디 가져오기
		if ((MemberDomain) session.getAttribute("member") != null) {
			MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
			String memberId = memberDomain.getMemberId();

			// no는 북마크 추가,삭제 작업, yes는 리스트 조회할때 북마크 여부만 가져오기
			String check = "no";

			// 북마크 여부 확인하여 추가 삭제
			bookMarkService.isBookmark(boardMyhomeArticleNo, memberId, check);

			// 북마크 숫자를 세션에 담기
			int bookMarkTotal = bookMarkService.selectTotArticle(memberId);
			session.setAttribute("bookMarkTotal", bookMarkTotal);
		}

		return "redirect:/board/board_myhome/myHomeSelect.do?boardMyhomeArticleNo=" + boardMyhomeArticleNo;
	}

}
