package com.spring.naeilhome.product.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.naeilhome.image.ImageDomain;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.member.service.MemberService;
import com.spring.naeilhome.mypage.wishlist.service.WishListService;
import com.spring.naeilhome.product.domain.ProductDomain;
import com.spring.naeilhome.product.service.ProductService;
import com.spring.naeilhome.review.domain.ReviewDomain;
import com.spring.naeilhome.review.service.ReviewService;

import net.coobird.thumbnailator.Thumbnails;

@Controller("productController")
@RequestMapping("/product")
public class ProductController {

	private static final String PRODUCT_IMAGE_SERVER = "C:\\naeilhome\\product_image";
	private static final String PRODUCT_SELECT_IMAGE_SERVER = "C:\\naeilhome\\product_select_image";
	private static final String REVIEW_IMAGE_SERVER = "C:\\naeilhome\\review_image"; // 리뷰 이미지 저장 경로

	@Autowired
	private ProductService productService;
	@Autowired
	private ImageDomain image;
	@Autowired
	private ProductDomain productDomain;
	@Autowired
	private WishListService wishListService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private MemberDomain memberDomain; // 회원정보
	@Autowired
	private MemberService memberService; // 회원정보

	// 상품 목록 - 임현규
	@RequestMapping(value = "/productList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView selectAllproduct(HttpServletRequest requ, HttpServletResponse resp,
			@RequestParam Map<String, Object> map) throws Exception {
		Map<String, Object> productMap = productService.selectAllPorduct(map);
		ModelAndView mav = new ModelAndView("/product/productList");
		mav.addObject("productMap", productMap);
		return mav;
	}

	// 상품 목록 썸네일 - 임현규
	@RequestMapping(value = "/productThumbnail.do", method = RequestMethod.GET)
	public void selectAllProductThumbnail(@RequestParam("articleNO") int articleNO,
			@RequestParam("image") String imageName, HttpServletRequest requ, HttpServletResponse resp)
			throws Exception {

		String filePath = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {			
			filePath = PRODUCT_IMAGE_SERVER + "\\" + articleNO + "\\" + imageName;
		}else {
			filePath = "/home/ubuntu/naeilhome-img/product_image/"+articleNO+"/"+imageName;
		}
		File image = new File(filePath);
		
		InputStream in = new FileInputStream(image);
		OutputStream out = resp.getOutputStream();
		byte[] buffer = new byte[1024 * 8];
		int lenght;
		while((lenght = in.read(buffer)) != -1) {
			out.write(buffer, 0, lenght);			
		}
		in.close();
		out.close();


//		  if (image.exists()) { // of : 경로, size : 출력크기, outputFormat : 출력포멧(.png), toOutputStream : 출력
//			  Thumbnails.of(image).size(450,450).outputFormat("png").toOutputStream(out); // Thumbnails 라이브러리 }
//		  }
		
	}

	// 상품상세조회 selectProduct() - 박찬희
	// 특정 상품정보 목록 가져오기 (상품번호,상품명,상품 사이즈,상품 색상,상품 설명,상품가격,상품수량,상품등록일)
	@RequestMapping(value = "/selectProduct.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView selectProduct(@RequestParam("productNO") int productNO,
			@RequestParam("productName") String productName, Model model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		ModelAndView mav = new ModelAndView();

		try {
			String viewName = (String) request.getAttribute("viewName");
			if (viewName == null) {
				viewName = "home"; // 메인으로 이동
			}

			// 상품 목록 가져오기
			List<ProductDomain> productList = productService.selectProduct(productName);

			// 상품 목록이 없으면 메인으로 이동
			if (productList == null || productList.isEmpty()) {
				viewName = "home";
			}
			// 상품 가져오기
			ProductDomain productDomain = null;
			for (ProductDomain product : productList) {
				productDomain = product;
				// break; // 빠져나옴
			}
			// productNo(상품번호)의 재고가 0일때 품절 Alert 띄우기
			boolean isQtyZero = (productDomain.getProductQty() == 0);
			if (isQtyZero) {
				mav.addObject("Message", "해당 상품은 품절되었습니다.");
			}

			// 상품 상세페이지 썸네일의 (imageFilename 이미지 파일 이름) 가져오기
			ImageDomain selectThumnailOne = productService.selectThumnail(productNO);
			// 추가 이미지 가져오기
			List<ImageDomain> selectThumnailTwo = productService.selectThumnailTwo(productNO);

			mav.setViewName("/product/selectProduct");
			mav.addObject("productNo", productNO);
			mav.addObject("productDomain", productDomain); // 상세상품 하나만 보여줌
			mav.addObject("productList", productList); // 같은 상품의 다른 옵션도 함께 보여줌
			mav.addObject("selectThumnail", selectThumnailOne); // 썸네일
			mav.addObject("selectThumnailTwo", selectThumnailTwo); // 상품상세페이지 썸네일 외 다른이미지

			// 회원이 찜한 글인지.(추가됨.)
			// 세션에서 아이디 가져오기
			if ((MemberDomain) session.getAttribute("member") != null) {
				MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
				String memberId = memberDomain.getMemberId();

				// no는 찜 추가,삭제 작업, yes는 리스트 조회할때 찜 여부만 가져오기
				String check = "yes";

				// 찜 여부 확인
				String wishListCheck = wishListService.isWishList(productNO, memberId, check, productName);
				System.out.println("productNO " + productNO);
				System.out.println("check " + check);
				System.out.println("controller wishListCheck " + wishListCheck);
				mav.addObject("wishListCheck", wishListCheck);
			}

			// [리뷰]
			// 상세페이지에서 상품에 대한 모든 리뷰 조회
			List<ReviewDomain> reviews = reviewService.reviewsList(productName);
			System.out.println("나 셀렉트프러덕트인데! 내가 받아온 리뷰야 = " + reviews);
			mav.addObject("reviews", reviews); // 리뷰 리스트

			// 상세페이지에서 모든 리뷰에 맞는 이미지명을 가져오기(리뷰번호에 맞는 이미지)
			List<ImageDomain> imageList = new ArrayList<>();
			List<MemberDomain> memberList = new ArrayList<>();

			for (ReviewDomain review : reviews) {
				// private으로 밑에 짜놓음
				String reviewImageName = reviewImageName(review.getReviewNo());
				if (reviewImageName != null) {
					ImageDomain image = new ImageDomain();
					image.setArticleNO(review.getReviewNo()); // 리뷰넘버
					image.setImageFilename(reviewImageName); // 이미지파일이름
					image.setImageType("리뷰");

					imageList.add(image);
				}
				// 회원정보 가져오기 (닉네임과 프로필이미지)
				// reviewNo을 조회해서 memberId 조회 -> member테이블에서 '닉네임','프로필이미지이름' 가져오기
				String memberId = review.getMemberId();
				MemberDomain member = memberService.selectMemberId(memberId);
				if (member != null) {
					memberList.add(member);
				}
			}
			mav.addObject("imageList", imageList); // 리뷰 이미지 리스트
			mav.addObject("memberList", memberList); // 회원정보 리스트
			System.out.println("리뷰 이미지 리스트 = " + imageList);
			System.out.println("회원 정보 리스트 = " + memberList);

			// 리뷰 별점 평균 계산
			// 평균별점, 리뷰개수, 소수점 반올림한 값 총3가지
			double totalStars = 0;
			int reviewCount = reviews.size();
			for (ReviewDomain review : reviews) {
				totalStars += review.getReviewStarAvg(); // 리뷰의 별점 평균값을 다 더해서
			}
			// 총평균별점 / 리뷰수 . 리뷰가0이라면 0;
			double averageStars = (reviewCount > 0) ? totalStars / reviewCount : 0;
			double roundAverageStars = Math.round(averageStars * 10) / 10.0; // 소수점1점까지만
			int roundedStars = (int) Math.round(averageStars); // 소수점 반올림

			int totalDurability = 0;// 내구성 별점
			int totalPrice = 0; // 가성비 별점
			int totalDesign = 0; // 디자인 별점
			int totalDelivery = 0; // 배송만족 별점

			for (ReviewDomain review : reviews) {
				totalDurability += review.getReviewStarDurability();
				totalPrice += review.getReviewStarPrice();
				totalDesign += review.getReviewStarDesign();
				totalDelivery += review.getReviewStarDelivery();
			}

			mav.addObject("averageStars", roundAverageStars); // 리뷰의 별점 평균값 -> 소수점1점까지만
			mav.addObject("reviewCount", reviewCount); // 리뷰 개수
			mav.addObject("roundedStars", roundedStars); // 소수점 반올림한 평균값
			mav.addObject("totalDurability", totalDurability); // 내구성
			mav.addObject("totalPrice", totalPrice); // 가성비
			mav.addObject("totalDesign", totalDesign); // 디자인
			mav.addObject("totalDelivery", totalDelivery); // 배송만족

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	// 상품 상세페이지 썸네일 - 박찬희
	@RequestMapping(value = "/selectThumnail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void selectThumnail(@RequestParam("productNO") int productNO, @RequestParam("image") String imageFileName,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		OutputStream out = response.getOutputStream();
		String filePath2 = null; 
		if(System.getProperty("os.name").toLowerCase().contains("win")) {			
			filePath2 = PRODUCT_IMAGE_SERVER + "\\" + productNO + "\\" + imageFileName;
		}else {
			filePath2 = "/home/ubuntu/naeilhome-img/product_image/"+productNO+"/"+imageFileName;;			
		}
		File image2 = new File(filePath2);
		
		
		InputStream in = new FileInputStream(image2);
		byte[] buffer = new byte[1024 * 8];
		int lenght;
		while((lenght = in.read(buffer)) != -1) {
			out.write(buffer, 0, lenght);			
		}
		in.close();
		out.close();
		
//		if (image2.exists()) {
//			response.setContentType("image/png");
//			Thumbnails.of(image2).size(400, 400).outputFormat("png").toOutputStream(out);
//		}
//		out.close();
	}

	// 상세페이지 상세이미지 - 박찬희
	@RequestMapping(value = "/selectProductDetailImage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void selectProductDetailImage(@RequestParam("productNO") int productNO,
			@RequestParam("image") String imageName, HttpServletResponse response) throws Exception {

		OutputStream out = response.getOutputStream();
		// PRODUCT_SELECT_IMAGE_SERVER 상수를 사용하여 파일 경로 구성
		String filePath = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			filePath = PRODUCT_SELECT_IMAGE_SERVER + File.separator + productNO + File.separator + imageName;
		}else {
			filePath = "/home/ubuntu/naeilhome-img/product_select_image/"+productNO+"/"+imageName;
		}
		File imageFile = new File(filePath);

		if (imageFile.exists()) {
			// 이미지 확장자에 따른 ContentType 설정
			if (imageName.toLowerCase().endsWith("png")) {
				response.setContentType("image/png");
			} else if (imageName.toLowerCase().endsWith("jpg") || imageName.toLowerCase().endsWith("jpeg")) {
				response.setContentType("image/jpeg");
			} else {
				response.setContentType("application/octet-stream");
			}
			// 이미지의 비율을 유지한 채 너비 기준으로 리사이징
//			Thumbnails.of(imageFile).width(1200) // 또는 적절한 너비로 지정
//					.keepAspectRatio(true).outputFormat("png").toOutputStream(out);
			
			InputStream in = new FileInputStream(imageFile);
			byte[] buffer = new byte[1024 * 8];
			int lenght;
			while((lenght = in.read(buffer)) != -1) {
				out.write(buffer, 0, lenght);			
			}
			in.close();
			out.close();
		}
		out.close();
	}

	// 게시판에서 상품 검색 - 이민주
	@RequestMapping(value = "/productSearch.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> productSearch(@RequestParam("keyword") String keyword) throws Exception {

		List<ProductDomain> searchedProdList = productService.productSearching(keyword);
		System.out.println("리스트 오시옵소서 : " + searchedProdList);

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("products", searchedProdList);

		return resultMap;
	}

	// 리뷰 번호에 맞는 이미지 파일명 - 박찬희
	private String reviewImageName(int reviewNo) {
		File reviewFolder = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			reviewFolder = new File(REVIEW_IMAGE_SERVER, String.valueOf(reviewNo));			
		}else {
			reviewFolder = new File("/home/ubuntu/naeilhome-img/review_image/"+reviewNo);
		}
		System.out.println("리뷰 이미지 파일 경로 = " + reviewFolder.getPath()); // 경로 확인

		if (reviewFolder.exists() && reviewFolder.isDirectory()) {
			File[] files = reviewFolder.listFiles();
			if (files != null && files.length > 0) {
				// 이미지가 있으면 첫 번째 이미지 파일명 반환
				for (File file : files) {
					// 첫 번째 이미지 파일명 (sample.jpg)
					System.out.println("이미지 파일명 ====" + file.getName());
				}
				return files[0].getName();
			}
		}
		return null; // 이미지가 없으면 null 반환
	}

	@RequestMapping("/productCre")
	@ResponseBody
	public Map<String, String> productCre() {
		Map<String, String> result = new HashMap<>();

		String message = "" + "<div>" + "<h3>배송교환반품 안내</h3>" + "<hr>" + "<h4>[배송]</h4>" + "<p>배송: 일반택배</p>"
				+ "<p>배송비: 3,500원</p>" + "<p>배송불가 지역: 배송불가 지역이 없습니다.</p>" + "<h4>[교환/환불]</h4>"
				+ "<p>반품배송비: 3,500원 (최초 배송비 무료 시 7,000원 부과)</p>" + "<p>교환배송비: 7,000원</p>"
				+ "<p>보내실 곳: 대전 서구 계룡로 637</p>" + "<hr>" + "<h4>[반품/교환 사유에 따른 요청 가능 기간]</h4>"
				+ "<p>반품 시 판매자와 연락 후 진행하세요.</p>" + "<p>1. 구매자 단순 변심: 상품 수령 후 7일 이내 (구매자 반품비 부담)</p>"
				+ "<p>2. 표시/광고와 상이할 경우: 수령 후 3개월 이내</p>" + "<hr>" + "<h4>[반품/교환 불가능 사유]</h4>" + "<ul>"
				+ "<li>반품 요청 기간이 지난 경우</li>" + "<li>상품이 훼손된 경우</li>" + "<li>시간 경과로 재판매가 어려운 경우</li>"
				+ "<li>복제가 가능한 상품의 포장이 훼손된 경우</li>" + "</ul>" + "</div>";

		result.put("message", message);
		return result;
	}

}