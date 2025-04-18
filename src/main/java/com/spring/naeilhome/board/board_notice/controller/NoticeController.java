package com.spring.naeilhome.board.board_notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.board.board_notice.domain.NoticeDomain;
import com.spring.naeilhome.board.board_notice.service.NoticeService;

@Controller("noticeController")
@RequestMapping("/board/board_notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	@Autowired
	NoticeDomain noticeDomain;
	
	// 공지사항 목록 - 임현규
    @RequestMapping("/noticeMain.do")
    public ModelAndView noticeMain() throws Exception {
    	ModelAndView mav = new ModelAndView("/board/board_notice/noticeMain");
    	List<NoticeDomain> noticeList = noticeService.noticeList();
    	mav.addObject("noticeList", noticeList);
    	return mav;
    }

}
