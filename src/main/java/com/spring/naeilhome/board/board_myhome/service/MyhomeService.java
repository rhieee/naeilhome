package com.spring.naeilhome.board.board_myhome.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

public interface MyhomeService {

	public boolean addArticleMyHome(MyhomeDomain myhomeDomain) throws Exception;
	public String coverImageUpload(int articleNo, MultipartFile file) throws Exception;
	public String getCoverImageName(int aticleNo) throws Exception;
	public List<MyhomeDomain> listArticles(int section,int pageNo) throws Exception;
	public int totalArticles() throws Exception ;
	public MyhomeDomain selectMyHome(int boardMyhomeArticleNo) throws Exception;
	public int selectNewMyHomeNO()  throws Exception;
	public void deleteMyHome(int boardMyhomeArticleNo) throws Exception;
	public void modArticle(MyhomeDomain myhomeDomain) throws Exception;
	public String checkNickName(String memberId) throws Exception;
	public List<MyhomeDomain> filterArticles(String sortType, String housingType, String homeSize) throws Exception;
	public void addMyhomeProd(int newArticle,List<String> productNames) throws Exception;
	public List<MyhomeDomain> getProdName(int boardMyhomeArticleNo) throws Exception;
	public void updateMyhomeProd(int newArticle,List<String> productNames) throws Exception;
}