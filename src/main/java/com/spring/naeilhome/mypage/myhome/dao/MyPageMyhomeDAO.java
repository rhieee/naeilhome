package com.spring.naeilhome.mypage.myhome.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.mypage.myhome.domain.MyPageMyhomeDomain;

public interface MyPageMyhomeDAO {

	public List<MyPageMyhomeDomain> selectMyArticlesList(Map<String, Object> pagingMap)  throws DataAccessException;
	public int selectTotArticle(String memberId)  throws DataAccessException;
	public Map<String, String> yourIdInfo(String yourId) throws DataAccessException;
}
