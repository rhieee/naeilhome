package com.spring.naeilhome.mypage.point.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.point.domain.PointDomain;
import com.spring.naeilhome.mypage.point.service.PointService;

@Controller
@RequestMapping("/mypage/point")
public class PointController {

	@Autowired
	private PointService pointService;

	@RequestMapping(value = "/pointList.do", method = RequestMethod.GET)
	public String pointList(HttpSession session, Model model) {
		// 세션에서 MemberDomain 객체를 가져옴
		MemberDomain member = (MemberDomain) session.getAttribute("member");

		if (member != null) {
			// 객체에서 memberId 추출
			String memberId = member.getMemberId();
			PointDomain point = pointService.getPointByMemberId(memberId);
			List<PointDomain> plusHistory = pointService.getPointPlusHistory(memberId);
			List<PointDomain> minusHistory = pointService.getPointMinusHistory(memberId);
			List<PointDomain> reviewPoint = pointService.getSelectPointReview(memberId);
			List<PointDomain> newGood = pointService.getNewMembergood(memberId);

			// 통합 리스트
			List<PointDomain> totalHistory = new ArrayList<>();

			// plus 내역 > 공통 필드에 매핑
			for (PointDomain pd : plusHistory) {
				pd.setHistoryDate(pd.getOrderJoinDate());
				pd.setHistoryType("[구매확정]");
				pd.setHistoryContent(pd.getProductName());
				pd.setPointChange("+" + pd.getProductPoint() + " P");
				totalHistory.add(pd);
			}

			// minus 내역 > 공통 필드에 매핑
			for (PointDomain pd : minusHistory) {
				pd.setHistoryDate(pd.getOrderDate());
				pd.setHistoryType("[포인트 사용]");
				pd.setHistoryContent(pd.getProductName());
				pd.setPointChange("-" + pd.getProductPoint() + " P");
				totalHistory.add(pd);
			}

			// 리뷰 작성 내역 > 공통 필드에 매핑
			for (PointDomain pd : reviewPoint) {
				pd.setHistoryDate(pd.getReviewUpdated());
				pd.setHistoryType("[리뷰작성]");
				// 리뷰 내용이 10자 이상이면 자르고 '...'
				String contents = pd.getReviewContents();
				if (contents == null) { // null 체크
					contents = "";	// 리뷰 작성시 리뷰내용 없으면 공백처리
				} else if (contents.length() > 20) {
					contents = contents.substring(0, 20) + "...";
				}
				pd.setHistoryContent(contents);
				pd.setPointChange("+150 P");
				totalHistory.add(pd);
			}

			// 회원가입 내역 > 공통 필드에 매핑
			for (PointDomain pd : newGood) {
				pd.setHistoryDate(pd.getMemberJoindate());
				pd.setHistoryType("[회원가입]");
				pd.setHistoryContent("회원가입");
				pd.setPointChange("+1000 P");
				totalHistory.add(pd);
			}

			// totalHistory를 historyDate 기준으로 내림차순 정렬
			Collections.sort(totalHistory, new Comparator<PointDomain>() {
				@Override
				public int compare(PointDomain o1, PointDomain o2) {
					// 날짜가 null일 가능성이 없다면 바로 compareTo
					return o2.getHistoryDate().compareTo(o1.getHistoryDate());
					// 최신 날짜가 먼저 오도록 내림차순
				}
			});

			model.addAttribute("point", point);
			model.addAttribute("plusHistory", plusHistory);
			model.addAttribute("minusHistory", minusHistory);
			model.addAttribute("reviewPoint", reviewPoint);
			model.addAttribute("newGood", newGood);
			model.addAttribute("totalHistory", totalHistory); // 통합 리스트
		} else {
			return "redirect:/member/loginForm.do";
		}
		return "/mypage/point/pointList";
	}

}
