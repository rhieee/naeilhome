package com.spring.naeilhome.board.board_question.dao;

import java.util.List;

import com.spring.naeilhome.board.board_question.domain.QuestionDomain;

public interface QuestionDAO {
	void insertQuestion(QuestionDomain questionDomain);

	// 전체 문의사항 목록 조회
	List<QuestionDomain> selectAllQuestions();

	// 기존 메서드와 함께
	QuestionDomain selectQuestionByNo(int boardQuestionArticleNo);

}
