package com.spring.naeilhome.mypage.like.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.mypage.myhome.domain.MyPageMyhomeDomain;

public interface LikeDAO {

	public List<MyPageMyhomeDomain> selectLikeList(Map<String, Object> pagingMap) throws DataAccessException;

	public int likeCount(String memberId) throws DataAccessException;
	
	public int selectTotArticle(String memberId)  throws DataAccessException;
	
	public int countUp(int boardMyhomeArticleNo) throws DataAccessException;
	public int isLiked(int boardMyhomeArticleNo, String memberId) throws DataAccessException;
	public void addLikes(int boardMyhomeArticleNo, String memberId) throws DataAccessException;
	public void upLikes(int boardMyhomeArticleNo) throws DataAccessException;
	public void deleteLikes(int boardMyhomeArticleNo, String memberId) throws DataAccessException;
	public void downLikes(int boardMyhomeArticleNo) throws DataAccessException;
	public int likesList(int boardMyhomeArticleNo) throws DataAccessException;
	public String likeChcek(Map<String, Object> likeChcekMap) throws DataAccessException;
	public int likeTotal(String memberId) throws DataAccessException;

}
