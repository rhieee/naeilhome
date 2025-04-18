package com.spring.naeilhome.board.board_notice.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.board_notice.domain.NoticeDomain;

@Repository("noticeDAO")
public class NoticeDAOImpl implements NoticeDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	// 공지사항 목록 - 임현규
	@Override
	public List<NoticeDomain> noticeList() throws DataAccessException {
		return sqlSession.selectList("mapper.notice.noticeList");
	}

}
