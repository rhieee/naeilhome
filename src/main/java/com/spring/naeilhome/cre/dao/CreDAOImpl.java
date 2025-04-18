package com.spring.naeilhome.cre.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;

@Repository("creDAO")
public class CreDAOImpl implements CreDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	// CRE 신청한 상품 정보(임현규)
	@Override
	public DeliveryDomain creProductApplication(Map<String, Object> map) throws DataAccessException {
		return sqlSession.selectOne("mapper.delivery.creProductApplication", map);
	}
	
	// CRE DB에 데이터 추가(임현규)
	@Override
	public void addCre(Map<String, Object> map) throws DataAccessException{
		sqlSession.insert("mapper.cre.addCre", map);
	}
	
	// CRE DB에 이미지파일명 추가(임현규)
	@Override
	public void addCreImage(Map<String, Object> map) throws DataAccessException {
		sqlSession.insert("mapper.cre.addCreImage",map);
	}
	
	// CRE 전체 count(임현규)
	@Override
	public int creCount() throws DataAccessException {
		return sqlSession.selectOne("mapper.cre.creCount");
	}
	
}
