package com.spring.naeilhome.board.board_myhome.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.naeilhome.board.board_myhome.dao.MyhomeDAO;
import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

@Service("myhomeService")
@Transactional(propagation = Propagation.REQUIRED)
public class MyhomeServiceImpl implements MyhomeService{

	@Autowired
	private MyhomeDAO myhomeDAO;
	
	@Autowired
	private MyhomeDomain myhomeDomain;
	
	@Override
	public boolean addArticleMyHome(MyhomeDomain myhomeDomain) throws Exception{
		try {
			myhomeDAO.addArticleMyHome(myhomeDomain);
			return true;	
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("게시글 DB저장 중 오류 발생");
			return false;	
		}
	}
	
	@Override
	public String coverImageUpload(int newArticle, MultipartFile file) throws Exception {
		 try {
	    // 파일 저장 경로 설정
	    String uploadDir = null;
	    if(System.getProperty("os.name").toLowerCase().contains("win")) {
	    	uploadDir = "C:\\naeilhome\\board\\board_myhome\\coverImage\\" + newArticle;
	    }else {
	    	uploadDir = "/home/ubuntu/naeilhome-img/board/board_myhome/coverImage/" + newArticle;	    	
	    }
	    File directory = new File(uploadDir);

	    // 폴더가 존재하지 않으면 자동으로 생성
	    if (!directory.exists()) {
	        directory.mkdirs();
	    }

	    // 파일 이름 가져오기
	    String fileName = file.getOriginalFilename();
	    File saveFile = new File(directory, fileName);

	    file.transferTo(saveFile); // 파일 저장

        // 파일 경로 DB 저장
        String filePath = saveFile.getAbsolutePath();
        myhomeDAO.CoverImagePath(newArticle, fileName);

        return "success";
	    } catch (IOException e) {
	        e.printStackTrace();
	        return "fail";
	    }
}

	 @Override
	 public String getCoverImageName(int aticleNo) throws Exception {
		 return myhomeDAO.getCoverImageName(aticleNo);
	 }
	
	 @Override
	 public List<MyhomeDomain> listArticles(int startPage,int endPage) throws Exception {		 
	      
		List<MyhomeDomain> myhomeList = myhomeDAO.selectAllArticlesList(startPage,endPage); // 게시글 조회
		List<MyhomeDomain> totalReplyList = myhomeDAO.getTotalReplys(); // 각 게시글 댓글개수 조회
	      
		 for (MyhomeDomain article : myhomeList) { // 모든 게시글 꺼내서
		    article.setTotalReply(0);
		    for (MyhomeDomain replyData : totalReplyList) {  // 모든 댓글 개수확인
		       // 게시글의 넘버와 댓글이 달린 게시글의 넘버가 같은경우
		       if (article.getBoardMyhomeArticleNo() == replyData.getBoardMyhomeArticleNo()) {
		       // 댓글개수를 'reply의 댓글개수'로 설정
		       article.setTotalReply(replyData.getTotalReply());
		       break;
		       }
		    }
		 }
		 return myhomeList;
		 }

	@Override
	public MyhomeDomain selectMyHome(int boardMyhomeArticleNo) throws Exception {
		myhomeDomain = myhomeDAO.selectMyHome(boardMyhomeArticleNo);
		return myhomeDomain;
	}
	
	@Override
	public int selectNewMyHomeNO() throws Exception {
		return myhomeDAO.selectNewMyHomeNO();
	}

	@Override
	public void deleteMyHome(int boardMyhomeArticleNo) throws Exception {
		myhomeDAO.deleteMyHome(boardMyhomeArticleNo);
		myhomeDAO.deleteMyhomeProd(boardMyhomeArticleNo);
	}
	
	@Override
	public void modArticle(MyhomeDomain myhomeDomain) throws Exception {
		myhomeDAO.updateArticle(myhomeDomain);
	}
		
	// 닉네임 조회
    public String checkNickName(String memberId) throws Exception{
        return myhomeDAO.checkNickName(memberId);
    }
        
    // 총 글 수 조회
    @Override
    public int totalArticles() throws Exception {
    	return myhomeDAO.totalArticles();
    }
		
    // 필터 검색
	@Override
	public List<MyhomeDomain> filterArticles(String sortType, String housingType, String homeSize) throws Exception {		 
		List<MyhomeDomain> myhomeList = myhomeDAO.filterArticles(sortType,housingType,homeSize);
		return myhomeList; // 게시글 조회
	}
		 
	// 나의 상품 서버저장
	@Override
	public void addMyhomeProd(int newArticle,List<String> productNames) throws Exception {
	    myhomeDAO.addMyhomeProd(newArticle,productNames);
	}
	        
	// 나의 상품 가져오기   
	@Override
	public List<MyhomeDomain> getProdName(int boardMyhomeArticleNo) throws Exception {		 
		return myhomeDAO.getProdName(boardMyhomeArticleNo);
	}
	
	// 나의 상품 업데이트
	@Override
	public void updateMyhomeProd(int newArticle,List<String> productNames) throws Exception {		
		// 기존 내용 모두 삭제 
		myhomeDAO.deleteMyhomeProd(newArticle);
		
		// 상품이 하나 이상 있을 때만 insert
	    if (productNames != null && !productNames.isEmpty()) {
	        myhomeDAO.addMyhomeProd(newArticle, productNames);
	    }
	}

}
