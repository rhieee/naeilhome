package com.spring.naeilhome.mypage.wishlist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.product.domain.ProductDomain;

@Repository("wishListDAO")
public class WishListDAOImpl implements WishListDAO{
	
	@Autowired
	private SqlSession sqlSession;

	// 좋아요 총 글 수
	@Override
	public int allwishListCount(String memberId) throws DataAccessException {
		return sqlSession.selectOne("mapper.wishList.allwishListCount", memberId); 
	}

	// 좋아요 리스트
	@Override
	public List<ProductDomain> wishList(Map<String, Object> map) throws DataAccessException {
		return sqlSession.selectList("mapper.wishList.wishList", map);
	}

	// 선택 삭제
	@Override
	public void deleteWishLists(Map<String, Object> deleteWishList) throws DataAccessException {
		sqlSession.delete("mapper.wishList.deleteWishLists", deleteWishList);
	}
	
	// 찜하기
	@Override
	public String isWishList(Map<String, Object> wishListCheck) throws DataAccessException {
		return sqlSession.selectOne("mapper.wishList.isWishList", wishListCheck);
	}

	// 찜하기 삭제
	@Override
	public void deleteWishList(Map<String, Object> wishListCheck) throws DataAccessException {
		sqlSession.delete("mapper.wishList.deleteWishList", wishListCheck);
	}

	// 찜하기 추가
	@Override
	public void addWishList(Map<String, Object> wishListCheck) throws DataAccessException {
		sqlSession.update("mapper.wishList.addWishList", wishListCheck);
	}

}
