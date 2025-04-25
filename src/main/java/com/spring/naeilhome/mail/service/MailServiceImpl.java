package com.spring.naeilhome.mail.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("mailService")
public class MailServiceImpl implements MailService {
	
	@Autowired
	private JavaMailSender mailSender;

	// 랜덤 6자리 인증번호
	@Override
	public int makeRandomNumber() {
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111; // 111111 ~ 999999 (6자리 랜덤)
		System.out.println("인증번호 : " + checkNum);
		int authNumber = checkNum;
		return authNumber;
	}

	// 이메일 전송 메소드
	@Override
	public void mailSend(String setFrom, String toMail, String title, String content) {

		MimeMessage message = mailSender.createMimeMessage();
		// true 매개값을 전달하면 multipart 형식의 메세지 전달이 가능.문자 인코딩 설정도 가능하다.

		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);

			// true 전달 > html 형식으로 전송 , 작성하지 않으면 단순 텍스트로 전달.
			helper.setText(content, true);
			mailSender.send(message);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

}
