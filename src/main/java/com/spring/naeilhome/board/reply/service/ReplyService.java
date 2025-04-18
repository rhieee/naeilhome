package com.spring.naeilhome.board.reply.service;

import java.util.List;
import java.util.Map;

import com.spring.naeilhome.board.reply.domain.ReplyDomain;

public interface ReplyService {

	public void addReply(ReplyDomain replyDomain) throws Exception;

	public List<ReplyDomain> replyList(Map<String, Integer> paging) throws Exception;

	public void addRereply(ReplyDomain replyDomain) throws Exception;

	public void deleteRereply(int replyNo)throws Exception;

	public void modRereply(ReplyDomain replyDomain)throws Exception;

	public ReplyDomain pagingInfo(int pageNum, int boardMyhomeArticleNo)throws Exception;
	
	public int totalReplys(int boardMyhomeArticleNo)throws Exception;

}
