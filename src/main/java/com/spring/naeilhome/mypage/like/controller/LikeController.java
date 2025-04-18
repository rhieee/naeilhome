package com.spring.naeilhome.mypage.like.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.like.service.LikeService;

@Controller("likeController")
@RequestMapping("/mypage/like")
public class LikeController {
	
	@Autowired
	MyhomeDomain myhomeDomain;
	@Autowired
	LikeService likeService;
	
	// 게시글 리스트 출력 - 송현오
    @RequestMapping(value = "/likeList.do", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView myHomelist(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
    	String memberId = memberDomain.getMemberId();
    	
    	String _section = request.getParameter("section"); //사용자가 볼 게시글수
    	String _pageNum = request.getParameter("pageNum"); //페이지번호
    	
    	int section = Integer.parseInt(((_section == null) ? "1" : _section));
    	int pageNum = Integer.parseInt(((_pageNum == null) ? "1" : _pageNum));
    	
    	//페이징
    	int pageSize = 9; //한페이지에 보여줄 게시글수
    	int startRow = (pageNum-1) * pageSize+1; //시작
    	int endRow = pageNum * pageSize;         //마지막
    	
    	//Map
    	Map<String, Object> pagingMap = new HashMap<>();
    	pagingMap.put("section", section);
    	pagingMap.put("pageNum", pageNum);
    	pagingMap.put("memberId", memberId);
    	pagingMap.put("startRow", startRow); //시작행
    	pagingMap.put("endRow", endRow);     //끝행
    	
    	Map<String, Object> myhomeMap = likeService.selectLikeList(pagingMap); // 게시글 조회
        int likeCount = likeService.likeCount(memberId); // 좋아요 수 조회
        
        // 총 게시글 수 계산, 기본값 설정
    	int totalArticles = 0;
    	if (myhomeMap.get("totalArticles") != null) {
    	    totalArticles = (int) myhomeMap.get("totalArticles");
    	}
    	// 총 페이지 수 계산
    	int totalPages = (int) Math.ceil((double) totalArticles / pageSize); 
        
        ModelAndView mav = new ModelAndView("/mypage/like/likeList");
        mav.addObject("myhomeMap", myhomeMap); // "myhomeMap"라는 이름으로 데이터를 JSP로 전달
        mav.addObject("likeCount", likeCount);
        mav.addObject("section", section);
        mav.addObject("memberId", memberId);
        mav.addObject("totalPages", totalPages); // 총페이지수 값을 추가
        return mav;
	}
    
    //좋아요수 - 송현오
  	@RequestMapping(value = "/likes.do", method = {RequestMethod.GET, RequestMethod.POST})
  	public String likes(@RequestParam("boardMyhomeArticleNo") int boardMyhomeArticleNo, 
  	  			HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
  	        
  	System.out.println("좋아요 요청 들어온 게시물번호: " + boardMyhomeArticleNo);
  	        
  	//로그인 여부 확인
  	MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
  	if(memberDomain == null) {
  	return "redirect:/member/loginForm.do";
  	}
  	//세션에서 아이디 가져오기
  	String memberId = memberDomain.getMemberId();
  	System.out.println("좋아요 테이블에 추가될 아이디: "+ memberId);
  	        
  	//좋아요 여부확인 후 -> 추가 또는 취소 할거야
  	boolean isLiked = likeService.isLiked(boardMyhomeArticleNo, memberId);
  	if(isLiked) {
  		likeService.deleteLikes(boardMyhomeArticleNo, memberId);
  	} else {
  		likeService.addLikes(boardMyhomeArticleNo, memberId);
  	}
  	        
  	//좋아요 수 조회
  	int boardMyhomeLikes = likeService.likesList(boardMyhomeArticleNo);
  	        
  	// jsp에 넘겨줄것
  	// Flash Attribute로 값 전달 (URL에 노출되지 않음)
  	redirectAttributes.addFlashAttribute("boardMyhomeLikes", boardMyhomeLikes);
  	redirectAttributes.addFlashAttribute("isLiked", !isLiked);
  	
  	// 총 좋아요 수
 	int likeTotal = likeService.likeTotal(memberId);
 	session.setAttribute("likeTotal", likeTotal);

  	// 해당 게시글상세페이지로 리다이렉트 (어디로?: myHomeSelect.jsp 여기로)
  	return "redirect:/board/board_myhome/myHomeSelect.do?boardMyhomeArticleNo=" + boardMyhomeArticleNo;
  	}
}
