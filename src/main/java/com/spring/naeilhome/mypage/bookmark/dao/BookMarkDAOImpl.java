package com.spring.naeilhome.mypage.bookmark.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;

@Repository("bookMarkDAO")
public class BookMarkDAOImpl implements BookMarkDAO{
	
	@Autowired
    private SqlSession sqlSession;
	
    @Autowired
    private MyhomeDomain myhomeDomain;

    
    // 목록 조회
	@Override
	public List<MyhomeDomain> selectBookMarkList(Map<String, Object> pagingMap) throws DataAccessException {
		List<MyhomeDomain> myhomeList = sqlSession.selectList("mapper.bookMark.selectBookMarkList", pagingMap);
		return myhomeList;
	}
	
	// 총 글 수
	@Override
	public int selectTotArticle(String memberId)  throws DataAccessException {
	return sqlSession.selectOne("mapper.bookMark.selectTotArticle", memberId);
	}

	// 선택 삭제
	@Override
	public void deleteMyBookMarkList(Map<String, Object> deleteBookMark) throws DataAccessException {
		sqlSession.delete("mapper.bookMark.deleteMyBookMarkList", deleteBookMark);
	}
	
    // 북마크
	@Override
	public String isBookmark(Map<String, Object> bookCheck) throws DataAccessException {
		return sqlSession.selectOne("mapper.bookMark.isBookmark", bookCheck);
	}

	// 북마크 삭제
	@Override
	public void deleteBookmark(Map<String, Object> bookCheck) throws DataAccessException {
		sqlSession.delete("mapper.bookMark.deleteBookmark", bookCheck);
	}

	// 북마크 추가
	@Override
	public void addBookmark(Map<String, Object> bookCheck) throws DataAccessException {
		sqlSession.update("mapper.bookMark.addBookmark", bookCheck);
	}

}
