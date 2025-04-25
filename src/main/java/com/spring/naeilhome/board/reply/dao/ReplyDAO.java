package com.spring.naeilhome.board.reply.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.spring.naeilhome.board.reply.domain.ReplyDomain;

public interface ReplyDAO {

	public void addReply(ReplyDomain replyDomain) throws DataAccessException;

	public List<ReplyDomain> replyList(Map<String, Integer> paging) throws DataAccessException;

	public void addRereply(ReplyDomain replyDomain) throws DataAccessException;

	public void deleteRereply(int replyNo) throws DataAccessException;

	public void modRereply(ReplyDomain replyDomain) throws DataAccessException;

	public int totalReplys(int boardMyhomeArticleNo) throws DataAccessException;


}