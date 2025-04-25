package com.spring.naeilhome.mail.service;

public interface MailService {
	
	public int makeRandomNumber();
	public void mailSend(String setFrom, String toMail, String title, String content);

}
