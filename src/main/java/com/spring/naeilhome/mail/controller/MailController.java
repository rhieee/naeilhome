package com.spring.naeilhome.mail.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.naeilhome.mail.service.MailService;
import com.spring.naeilhome.member.service.MemberService;

@Controller("mailController")
@RequestMapping("/mail")
public class MailController {
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private MemberService memberService;
	
	// 인증번호 저장할 맵
	private Map<String, Integer> authNumbers = new HashMap<>();

	// 이메일 보낼 양식 + 인증번호 생성 + 전송
    @RequestMapping(value="/mailCheck.do", method=RequestMethod.POST)
    @ResponseBody
    public String joinEmail(@RequestParam Map<String,Object> map) throws Exception {

        System.out.println("메일 보낼 주소 들어옴? " + map.get("memberEmail1") + "@" + map.get("memberEmail2"));
        
        // COUNT로 뽑아서 중복된게 없으면 0 있으면 1 이상
        int useEmailCount = memberService.useEmail(map);

        JSONObject ob = new JSONObject();

        if(useEmailCount == 0) {
            // 인증번호 가져오기
            int authNumber = mailService.makeRandomNumber();

            String setFrom = "gami_project@naver.com"; // 발신자
            String toMail = map.get("memberEmail1") + "@" + map.get("memberEmail2");
            String title = "내일의 집 인증 이메일 입니다."; // 제목

            // HTML 형식으로 이메일 작성
            String content = 
                    "내일의 집 인증 이메일 입니다." +
                            "<br><br>" + 
                            "인증 번호는 <h3>" + authNumber + "</h3>입니다." + 
                            "<br>" + 
                            "인증번호 확인란에 기입해 주세요.";

            // 이메일 발송
            mailService.mailSend(setFrom, toMail, title, content);

            // 인증번호를 이메일과 함께 맵에 저장
            authNumbers.put(toMail, authNumber);
        }
        

        ob.append("useEmailCount", useEmailCount);

        return ob.toString();
    }
    
 // 이메일 보낼 양식 + 인증번호 생성 + 전송
//비밀번호찾기 (1이상)
    @RequestMapping(value="/mailCheck2.do", method=RequestMethod.POST)
    @ResponseBody
    public String joinEmail2(@RequestParam Map<String,Object> map) throws Exception {

        System.out.println("메일 보낼 주소 들어옴? " + map.get("memberEmail1") + "@" + map.get("memberEmail2"));
        
        // COUNT로 뽑아서 중복된게 없으면 0 있으면 1 이상
        int useEmailCount = memberService.useEmail(map);

        JSONObject ob = new JSONObject();

        if(useEmailCount > 0) {
            // 인증번호 가져오기
            int authNumber = mailService.makeRandomNumber();

            String setFrom = "gami_project@naver.com"; // 발신자
            String toMail = map.get("memberEmail1") + "@" + map.get("memberEmail2");
            String title = "내일의 집 인증 이메일 입니다."; // 제목

            // HTML 형식으로 이메일 작성
            String content = 
                    "내일의 집 인증 이메일 입니다." +
                            "<br><br>" + 
                            "인증 번호는 <h3>" + authNumber + "</h3>입니다." + 
                            "<br>" + 
                            "인증번호 확인란에 기입해 주세요.";

            // 이메일 발송
            mailService.mailSend(setFrom, toMail, title, content);

            // 인증번호를 이메일과 함께 맵에 저장
            authNumbers.put(toMail, authNumber);
        }
        

        ob.append("useEmailCount", useEmailCount);

        return ob.toString();
    }
    
    // 인증번호 비교 확인
    @RequestMapping(value="/authNumberCheck.do", method=RequestMethod.POST)
    public ResponseEntity<String> authNumberCheck(@RequestParam String email, @RequestParam int authNumber) {
    	
        Integer authNumberCheck = authNumbers.get(email); // 저장된 인증번호 가져오기
        
        if (authNumberCheck != null && authNumberCheck.equals(authNumber)) {
            // 인증 성공 시 맵 비우기
            authNumbers.clear();
            
            return new ResponseEntity<>("인증 성공", HttpStatus.OK);
        } else {
        	
            return new ResponseEntity<>("인증 실패", HttpStatus.BAD_REQUEST);
        }
    }
			
			
}
