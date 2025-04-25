package com.spring.naeilhome.main.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.main.dao.MainDAO;
import com.spring.naeilhome.main.domain.MainDomain;

@Service("mainService")
public class MainServiceImpl implements MainService {

	@Autowired
	private MainDAO mainDAO;

	@Override
	public List<MainDomain> getNewProducts() {
		return mainDAO.selectNewProducts();
	}

	@Override
	public List<MainDomain> getBestBoardPosts() {
		return mainDAO.selectBestBoardPosts();
	}

	@Override
	public List<MainDomain> getBestProducts() {
		return mainDAO.selectBestProducts();
	}

	@Override
	public List<MainDomain> searchProducts(String keyword) {
		return mainDAO.searchProducts(keyword);
	}

	@Override
	public List<MainDomain> searchBoardArticles(String keyword) {
		return mainDAO.searchBoardArticles(keyword);
	}

	@Override
	public List<String> autoComplete(String keyword) {
		return mainDAO.autoComplete(keyword);
	}
}