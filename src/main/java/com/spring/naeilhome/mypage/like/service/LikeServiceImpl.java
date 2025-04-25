package com.spring.naeilhome.mypage.like.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.mypage.like.dao.LikeDAO;
import com.spring.naeilhome.mypage.myhome.domain.MyPageMyhomeDomain;

@Service("likeService")
public class LikeServiceImpl implements LikeService{
	
	@Autowired
	private LikeDAO likeDAO;
	@Autowired
	private MyhomeDomain myhomeDomain;

	@Override
	public Map<String, Object> selectLikeList(Map<String, Object> pagingMap) throws Exception {
		
		System.out.println("안녕 난 서비스 이제 페이징을 보내볼게?? 내가 답이 없으면 못 온거야");

		Map<String, Object> articlesMap = new HashMap();
		List<MyPageMyhomeDomain> articlesList = likeDAO.selectLikeList(pagingMap); //게시글목록
		
		String memberId = (String) pagingMap.get("memberId");
		int totalArticles = likeDAO.selectTotArticle(memberId); // 전체 게시글 수 count

		articlesMap.put("articlesList", articlesList);
		articlesMap.put("totalArticles", totalArticles);

		return articlesMap;
	}

	@Override
	public int likeCount(String memberId) throws Exception {
		return likeDAO.likeCount(memberId);
	}
	
	//조회수 증가
	@Override
	public int countUp(int boardMyhomeArticleNo, HttpSession session) throws Exception {
		// 세션에 "viewed"라는 이름의 데이터를 가져옴, 없으면 밑에서 저장됨
		Set<Integer> viewed = (Set<Integer>) session.getAttribute("viewed");

		// 세션에 아무것도 없으면 "viewed"저장
		if (viewed == null) {
			viewed = new HashSet<>();
			session.setAttribute("viewed", viewed);
        }
		// 있으면 조회했는지 확인
		if (viewed.contains(boardMyhomeArticleNo)) {
			System.out.println("이미 조회한 글입니다.");
		} else {
			System.out.println("조회수가 증가됩니다.");
			viewed.add(boardMyhomeArticleNo);
			likeDAO.countUp(boardMyhomeArticleNo);
        }
		return boardMyhomeArticleNo;
	}
	
	// 좋아요 여부 있는지 조회
	public boolean isLiked(int boardMyhomeArticleNo, String memberId) {
		return likeDAO.isLiked(boardMyhomeArticleNo, memberId) > 0;
	}
	// 좋아요 추가
	public void addLikes(int boardMyhomeArticleNo, String memberId) {
		likeDAO.addLikes(boardMyhomeArticleNo, memberId);
		likeDAO.upLikes(boardMyhomeArticleNo);
	}
	// 좋아요 삭제
	public void deleteLikes(int boardMyhomeArticleNo, String memberId) {
		likeDAO.deleteLikes(boardMyhomeArticleNo, memberId);
		likeDAO.downLikes(boardMyhomeArticleNo);
	}
	// 좋아요 수 조회
	public int likesList(int boardMyhomeArticleNo) {
		return likeDAO.likesList(boardMyhomeArticleNo);
	}
	
	// 좋아요 체크
	public String likeChcek(Map<String, Object> likeChcekMap) throws Exception{
		return likeDAO.likeChcek(likeChcekMap);
	}

	// 사이드 바에 띄울 총 좋아요 수
	@Override
	public int likeTotal(String memberId) throws Exception {
		return likeDAO.likeTotal(memberId);
	}
}
