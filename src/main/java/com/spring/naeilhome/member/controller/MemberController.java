package com.spring.naeilhome.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.spring.naeilhome.member.domain.MemberDomain;
import com.spring.naeilhome.member.service.MemberService;
import com.spring.naeilhome.mypage.bookmark.service.BookMarkService;
import com.spring.naeilhome.mypage.follow.service.FollowService;
import com.spring.naeilhome.mypage.like.service.LikeService;
import com.spring.naeilhome.mypage.wishlist.service.WishListService;

@Controller("memberController")
@RequestMapping("/member")
public class MemberController {
	// 인터페이스 삭제
	// 수정내용 : 클래스 RequestMapping /member 걸어둠
	// 주석처리 된 메서드 다 삭제
	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberDomain memberDomain;

	@Autowired
	BookMarkService bookMarkService;

	@Autowired
	WishListService wishListService;

	@Autowired
	FollowService followService;

	@Autowired
	LikeService likeService;

	final String[] ALLOW_EXTENSION = { ".gif", ".GIF", ".jpg", ".JPG", ".png", ".PNG", ".jepg", ".JEPG" }; // 확장자 검사

	// 로그인 폼으로
	@RequestMapping("/loginForm.do")
	public String home() {
		return "/member/loginForm";
	}

	// 로그인 - 송현오
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("member") MemberDomain member, RedirectAttributes rAttr,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		System.out.println(member.getMemberId());
		System.out.println(member.getMemberPw());
		memberDomain = memberService.login(member);
		if (memberDomain != null) {
			HttpSession session = request.getSession();
			session.setAttribute("member", memberDomain);
			session.setAttribute("isLogOn", true);

			String memberId = member.getMemberId();

			// 총 좋아요 수
			int likeTotal = likeService.likeTotal(memberId);
			session.setAttribute("likeTotal", likeTotal);

			// 북마크 수
			int bookMarkTotal = bookMarkService.selectTotArticle(memberId);
			session.setAttribute("bookMarkTotal", bookMarkTotal);

			// 찜 수
			int wishListTotal = wishListService.allwishListCount(memberId);
			session.setAttribute("wishListTotal", wishListTotal);

			// 팔로우 팔로잉 수
			int followCount = followService.followCount(memberId);
			int followingCount = followService.followingCount(memberId);

			session.setAttribute("followCount", followCount);
			session.setAttribute("followingCount", followingCount);

			// mav.setViewName("redirect:/member/listMembers.do");
			String action = (String) session.getAttribute("action");
			session.removeAttribute("action");
			if (action != null) {
				mav.setViewName("redirect:" + action);
			} else {
				mav.setViewName("redirect:/");
			}

		} else {
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/member/loginForm.do");
		}
		return mav;
	}

	// 로그 아웃 - 송현오
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		session.invalidate();

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}

	// 아이디 찾기 페이지로 이동 - 박찬희
	@RequestMapping(value = "/findId.do", method = RequestMethod.GET)
	public String findId() {
		return "/member/findId";
	}

	// 아이디 찾기 (입력된 값 찾기) - 박찬희
	@RequestMapping(value = "/checkId.do", method = RequestMethod.POST)
	public String findIdSearch(@RequestParam("memberName") String memberName,
			@RequestParam("memberPhone1") String memberPhone1, @RequestParam("memberPhone2") String memberPhone2,
			@RequestParam("memberPhone3") String memberPhone3, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// 이름과 휴대폰번호 확인 로직
		memberDomain.setMemberName(memberName);
		memberDomain.setMemberPhone1(memberPhone1);
		memberDomain.setMemberPhone2(memberPhone2);
		memberDomain.setMemberPhone3(memberPhone3);

		String id = memberService.findId(memberDomain);
		System.out.println("돌아온 이름 =" + id);

		if (id != null && !id.isEmpty()) {
			model.addAttribute("id", id);
		} else {
			model.addAttribute("error", "일치하는 회원정보가 없습니다.");
		}

		return "/member/checkId";
	}

	// 비밀번호 찾기 - 박찬희
	@RequestMapping(value = "/findPw.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String findPw() {
		return "/member/findPw";
	}

	// 비밀번호 찾기(입력된 값 찾기) - 박찬희
	@RequestMapping(value = "/findPwSearch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String findPwSearch(
			@RequestParam("memberName") String memberName,
			@RequestParam("memberId") String memberId,
			@RequestParam("memberEmail1") String memberEmail1,
			@RequestParam("memberEmail2") String memberEmail2, HttpSession session, Model model,
			RedirectAttributes rAttr, HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 아이디와 휴대폰번호 확인 로직
		MemberDomain memberDomain = new MemberDomain();
		memberDomain.setMemberName(memberName);
		memberDomain.setMemberId(memberId);
		memberDomain.setMemberEmail1(memberEmail1);
		memberDomain.setMemberEmail2(memberEmail2);
		System.out.println("들어온 비밀번호찾기 값들== " + memberDomain);

		// 회원 정보 확인
		String userId = memberService.findPw(memberDomain);
		System.out.println("찾은 아이디 = " + userId);

		// 값이 없으면
		if (userId == null || userId.isEmpty()) { // userId가 없을 경우 예외처리
			rAttr.addFlashAttribute("error", "일치하는 회원정보가 없습니다.");
			return "redirect:/member/findPw.do";
		}
		// 세션에 memberId 저장
		session.setAttribute("memberId", userId);
		System.out.println("세션에 저장된 memberId = " + session.getAttribute("memberId"));

		return "/member/checkPw"; // 컨트롤러 호출할때 redirect
	}

	// 비밀번호 수정 - 박찬희
	@RequestMapping(value = "/checkPw.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String checkPw(@RequestParam("memberPw") String memberPw, @RequestParam("newPwd") String newPwd,
			RedirectAttributes rAttr, HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// 세션에서 memberId 가져오기
		String memberId = (String) session.getAttribute("memberId");
		if (memberId == null) {
			model.addAttribute("error", "세션이 만료되었습니다. 다시 시도해주세요.");
			return "/member/checkPw"; // 페이지 그대로 유지
		}

		// 빈값 체크
		if (newPwd == null || newPwd.isEmpty() || memberPw == null || memberPw.isEmpty()) {
			model.addAttribute("error", "새 비밀번호를 입력하세요.");
			return "/member/checkPw"; // 페이지 유지
		}

		// 비밀번호 확인 로직
		if (!newPwd.trim().equals(memberPw.trim())) {
			model.addAttribute("error", "새 비밀번호가 일치하지 않습니다.");
			return "/member/checkPw"; // 페이지 유지
		}

		// 비밀번호 변경 로직 실행
		Map<String, String> updatePw = new HashMap<>();
		updatePw.put("memberId", memberId);
		updatePw.put("newPwd", newPwd);
		memberService.updatePwd(updatePw);
		// 비밀번호 변경 후 세션에서 memberId 제거
		session.removeAttribute("memberId");

		// 비밀번호 변경 성공 메시지
		rAttr.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
		return "redirect:/member/loginForm.do";
	}

	// 회원가입 정보입력
    @RequestMapping(value = "/memberForm.do", method = RequestMethod.GET)
    public String memberForm(Model model) {
        model.addAttribute("resultMember", false);
        return "/member/memberForm";
    }

	// 회원가입 - 임현규
	@RequestMapping(value = "/addMember.do", method = RequestMethod.POST)
	public ResponseEntity addMember(@RequestParam("memberIamge") MultipartFile multipartFile,
			MemberDomain member) throws Exception {
		boolean fileCheck = true;
		String fileName = multipartFile.getOriginalFilename();
		if (!fileName.trim().isEmpty()) {
			String extension = fileName.substring(fileName.lastIndexOf(".")); // 파일 확장자 확인
			if (!Arrays.asList(ALLOW_EXTENSION).contains(extension)) {
				fileCheck = false;
			}
			if (fileCheck) {
				File file = null;
				if(System.getProperty("os.name").toLowerCase().contains("win")) {
					file = new File("C:\\naeilhome\\memberProfileImage\\" + member.getMemberId() + "\\" + fileName);
				}else {
					file = new File("/home/ubuntu/naeilhome-img/memberProfileImage/" + member.getMemberId() + "/" + fileName);
				}
				InputStream in = multipartFile.getInputStream();
				member.setMemberImage(fileName);
				FileUtils.copyInputStreamToFile(in, file);
			}
		} else {
			System.out.println("addMember method : filename is null");
		}

		if (member.getMemberEmailReceotion() == null) { // 이메일 광고 선택 X 시
			member.setMemberEmailReceotion("N");
		}
		if (member.getMemberSmsReceotion() == null) { // SMS 광고 선택 X 시
			member.setMemberSmsReceotion("N");
		}
		memberService.addMember(member);
		ResponseEntity res = null;
		String msg = "<script>";
		msg += " alert('회원가입이 되었습니다. 로그인 화면으로 이동합니다.');";
		msg += " location.href='/member/loginForm.do'; ";
		msg += " </script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
		return res;
	}

	// 회원 정보 수정 페이지로
	@RequestMapping(value = "/memberModifyForm.do", method = RequestMethod.GET)
	public String memberModifyForm() {
		return "/member/memberModifyForm";
	}

	// 회원 탈퇴 전 비밀번호 입력 페이지로
	@RequestMapping(value = "/memberDeletePwd.do", method = RequestMethod.GET)
	public String memberDeletePwd() {
		return "/member/memberDeletePwd";
	}

	// 회원 탈퇴 전 마지막 선택 페이지로
	@RequestMapping(value = "/memberDeleteLastCh.do", method = RequestMethod.GET)
	public String memberDeleteLastCh() {
		return "/member/memberDeleteLastCh";
	}

	// 비밀번호 수정 페이지로
	@RequestMapping(value = "/changePassword.do", method = RequestMethod.GET)
	public String changePassword() {
		return "/member/changePassword";
	}

	// 비밀번호 수정 - 송현오
	@RequestMapping(value = "/updatePassword.do", method = RequestMethod.POST)
	public ResponseEntity updatePassword(@RequestParam("newMemberPw") String newPwd, HttpSession session) {

		ResponseEntity res = null;
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();

		System.out.println("memberIdCheck 들어옴? " + memberId);
		System.out.println("newPwd 들어옴? " + newPwd);

		Map<String, String> updatePw = new HashMap<>();

		updatePw.put("memberId", memberId);
		updatePw.put("newPwd", newPwd);

		try {
			memberService.updatePwd(updatePw);
			session.removeAttribute("member");
			session.removeAttribute("isLogOn");

			String msg = "<script>";
			msg += " alert('비밀번호가 수정되었습니다. 로그인 화면으로 이동합니다.');";
			msg += " opener.location.href ='/member/loginForm.do'; ";
			msg += " window.close(); ";
			msg += " </script>";
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "text/html; charset=utf-8");
			res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			e.printStackTrace();
			String msg = "<script>";
			msg += " alert('비밀번호가 수정에 실패하였습니다. 다시 시도해 주세요.');";
			msg += " opener.location.href ='/member/memberModifyForm.do'; ";
			msg += " window.close(); ";
			msg += " </script>";
			HttpHeaders responseHeaders = new HttpHeaders();
			responseHeaders.add("Content-Type", "text/html; charset=utf-8");
			res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
		}

		return res;
	}

	// 회원 탈퇴 확정 시 - 송현오
	@RequestMapping(value = "/memberDelete.do", method = RequestMethod.POST)
	public ResponseEntity deleteMember(@RequestParam("memberId") String memberId, HttpSession session) throws Exception {

		ResponseEntity res = null;

		// 세션에서 아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberIdCheck = memberDomain.getMemberId();
		System.out.println("memberId야 들어왔니? " + memberId);

		if (memberId.equals(memberIdCheck)) {
			boolean deleteQuietlyCheck = true;
			boolean deleteMyHomeCheck = false;

			// 파일 삭제 // 커버파일삭제 추가 03.18
			String fileRoot = null;
			if(System.getProperty("os.name").toLowerCase().contains("win")) {
				fileRoot = "C:\\naeilhome\\memberProfileImage\\" + memberId + "\\";
			}else {
				fileRoot = "/home/ubuntu/naeilhome-img/memberProfileImage/" + memberId + "/";
			}

			File targetFile = new File(fileRoot);

			if (targetFile.isDirectory()) { // 해당 게시글 폴더가 존재하면 폴더 째로 삭제.
				try {
					FileUtils.deleteQuietly(targetFile);

				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("파일 삭제를 실패하였습니다.");
					deleteQuietlyCheck = false;
				}
			}

			// 탈퇴
			try {
				memberService.deleteMember(memberId);

				// 세션 초기화
				session.invalidate();
				
				deleteMyHomeCheck = true;
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("게시글 삭제를 실패하였습니다.");
			}

			if (deleteMyHomeCheck && deleteQuietlyCheck) {
				String msg = "<script>";
				msg += " alert('탈퇴되었습니다.');";
				msg += " location.href='/'; ";
				msg += " </script>";
				HttpHeaders responseHeaders = new HttpHeaders();
				responseHeaders.add("Content-Type", "text/html; charset=utf-8");
				res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
			} else {
				String msg = "<script>";
				msg += " alert('오류가 발생하였습니다. 다시 시도해 주세요.');";
				msg += " location.href='/member/memberDeleteLastCh.do'; ";
				msg += " </script>";
				HttpHeaders responseHeaders = new HttpHeaders();
				responseHeaders.add("Content-Type", "text/html; charset=utf-8");
				res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
			}
		}
		return res;
	}

	// ID 중복확인 - 임현규
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String idCheck(@RequestParam String memberId) throws Exception {
		JsonObject ob = new JsonObject();
		String result = memberService.idCheck(memberId);
		ob.addProperty("result", result);
		return ob.toString();
	}

	// 닉네임 중복확인 - 임현규
	@RequestMapping(value = "/nickNameCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String nickNameCheck(@RequestParam String nickName) throws Exception {
		JsonObject ob = new JsonObject();
		String result = "false";
		if (!nickName.equals("탈퇴회원")) {
			result = memberService.nickCheck(nickName);
		}
		ob.addProperty("result", result);
		return ob.toString();
	}
	
	// 핸드폰 번호 중복확인 - 송현오
	@RequestMapping(value = "/phoneCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String phoneCheck(@RequestParam String phone) throws Exception {
		JsonObject ob = new JsonObject();
		String result = "false";
		result = memberService.phoneCheck(phone);
		ob.addProperty("result", result);
		return ob.toString();
	}
	
	// 프로필 사진 업로드 - 송현오
	@ResponseBody
	@RequestMapping(value = "/memberProfileImageUpload.do", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String memberProfileImageLoad(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request,
			HttpSession session) throws Exception {

		// 아이디 가져오기
		// 세션에서 아이디 가져오기
		MemberDomain memberDomain = (MemberDomain) session.getAttribute("member");
		String memberId = memberDomain.getMemberId();
		System.out.println("memberId야 들어왔니? " + memberId);

		JsonObject jsonObject = new JsonObject();

// 	    String fileRoot = request.getSession().getServletContext().getRealPath("/resources/images/board/");  // 내부경로 저장
		String fileRoot = null;
		if(System.getProperty("os.name").toLowerCase().contains("win")) {
			fileRoot = "C:\\naeilhome\\memberProfileImage\\" + memberId + "\\"; // 외부 경로 저장
		}else {
			fileRoot = "/home/ubuntu/naeilhome-img/memberProfileImage/" + memberId + "/"; // 외부 경로 저장			
		}
		String originalFileName = multipartFile.getOriginalFilename(); // 원래 파일명
		System.out.println(originalFileName);
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자 확인
		System.out.println(extension);

		if (!Arrays.asList(ALLOW_EXTENSION).contains(extension)) {
			jsonObject.addProperty("responseCode", "extension");
			String check = jsonObject.toString();
			System.out.println(check);
			return check;
		}

		String savedFileName = UUID.randomUUID() + extension; // 파일 이름 새로 부여 : UUID
		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();

			FileUtils.copyInputStreamToFile(fileStream, targetFile);

			jsonObject.addProperty("responseCode", "success");
			System.out.println("savedFileName 업로드에서" + savedFileName);
			jsonObject.addProperty("fileName", savedFileName);

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 업로드 실패 시 하위 파일 및 폴더 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}

		String check = jsonObject.toString();
		return check;
	}

	// 회원 정보 수정 - 송현오
	@RequestMapping(value = "/memberUpdate.do", method = RequestMethod.POST)
	public ResponseEntity memberUpdate(@RequestParam("memberNickName") String memberNickName, @RequestParam("memberId") String memberId,
			@RequestParam("memberEmail1") String memberEmail1, @RequestParam("memberEmail2") String memberEmail2,
			@RequestParam("memberPhone1") String memberPhone1, @RequestParam("memberPhone2") String memberPhone2,
			@RequestParam("memberPhone3") String memberPhone3, @RequestParam("memberZip1") String memberZip1,
			@RequestParam("memberZip2") String memberZip2, @RequestParam("memberZip3") String memberZip3,
			@RequestParam("memberImage") String memberImage, HttpSession session) throws Exception {
		// 들어왔나 확인.
		System.out.println("수정 memberNickName 들어왔니? " + memberNickName);
		System.out.println("수정 memberEmail1 들어왔니? " + memberEmail1);
		System.out.println("수정 memberEmail2 들어왔니? " + memberEmail2);
		System.out.println("수정 memberPhone1 들어왔니? " + memberPhone1);
		System.out.println("수정 memberPhone2 들어왔니? " + memberPhone2);
		System.out.println("수정 memberPhone3 들어왔니? " + memberPhone3);
		System.out.println("수정 memberZip1 들어왔니? " + memberZip1);
		System.out.println("수정 memberZip2 들어왔니? " + memberZip2);
		System.out.println("수정 memberZip3 들어왔니? " + memberZip3);
		System.out.println("수정 memberImage 들어왔니? " + memberImage);
		System.out.println("수정 memberId 들어왔니? " + memberId);

		memberDomain.setMemberNickname(memberNickName);
		memberDomain.setMemberEmail1(memberEmail1);
		memberDomain.setMemberEmail2(memberEmail2);
		memberDomain.setMemberPhone1(memberPhone1);
		memberDomain.setMemberPhone2(memberPhone2);
		memberDomain.setMemberPhone3(memberPhone3);
		memberDomain.setMemberZip1(memberZip1);
		memberDomain.setMemberZip2(memberZip2);
		memberDomain.setMemberZip3(memberZip3);
		memberDomain.setMemberImage(memberImage);

		System.out.println("일로 왔니? " + memberImage);
		System.out.println("memberDomain.getMemberImage(); : " + memberDomain.getMemberImage());
		
		try {
			memberService.updateMember(memberDomain);

			String imageRoot = null;
			if(System.getProperty("os.name").toLowerCase().contains("win")) {
				imageRoot = "C:\\naeilhome\\memberProfileImage\\" + memberDomain.getMemberId() + "\\";
			}else {				
				imageRoot = "/home/ubuntu/naeilhome-img/memberProfileImage/" + memberDomain.getMemberId() + "/";
			}
			
			if (memberImage != "") {

				System.out.println(imageRoot);

				// 이미지 경로로 파일 객체 생성
				File imageDir = new File(imageRoot);

				// 이미지 파일 목록을 배열에 담음.
				if (imageDir.exists()) {
					String[] imageList = imageDir.list();

					// for문을 돌려서 이미지 파일이 포함되었나 확인
					for (String imageName : imageList) {
						System.out.println(imageName);
						boolean check = memberDomain.getMemberImage().equals(imageName);
						System.out.println("이름이 같은지 : " + check);

						// 폴더에 해당 파일이랑 다른 파일들은 삭제
						if (!check) {
							String filePath = imageRoot + imageName;
							File fileToDelete = new File(filePath);
							FileUtils.deleteQuietly(fileToDelete);
						}
					}
				}
				// 이미지 파일이 널값이면 다지워버려
			}else {
				File fileToDelete = new File(imageRoot);
				FileUtils.deleteQuietly(fileToDelete);
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("수정 및 파일 삭제 실패");

		}
		
		// 해당 회원 정보 다시 조회해서 세션에 넣기
		memberDomain = memberService.selectMemberId(memberId);
		session.removeAttribute("member");
		session.setAttribute("member", memberDomain);
		
		ResponseEntity res = null;
		String msg = "<script>";
		msg += " alert('회원 정보가 수정되었습니다.');";
		msg += " location.href='/member/memberModifyForm.do'; ";
		msg += " </script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
		return res;

	}
	
	@GetMapping("/kakaoLogin.do")
	public ResponseEntity kakaoLogin(HttpServletRequest request) {
		ResponseEntity res = null;
		String msg = "<script>";
		msg += " location.href='" + request.getContextPath() + "/'; ";
		msg += " </script>";
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		res = new ResponseEntity(msg, responseHeaders, HttpStatus.CREATED);
		return res;
	}

}
