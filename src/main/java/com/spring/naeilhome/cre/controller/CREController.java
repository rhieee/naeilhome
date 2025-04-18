package com.spring.naeilhome.cre.controller;

import java.io.File;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.cre.service.CreService;
import com.spring.naeilhome.mypage.delivery.domain.DeliveryDomain;

@Controller
@RequestMapping("/cre")
public class CREController {
	
	@Autowired
	CreService creService;
	@Autowired
	DeliveryDomain deliveryDomain;
	
	final String CRE_IMAGE = "C:\\naeilhome\\cre_image";
	
	// CRE 작성 페이지 (임현규)
	@RequestMapping("/creForm.do")
	public ModelAndView creForm(@RequestParam Map<String, Object> map) throws Exception {
		ModelAndView mav = new ModelAndView("/cre/creForm");
		deliveryDomain = creService.creProductApplication(map);
		mav.addObject("deliveryList", deliveryDomain);
		mav.addObject("creStatement", map.get("creStatement"));
		return mav;
	}
	
	// CRE 이미지업로드 및 DB에 데이터 추가 (임현규)
	@RequestMapping(value = "/addCre.do", method=RequestMethod.POST)
	public ResponseEntity addCre(@RequestParam("imageFile") List<MultipartFile> multipartFile, @RequestParam Map<String, Object> map, 
			HttpServletRequest requ) throws Exception {
		boolean fileHaveResult = false;
		String creStatement = null;
		int creCount = creService.creCount() + 1;
		for(MultipartFile m : multipartFile) {
			String fileName = m.getOriginalFilename();
			if(!fileName.trim().isEmpty()) {
				File file = null;
				if(System.getProperty("os.name").toLowerCase().contains("win")) {					
					file = new File(CRE_IMAGE + "\\" + creCount + "\\" + fileName);
				}else {
					file = new File("/home/ubuntu/naeilhome-img/cre_image/" + creCount + "/" + fileName);
				}
				InputStream in = m.getInputStream();
				FileUtils.copyInputStreamToFile(in, file);
				fileHaveResult = true;
			}
		}
		creStatement = (String)map.get("creType");
		if(!creStatement.equals("취소")) {
			creStatement += "신청";
		}
		map.put("creStatement", creStatement);
		creService.addCre(map);
		if(fileHaveResult) {
			creService.addCreImage(multipartFile, map);			
		}
		ResponseEntity res = null;
		String msg = "<script>";
        msg += " alert('"+creStatement+"이(가) 되었습니다.');";
        msg += " location.href='/mypage/delivery/deliveryList.do'; ";
        msg += " </script>";
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("Content-Type", "text/html; charset=utf-8");
        res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
		return res;
	}

}
