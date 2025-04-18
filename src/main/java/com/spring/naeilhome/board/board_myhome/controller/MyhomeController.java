package com.spring.naeilhome.board.board_myhome.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.spring.naeilhome.board.board_myhome.domain.MyhomeDomain;
import com.spring.naeilhome.board.board_myhome.service.MyhomeService;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.mypage.bookmark.service.BookMarkService;
import com.spring.naeilhome.mypage.follow.service.FollowService;
import com.spring.naeilhome.mypage.like.service.LikeService;

import net.coobird.thumbnailator.Thumbnails;

@Controller("myhomeController")
@RequestMapping("/board/board_myhome")
public class MyhomeController {

	@Autowired
	MyhomeDomain myhomeDomain;

	@Autowired
	MyhomeService myhomeService;

	@Autowired
	BookMarkService bookMarkService;

	@Autowired
	LikeService likeService;

	@Autowired
	FollowService followService;

	// 작성 폼으로
	@RequestMapping("/myHomeForm.do")
	public String myHomeForm() {
		return "/board/board_myhome/myHomeForm";
	}

	// 썸머 노트 이미지 로컬 저장 - 송현오
	@ResponseBody
	@RequestMapping(value = "/uploadSummernoteImageFile.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			@RequestParam(value = "writer", defaultValue = "modify") String writer,
			@RequestParam(value = "boardMyhomeArticleNo", defaultValue = "0") int Article, HttpServletRequest request)
			throws Exception {

		JsonObject jsonObject = new JsonObject();

		// 새 글 번호 가져오기
		if (writer.equals("writer")) {
			Article = myhomeService.selectNewMyHomeNO();
		}

		System.out.println("이미지 폴더 명에 넣을 새글 번호 : " + Article);

//	    String fileRoot = request.getSession().getServletContext().getRealPath("/resources/images/board/");  // 내부경로 저장
		String fileRoot = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {					
			fileRoot = "C:\\naeilhome\\board\\board_myhome\\" + Article + "\\"; // 외부 경로 저장
		}else {
			fileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/"+Article+"/";
		}
		String originalFileName = multipartFile.getOriginalFilename(); // 원래 파일명
		System.out.println(originalFileName);
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자 확인
		System.out.println(extension);

		final String[] ALLOW_EXTENSION = { ".gif", ".GIF", ".jpg", ".JPG", ".png", ".PNG", ".jepg", ".JEPG" }; // 확장자 검사
		if (!Arrays.asList(ALLOW_EXTENSION).contains(extension)) {
			jsonObject.addProperty("responseCode", "extension");
			String check = jsonObject.toString();
			System.out.println(check);
			return check;
		}

		String savedFileName = UUID.randomUUID() + extension; // 파일 이름 새로 부여 : UUID
		System.out.println(savedFileName);
		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);

			// 파일 저장
//	        jsonObject.addProperty("url", fileRoot + savedFileName); // contextroot + resources + 저장할 내부 폴더명
			System.out.println(fileRoot + savedFileName);
			System.out.println("떠라 제발 : " + Article + savedFileName);
			if(System.getProperty("os.name").toLowerCase().contains("win")) {
				jsonObject.addProperty("fileName", "\\" + Article + "\\" + savedFileName); // 톰켓 서버.xml에서 경로 설정해줬기에 게시글 번호				
			}else {
				jsonObject.addProperty("fileName", "/" + Article + "/" + savedFileName); // 톰켓 서버.xml에서 경로 설정해줬기에 게시글 번호								
			}
																						// 폴더명과 파일명을 같이 넘겨야함.

			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 업로드 실패 시 하위 파일 및 폴더 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String check = jsonObject.toString();
		return check;
	}

	// 썸머노트 로컬 이미지 삭제 - 송현오
	// 글작성, 글수정시 썸머노트 본문에서 이미지 업로드 후 삭제시 로컬폴더에서 삭제됨
	@ResponseBody
	@RequestMapping(value = "/deleteSummernoteImageFile.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String deleteSummernoteImageFile(@RequestParam("file") String fileName,
			@RequestParam(value = "writer", defaultValue = "modify") String writer,
			@RequestParam(value = "boardMyhomeArticleNo", defaultValue = "0") int Article, HttpServletRequest request)
			throws Exception {

		JsonObject jsonObject = new JsonObject();

		System.out.println("writer야 넘어왔니? : " + writer);
		// 새 글 번호 가져오기
		if (writer.equals("writer")) {
			Article = myhomeService.selectNewMyHomeNO();
		}

		// 폴더 위치 확인 (콘솔용)
		System.out.println("삭제할 이미지가 위치한 폴더 : " + Article);
		// 이미지 파일 경로 (이미지 폴더와 글 번호 합침)
		String fileRoot = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			fileRoot = "C:\\naeilhome\\board\\board_myhome\\" + Article + "\\";
		}else {
			fileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/" + Article + "/";
		}
		// fileName에서 폴더 경로 제거
		fileName = Paths.get(fileName).getFileName().toString();
		// 삭제할 파일 경로
		File fileToDelete = new File(fileRoot + fileName);
		// 파일 삭제
		if (fileToDelete.exists() && fileToDelete.isFile()) {
			boolean isDeleted = fileToDelete.delete();
			if (isDeleted) {
				jsonObject.addProperty("responseCode", "success");
				System.out.println("이미지 삭제 성공: " + fileToDelete.getAbsolutePath());
			} else {
				jsonObject.addProperty("responseCode", "error");
				System.out.println("이미지 삭제 실패: " + fileToDelete.getAbsolutePath());
			}
		} else {
			jsonObject.addProperty("responseCode", "fileNotFound");
			System.out.println("삭제할 이미지 파일을 찾을 수 없습니다: " + fileToDelete.getAbsolutePath());
		}
		return jsonObject.toString();
	}

	// 커버 이미지 파일 저장 - 이민주
	@RequestMapping(value = "/coverImageUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String coverImageUpload(@RequestParam("coverImage") MultipartFile file,
			@RequestParam(value = "boardMyhomeArticleNo", required = false) Integer articleNo) throws Exception {
		if (file.isEmpty()) {
			return "fail";
		}
		try {
			int newArticle = 0;
			if (articleNo == null) {
				// 새 글 번호 가져오기
				newArticle = myhomeService.selectNewMyHomeNO();
				System.out.println("커버이미지 새 글작성 번호 : " + newArticle);
			} else {
				newArticle = articleNo;
				System.out.println("커버이미지 수정 글번호 : " + newArticle);
			}

			String result = myhomeService.coverImageUpload(newArticle, file);

			return result;
		} catch (Exception e) {
			return "fail";
		}
	}

	// 글 저장 - 송현오, 이민주
	@ResponseBody
	@RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String insertBoard(HttpSession session, @RequestParam("title") String title,
			@RequestParam("content") String content, @RequestParam("housingType") String housingType,
			@RequestParam("homeSize") String homeSize, @RequestParam("selectedProducts") String selectedProducts)
			throws Exception {

		// 세션에서 아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		myhomeDomain.setMemberId(memberDomain.getMemberId());
		System.out.println(memberDomain.getMemberId());

		// 새글 번호 가져오기
		int newArticle = myhomeService.selectNewMyHomeNO();
		System.out.println("새글 번호 : " + newArticle);
		myhomeDomain.setBoardMyhomeArticleNo(newArticle);

		// 파람으로 받은 데이터 가져오기
		System.out.println("제목 : " + title + "내용 :" + content);
		System.out.println("하우징타입:" + housingType + "평수:" + homeSize);
		myhomeDomain.setBoardMyhomeTitle(title);
		myhomeDomain.setBoardMyhomeContents(content);
		myhomeDomain.setBoardMyhomeHousingType(housingType);
		myhomeDomain.setBoardMyhomeHomeSize(homeSize);

		boolean check = myhomeService.addArticleMyHome(myhomeDomain);

		// 검색된 상품 저장하기
		List<String> productNames = new ArrayList<>();
		ObjectMapper objectMapper = new ObjectMapper();
		// JSON 파일을 Java 객체로 읽기
		JsonNode rootNode = objectMapper.readTree(selectedProducts);

		for (JsonNode element : rootNode) {
			JsonNode productNameNode = element.get("productName");

			if (productNameNode != null && !productNameNode.isNull()) {
				String productName = productNameNode.getTextValue();
				System.out.println("productName: " + productName);
				productNames.add(productName);

			}
		}
		if (productNames != null && !productNames.isEmpty()) {
			myhomeService.addMyhomeProd(newArticle, productNames);
		}

		// 폴더에 존재하지 않은 파일 삭제
		int boardMyhomeArticleNo = newArticle;
		myhomeDomain = myhomeService.selectMyHome(boardMyhomeArticleNo); // 게시글 조회

		// 파일 저장 경로 두개로 수정 (게시글내용 , 커버이미지)
		String fileRoot = null; // 외부 경로
		String coFileRoot = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			fileRoot = "C:\\naeilhome\\board\\board_myhome\\" + boardMyhomeArticleNo + "\\"; // 외부 경로
			coFileRoot = "C:\\naeilhome\\board\\board_myhome\\coverImage\\" + boardMyhomeArticleNo + "\\";
		}else {
			fileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/" + boardMyhomeArticleNo + "/"; // 외부 경로
			coFileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/coverImage/" + boardMyhomeArticleNo + "/";		
		}
		
		
		// 위 경로로 파일 객체 생성
		File saveFileDir = new File(fileRoot);
		File saveFileDir2 = new File(coFileRoot);

		// 파일 목록들을 배열에 담음.
		if (saveFileDir.exists()) {
			String[] saveFileList = saveFileDir.list();

			// for문을 돌려서 작성된 글 내용에 파일이 포함되었나 확인
			for (String saveFileName : saveFileList) {
				System.out.println(saveFileName);
				boolean Check = myhomeDomain.getBoardMyhomeContents().contains(saveFileName);
				System.out.println("사진 포함 여부 : " + Check);
				// 만약 글내용에 포함되어 있지 않다면 해당 파일 삭제.
				if (myhomeDomain.getBoardMyhomeContents().contains(saveFileName) == false) {
					if(System.getProperty("os.name").toLowerCase().contains("win")) {
						fileRoot = "C:\\naeilhome\\board\\board_myhome\\" + newArticle + "\\" + saveFileName;						
					}else {
						fileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/" + newArticle + "/" + saveFileName;
					}
					saveFileDir = new File(fileRoot);
					FileUtils.deleteQuietly(saveFileDir);
				}
			}
		}

		// 커버이미지 삭제
		String coverImage = myhomeService.getCoverImageName(boardMyhomeArticleNo); // 파일이름 가져오기
		System.out.println("커버이미지넴 ???" + coverImage);

		if (coverImage != null && !coverImage.isEmpty()) {
			// 폴더가 존재하는지 확인
			if (saveFileDir2.exists() && saveFileDir2.isDirectory()) {
				// 폴더 내 모든 파일 리스트 가져오기
				File[] fileList = saveFileDir2.listFiles();

				if (fileList != null) {
					for (File file : fileList) {
						// 커버 이미지가 아닌 파일이면 삭제
						if (!file.getName().equals(coverImage)) {
							boolean deleted = file.delete();
							System.out.println("파일 삭제됨: " + file.getName() + ":" + deleted);
						}
					}
				}
			}
		}

		if (check == true) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 게시글 리스트 출력 - 이민주
	@RequestMapping(value = "/myHomeList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView myHomelist(@RequestParam(defaultValue = "1") int section,
			@RequestParam(defaultValue = "1") int pageNo, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		// 게시글목록 + 페이징 추가
		int pageSize = 12; // 한 페이지에 12개

		int startPage = (section - 1) * 100 + (pageNo - 1) * pageSize + 1;
		int endPage = (section - 1) * 100 + (pageNo * pageSize);

		List<MyhomeDomain> myhomeList = myhomeService.listArticles(startPage, endPage); // 게시글 조회
		int totalArticles = myhomeService.totalArticles(); // 총 게시글 수
		// int totalArticles = 500; // 총 게시글 수 테스트용

		int totalPages = (int) Math.ceil((double) totalArticles / pageSize); // 총 페이지수

		ModelAndView mav = new ModelAndView("/board/board_myhome/myHomeList");

		mav.addObject("myhomeList", myhomeList); // "myhomeList"라는 이름으로 데이터를 JSP로 전달
		mav.addObject("section", section);
		mav.addObject("pageNo", pageNo);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("totalArticles", totalArticles);
		mav.addObject("totalPages", totalPages);
		return mav;
	}

	// 썸네일불러오기 - 이민주
	@RequestMapping(value = "/myHomeCoverImages.do", method = RequestMethod.GET)
	public void myHomeCoverImages(@RequestParam("articleNo") int articleNo, @RequestParam("image") String image,
			HttpServletRequest requ, HttpServletResponse resp) throws Exception {
		OutputStream out = resp.getOutputStream();

		String filePath = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			filePath = "C:\\naeilhome\\board\\board_myhome\\coverImage\\" + articleNo + "\\" + image;			
		}else {
			filePath = "/home/ubuntu/naeilhome-img/board/board_myhome/coverImage/" + articleNo + "/" + image;						
		}
		File image1 = new File(filePath);

		if (image1.exists()) {
			// of : 경로, size : 출력크기, outputFormat : 출력포멧(.png), toOutputStream : 출력
			Thumbnails.of(image1).scale(1).outputFormat("png").toOutputStream(out); // Thumbnails 라이브러리
		}
		byte[] buffer = new byte[1024 * 8];
		out.close();
	}

	// 게시글 상세보기 - 송현오, 이민주
	@RequestMapping(value = "/myHomeSelect.do", method = RequestMethod.GET)
	public ModelAndView selectMyHome(int boardMyhomeArticleNo, HttpSession session) throws Exception {
		System.out.println(boardMyhomeArticleNo);

		myhomeDomain = myhomeService.selectMyHome(boardMyhomeArticleNo); // 게시글 조회

		// "myHome"를 JSP에 전달
		ModelAndView mav = new ModelAndView("/board/board_myhome/myHomeSelect");
		mav.addObject("selectMyHome", myhomeDomain); // "selectMyHome"라는 이름으로 데이터를 JSP로 전달

		if (session.getAttribute("member") != null) {
			// 세션에서 아이디 가져오기
			MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
			String memberId = memberDomain.getMemberId();

			// 회원이 좋아요한 글인지
			Map<String, Object> likeChcekMap = new HashMap<>();
			likeChcekMap.put("memberId", memberId);
			likeChcekMap.put("boardMyhomeArticleNo", boardMyhomeArticleNo);
			String likeChcek = likeService.likeChcek(likeChcekMap);
			System.out.println("라이크 체크 들어왔니? " + likeChcek);
			mav.addObject("likeChcek", likeChcek); // "selectMyHome"라는 이름으로 데이터를 JSP로 전달

			// 회원이 북마크한 글인지.(추가됨.)

			// no는 북마크 추가,삭제 작업, yes는 리스트 조회할때 북마크 여부만 가져오기
			String check = "yes";

			// 북마크 여부 확인하여 추가 삭제
			String bookCheck = bookMarkService.isBookmark(boardMyhomeArticleNo, memberId, check);
			System.out.println("북마크 체크 들어왔니? " + bookCheck);
			mav.addObject("bookCheck", bookCheck);

			// 글 조회 목록에서 팔로우 아이디 가져오기
			String followId = myhomeDomain.getMemberId();

			// 맵에 회원 아이디와 팔로우 아이디 넣기
			Map<String, Object> followIds = new HashMap<>();
			followIds.put("followId", followId);
			followIds.put("memberId", memberId);

			String checkBoardFollow = "false";

			if (followService.checkBoardFollow(followIds) != null) {
				checkBoardFollow = followService.checkBoardFollow(followIds);
			}
			System.out.println("checkBoardFollow : " + checkBoardFollow);
			mav.addObject("checkBoardFollow", checkBoardFollow);
		}

		// 이 게시글에 사용된 제품 목록 불러오기
		List<MyhomeDomain> productInfo = myhomeService.getProdName(boardMyhomeArticleNo);
		mav.addObject("productInfo", productInfo);

		return mav;
	}

	// 글 삭제 및 로컬 저장소에 있는 이미지 삭제 - 송현오, 이민주
	@RequestMapping(value = "/myHomeDelete.do", method = RequestMethod.POST)
	public ResponseEntity deleteMyHome(int boardMyhomeArticleNo,
			HttpServletResponse response) throws Exception {
		System.out.println("삭제 글 번호" + boardMyhomeArticleNo);

		response.setContentType("text/html; charset=UTF-8");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		boolean deleteQuietlyCheck = true;
		boolean deleteQuietlyCheck2 = true;
		boolean deleteMyHomeCheck = false;

		// 파일 삭제 // 커버파일삭제 추가 03.18
		String fileRoot = null;
		String coFileRoot = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			fileRoot = "C:\\naeilhome\\board\\board_myhome\\" + boardMyhomeArticleNo; // 삭제 경로
			coFileRoot = "C:\\naeilhome\\board\\board_myhome\\coverImage\\" + boardMyhomeArticleNo;			
		}else {
			fileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/" + boardMyhomeArticleNo; // 삭제 경로
			coFileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/coverImage/" + boardMyhomeArticleNo;						
		}

		File targetFile = new File(fileRoot);
		File coTargetFile = new File(coFileRoot);

		if (targetFile.isDirectory()) { // 해당 게시글 폴더가 존재하면 폴더 째로 삭제.
			try {
				FileUtils.deleteQuietly(targetFile); // 업로드 실패 시 하위 파일 및 폴더 삭제

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("파일 삭제를 실패하였습니다.");
				deleteQuietlyCheck = false;
			}
		}

		if (coTargetFile.isDirectory()) {
			try {
				FileUtils.deleteQuietly(coTargetFile);

			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("파일 삭제를 실패하였습니다.");
				deleteQuietlyCheck2 = false;
			}
		}

		// 게시글 삭제
		try {
			myhomeService.deleteMyHome(boardMyhomeArticleNo); // DB에서 게시글 삭제
			deleteMyHomeCheck = true;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("게시글 삭제를 실패하였습니다.");
		}

		if (deleteMyHomeCheck && deleteQuietlyCheck && deleteQuietlyCheck2) {
			message = "<script>";
			message += " alert('글을 삭제했습니다.');";
			message += " location.href='/board/board_myhome/myHomeList.do';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} else {
			message = "<script>";
			message += " alert('작업중 오류가 발생했습니다.다시 시도해 주세요.');";
			message += " location.href='/board/board_myhome/myHomeList.do';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}

	// 수정 폼으로 이동 - 송현오, 이민주
	@RequestMapping(value = "/myHomeModForm.do", method = RequestMethod.POST)
	public String modArticleForm(Model model) throws Exception {

		System.out.println("도메인 받았니 ? " + myhomeDomain.getBoardMyhomeContents());

		model.addAttribute("selectMyHome", myhomeDomain);
		// 상품검색 정보 넘기기
		int boardMyhomeArticleNo = myhomeDomain.getBoardMyhomeArticleNo();
		List<MyhomeDomain> productInfo = myhomeService.getProdName(boardMyhomeArticleNo);
		model.addAttribute("productInfo", productInfo);

		return "/board/board_myhome/myHomeModForm";
	}

	// 게시글 수정 - 송현오, 이민주
	@RequestMapping(value = "/myHomeMod.do", method = RequestMethod.POST)
	@ResponseBody
	public String modArticle(@RequestParam("boardMyhomeArticleNo") int articleNo,
			@RequestParam("boardMyhomeTitle") String title, @RequestParam("boardMyhomeContents") String content,
			@RequestParam("boardMyhomeHosingType") String housingType,
			@RequestParam("boardMyhomeHomeSize") String homeSize,
			@RequestParam("selectedProducts") String selectedProducts) throws Exception {

		MyhomeDomain myhomeDomain = new MyhomeDomain();

		myhomeDomain.setBoardMyhomeArticleNo(articleNo);
		myhomeDomain.setBoardMyhomeTitle(title);
		myhomeDomain.setBoardMyhomeContents(content);
		myhomeDomain.setBoardMyhomeHousingType(housingType);
		myhomeDomain.setBoardMyhomeHomeSize(homeSize);

		// 검색된 상품 수정
		List<String> productNames = new ArrayList<>();
		ObjectMapper objectMapper = new ObjectMapper();
		// JSON 파일을 Java 객체로 읽기
		JsonNode rootNode = objectMapper.readTree(selectedProducts);

		for (JsonNode element : rootNode) {
			JsonNode productNameNode = element.get("productName");

			if (productNameNode != null && !productNameNode.isNull()) {
				String productName = productNameNode.getTextValue();
				System.out.println("productName: " + productName);
				productNames.add(productName);

			}
		}
		myhomeService.updateMyhomeProd(articleNo, productNames);

		try {
			myhomeService.modArticle(myhomeDomain);

			// 폴더에 존재하지 않은 파일 삭제
			int boardMyhomeArticleNo = myhomeDomain.getBoardMyhomeArticleNo();

			String fileRoot = null;
			String coFileRoot = null;
			if(System.getProperty("os.name").toLowerCase().contains("win")) {
				fileRoot = "C:\\naeilhome\\board\\board_myhome\\" + boardMyhomeArticleNo + "\\"; // 삭제 경로
				coFileRoot = "C:\\naeilhome\\board\\board_myhome\\coverImage\\" + boardMyhomeArticleNo + "\\";			
			}else {
				fileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/" + boardMyhomeArticleNo + "/"; // 삭제 경로
				coFileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/coverImage/" + boardMyhomeArticleNo + "/";						
			}
			

			// 위 경로로 파일 객체 생성
			File saveFileDir = new File(fileRoot);
			File saveFileDir2 = new File(coFileRoot);

			// 파일 목록들을 배열에 담음.
			String[] saveFileList;

			// 파일 목록들을 배열에 담음.
			if (saveFileDir.exists()) {
				saveFileList = saveFileDir.list();

				// for문을 돌려서 작성된 글 내용에 파일이 포함되었나 확인
				for (String saveFileName : saveFileList) {
					System.out.println(saveFileName);
					boolean Check = myhomeDomain.getBoardMyhomeContents().contains(saveFileName);
					System.out.println("사진 포함 여부 : " + Check);
					// 만약 글내용에 포함되어 있지 않다면 해당 파일 삭제.
					if (myhomeDomain.getBoardMyhomeContents().contains(saveFileName) == false) {
						if(System.getProperty("os.name").toLowerCase().contains("win")) {
							fileRoot = "C:\\naeilhome\\board\\board_myhome\\" + boardMyhomeArticleNo + "\\" + saveFileName;							
						}else {							
							fileRoot = "/home/ubuntu/naeilhome-img/board/board_myhome/" + boardMyhomeArticleNo + "/" + saveFileName;							
						}
						saveFileDir = new File(fileRoot);
						FileUtils.deleteQuietly(saveFileDir);
					}
				}
			}

			// 커버이미지 삭제
			String coverImage = myhomeService.getCoverImageName(boardMyhomeArticleNo); // 파일이름 가져오기
			System.out.println("커버이미지넴 ???" + coverImage);

			if (coverImage != null && !coverImage.isEmpty()) {
				// 폴더가 존재하는지 확인
				if (saveFileDir2.exists() && saveFileDir2.isDirectory()) {
					// 폴더 내 모든 파일 리스트 가져오기
					File[] fileList = saveFileDir2.listFiles();

					if (fileList != null) {
						for (File file : fileList) {
							// 커버 이미지가 아닌 파일이면 삭제
							if (!file.getName().equals(coverImage)) {
								boolean deleted = file.delete();
								System.out.println("파일 삭제됨: " + file.getName() + ":" + deleted);
							}
						}
					}
				}
			}
			return "success";
		} catch (Exception e) {
			return "fail";
		}
	}

	// 조회수 증가 - 박찬희
	@RequestMapping(value = "/viewCount.do", method = RequestMethod.GET)
	public String countUp(@RequestParam("boardMyhomeArticleNo") int boardMyhomeArticleNo, HttpSession session)
			throws Exception {

		// 최신 게시글 데이터를 가져오기
		likeService.countUp(boardMyhomeArticleNo, session);

		return "redirect:/board/board_myhome/myHomeSelect.do?boardMyhomeArticleNo=" + boardMyhomeArticleNo;
	}

	// 필터링 적용, 게시글 조각 업데이트용 - 이민주
	@RequestMapping(value = "/filterList.do", method = RequestMethod.GET)
	public void myHomeFilterList(@RequestParam(required = false) String housingType,
			@RequestParam(required = false) String homeSize, @RequestParam(required = false) String sortType,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("sort?" + sortType + "housingType?" + housingType + "homeSize?" + homeSize);

		List<MyhomeDomain> filteredList = myhomeService.filterArticles(sortType, housingType, homeSize);
		request.setAttribute("myhomeList", filteredList);

		// Tiles나 ViewResolver를 거치지 않고 JSP 파일로 직접 포워딩
		request.getRequestDispatcher("/WEB-INF/views/board/board_myhome/myHomeListFragment.jsp").forward(request,
				response);
	}

}