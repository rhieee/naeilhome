package com.spring.naeilhome.cre.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;

public interface CreService {
	
	public DeliveryDomain creProductApplication(Map<String, Object> map) throws Exception;
	public void addCre(Map<String, Object> map) throws Exception;
	public void addCreImage(List<MultipartFile> list, Map<String, Object> map) throws Exception;
	public int creCount() throws Exception;

}
