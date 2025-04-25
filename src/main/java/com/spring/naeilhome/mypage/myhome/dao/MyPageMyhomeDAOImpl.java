package com.spring.naeilhome.mypage.myhome.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.mypage.myhome.domain.MyPageMyhomeDomain;

@Repository("myPageMyhomeDAO")
public class MyPageMyhomeDAOImpl implements MyPageMyhomeDAO {
	
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private MyhomeDomain myhomeDomain;

	@Override  //게시글
	public List<MyPageMyhomeDomain> selectMyArticlesList(Map<String, Object> pagingMap)  throws DataAccessException {
	List<MyPageMyhomeDomain> articlesList = sqlSession.selectList("mapper.myBoard.selectMyArticlesList", pagingMap);
	return articlesList;
	}
	@Override  //페이지 수 count
	public int selectTotArticle(String memberId)  throws DataAccessException {
	int totArticles = sqlSession.selectOne("mapper.myBoard.selectTotArticle", memberId);
	return totArticles;
	}
	@Override
	public Map<String, String> yourIdInfo(String yourId) throws DataAccessException {
		return sqlSession.selectOne("mapper.myBoard.yourIdInfo", yourId);
	}

}
