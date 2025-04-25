package com.spring.naeilhome.board.board_question.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.naeilhome.board.board_question.dao.QuestionDAO;
import com.spring.naeilhome.board.board_question.domain.QuestionDomain;

@Service("questionService")
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	private QuestionDAO questionDAO;

	@Override
	public void insertQuestion(QuestionDomain questionDomain) {
		questionDAO.insertQuestion(questionDomain);
	}

	@Override
	public List<QuestionDomain> getAllQuestions() {
		return questionDAO.selectAllQuestions();
	}

	@Override
	public QuestionDomain getQuestionByNo(int boardQuestionArticleNo) {
		return questionDAO.selectQuestionByNo(boardQuestionArticleNo);
	}

	// 로그인한 사용자만 조회
	@Override
	public List<QuestionDomain> getQuestionsByWriterId(String writerId) {
		return questionDAO.selectQuestionsByWriterId(writerId);
	}
}