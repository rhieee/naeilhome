package com.spring.naeilhome.mypage.bookmark.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.mypage.bookmark.dao.BookMarkDAO;

@Service("bookMarkService")
public class BookMarkServiceImpl implements BookMarkService{
	
	@Autowired
	private BookMarkDAO bookMarkDAO;
	 
	@Autowired
	private MyhomeDomain myhomeDomain;

	
	// 목록 조회
	@Override
	public Map<String, Object> selectBookMarkList(Map<String, Object> pagingMap) throws Exception {
		

		Map<String, Object> articlesMap = new HashMap<>();
		List<MyhomeDomain> articlesList = bookMarkDAO.selectBookMarkList(pagingMap); //게시글목록
		
		String memberId = (String) pagingMap.get("memberId");
		int totalArticles = selectTotArticle(memberId); // 전체 게시글 수 count

		
		articlesMap.put("articlesList", articlesList);
		articlesMap.put("totalArticles", totalArticles);

		return articlesMap;
	}

	// 총 개수
	@Override
	public int selectTotArticle(String memberId) throws Exception {
		return bookMarkDAO.selectTotArticle(memberId);
	}

	// 북마크 선택 삭제
	@Override
	public void deleteMyBookMarkList(Map<String, Object> deleteBookMark) throws Exception {
		bookMarkDAO.deleteMyBookMarkList(deleteBookMark);
	}
	
	 // 북마크
	@Override
	public String isBookmark(int boardMyhomeArticleNo, String memberId, String check) throws Exception {
		
		Map<String, Object> bookCheck = new HashMap<>();
		
		bookCheck.put("boardMyhomeArticleNo", boardMyhomeArticleNo);
		bookCheck.put("memberId", memberId);
		
		String isBookMark = bookMarkDAO.isBookmark(bookCheck);
		
		System.out.println("isBookMark : " + isBookMark);
	
		if(check.equals("no")) {
		if(isBookMark.equals("nobook")) {
			addBookmark(bookCheck);
		}else {
			deleteBookmark(bookCheck);}
		}
		
		return isBookMark;
	}
	
	// 북마크 삭제
	private void deleteBookmark(Map<String, Object> bookCheck) {
		bookMarkDAO.deleteBookmark(bookCheck);
	}
	
	// 북마크 추가
	private void addBookmark(Map<String, Object> bookCheck) {
		bookMarkDAO.addBookmark(bookCheck);
	}
	
	
	

}
