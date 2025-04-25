package com.spring.naeilhome.board.board_question.service;

import java.util.List;

import com.spring.naeilhome.board.board_question.domain.QuestionDomain;

public interface QuestionService {

	void insertQuestion(QuestionDomain questionDomain);

	// 전체 문의사항 조회
	List<QuestionDomain> getAllQuestions();

	QuestionDomain getQuestionByNo(int boardQuestionArticleNo);
	
	// 로그인한 사용자만 조회
	List<QuestionDomain> getQuestionsByWriterId(String writerId);
}
