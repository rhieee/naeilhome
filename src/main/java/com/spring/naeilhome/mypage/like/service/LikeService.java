package com.spring.naeilhome.mypage.like.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;


public interface LikeService {

	int likeCount(String memberId) throws Exception;
	
	public Map<String, Object> selectLikeList(Map<String, Object> pagingMap) throws Exception;
	public String likeChcek(Map<String, Object> likeChcekMap) throws Exception;
	public boolean isLiked(int boardMyhomeArticleNo, String memberId);
	public void addLikes(int boardMyhomeArticleNo, String memberId);
	public void deleteLikes(int boardMyhomeArticleNo, String memberId);
	public int likesList(int boardMyhomeArticleNo);
	public int countUp(int boardMyhomeArticleNo, HttpSession session) throws Exception;
	int likeTotal(String memberId) throws Exception;
	

}
