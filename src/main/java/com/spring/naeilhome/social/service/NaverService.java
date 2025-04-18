package com.spring.naeilhome.social.service;

import org.springframework.http.MediaType;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;


import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.social.dao.NaverDAO;

@Service("naverService")
public class NaverService {

    @Autowired
    NaverDAO naverDAO;
    
    @Autowired
    MemberDomain member;
    
    @Value("${api.naver.client-id}")
	private String CLIENT_ID;
	
	@Value("${api.naver.client-secret}")
	private String CLIENT_SECRET;

// 	HttpHeaders + HttpEntity + RestTemplate 방식
//	public Map<String, String> getTokens(String code, String clientId, String clientSecret, String redirectUri) {
//	    String apiUrl = "https://nid.naver.com/oauth2.0/token";
//
//	    // 요청 파라미터 설정
//	    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//	    params.add("grant_type", "authorization_code");
//	    params.add("client_id", clientId);
//	    params.add("client_secret", clientSecret);
//	    params.add("code", code);
//	    params.add("redirect_uri", redirectUri);
//
//	    // 헤더 설정
//	    HttpHeaders headers = new HttpHeaders();
//	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
//
//	    // HttpEntity에 헤더 + 바디 담기
//	    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
//
//	    RestTemplate restTemplate = new RestTemplate();
//
//	    try {
//	        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, request, String.class);
//
//	        if (response.getStatusCode().is2xxSuccessful()) {
//	            // JSON 파싱
//	            JSONObject json = new JSONObject(response.getBody());
//
//	            Map<String, String> tokens = new HashMap<>();
//	            tokens.put("access_token", json.optString("access_token"));
//	            tokens.put("refresh_token", json.optString("refresh_token"));
//	            return tokens;
//	        } else {
//	            System.out.println("토큰 요청 실패: " + response.getStatusCode());
//	        }
//	    } catch (Exception e) {
//	         System.out.println("토큰 요청 오류 발생", e);
//	    }
//	}
	
	
    // 네이버 Access Token과 refresh_token을 요청
    public Map<String, String> getTokens(String code, String clientId, String clientSecret, String redirectUri) throws IOException {
        String apiUrl = "https://nid.naver.com/oauth2.0/token";
        String params = "grant_type=authorization_code&client_id=" + clientId + 
                        "&client_secret=" + clientSecret + 
                        "&code=" + code + 
                        "&redirect_uri=" + redirectUri;

        URL url = new URL(apiUrl + "?" + params);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setDoOutput(true);
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(5000);

        // 서버로부터 응답 받기
        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        // JSON 파싱하여 access_token과 refresh_token 추출
        JSONObject jsonResponse = new JSONObject(response.toString());
        Map<String, String> tokens = new HashMap<>();
        tokens.put("access_token", jsonResponse.optString("access_token"));
        tokens.put("refresh_token", jsonResponse.optString("refresh_token"));

        return tokens;
    }
// 	HttpHeaders + HttpEntity + RestTemplate 방식    
//    public Map<String, Object> getUserInfo(String accessToken) {
//        Map<String, Object> userInfo = new HashMap<>();
//        boolean resultMember = false;
//
//        String reqURL = "https://openapi.naver.com/v1/nid/me";
//
//        // 헤더 설정
//        HttpHeaders headers = new HttpHeaders();
//        headers.set("Authorization", "Bearer " + accessToken);
//
//        // HttpEntity 생성 (바디는 필요 없으므로 헤더만 전달)
//        HttpEntity<String> entity = new HttpEntity<>(headers);
//
//        RestTemplate restTemplate = new RestTemplate();
//
//        try {
//            ResponseEntity<String> response = restTemplate.exchange(
//                reqURL,
//                HttpMethod.GET,
//                entity,
//                String.class
//            );
//
//            if (response.getStatusCode().is2xxSuccessful()) {
//                String body = response.getBody();
//
//                JSON 파싱
//                JsonParser parser = new JsonParser();
//                JsonObject jsonObject = parser.parse(body).getAsJsonObject();
//                JsonObject res = jsonObject.getAsJsonObject("response");
//
//                String memberId = res.get("id").getAsString();
//                String emailFull = res.get("email").getAsString();
//                String[] emailParts = emailFull.split("@");
//                String memberEmail1 = emailParts[0];
//                String memberEmail2 = emailParts[1];
//
//                // 사용자 정보 저장
//                userInfo.put("memberId", memberId);
//                userInfo.put("email", emailFull);
//                userInfo.put("memberEmail1", memberEmail1);
//                userInfo.put("memberEmail2", memberEmail2);
//
//                member.setMemberId(memberId);
//                member.setMemberEmail1(memberEmail1);
//                member.setMemberEmail2(memberEmail2);
//
//                System.out.println(userInfo.get("memberEmail1"));
//
//            } else {
//                 System.out.println("유저 정보 요청 실패: " + response.getStatusCode());
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        // 여부 확인
//        int resultMemberCount = naverDAO.findNaverMemberCount(userInfo);
//        System.out.println("resultMemberCount : " + resultMemberCount);
//
//        if (resultMemberCount == 0) {
//            resultMember = true;
//        } else {
//            MemberDomain m = naverDAO.findNaverMember(userInfo);
//            userInfo.put("m", m);
//            resultMember = false;
//        }
//
//        userInfo.put("resultMember", resultMember);
//        return userInfo;
//    }

    // 유저 정보 가져오기
    public Map<String, Object> getUserInfo(String accessToken) {
        Map<String, Object> userInfo = new HashMap<>();
        boolean resultMember = false;

        try {
            String reqURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            // 헤더 설정
            // Authorization : 네이버 API에 인증된 사용자인지를 확인하는 데 사용
            // Bearer :  OAuth2.0에서 액세스 토큰을 전달하는 방법
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String line;
            
            // StringBuilder : 하나의 문자열로 합침.
            StringBuilder result = new StringBuilder();

            // 한줄씩 가져와서 하나의 문자열로 합치는 과정 일껄?
            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            // JSON 파싱 
            JsonParser parser = new JsonParser();
            JsonObject jsonObject = parser.parse(result.toString()).getAsJsonObject();
            JsonObject response = jsonObject.getAsJsonObject("response");

            // 정보 가져오기
            String memberId = response.get("id").getAsString();
            String emailFull = response.get("email").getAsString();
            String[] emailParts = emailFull.split("@");
            String memberEmail1 = emailParts[0];
            String memberEmail2 = emailParts[1];

            // 사용자 정보 userInfo에 넣기
            userInfo.put("memberId", memberId);
            userInfo.put("email", emailFull);
            userInfo.put("memberEmail1", memberEmail1);
            userInfo.put("memberEmail2", memberEmail2);

            member.setMemberId(memberId);
            member.setMemberEmail1(memberEmail1);
            member.setMemberEmail2(memberEmail2);
            
            System.out.println(userInfo.get("memberEmail1"));

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 네이버 회원 조회
        int resultMemberCount = naverDAO.findNaverMemberCount(userInfo);
        System.out.println("resultMemberCount : " + resultMemberCount);

        if (resultMemberCount == 0) {
            resultMember = true; // 없으면 true (회원가입 필요)
        } else {
            MemberDomain m = naverDAO.findNaverMember(userInfo);
            userInfo.put("m", m);
            resultMember = false; // 있으면 false
        }

        userInfo.put("resultMember", resultMember);
        return userInfo;
    }

    public boolean isUserExist(MemberDomain member) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberId", member.getMemberId());
        return naverDAO.findNaverMemberCount(map) > 0;
    }
        
    // 연동 해제
    public boolean unlinkNaverAccount(String accessToken) {
        String url = "https://nid.naver.com/oauth2.0/token";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "delete");
        params.add("client_id", CLIENT_ID);
        params.add("client_secret", CLIENT_SECRET);
        params.add("access_token", accessToken);
        params.add("service_provider", "NAVER");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        RestTemplate restTemplate = new RestTemplate();
        try {
            ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);

            System.out.println("연동 해제 응답 코드: " + response.getStatusCode());
            System.out.println("연동 해제 응답 본문: " + response.getBody());

            return response.getStatusCode().is2xxSuccessful();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
 
// 	HttpHeaders + HttpEntity + RestTemplate 방식      
//    public String getAccessTokenUsingRefreshToken(String refreshToken) {
//        String apiUrl = "https://nid.naver.com/oauth2.0/token";
//
//        // 요청 헤더 설정
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
//
//        // 요청 파라미터 설정
//        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//        params.add("grant_type", "refresh_token");
//        params.add("client_id", CLIENT_ID);
//        params.add("client_secret", CLIENT_SECRET);
//        params.add("refresh_token", refreshToken);
//
//        // HttpEntity 생성 (헤더와 파라미터를 포함)
//        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);
//
//        // RestTemplate을 사용 POST 요청
//        RestTemplate restTemplate = new RestTemplate();
//        try {
//            // 응답 String으로 받음
//            ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, entity, String.class);
//
//            // access_token 꺼내기
//            JSONObject jsonResponse = new JSONObject(response.getBody());
//            return jsonResponse.optString("access_token", null);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return null;
//    }
    
    // 엑세스 토큰 만료시 리플래쉬 토큰으로 재발급
    public String getAccessTokenUsingRefreshToken(String refreshToken) throws IOException {
        String apiUrl = "https://nid.naver.com/oauth2.0/token?grant_type=refresh_token&client_id=" + CLIENT_ID +
                        "&client_secret=" + CLIENT_SECRET +
                        "&refresh_token=" + refreshToken;

        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setDoOutput(true);
        connection.setConnectTimeout(5000);
        connection.setReadTimeout(5000);

        // 서버 응답을 받음
        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        // 네이버 API 응답에서 access_token 추출
        JSONObject jsonResponse = new JSONObject(response.toString());
        return jsonResponse.optString("access_token", null);
    }
}