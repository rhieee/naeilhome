package com.spring.naeilhome.mypage.bookmark.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

@Repository("bookMarkDAO")
public interface BookMarkDAO {

	public List<MyhomeDomain> selectBookMarkList(Map<String, Object> myhomeMap) throws DataAccessException;
	public int selectTotArticle(String memberId)  throws DataAccessException;
	public void deleteMyBookMarkList(Map<String, Object> deleteBookMark) throws DataAccessException;
	public String isBookmark(Map<String, Object> bookCheck) throws DataAccessException;
	public void deleteBookmark(Map<String, Object> bookCheck) throws DataAccessException;
	public void addBookmark(Map<String, Object> bookCheck) throws DataAccessException;
	
}
