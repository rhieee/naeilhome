package com.spring.naeilhome.board.board_notice.service;

import java.util.List;

import com.spring.naeilhome.board.board_notice.domain.NoticeDomain;

public interface NoticeService {
	
	public List<NoticeDomain> noticeList() throws Exception;

}
