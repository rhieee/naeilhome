package com.spring.naeilhome.main.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.main.domain.MainDomain;

@Repository("mainDAO")
public class MainDAOImpl implements MainDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<MainDomain> selectNewProducts() {
		return sqlSession.selectList("mapper.main.selectNewProducts");
	}

	@Override
	public List<MainDomain> selectBestBoardPosts() {
		return sqlSession.selectList("mapper.main.selectBestBoardPosts");
	}

	@Override
	public List<MainDomain> selectBestProducts() {
		return sqlSession.selectList("mapper.main.selectBestProducts");
	}

	@Override
	public List<MainDomain> searchProducts(String keyword) {
		return sqlSession.selectList("mapper.main.searchProducts", keyword);
	}

	@Override
	public List<MainDomain> searchBoardArticles(String keyword) {
		return sqlSession.selectList("mapper.main.searchBoardArticles", keyword);
	}

	@Override
	public List<String> autoComplete(String keyword) {
		return sqlSession.selectList("mapper.main.autoCompleteSearch", keyword);
	}
}
