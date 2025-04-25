package com.spring.naeilhome.mypage.like.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.mypage.myhome.domain.MyPageMyhomeDomain;

@Repository("likeDAO")
public class LikeDAOImpl implements LikeDAO{

	@Autowired
    private SqlSession sqlSession;
    @Autowired
    private MyhomeDomain myhomeDomain;
    private MyPageMyhomeDomain myPageMyhomeDomain;
	
	@Override
	public List<MyPageMyhomeDomain> selectLikeList(Map<String, Object> pagingMap) throws DataAccessException {
		List<MyPageMyhomeDomain> myhomeList = sqlSession.selectList("mapper.like.selectLikeList", pagingMap);
		return myhomeList;
	}
	@Override  //페이지 수 count
	public int selectTotArticle(String memberId)  throws DataAccessException {
	int totArticles = sqlSession.selectOne("mapper.like.selectTotArticle", memberId);
	return totArticles;
	}

	@Override
	public int likeCount(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.like.likeCount", memberId);
	}
	
	// 조회수 증가 (sqlSession.update를 통해 매퍼에 접근)
	@Override
	public int countUp(int boardMyhomeArticleNo) throws DataAccessException {
		int result = sqlSession.update("mapper.like.countUp", boardMyhomeArticleNo);
		return result;
	}
	// 좋아요 여부 있는지 조회
	@Override
	public int isLiked(int boardMyhomeArticleNo, String memberId) throws DataAccessException {
		Map<String, Object> params = new HashMap<>();
		params.put("boardMyhomeArticleNo", boardMyhomeArticleNo);
	      params.put("memberId", memberId);
	      return sqlSession.selectOne("mapper.like.isLiked", params);
	}
	// 좋아요 추가
	@Override
	public void addLikes(int boardMyhomeArticleNo, String memberId) throws DataAccessException {
		Map<String, Object> params = new HashMap<>();
		   params.put("boardMyhomeArticleNo", boardMyhomeArticleNo);
		   params.put("memberId", memberId);
		   sqlSession.insert("mapper.like.addLikes", params);
	}
	// 좋아요 증가
	@Override
	public void upLikes(int boardMyhomeArticleNo) throws DataAccessException {
		sqlSession.update("mapper.like.upLikes", boardMyhomeArticleNo);
	}
	// 좋아요 삭제
	@Override
	public void deleteLikes(int boardMyhomeArticleNo, String memberId) throws DataAccessException {
		Map<String, Object> params = new HashMap<>();
	       params.put("boardMyhomeArticleNo", boardMyhomeArticleNo);
	       params.put("memberId", memberId);
	       sqlSession.delete("mapper.like.deleteLikes", params);
	}
	// 좋아요 감소
	@Override
	public void downLikes(int boardMyhomeArticleNo) throws DataAccessException {
		sqlSession.update("mapper.like.downLikes", boardMyhomeArticleNo);
	}
	// 좋아요 수 조회
	@Override
	public int likesList(int boardMyhomeArticleNo) throws DataAccessException {
		return sqlSession.selectOne("mapper.like.likesList", boardMyhomeArticleNo);
	}
	
	// 해당 글 좋아요 체크
	public String likeChcek(Map<String, Object> likeChcekMap) throws DataAccessException{
		return sqlSession.selectOne("mapper.like.likeChcek", likeChcekMap);
	}
	
	// 사이드 바에 띄울 총 좋아요 수
	@Override
	public int likeTotal(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.like.likeTotal", memberId);
	}
}