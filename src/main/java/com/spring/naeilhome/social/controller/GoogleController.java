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
import com.spring.naeilhome.social.service.GoogleService;

@Controller("googleController")
@RequestMapping("/google")
public class GoogleController {

	@Value("${api.google.api-key}")
	private String CLIENT_ID;
	
	@Value("${api.google.secret-key}")
	private String CLIENT_SECRET;
	
    private final String REDIRECT_URI = "http://52.78.56.248:8080/google/callback.do";

    @Autowired
    private GoogleService googleService;

    @Autowired
    private MemberDomain member;

    @Autowired
    private MemberController memberController;

    // Google 로그인 URL 생성
    @GetMapping("/login.do")
    public String googleLogin() throws UnsupportedEncodingException {
        String state = UUID.randomUUID().toString();
        String loginUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                + "?response_type=code"
                + "&client_id=" + CLIENT_ID
                + "&redirect_uri=" + java.net.URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&scope=" + "email profile"
                + "&state=" + state;

        return "redirect:" + loginUrl;
    }

    // Google callback 처리
    @GetMapping("/callback.do")
    public ModelAndView googleCallback(@RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView();

        // Google OAuth 토큰 요청
        String accessToken = googleService.getAccessToken(code, CLIENT_ID, CLIENT_SECRET, REDIRECT_URI);

        // 세션에 access token 저장
        session.setAttribute("accessToken", accessToken);

        // 유저 정보 가져오기
        Map<String, Object> userInfo = googleService.getUserInfo(accessToken);

        member.setMemberId((String) userInfo.get("memberId"));
        member.setMemberEmail1((String) userInfo.get("email"));
        member.setMemberEmail2("socialGoogle");

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

	 
    // Google 연동 해제
    @PostMapping("/memberDelete.do")
    public String unlinkGoogleAccount(@RequestParam("memberId") String memberId, HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
    	
        // 세션에 저장된 accessToken과 refreshToken를 가져오기
        String accessToken = (String) session.getAttribute("accessToken");
        String refreshToken = (String) session.getAttribute("refreshToken"); // 리프레시 토큰 가져오기

        if (accessToken == null || accessToken.isEmpty()) {
            if (refreshToken != null && !refreshToken.isEmpty()) {
                // 리프레시 토큰을 사용하여 새로운 액세스 토큰 발급
                accessToken = googleService.getAccessTokenUsingRefreshToken(refreshToken);

                if (accessToken != null) {
                    // 새로운 액세스 토큰을 세션에 저장
                    session.setAttribute("accessToken", accessToken);
                } else {
                	System.out.println("refreshToken을 사용한 accessToken 발급 실패");
                }
            } else {
            	System.out.println("accessToken과 refreshToken이 존재x");
            }
        }

        // Google 연동 해제 요청
        boolean unlinkSuccess = googleService.unlinkGoogleAccount(accessToken);
        // accessToken 삭제 요청
        googleService.revokeToken(accessToken);

        if (unlinkSuccess) {
            System.out.println("Google 연동 해제 성공");

            // 회원 탈퇴
            memberController.deleteMember(memberId, session);

            redirectAttributes.addFlashAttribute("socialMessage", "Google 연동 해제 및 탈퇴되었습니다.");
            return "redirect:/";
        } else {
            System.out.println("Google 연동 해제 실패");
            return "redirect:/";
        }

    }
	 
}