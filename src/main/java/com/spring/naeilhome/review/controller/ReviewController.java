package com.spring.naeilhome.review.controller;

import java.io.File;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.image.ImageDomain;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.review.domain.ReviewDomain;
import com.spring.naeilhome.review.service.ReviewService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/review")
public class ReviewController {
	private static final String PRODUCT_IMAGE_SERVER = "C:\\naeilhome\\product_image"; // 경로
	private static final String REVIEW_IMAGE_SERVER = "C:\\naeilhome\\review_image"; // 리뷰 이미지 저장 경로

	@Autowired
	ReviewDomain reviewDomain;
	@Autowired
	ReviewService reviewService;
	@Autowired
	ImageDomain imageDomain;

	// 나의 리뷰보기 - 박찬희
	@RequestMapping(value = "/myReviewList.do", method = RequestMethod.GET)
	public ModelAndView myPageReviewList(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("안녕! 난 마이페이지의 마이리뷰리스트야.");
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		Map<String, Object> myReviewMap = reviewService.selectReviewList(memberId); // 게시글 조회
		System.out.println("나 리뷰들고 왔어! " + myReviewMap);

		// 이미지 출력
		// ReviewDoamin의 리뷰게시글에서 리뷰번호(파일명 ex.1)를 꺼냄
		List<ReviewDomain> reviewList = (List<ReviewDomain>) myReviewMap.get("myReviewList");
		List<ImageDomain> imageList = new ArrayList<>();

		for (ReviewDomain review : reviewList) {
			String reviewImageName = reviewImageName(review.getReviewNo()); // 하나의 이미지 파일명만 가져옴
			// 이미지가 있으면
			if (reviewImageName != null) {
				ImageDomain image = new ImageDomain();
				image.setArticleNO(review.getReviewNo()); // 리뷰 번호
				image.setImageFilename(reviewImageName); // 이미지 파일명
				imageList.add(image);
			}
		}
		// Map에 추가
		myReviewMap.put("imageList", imageList);

		ModelAndView mav = new ModelAndView("/review/myReviewList");
		mav.addObject("myReviewMap", myReviewMap); // "reviewMap"라는 이름으로 데이터를 JSP로 전달
		return mav;
	} // myPageReviewList END

	// 리뷰 작성 페이지로 이동  - 박찬희
	@RequestMapping(value = "/reviewForm.do", method = RequestMethod.GET)
	public String myReviewForm(@RequestParam(value = "productNo") int productNo,
			@RequestParam(value = "orderNo") int orderNo, Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String imageFolderPath = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			imageFolderPath = PRODUCT_IMAGE_SERVER + "\\" + productNo;			
		}else {
			imageFolderPath = "/home/ubuntu/naeilhome-img/product_image" + "/" + productNo;			
		}
		File imageFolder = new File(imageFolderPath);
		// 상품이미지 파일명 찾는 방법
		String productImageFileName = null;
		if (imageFolder.exists() && imageFolder.isDirectory()) {
			File[] files = imageFolder.listFiles();
			if (files != null && files.length > 0) {
				productImageFileName = files[0].getName(); // 첫 번째 이미지 파일이름 찾는거
			}
		}
		String productName = reviewService.selectProductName(productNo); // 상품명 조회

		model.addAttribute("productNo", productNo);
		model.addAttribute("productName", productName);
		model.addAttribute("productImageFileName", productImageFileName);
		model.addAttribute("orderNo", orderNo);

		System.out.println("상품 번호: " + productNo + ", 상품 이름: " + productName); // 로그 확인

		System.out.println("나 리뷰폼인데 이제 간당");

		return "/review/reviewForm";
	} // myReviewForm END

	// 리뷰 저장 (이미지포함으로 수정)  - 박찬희
	@RequestMapping(value = "/addReview.do", method = RequestMethod.POST)
	public String addReview(@RequestParam(value = "productNo") int productNo,
			@RequestParam(value = "orderNo") int orderNo, @RequestParam("memberId") String memberId,
			@RequestParam("reviewContents") String reviewContents, @RequestParam("reviewStarDurability") int durability,
			@RequestParam("reviewStarPrice") int price, @RequestParam("reviewStarDesign") int design,
			@RequestParam("reviewStarDelivery") int delivery,
			@RequestParam(value = "reviewImage", required = false) MultipartFile reviewImage, // 'required = false'를 쓰면
																								// 파일안올려도 괜찮
			Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("나 add리뷰로 도착했당");
		System.out.println("addR : " + orderNo);
		if (memberId == null || memberId.isEmpty()) {
			return "redirect:/member/loginForm.do"; // 로그인 페이지
		}
		// 별점 4개의 평균 내기
		int avg = (durability + price + design + delivery) / 4;
		System.out.println("리뷰내용 = " + reviewContents);

		ReviewDomain reviewsDomain = new ReviewDomain();
		// 도메인에 set
		reviewsDomain.setProductNo(productNo);
		reviewsDomain.setOrderNo(orderNo);
		reviewsDomain.setMemberId(memberId);
		reviewsDomain.setReviewContents(reviewContents);
		reviewsDomain.setReviewStarDelivery(delivery);
		reviewsDomain.setReviewStarPrice(price);
		reviewsDomain.setReviewStarDesign(design);
		reviewsDomain.setReviewStarAvg(avg);
		reviewsDomain.setReviewStarDurability(durability);
		System.out.println("도메인에 들어온 리뷰값  = " + reviewsDomain);

		// 리뷰 저장
		reviewService.addReview(reviewsDomain);

		// 리뷰 저장후 생성된 reviewNo사용(게시글번호 역할/현재 리뷰 번호)
		// (시퀀스를 이용해 자동으로 생성된 리뷰 번호를 끌고 오는 mybatis로 쿼리문을 날림)
		int reviewNo = reviewService.selectCurrVal();
		System.out.println("리뷰저장에 사용될 게시글번호 = " + reviewNo);

		// 이미지 파일이 존재하면
		if (reviewImage != null && !reviewImage.isEmpty()) {
			// 리뷰경로 + 리뷰번호 폴더생성
			File reviewFolder = new File(REVIEW_IMAGE_SERVER, String.valueOf(reviewNo));
			if(!System.getProperty("os.name").toLowerCase().contains("win")) {
				reviewFolder = new File("/home/ubuntu/naeilhome-img/review_image", String.valueOf(reviewNo));
			}
			if (!reviewFolder.exists()) {
				reviewFolder.mkdirs(); // 폴더가 없으면 생성
			}
			String imageFilename = reviewImage.getOriginalFilename(); // 원본이름
			File ImagePath = new File(reviewFolder, imageFilename); // 폴더명, 파일이름

			// 파일 저장
			try {
				reviewImage.transferTo(ImagePath); // 경로에 파일 저장
			} catch (Exception e) {
				e.printStackTrace();
			}

			Map<String, Object> imageMap = new HashMap();
			imageMap.put("articleNo", reviewNo); // 리뷰게시글번호를 게시글번호로 이름
			imageMap.put("imageFilename", imageFilename);
			imageMap.put("imageType", "리뷰");

			reviewService.addImage(imageMap);
		} // if End (이미지 파일이 존재하면~)

		return "redirect:/review/myReviewList.do";
	} // addReview END

	// 상품 썸네일  - 박찬희
	@RequestMapping(value = "/productThumbnail.do", method = RequestMethod.GET)
	public void selectAllProductThumbnail(@RequestParam("productNo") int productNo,
			@RequestParam("image") String imageName, HttpServletRequest requ, HttpServletResponse resp)
			throws Exception {

		OutputStream out = resp.getOutputStream();
		String filePath = PRODUCT_IMAGE_SERVER + "\\" + productNo + "\\" + imageName;
		if(!System.getProperty("os.name").toLowerCase().contains("win")) {
			filePath = "/home/ubuntu/naeilhome-img/product_image/" + productNo + "/" + imageName;
		}
		File image = new File(filePath);

		if (image.exists()) {
			// of : 경로, size : 출력크기, outputFormat : 출력포멧(.png), toOutputStream : 출력
			Thumbnails.of(image).size(450, 450).outputFormat("png").toOutputStream(out); // Thumbnails 라이브러리
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}

	// 리뷰번호에 맞는 이미지 파일명  - 박찬희
	private String reviewImageName(int reviewNo) {
		File reviewFolder = new File(REVIEW_IMAGE_SERVER, String.valueOf(reviewNo));
		if(!System.getProperty("os.name").toLowerCase().contains("win")) {
			reviewFolder = new File("/home/ubuntu/naeilhome-img/review_image", String.valueOf(reviewNo));			
		}
		System.out.println("나 이미지파일명 찾는 컨트롤러인데 파일 경로야 = " + reviewFolder.getPath()); // 경로 확인

		if (reviewFolder.exists() && reviewFolder.isDirectory()) {
			File[] files = reviewFolder.listFiles();
			if (files != null && files.length > 0) {
				System.out.println("그리고 내가 찾은 파일 이름이야 = " + files[0].getName()); // 찾은 이미지 확인

				// 파일명만 반환해야 함
				return files[0].getName(); // sample.jpg
			}
		}
		return null; // 이미지가 없으면 null 반환
	} // reviewImageName END
 
	// 리뷰이미지 불러오는거  - 박찬희
	@RequestMapping(value = "/imagesReview.do", method = RequestMethod.GET)
	public void imagesReviews(@RequestParam("reviewNo") int reviewNo, @RequestParam("imageName") String imageName,
			HttpServletRequest requ, HttpServletResponse resp) throws Exception {

		OutputStream out = resp.getOutputStream();
		String filePath = REVIEW_IMAGE_SERVER + "\\" + reviewNo + "\\" + imageName;
		if(!System.getProperty("os.name").toLowerCase().contains("win")) {
			filePath = "/home/ubuntu/naeilhome-img/review_image/" + reviewNo + "/" + imageName;			
		}
		File image = new File(filePath);

		if (image.exists()) {
			// of : 경로, size : 출력크기, outputFormat : 출력포멧(.png), toOutputStream : 출력
			Thumbnails.of(image).size(450, 450).outputFormat("png").toOutputStream(out); // Thumbnails 라이브러리
			out.close(); // 정상 이미지일 경우에만 닫기
		} else {
			// 이미지가 없으면 404 상태코드 보내기
			resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
		}
		System.out.println("이미지 요청된 경로 = " + filePath);
		System.out.println("파일 존재해??? = " + image.exists());

	} // imagesReviews END

}