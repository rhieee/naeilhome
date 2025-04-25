package com.spring.naeilhome.board.board_myhome.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

public interface MyhomeDAO {

	public List selectAllArticlesList(int startPage, int endPage) throws DataAccessException;
	public void addArticleMyHome(MyhomeDomain myhomeDomain) throws DataAccessException;
	public void CoverImagePath(int articleNO, String filePath) throws DataAccessException;
	public String getCoverImageName(int aticleNo) throws DataAccessException;
	public MyhomeDomain selectMyHome(int boardMyhomeArticleNo) throws DataAccessException;
	public int selectNewMyHomeNO() throws DataAccessException;
	public void deleteMyHome(int boardMyhomeArticleNo) throws DataAccessException;
	public void updateArticle(MyhomeDomain myhomeDomain) throws DataAccessException;
	public String checkNickName(String memberId) throws DataAccessException;
	public List<MyhomeDomain> getTotalReplys() throws DataAccessException;
	public int totalArticles() throws DataAccessException;
	public List filterArticles(String sortType, String housingType, String homeSize) throws DataAccessException;
	public void addMyhomeProd(int newArticle,List<String> productNames) throws DataAccessException;
	public List<MyhomeDomain> getProdName(int boardMyhomeArticleNo) throws DataAccessException;
	public void deleteMyhomeProd(int boardMyhomeArticleNo) throws DataAccessException;
	
}
