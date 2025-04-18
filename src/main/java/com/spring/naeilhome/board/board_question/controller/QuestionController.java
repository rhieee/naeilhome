package com.spring.naeilhome.board.board_question.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.naeilhome.board.board_question.domain.QuestionDomain;
import com.spring.naeilhome.board.board_question.service.QuestionService;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.product.domain.ProductDomain;
import com.spring.naeilhome.product.service.ProductService;

@Controller("questionController")
@RequestMapping("/board/board_question")
public class QuestionController {

	@Autowired
	private QuestionService questionService;

	@Autowired
	private ProductService productService; // 상품 조회 서비스

	// 자주 묻는 질문 페이지
	@RequestMapping(value = "/FAQList.do", method = RequestMethod.GET)
	public String FAQList() {
		return "/board/board_question/FAQList";
	}

	// 내가 작성한 문의 상세페이지
	@RequestMapping(value = "/questionSelect.do", method = RequestMethod.GET)
	public String myQuestionSelect(@RequestParam("boardQuestionArticleNo") int boardQuestionArticleNo, Model model) {
		// boardQuestionArticleNo로 문의글 조회
		QuestionDomain question = questionService.getQuestionByNo(boardQuestionArticleNo);
		model.addAttribute("question", question);

		// 만약 문의유형이 "상품문의"이면 상품정보도 함께 조회 (상품번호가 존재하는 경우)
		if (question.getBoardQuestionType1() != null && question.getBoardQuestionType1().equals("상품문의")
				&& question.getProductNo() != null) {
			ProductDomain product = productService.getProductByNo(question.getProductNo());
			model.addAttribute("product", product);
		}
		return "/board/board_question/questionSelect";
	}

	// 마이페이지 - 문의내역
	@RequestMapping(value = "/myQuestionList.do", method = RequestMethod.GET)
	public String myQuestionList(Model model) {
		List<QuestionDomain> questionList = questionService.getAllQuestions();
		model.addAttribute("questionList", questionList);
		return "/board/board_question/myQuestionList";
	}

	// 문의 작성 페이지(GET)
	// 상품 상세 페이지에서 productNo 파라미터가 있으면 상품문의, 없으면 1:1문의
	@RequestMapping(value = "/questionForm.do", method = RequestMethod.GET)
	public String questionForm(HttpServletRequest request, Model model) {
		System.out.println("들어옴");
		String productNoStr = request.getParameter("productNO");
		System.out.println(productNoStr);
		if (productNoStr != null && !productNoStr.isEmpty()) {
			System.out.println("true");
			// 상품문의인 경우 productNo으로 상품 정보를 조회하여 뷰에 전달
			int productNO = Integer.parseInt(productNoStr);
			System.out.println("상품번호 = " + productNO);
			ProductDomain product = productService.getProductByNo(productNO);
//			System.out.println("상품번호 = " + product.getProductNO());
			model.addAttribute("product", product);
			model.addAttribute("boardQuestionType1", "상품문의");
		} else {
			System.out.println("false");
			// 1:1문의인 경우
			model.addAttribute("boardQuestionType1", "1:1문의");
		}
		return "/board/board_question/questionForm";
	}

	// 문의 등록 처리(POST)
	@RequestMapping(value = "/questionForm.do", method = RequestMethod.POST)
	public String submitQuestion(QuestionDomain question, @RequestParam("uploadFile") MultipartFile uploadFile,
			HttpServletRequest request, Model model) {
		// boardQuestionType2 값 끝에 붙은 콤마 제거
		if (question.getBoardQuestionType2() != null) {
			question.setBoardQuestionType2(question.getBoardQuestionType2().replaceAll(",$", ""));
		}
		
		// 세션에서 로그인된 회원의 memberId 가져오기
        HttpSession session = request.getSession();
        MemberDomain loginMember = (MemberDomain) session.getAttribute("member");
        if (loginMember == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            return "redirect:/member/loginForm.do";
        }
        // 세션의 memberId를 writerId로 설정
        question.setWriterId(loginMember.getMemberId());

		// 파일 업로드 처리
		if (!uploadFile.isEmpty()) {
			try {
				// 파일명 생성 (예: 현재 타임스탬프와 원본 파일명 결합)
				String fileName = System.currentTimeMillis() + "_" + uploadFile.getOriginalFilename();

				// 저장할 디렉토리 경로: C:\naeilhome\board\board_question
				String uploadDir = "C:\\naeilhome\\board\\board_question";
				if(System.getProperty("os.name").toLowerCase().contains("win")) {
					uploadDir = "C:\\naeilhome\\board\\board_question";					
				}else {
					uploadDir = "/home/ubuntu/naeilhome-img/board/board_question";										
				}
				File dir = new File(uploadDir);
				if (!dir.exists()) {
					dir.mkdirs();
				}

				// 파일 저장
				File dest = new File(dir, fileName);
				uploadFile.transferTo(dest);

				// DB 저장용으로 파일명 세팅
				question.setBoardQuestionImage(fileName);
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("error", "파일 업로드 실패");
				return "/board/board_question/questionForm";
			}
		}

		// 문의 등록 boardQuestionStatement는 MyBatis 매퍼에서 "처리중"으로 고정 설정
		questionService.insertQuestion(question);
		return "redirect:/board/board_question/myQuestionList.do";
	}

	@RequestMapping(value="/imageDisplay.do", method=RequestMethod.GET)
	public void imageDisplay(@RequestParam("imageName") String imageName, HttpServletResponse response) {
	    // 이미지 파일이 저장된 폴더 경로
	    String uploadDir = null;
	    if(System.getProperty("os.name").toLowerCase().contains("win")) {
	    	uploadDir = "C:\\naeilhome\\board\\board_question";	    	
	    }else {
	    	uploadDir = "/home/ubuntu/naeilhome-img/board/board_question";	    		    	
	    }
	    File file = new File(uploadDir, imageName);
	    
	    if(file.exists()){
	        // 파일 확장자에 따른 MIME 타입 설정 (예: jpg, png, gif)
	        String ext = imageName.substring(imageName.lastIndexOf('.') + 1).toLowerCase();
	        String mimeType = "application/octet-stream";
	        if("jpg".equals(ext) || "jpeg".equals(ext)) {
	            mimeType = "image/jpeg";
	        } else if("png".equals(ext)) {
	            mimeType = "image/png";
	        } else if("gif".equals(ext)) {
	            mimeType = "image/gif";
	        }
	        response.setContentType(mimeType);
	        
	        try(FileInputStream in = new FileInputStream(file);
	            OutputStream out = response.getOutputStream()) {
	            // Apache Commons IO를 사용하여 파일 내용을 복사합니다.
	            IOUtils.copy(in, out);
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

}
