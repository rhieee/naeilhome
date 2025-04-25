package com.spring.naeilhome.board.board_myhome.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

@Repository("myhomeDAO")
public class MyhomeDAOImpl implements MyhomeDAO {

    @Autowired
    private SqlSession sqlSession;
    @Autowired
    private MyhomeDomain myhomeDomain;


    @Override
    public List selectAllArticlesList(int startPage, int endPage) throws DataAccessException {
    	
    	 Map<String, Object> pages = new HashMap<>();
    	 	pages.put("startPage", startPage);
    	 	pages.put("endPage", endPage);
    	
    	List<MyhomeDomain> myhomeList = sqlSession.selectList("mapper.board.selectAllArticlesList",pages);
    	System.out.println("myhomeList 조회 결과: " + myhomeList);
    	return myhomeList;
    	}

	@Override
	public void addArticleMyHome(MyhomeDomain myhomeDomain) throws DataAccessException {
		sqlSession.insert("mapper.board.addArticleMyHome", myhomeDomain);
	}
	
	@Override
	public void CoverImagePath(int newArticle, String fileName) {
        Map<String, Object> imageMap = new HashMap<>();
        imageMap.put("articleNo", newArticle);
        imageMap.put("imageFilename", fileName);       
                
        try {
        	// DB에 이미 존재하는 아티클 넘버인지 확인
        	int countArticleNo = sqlSession.selectOne("mapper.board.coverImageArticleNo", imageMap);
        	
        	if(countArticleNo == 0) { 
	        	sqlSession.insert("mapper.board.coverImagePath", imageMap);
	            System.out.println("insert성공 " + fileName);
        	} else { 
        		sqlSession.update("mapper.board.coverImageSamePath", imageMap); 
        		System.out.println("update성공 " + fileName);
        	}
        	
        }catch (Exception e) {
            e.printStackTrace();  
        }
    }
	
	@Override
	public String getCoverImageName(int aticleNo) throws DataAccessException {
	    String CoverImageName = sqlSession.selectOne("mapper.board.getCoverImageName",aticleNo);
	    System.out.println(CoverImageName);
	    return CoverImageName;
	}
	

	@Override
	public MyhomeDomain selectMyHome(int boardMyhomeArticleNo) throws DataAccessException {
		myhomeDomain = sqlSession.selectOne("mapper.board.selectMyHome", boardMyhomeArticleNo);
		return myhomeDomain;
	}
	
	@Override
	public int selectNewMyHomeNO() throws DataAccessException {
		return sqlSession.selectOne("mapper.board.selectNewMyHomeNO");
	}

	@Override
	public void deleteMyHome(int boardMyhomeArticleNo) throws DataAccessException {
		sqlSession.delete("mapper.board.deleteMyHome", boardMyhomeArticleNo);
	}
	
	@Override
	public void updateArticle(MyhomeDomain myhomeDomain) throws DataAccessException {
		sqlSession.update("mapper.board.updateArticle", myhomeDomain);
	}
	
	// 닉네임 조회
    public String checkNickName(String memberId) throws DataAccessException{
        return sqlSession.selectOne("mapper.board.checkNickName", memberId);

    }
    
    // 게시글 별 댓글 수 조회
    @Override
    public List<MyhomeDomain> getTotalReplys() throws DataAccessException {
    return sqlSession.selectList("mapper.board.totalReply");
    }
    
    // 총 글 수 조회
    @Override
    public int totalArticles() throws DataAccessException {
    	return sqlSession.selectOne("mapper.board.totalAtricles");
    	}
	
	// 필터 검색
    @Override
    public List filterArticles(String sortType, String housingType, String homeSize) throws DataAccessException {
    	
    	 Map<String, Object> filterList = new HashMap<>();
	    	 filterList.put("boardMyhomeHousingType", housingType);
	    	 filterList.put("sortType", sortType);
	    	 filterList.put("boardMyhomeHomeSize", homeSize);
    	
    	List<MyhomeDomain> myhomeList = sqlSession.selectList("mapper.board.selectFilterArticlesList",filterList);
    	System.out.println("myhomeList 조회 결과: " + myhomeList);
    	return myhomeList;
    	}
    
 // 상품검색 저장
 	@Override
 	public void addMyhomeProd(int newArticle,List<String> productNames) throws DataAccessException {
 		
 		 Map<String, Object> prodNames = new HashMap<>();
 		 prodNames.put("boardMyhomeArticleNO", newArticle);
 		 prodNames.put("productName", productNames);

 		sqlSession.insert("mapper.board.addMyhomeProd", prodNames);		
 	}
 	
 	// 상품검색 가져오기
 	@Override
     public List<MyhomeDomain> getProdName(int boardMyhomeArticleNo) throws DataAccessException {
 		
 		List<MyhomeDomain> productInfo = sqlSession.selectList("mapper.board.getProdName",boardMyhomeArticleNo);
     	System.out.println("productName 조회 결과: " + productInfo);
     	return productInfo;
 	}
 	
 	// 상품검색 삭제
 	@Override
 	public void deleteMyhomeProd(int boardMyhomeArticleNo) throws DataAccessException {
 		sqlSession.delete("mapper.board.deleteMyhomeProd", boardMyhomeArticleNo);		
 	}

	
}
