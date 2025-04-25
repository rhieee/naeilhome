package com.spring.naeilhome.board.board_question.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.board_question.domain.QuestionDomain;

@Repository("questionDAO")
public class QuestionDAOImpl implements QuestionDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertQuestion(QuestionDomain questionDomain) {
		sqlSession.insert("mapper.question.insertQuestion", questionDomain);
	}

	// 전체 문의사항 목록 조회
	@Override
	public List<QuestionDomain> selectAllQuestions() {
		return sqlSession.selectList("mapper.question.selectAllQuestions");
	}

	@Override
	public QuestionDomain selectQuestionByNo(int boardQuestionArticleNo) {
		return sqlSession.selectOne("mapper.question.selectQuestionByNo", boardQuestionArticleNo);
	}
	
	// 로그인한 사용자만 조회
	@Override
    public List<QuestionDomain> selectQuestionsByWriterId(String writerId) {
        return sqlSession.selectList("mapper.question.selectQuestionsByWriterId", writerId);
    }
	
}
