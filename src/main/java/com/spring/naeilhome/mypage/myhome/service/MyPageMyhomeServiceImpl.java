package com.spring.naeilhome.mypage.myhome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.mypage.myhome.dao.MyPageMyhomeDAO;
import com.spring.naeilhome.mypage.myhome.domain.MyPageMyhomeDomain;

@Service("myPageMyhomeService")
@Transactional(propagation = Propagation.REQUIRED)
//트랜잭셔널
public class MyPageMyhomeServiceImpl implements MyPageMyhomeService {

@Autowired
private MyPageMyhomeDAO myPageMyhomeDAO;
@Autowired
private MyhomeDomain myhomeDomain;
@Autowired
private MyPageMyhomeDomain myPageMyhomeDomain; //이것도

@Override
public Map<String, Object> listArticles(Map<String, Object> pagingMap) throws Exception {
Map<String, Object> articlesMap = new HashMap();

List<MyPageMyhomeDomain> articlesList = myPageMyhomeDAO.selectMyArticlesList(pagingMap); //게시글목록

String memberId = (String) pagingMap.get("memberId");
		
int totalArticles = myPageMyhomeDAO.selectTotArticle(memberId); //전체 게시글 수 count

articlesMap.put("articlesList", articlesList);
articlesMap.put("totalArticles", totalArticles);
		
return articlesMap;
}

@Override
public Map<String, String> yourIdInfo(String yourId) throws Exception {
	return myPageMyhomeDAO.yourIdInfo(yourId);
}
}
