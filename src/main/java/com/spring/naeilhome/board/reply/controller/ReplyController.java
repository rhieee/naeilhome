package com.spring.naeilhome.board.reply.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.board.reply.domain.ReplyDomain;
import com.spring.naeilhome.board.reply.service.ReplyService;
import com.spring.naeilhome.member.domain.MemberDomain;

@Controller("replyController")
@RequestMapping("/board/reply")
public class ReplyController {
	
	@Autowired
	ReplyDomain replyDomain;
	
	@Autowired
	ReplyService replyService;
	
	// 댓글 작성
	// 21 닉네임 삭제하고 도메인 및 마이바티스 업글
	@RequestMapping(value="/addReply.do", method=RequestMethod.POST)
	@ResponseBody
	public void addReply(@RequestParam("reply") String replyContents, 
						 @RequestParam("boardMyhomeArticleNo") int boardMyhomeArticleNo,HttpSession session) throws Exception {

		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();
		
		replyDomain.setBoardMyhomeArticleNo(boardMyhomeArticleNo);
		replyDomain.setMemberId(memberId);
		replyDomain.setReplyContents(replyContents);
		
		System.out.println(replyContents);
		System.out.println(boardMyhomeArticleNo);
		System.out.println(memberId);
		
		replyService.addReply(replyDomain);
	}
	
	// 댓글 조회
	@RequestMapping(value="/replyList.do", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public void replylist(@RequestParam("boardMyhomeArticleNo") int boardMyhomeArticleNo,
						  @RequestParam(value="section", defaultValue = "1") int section, // section, pageNum 값이 없을 경우 1로 초기화 하기.
			              @RequestParam(value="pageNum", defaultValue = "1") int pageNum,
						  HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// Map 생성해서 section, pageNum 넣어주기
		Map<String, Integer> paging = new HashMap<>();
		paging.put("section", section);
		paging.put("pageNum", pageNum);
		paging.put("boardMyhomeArticleNo", boardMyhomeArticleNo);
		
		List<ReplyDomain> replyList = replyService.replyList(paging); // 게시글 조회
				
		// 페이징 정보 불러오기
		replyDomain = replyService.pagingInfo(pageNum, boardMyhomeArticleNo);
				
		// JSON 객체 생성
	    JSONObject data = new JSONObject();		
	    int totalReplys = replyDomain.getTotalReplys();
	    data.put("totalReplys", totalReplys); // 총 글 수
	    System.out.println("totalReplys" + replyDomain.getTotalReplys());
	    
	    int totalPages = replyDomain.getTotalPages();
	    data.put("totalPages", totalPages); // 총 페이지 수
	    System.out.println("totalPages" + replyDomain.getTotalPages());	
	    
	    int startPage = replyDomain.getStartPage();
	    data.put("startPage", startPage); // 시작 페이지
	    System.out.println("startPage" + replyDomain.getStartPage());	
	    
	    int endPage = replyDomain.getEndPage();
	    data.put("endPage", endPage); // 끝 페이지
	    System.out.println("endPage" + replyDomain.getEndPage());	
				
	    data.put("replyList", replyList);
				
	    data.put("section", section);
	    System.out.println("section 받았니?" + section);	
	    
	    data.put("pageNum", pageNum);
	    System.out.println("pageNum 받았니?" + pageNum);	
	    
	    
	    System.out.println("댓글 리스트" + replyList);
	    System.out.println("가져오나?" + boardMyhomeArticleNo);
	    
	    // 응답 설정
	    response.setContentType("application/json"); // json타입으로
	    response.setCharacterEncoding("UTF-8"); // utf-8로 안하면 외계어 나옴.
	    response.getWriter().write(data.toString()); // 스트링 타입으로 변환해서 JSON 데이터 전송
	}	

	// 대댓글 추가
	// 21 닉네임 삭제하고 도메인 및 마이바티스 업글
	@RequestMapping(value="/addRereply.do", method=RequestMethod.POST)
	@ResponseBody
	public void addRereply(@RequestParam("rereplyContents") String replyContents, 
			 					  @RequestParam("replyNo") int replyNo,
			 					  @RequestParam("boardMyhomeArticleNo") int boardMyhomeArticleNo,
			 					  HttpSession session) throws Exception {
		
		System.out.println("응답 왔냐?");
		System.out.println("replyContents 받았냐 ?: " + replyContents); // 글 내용
		System.out.println("replyNo 받았냐 ?: " + replyNo); // 부모 번호
		System.out.println("boardMyhomeArticleNo 받았냐 ?: " + boardMyhomeArticleNo); // 원글 번호
		
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();
		
		replyDomain.setMemberId(memberId);
		replyDomain.setReplyParentNo(replyNo);
		replyDomain.setBoardMyhomeArticleNo(boardMyhomeArticleNo);
		replyDomain.setReplyContents(replyContents);

		replyService.addRereply(replyDomain);
		
	}
	
	// 삭제
	@RequestMapping(value="/deleteRereply.do", method=RequestMethod.POST)
	@ResponseBody
	public void deleteRereply(@RequestParam("replyNo") int replyNo) throws Exception {
		
		System.out.println("replyNo 받았냐 ?: " + replyNo); // 글 번호
		
		replyService.deleteRereply(replyNo);
		
	}
	
	// 수정
	@RequestMapping(value="/modRereply.do", method=RequestMethod.POST)
	@ResponseBody
	public void modRereply(@RequestParam("replyNo") int replyNo,
							  @RequestParam("updateRereplyContents") String replyContents) throws Exception {
		
		System.out.println("replyNo 받았냐 ?: " + replyNo); // 글 번호
		System.out.println("replyContents 받았냐 ?: " + replyContents); // 글 내용
		
		replyDomain.setReplyNo(replyNo);
		replyDomain.setReplyContents(replyContents);
		
		replyService.modRereply(replyDomain);
		
	}
	
}
