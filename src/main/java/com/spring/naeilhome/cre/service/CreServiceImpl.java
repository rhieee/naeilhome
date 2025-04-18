package com.spring.naeilhome.cre.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.naeilhome.cre.dao.CreDAO;
import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;

@Service("creService")
public class CreServiceImpl implements CreService{
	
	@Autowired
	CreDAO creDAO;
	
	// CRE 신청한 상품 정보 (임현규)
	@Override
	public DeliveryDomain creProductApplication(Map<String, Object> map) throws Exception {
		return creDAO.creProductApplication(map);
	}
	
	// CRE DB에 데이터 추가(임현규)
	@Override
	public void addCre(Map<String, Object> map) throws Exception {
		creDAO.addCre(map);
	}
	
	// CRE DB에 이미지파일명 추가(임현규)
	@Override
	public void addCreImage(List<MultipartFile> list, Map<String, Object> map) throws Exception {
		Map<String, Object> map1 = new HashMap<>();
		for(MultipartFile m : list) {
			map1.put("imageFilename", m.getOriginalFilename());
			map1.put("memberId", map.get("memberId"));
			map1.put("orderNo", map.get("orderNo"));
			map1.put("productNo", map.get("productNo"));
			creDAO.addCreImage(map1);
		}
	}
	
	// 이미지 로컬에 저장할 때 쓰일 구분번호 (임현규)
	@Override
	public int creCount() throws Exception {
		return creDAO.creCount();
	}

}
