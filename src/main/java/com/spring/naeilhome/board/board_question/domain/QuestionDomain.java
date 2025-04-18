package com.spring.naeilhome.board.board_question.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("questionDomain")
public class QuestionDomain {

	private int boardQuestionArticleNo; // 문의글 번호
	private String boardQuestionTitle; // 제목
	private String boardQuestionContents; // 내용
	private String boardQuestionImage; // 사진
	private Date boardQuestionUpdated; // 등록일
	private String boardQuestionStatement; // 처리상태
	private int boardQuestionParentNO; // 부모글 번호
	private String boardQuestionType1; // 구분(1대1문의, 상품 문의)
	private String boardQuestionType2; // 구분2 (1대1: 불편사항, 버그제보 등 / 상품 : 파손, 배송 등)

	private Integer productNo;
	private String writerId;

	public QuestionDomain(int boardQuestionArticleNo, String boardQuestionTitle, String boardQuestionContents,
			String boardQuestionImage, Date boardQuestionUpdated, String boardQuestionStatement,
			int boardQuestionParentNO, String boardQuestionType1, String boardQuestionType2) {
		this.boardQuestionArticleNo = boardQuestionArticleNo;
		this.boardQuestionTitle = boardQuestionTitle;
		this.boardQuestionContents = boardQuestionContents;
		this.boardQuestionImage = boardQuestionImage;
		this.boardQuestionUpdated = boardQuestionUpdated;
		this.boardQuestionStatement = boardQuestionStatement;
		this.boardQuestionParentNO = boardQuestionParentNO;
		this.boardQuestionType1 = boardQuestionType1;
		this.boardQuestionType2 = boardQuestionType2;
	}

	public QuestionDomain() {
	}

	public int getBoardQuestionArticleNo() {
		return boardQuestionArticleNo;
	}

	public void setBoardQuestionArticleNo(int boardQuestionArticleNo) {
		this.boardQuestionArticleNo = boardQuestionArticleNo;
	}

	public String getBoardQuestionTitle() {
		return boardQuestionTitle;
	}

	public void setBoardQuestionTitle(String boardQuestionTitle) {
		this.boardQuestionTitle = boardQuestionTitle;
	}

	public String getBoardQuestionContents() {
		return boardQuestionContents;
	}

	public void setBoardQuestionContents(String boardQuestionContents) {
		this.boardQuestionContents = boardQuestionContents;
	}

	public String getBoardQuestionImage() {
		return boardQuestionImage;
	}

	public void setBoardQuestionImage(String boardQuestionImage) {
		this.boardQuestionImage = boardQuestionImage;
	}

	public Date getBoardQuestionUpdated() {
		return boardQuestionUpdated;
	}

	public void setBoardQuestionUpdated(Date boardQuestionUpdated) {
		this.boardQuestionUpdated = boardQuestionUpdated;
	}

	public String getBoardQuestionStatement() {
		return boardQuestionStatement;
	}

	public void setBoardQuestionStatement(String boardQuestionStatement) {
		this.boardQuestionStatement = boardQuestionStatement;
	}

	public int getBoardQuestionParentNO() {
		return boardQuestionParentNO;
	}

	public void setBoardQuestionParentNO(int boardQuestionParentNO) {
		this.boardQuestionParentNO = boardQuestionParentNO;
	}

	public String getBoardQuestionType1() {
		return boardQuestionType1;
	}

	public void setBoardQuestionType1(String boardQuestionType1) {
		this.boardQuestionType1 = boardQuestionType1;
	}

	public String getBoardQuestionType2() {
		return boardQuestionType2;
	}

	public void setBoardQuestionType2(String boardQuestionType2) {
		this.boardQuestionType2 = boardQuestionType2;
	}

	public Integer getProductNo() {
		return productNo;
	}

	public void setProductNo(Integer productNo) {
		this.productNo = productNo;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

}