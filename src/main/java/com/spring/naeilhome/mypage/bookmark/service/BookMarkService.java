package com.spring.naeilhome.mypage.bookmark.service;

import java.util.List;
import java.util.Map;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

public interface BookMarkService {

	public Map<String, Object> selectBookMarkList(Map<String, Object> pagingMap) throws Exception;
	public int selectTotArticle(String memberId) throws Exception;
	public void deleteMyBookMarkList(Map<String, Object> deleteBookMark) throws Exception;
	public String isBookmark(int boardMyhomeArticleNo, String memberId, String check) throws Exception;
}
