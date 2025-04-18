package com.spring.naeilhome.social.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.social.dao.KakaoDAO;

@Service("kakaoService")
public class KakaoService {
	
	@Autowired
	KakaoDAO kakaoDAO;
	@Autowired
	MemberDomain member;
	
	@Value("${api.kakao.rest-key}")
	private String CLIENT_ID;
	
	// 로그인 시도하는 유저의 token 저장
	public Map<String, String> getTokens(String code) {
		
		String accessToken = "";
		String refreshToken = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		Map<String, String> tokens = new HashMap<>();
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			// URL 설정
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			//buffer 스트림 객체 값 세팅 후 요청
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=" + CLIENT_ID);//앱 KEY VALUE
			sb.append("&redirect_uri=http://localhost:8080/kakao/kakao_callback");//앱 callback 경로
			sb.append("&code="+code);
			bw.write(sb.toString());
			bw.flush();
			
			//RETURN 값 result 변수에 저장
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String br_line = "";
			String result = "";
			
			while((br_line = br.readLine()) != null) {
				result += br_line;
			}
			
			System.out.println("TOKEN result : " + result);
			
			JSONObject ob = new JSONObject(result);
			accessToken = ob.getString("access_token");
			refreshToken = ob.getString("refresh_token");
			
			tokens.put("access_token", accessToken);
		    tokens.put("refresh_token", refreshToken);
			
			br.close();
			bw.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return tokens;
	}
	
	// 로그인 시도한 유저의 token을 보내 유저의 정보 가져오기
	public Map getUserInfo(String kakaoAccessToken) {
		Map<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		boolean resultMember = false;
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			
			//요청에 필요한 Header에 포함 될 내용
			conn.setRequestProperty("Authorization", "Bearer " + kakaoAccessToken);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			String br_line = "";
			String result = "";
			
			while((br_line = br.readLine()) != null) {
				result += br_line;
			}
			System.out.println("getUserInfo method result : " + result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			JsonElement idElement = element.getAsJsonObject().get("id");
			String memberId = idElement.getAsString();
			System.out.println("memberId : " + memberId);
			
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			//String memberNickname = properties.getAsJsonObject().get("nickname").getAsString();
			//System.out.println("memberNickname : " + memberNickname);
			String email[] = kakao_account.getAsJsonObject().get("email").getAsString().split("@");
			String emailAll = kakao_account.getAsJsonObject().get("email").getAsString();
			String memberEmail1 = email[0];
			String memberEmail2 = email[1];
			System.out.println("memberEmail1 : " + memberEmail1);
			System.out.println("memberEmail2 : " + memberEmail2);
			
			userInfo.put("memberId", memberId);
			//userInfo.put("memberNickname", memberNickname);
			userInfo.put("memberEmail1", memberEmail1);
			userInfo.put("memberEmail2", memberEmail2);
			userInfo.put("email", emailAll);
			
			member.setMemberId(memberId);
			//member.setMemberNickname(memberNickname);
			member.setMemberEmail1(memberEmail1);
			member.setMemberEmail2(memberEmail2);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		// kakaoMember 테이블 조회
		int resultMemberCount = kakaoDAO.findKakaoMemberCount(userInfo);
		System.out.println("resultMemberCount : " + resultMemberCount);
		// kakaoMember 테이블 조회해서 없나 있나 구분
		if(resultMemberCount == 0) {
			resultMember = true; // 없으면 true
		} else {
			MemberDomain m = kakaoDAO.findKakaoMember(userInfo);
			userInfo.put("m", m);
			resultMember = false; // 있으면 false
		}
		userInfo.put("resultMember", resultMember);
		
		return userInfo;
	}
	
	// refreshToken을 사용하여 새로운 accessToken 발급
	public String getAccessTokenUsingRefreshToken(String refreshToken) {
	    String accessToken = "";
	    String reqURL = "https://kauth.kakao.com/oauth/token";
	    
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        // URL 설정
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        
	        // buffer 스트림 객체 값 세팅 후 요청
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        StringBuilder sb = new StringBuilder();
	        sb.append("grant_type=refresh_token");
	        sb.append("&client_id=" + CLIENT_ID);  
	        sb.append("&refresh_token=" + refreshToken);
	        bw.write(sb.toString());
	        bw.flush();
	        
	        // RETURN 값 result 변수에 저장
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        String br_line = "";
	        String result = "";
	        
	        while ((br_line = br.readLine()) != null) {
	            result += br_line;
	        }
	        
	        System.out.println("result : " + result);
	        
	        JSONObject ob = new JSONObject(result);
	        accessToken = ob.getString("access_token");
	        
	        br.close();
	        bw.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return accessToken;
	}
	
	// 카카오 연동 해제
	public boolean unlinkKakaoAccount(String accessToken) {
	    String reqURL = "https://kapi.kakao.com/v1/user/unlink";
	    boolean success = false;
	    
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        // URL 설정
	        conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        
	        // 요청에 필요한 Header에 포함될 내용
	        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
	        
	        // 반환값 처리
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        
	        String br_line = "";
	        String result = "";
	        
	        while ((br_line = br.readLine()) != null) {
	            result += br_line;
	        }
	        System.out.println("unlink response: " + result);
	        
	        // 카카오 연동 해제 성공 여부 확인
	        if (result.contains("id")) {
	            success = true;
	        }
	        
	        br.close();
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return success;
	}

}
