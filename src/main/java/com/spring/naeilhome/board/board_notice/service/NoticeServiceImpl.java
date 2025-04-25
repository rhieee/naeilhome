package com.spring.naeilhome.board.board_notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.board.board_notice.dao.NoticeDAO;
import com.spring.naeilhome.board.board_notice.domain.NoticeDomain;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{
	
	@Autowired
	NoticeDAO noticeDAO;
	
	// 공지사항 목록 - 임현규
	@Override
	public List<NoticeDomain> noticeList() throws Exception {
		return noticeDAO.noticeList();
	}

}
