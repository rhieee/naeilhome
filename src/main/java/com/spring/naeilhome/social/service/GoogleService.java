package com.spring.naeilhome.social.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.social.dao.GoogleDAO;

@Service("googleService")
public class GoogleService {
	
	 @Autowired
	 GoogleDAO googleDAO;
	 
	 	@Value("${api.google.api-key}")
		private String CLIENT_ID;
		
		@Value("${api.google.secret-key}")
		private String CLIENT_SECRET;
		
//	 	HttpHeaders + HttpEntity + RestTemplate 방식		
//		public String getAccessToken(String code, String clientId, String clientSecret, String redirectUri) {
//		    String apiUrl = "https://oauth2.googleapis.com/token";
//
//		    // 파라미터 설정
//		    MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//		    params.add("code", code);
//		    params.add("client_id", clientId);
//		    params.add("client_secret", clientSecret);
//		    params.add("redirect_uri", redirectUri);
//		    params.add("grant_type", "authorization_code");
//
//		    // 헤더 설정
//		    HttpHeaders headers = new HttpHeaders();
//		    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
//
//		    // HttpEntity 생성
//		    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
//
//		    // RestTemplate 사용
//		    RestTemplate restTemplate = new RestTemplate();
//
//		    try {
//		        // POST 요청하여 응답 받기
//		        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, request, String.class);
//
//		        if (response.getStatusCode().is2xxSuccessful()) {
//		            JSONObject json = new JSONObject(response.getBody());
//		            return json.optString("access_token", null);
//		        } else {
//		             System.out.println("액세스 토큰 요청 실패: " + response.getStatusCode());
//		        }
//
//		    } catch (Exception e) {
//		         System.out.println("구글 액세스 토큰 요청 오류 발생", e);
//		    }
//		}

		// 구글 액세스 토큰 요청
	    public String getAccessToken(String code, String clientId, String clientSecret, String redirectUri) {
	        String accessToken = "";
	        String reqURL = "https://oauth2.googleapis.com/token";

	        try {
	            // URL 객체 생성
	            URL url = new URL(reqURL);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	            // HTTP 요청 방식 설정
	            // setDoOutput(true) : 요청 본문을 전송하기 위해 OutputStream을 사용한다는 것
	            conn.setRequestMethod("POST");
	            conn.setDoOutput(true);

	            // Content-Type 설정 구글은 기본 URL인코딩 방식 사용해야 된다고 함.
	            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

	            // 요청 파라미터 설정
	            String data = "code=" + code
	                        + "&client_id=" + clientId
	                        + "&client_secret=" + clientSecret
	                        + "&redirect_uri=" + redirectUri
	                        + "&grant_type=authorization_code";

	            // 데이터 바이트 배열로 변환
	            // data의 문자열을 UTF-8 인코딩 형식의 바이트 배열로 변환
	            byte[] postData = data.getBytes("UTF-8");

	            // Content-Length 헤더 설정
	            // Content-Length : 요청 본문의 크기를 설정, 바이트 배열을 넣음으로써 크기를 설정함.
	            conn.setRequestProperty("Content-Length", String.valueOf(postData.length));

	            // 데이터 전송
	            // OutputStream를 사용해서 postData를 서버로 전송
	            try (OutputStream os = conn.getOutputStream()) {
	                os.write(postData);
	            }

	            // 응답 받기
	            // 구글 서버로 부터 응답 코드 확인
	            int responseCode = conn.getResponseCode();
	            
	            // OK 200일 경우, 서버 응답은 JSON 형식으로 오기 때문에 InputStreamReader와 BufferedReader를 사용하여 본문을 읽어옴.
	            if (responseCode == HttpURLConnection.HTTP_OK) {
	                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	                StringBuilder result = new StringBuilder();
	                String line;

	                while ((line = br.readLine()) != null) {
	                    result.append(line);
	                }

	                // JSON 파싱하기
	                JsonParser parser = new JsonParser();
	                JsonObject jsonObject = parser.parse(result.toString()).getAsJsonObject();
	                accessToken = jsonObject.get("access_token").getAsString();

	                br.close();
	            } else {
	                System.out.println("HTTP 요청 실패: " + responseCode);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return accessToken;
	    }
	    
//	 	HttpHeaders + HttpEntity + RestTemplate 방식	    
//	    public Map<String, Object> getUserInfo(String accessToken) {
//	        Map<String, Object> userInfo = new HashMap<>();
//	        boolean resultMember = false;
//
//	        String reqURL = "https://www.googleapis.com/oauth2/v2/userinfo";
//
//	        // 헤더 설정
//	        HttpHeaders headers = new HttpHeaders();
//	        headers.set("Authorization", "Bearer " + accessToken);
//
//	        // HttpEntity 생성
//	        HttpEntity<String> entity = new HttpEntity<>(headers);
//
//	        // RestTemplate 사용
//	        RestTemplate restTemplate = new RestTemplate();
//
//	        try {
//	            // GET 요청 유저 정보 가져오기
//	            ResponseEntity<String> response = restTemplate.exchange(reqURL, HttpMethod.GET, entity, String.class);
//
//	            if (response.getStatusCode().is2xxSuccessful()) {
//	                String body = response.getBody();
//	                
//	                // JSON 파싱
//	                JsonParser parser = new JsonParser();
//	                JsonObject jsonObject = parser.parse(body).getAsJsonObject();
//
//	                String memberId = jsonObject.get("id").getAsString();
//	                String emailFull = jsonObject.get("email").getAsString();
//	                String[] emailParts = emailFull.split("@");
//	                String memberEmail1 = emailParts[0];
//	                String memberEmail2 = emailParts[1];
//
//	                
//	                userInfo.put("memberId", memberId);
//	                userInfo.put("email", emailFull);
//	                userInfo.put("memberEmail1", memberEmail1);
//	                userInfo.put("memberEmail2", memberEmail2);
//	            } else {
//	                System.out.println("유저 정보 요청 실패: " + response.getStatusCode());
//	            }
//
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	        }
//
//	        // 구글 회원 조회
//	        int resultMemberCount = googleDAO.findGoogleMemberCount(userInfo);
//	        System.out.println("resultMemberCount : " + resultMemberCount);
//
//	        if (resultMemberCount == 0) {
//	            resultMember = true; // 없으면 true (회원가입 필요)
//	        } else {
//	            MemberDomain m = googleDAO.findGoogleMember(userInfo);
//	            userInfo.put("m", m);
//	            resultMember = false; // 있으면 false
//	        }
//
//	        userInfo.put("resultMember", resultMember);
//	        return userInfo;
//	    }

    // 구글 유저 정보 가져오기
    public Map<String, Object> getUserInfo(String accessToken) {
        Map<String, Object> userInfo = new HashMap<>();
        boolean resultMember = false;

        try {
            String reqURL = "https://www.googleapis.com/oauth2/v2/userinfo";
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
            
            // 정보 가져오기
            String memberId = jsonObject.get("id").getAsString();
            String emailFull = jsonObject.get("email").getAsString();
            String[] emailParts = emailFull.split("@");
            String memberEmail1 = emailParts[0];
            String memberEmail2 = emailParts[1];

            // 사용자 정보 userInfo에 넣기
            userInfo.put("memberId", memberId);
            userInfo.put("email", emailFull);
            userInfo.put("memberEmail1", memberEmail1);
            userInfo.put("memberEmail2", memberEmail2);

        } catch (Exception e) {
            e.printStackTrace();
        }

     // 구글 회원 조회
        int resultMemberCount = googleDAO.findGoogleMemberCount(userInfo);
        System.out.println("resultMemberCount : " + resultMemberCount);

        if (resultMemberCount == 0) {
            resultMember = true; // 없으면 true (회원가입 필요)
        } else {
            MemberDomain m = googleDAO.findGoogleMember(userInfo);
            userInfo.put("m", m);
            resultMember = false; // 있으면 false
        }

        userInfo.put("resultMember", resultMember);
        
        return userInfo;
    }

    // 사용자가 이미 존재하는지 확인
    public boolean isUserExist(MemberDomain member) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberId", member.getMemberId());
        return googleDAO.findGoogleMemberCount(map) > 0;
    }
    
// 	HttpHeaders + HttpEntity + RestTemplate 방식	     
//  // 구글 리프레시 토큰을 사용하여 새로운 액세스 토큰 발급
// 	public String getAccessTokenUsingRefreshToken(String refreshToken) {
//     String url = "https://oauth2.googleapis.com/token";
//
//     // 요청 헤더 설정
//     HttpHeaders headers = new HttpHeaders();
//     headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
//
//     // 요청 파라미터 설정
//     MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
//     params.add("client_id", CLIENT_ID);
//     params.add("client_secret", CLIENT_SECRET);
//     params.add("refresh_token", refreshToken);
//     params.add("grant_type", "refresh_token");
//
//     // 요청 엔티티 구성
//     HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
//
//     RestTemplate restTemplate = new RestTemplate();
//
//     try {
//         // POST 요청 보내기
//         ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);
//
//         // access_token 추출
//         if (response.getStatusCode().is2xxSuccessful()) {
//             JSONObject jsonResponse = new JSONObject(responseBody);
//             return jsonResponse.optString("access_token", null);
//         } else {
//             System.out.println("구글 액세스 토큰 갱신 실패: " + response.getStatusCode());
//         }
//     } catch (Exception e) {
//         System.err.println("구글 액세스 토큰 갱신 중 오류 발생");
//         e.printStackTrace();
//     }
//
//     return null;
// }
    
    // 리프레시 토큰을 사용하여 새로운 액세스 토큰 발급
    public String getAccessTokenUsingRefreshToken(String refreshToken) {
        String tokenUrl = "https://oauth2.googleapis.com/token";
        
        String params = "client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&refresh_token=" + refreshToken
                + "&grant_type=refresh_token";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");

        HttpEntity<String> entity = new HttpEntity<>(params, headers);

        RestTemplate restTemplate = new RestTemplate();

        try {
            ResponseEntity<String> response = restTemplate.exchange(tokenUrl, HttpMethod.POST, entity, String.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                // 응답에서 새로운 액세스 토큰 추출
                String responseBody = response.getBody();
                String accessToken = parseAccessToken(responseBody);
                return accessToken;
            } else {
                System.out.println("리프레시 토큰 사용한 액세스 토큰 갱신 x");
                return null;
            }
        } catch (Exception e) {
            System.err.println("리프레시 토큰을 사용하여 액세스 토큰을 갱신하는 중 에러? 오류?");
            e.printStackTrace();
            return null;
        }
    }

    // 액세스 토큰을 파싱
    private String parseAccessToken(String responseBody) {
        // access token만 추출 
        // {"access_token": "new_access_token", "expires_in": 3600, "token_type": "Bearer"} 요로코롬 들어있음.
        String accessToken = responseBody.split("\"access_token\":\"")[1].split("\"")[0];
        return accessToken;
    }

    // 구글 연동 해제 요청
    public boolean unlinkGoogleAccount(String accessToken) {
        String unlinkUrl = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json";
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();

        try {
            // 연동 해제 API
            ResponseEntity<String> response = restTemplate.exchange(unlinkUrl, HttpMethod.GET, entity, String.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 액세스 토큰을 취소하는 메서드
    public void revokeToken(String accessToken) {
        String revokeUrl = "https://oauth2.googleapis.com/revoke?token=" + accessToken;
        
        RestTemplate restTemplate = new RestTemplate();
        
        try {
            restTemplate.postForObject(revokeUrl, null, String.class);
            System.out.println("액세스 토큰 해제 성공");
        } catch (Exception e) {
            System.out.println("액세스 토큰 해제 실패");
            e.printStackTrace();
        }
    }

}