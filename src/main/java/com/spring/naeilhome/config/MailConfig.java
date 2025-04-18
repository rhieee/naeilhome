/*
 * package com.spring.naeilhome.config;
 * 
 * import java.util.Properties;
 * 
 * import org.springframework.context.annotation.Bean; import
 * org.springframework.context.annotation.Configuration; import
 * org.springframework.mail.javamail.JavaMailSender; import
 * org.springframework.mail.javamail.JavaMailSenderImpl;
 * 
 * @Configuration public class MailConfig {
 * 
 * 
 * // @Bean // public JavaMailSender javaMailSender() { // JavaMailSenderImpl
 * mailSender = new JavaMailSenderImpl(); //
 * mailSender.setHost("smtp.naver.com"); // mailSender.setPort(465); // //
 * mailSender.setUsername("gami_project@naver.com"); //
 * mailSender.setPassword("gami1234"); // // Properties props =
 * mailSender.getJavaMailProperties(); // props.put("mail.transport.protocol",
 * "smtp"); // props.put("mail.smtp.auth", "true"); // props.put("mail.debug",
 * "true"); // props.put("mail.smtp.ssl.enable", "true"); // SSL 사용 설정 //
 * props.put("mail.smtps.ssl.protocols","TLSv1.2"); // // return mailSender; //
 * }
 * 
 * // 스프링 부트에서 사용
 * 
 * @Bean public JavaMailSender javaMailSender() { JavaMailSenderImpl mailSender
 * = new JavaMailSenderImpl(); mailSender.setHost("smtp.naver.com");
 * mailSender.setPort(465); mailSender.setUsername("gami_project@naver.com");
 * mailSender.setPassword("gami1234");
 * 
 * Properties props = mailSender.getJavaMailProperties();
 * props.put("mail.transport.protocol", "smtp"); props.put("mail.smtp.auth",
 * "true"); props.put("mail.smtp.ssl.enable", "true"); // SSL을 활성화
 * props.put("mail.debug", "true");
 * 
 * return mailSender; } }
 */