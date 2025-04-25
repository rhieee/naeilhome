package com.spring.naeilhome.social.controller;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.naeilhome.member.controller.MemberController;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.social.service.NaverService;

@Controller("naverController")
@RequestMapping("/naver")
public class NaverController {
	
	@Value("${api.naver.client-id}")
	private String CLIENT_ID;
	
	@Value("${api.naver.client-secret}")
	private String CLIENT_SECRET;

    private final String REDIRECT_URI = "http://52.78.56.248:8080/naver/callback.do";

    @Autowired
    private NaverService naverService;

    @Autowired
    MemberDomain member;
    
    @Autowired
    MemberController memberController;

    @GetMapping("/login.do")
    public String naverLogin() throws UnsupportedEncodingException {
        String state = UUID.randomUUID().toString();
        String loginUrl = "https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + CLIENT_ID
                + "&redirect_uri=" + java.net.URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&state=" + state;

        return "redirect:" + loginUrl;
    }

    @GetMapping("/callback.do")
    public ModelAndView naverCallback(@RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView();

        // access token과 refresh token 요청
        Map<String, String> tokens = naverService.getTokens(code, CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);
        String accessToken = tokens.get("access_token");
        String refreshToken = tokens.get("refresh_token");

        // 세션에 access token과 refresh token 저장
        session.setAttribute("accessToken", accessToken);
        session.setAttribute("refreshToken", refreshToken);

        // 유저 정보 가져오기
        Map<String, Object> userInfo = naverService.getUserInfo(accessToken);

        member.setMemberId((String) userInfo.get("memberId"));
        member.setMemberEmail1((String) userInfo.get("email"));
        member.setMemberEmail2("socialNaver");

        mav.addObject("member", member);
        mav.addObject("resultMember", userInfo.get("resultMember"));

        if ((boolean) userInfo.get("resultMember")) {
            mav.setViewName("/member/memberForm"); // 회원가입 폼으로 이동
        } else {
            session.setAttribute("member", userInfo.get("m"));
            session.setAttribute("isLogOn", true);
            mav.setViewName("redirect:/"); // 메인 페이지로 이동
        }

        return mav;
    }
    

    
    // 연동해제
    @PostMapping("/memberDelete.do")
    public String unlinkNaverAccount(@RequestParam("memberId") String memberId, HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
    	
        // 세션에 저장된 accessToken과 refreshToken을 가져오기
        String accessToken = (String) session.getAttribute("accessToken");
        String refreshToken = (String) session.getAttribute("refreshToken");
        
        // accessToken이 없으면 refreshToken을 사용하여 새로운 accessToken을 발급받음
        if (accessToken == null || accessToken.isEmpty()) {
            if (refreshToken != null && !refreshToken.isEmpty()) {
            	
                // refreshToken을 사용하여 새로운 accessToken 발급
                accessToken = naverService.getAccessTokenUsingRefreshToken(refreshToken);
                
                if (accessToken != null) {
                    // 새로운 accessToken을 세션에 저장
                    session.setAttribute("accessToken", accessToken);
                } else {
                    System.out.println("refreshToken을 사용한 accessToken 발급 실패");
                }
            } else {
            	 System.out.println("accessToken과 refreshToken이 존재x");
            }
        }

        // 네이버 연동 해제 요청
        boolean unlinkSuccess = naverService.unlinkNaverAccount(accessToken);

        redirectAttributes.addFlashAttribute("socialMessage", "Naver 연동 해제 및 탈퇴되었습니다.");
        if (unlinkSuccess) {
            System.out.println("네이버 연동 해제 성공");

            // 회원 탈퇴
            memberController.deleteMember(memberId, session);
            return "redirect:/";
        } else {
        	System.out.println("네이버 연동 해제 실패");
        	return "redirect:/";
        }
    }
}