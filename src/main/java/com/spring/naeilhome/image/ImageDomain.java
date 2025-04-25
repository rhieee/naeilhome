package com.spring.naeilhome.image;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("imageDomain")
public class ImageDomain {
	
	private int imageNO; // 이미지 번호
	private int articleNO; // 글 번호
	private String imageFilename; // 이미지 파일 이름
	private Date imageUpdated; // 등록 일자
	private String imageType; // 구분 번호 or 이름(이름일 시 String변경)
	
	
	public int getImageNO() {
		return imageNO;
	}
	public void setImageNO(int imageNO) {
		this.imageNO = imageNO;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public Date getImageUpdated() {
		return imageUpdated;
	}
	public void setImageUpdated(Date imageUpdated) {
		this.imageUpdated = imageUpdated;
	}
	public String getImageType() {
		return imageType;
	}
	public void setImageType(String imageType) {
		this.imageType = imageType;
	}
	public ImageDomain(int imageNO, int articleNO, String imageFilename, Date imageUpdated, String imageType) {
		this.imageNO = imageNO;
		this.articleNO = articleNO;
		this.imageFilename = imageFilename;
		this.imageUpdated = imageUpdated;
		this.imageType = imageType;
	}
	public ImageDomain() {
	}
	
	
}
