package com.spring.naeilhome.mypage.myhome.service;

import java.util.List;
import java.util.Map;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

public interface MyPageMyhomeService {

	public Map<String, Object> listArticles(Map<String, Object> pagingMap) throws Exception;

	public Map<String, String> yourIdInfo(String yourId) throws Exception;

}
