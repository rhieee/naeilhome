package com.spring.naeilhome.board.reply.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.naeilhome.board.reply.domain.ReplyDomain;

@Repository("replyDAOImpl")
public class ReplyDAOImpl implements ReplyDAO{

	@Autowired
    private SqlSession sqlSession;
	
    @Autowired
    private ReplyDomain replyDomain;
	
	@Override
	public void addReply(ReplyDomain replyDomain) throws DataAccessException {
		sqlSession.insert("mapper.board.addReply", replyDomain);
	}

	@Override
	public List<ReplyDomain> replyList(Map<String, Integer> paging) throws DataAccessException{
		return sqlSession.selectList("mapper.board.replyList", paging);
	}

	@Override
	public void addRereply(ReplyDomain replyDomain) throws DataAccessException {
		sqlSession.insert("mapper.board.addRereply", replyDomain);
	}

	@Override
	public void deleteRereply(int replyNo) throws DataAccessException {
		sqlSession.delete("mapper.board.deleteRereply", replyNo);
	}

	@Override
	public void modRereply(ReplyDomain replyDomain) throws DataAccessException {
		sqlSession.delete("mapper.board.modRereply", replyDomain);
	}

	@Override
	public int totalReplys(int boardMyhomeArticleNo) throws DataAccessException{
		int totalReplys = sqlSession.selectOne("mapper.board.totalReplys", boardMyhomeArticleNo);
		return totalReplys;	
	}

}
