package com.spring.naeilhome.board.board_notice.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.board.board_notice.domain.NoticeDomain;

public interface NoticeDAO {
	
	public List<NoticeDomain> noticeList() throws DataAccessException;

}
