package com.spring.naeilhome.mypage.myhome.domain;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("myPageMyhomeDomain")
public class MyPageMyhomeDomain {

    private int boardMyhomeArticleNo; // 게시글번호
    private String memberId; // 작성자 아이디
    private String boardMyhomeTitle;  // 제목
    private String boardMyhomeContents;  // 내용
    private int boardMyhomeLikes;  // 좋아요
    private int boardMyhomeViews;  // 조회수
    private Date boardMyhomeUpdated;  // 등록일
    private String boardMyhomeHomeSize;  // 평수 카테고리
    private String boardMyhomeHousingType;  // 주거형태 카테고리
    private String imageFileName; // 커버이미지 파일이름
    
    private int startRow; // 시작 행 번호
    private int endRow;   // 끝 행 번호

    public MyPageMyhomeDomain() {
    }

    // 전체 필드 포함하는 생성자
    public MyPageMyhomeDomain(int boardMyhomeArticleNo, String memberId, String boardMyhomeTitle, String boardMyhomeContents,
                              int boardMyhomeLikes, int boardMyhomeViews, Date boardMyhomeUpdated, String boardMyhomeHomeSize,
                              String boardMyhomeHousingType, String imageFileName, int startRow, int endRow) {
        this.boardMyhomeArticleNo = boardMyhomeArticleNo;
        this.memberId = memberId;
        this.boardMyhomeTitle = boardMyhomeTitle;
        this.boardMyhomeContents = boardMyhomeContents;
        this.boardMyhomeLikes = boardMyhomeLikes;
        this.boardMyhomeViews = boardMyhomeViews;
        this.boardMyhomeUpdated = boardMyhomeUpdated;
        this.boardMyhomeHomeSize = boardMyhomeHomeSize;
        this.boardMyhomeHousingType = boardMyhomeHousingType;
        this.imageFileName = imageFileName;
        this.startRow = startRow;
        this.endRow = endRow;
    }
    @Override
    public String toString() {
    	return "MyPageMyhomeDomain [boardMyhomeArticleNo=" + boardMyhomeArticleNo + ", memberId=" + memberId
    			+ ", boardMyhomeTitle=" + boardMyhomeTitle + ", boardMyhomeContents=" + boardMyhomeContents
    			+ ", boardMyhomeLikes=" + boardMyhomeLikes + ", boardMyhomeViews=" + boardMyhomeViews
    			+ ", boardMyhomeUpdated=" + boardMyhomeUpdated + ", boardMyhomeHomeSize=" + boardMyhomeHomeSize
    			+ ", boardMyhomeHousingType=" + boardMyhomeHousingType + ", imageFileName=" + imageFileName
    			+ ", startRow=" + startRow + ", endRow=" + endRow + "]";
    }

    public int getStartRow() {
        return startRow;
    }

    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }

    public int getEndRow() {
        return endRow;
    }

    public void setEndRow(int endRow) {
        this.endRow = endRow;
    }



	public int getBoardMyhomeArticleNo() {
		return boardMyhomeArticleNo;
	}

	public void setBoardMyhomeArticleNo(int boardMyhomeArticleNo) {
		this.boardMyhomeArticleNo = boardMyhomeArticleNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getBoardMyhomeTitle() {
		return boardMyhomeTitle;
	}

	public void setBoardMyhomeTitle(String boardMyhomeTitle) {
		this.boardMyhomeTitle = boardMyhomeTitle;
	}

	public String getBoardMyhomeContents() {
		return boardMyhomeContents;
	}

	public void setBoardMyhomeContents(String boardMyhomeContents) {
		this.boardMyhomeContents = boardMyhomeContents;
	}

	public int getBoardMyhomeLikes() {
		return boardMyhomeLikes;
	}

	public void setBoardMyhomeLikes(int boardMyhomeLikes) {
		this.boardMyhomeLikes = boardMyhomeLikes;
	}

	public int getBoardMyhomeViews() {
		return boardMyhomeViews;
	}

	public void setBoardMyhomeViews(int boardMyhomeViews) {
		this.boardMyhomeViews = boardMyhomeViews;
	}

	public Date getBoardMyhomeUpdated() {
		return boardMyhomeUpdated;
	}

	public void setBoardMyhomeUpdated(Date boardMyhomeUpdated) {
		this.boardMyhomeUpdated = boardMyhomeUpdated;
	}

	public String getBoardMyhomeHomeSize() {
		return boardMyhomeHomeSize;
	}

	public void setBoardMyhomeHomeSize(String boardMyhomeHomeSize) {
		this.boardMyhomeHomeSize = boardMyhomeHomeSize;
	}

	public String getBoardMyhomeHousingType() {
		return boardMyhomeHousingType;
	}

	public void setBoardMyhomeHousingType(String boardMyhomeHousingType) {
		this.boardMyhomeHousingType = boardMyhomeHousingType;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

}