package com.spring.naeilhome.board.reply.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.naeilhome.board.reply.dao.ReplyDAO;
import com.spring.naeilhome.board.reply.domain.ReplyDomain;

@Service("replyServiceImpl")
@Transactional(propagation = Propagation.REQUIRED)
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	ReplyDAO replyDAO;
	
	@Autowired
	ReplyDomain replyDomain;
	
	
	@Override
	public void addReply(ReplyDomain replyDomain) throws Exception {
		replyDAO.addReply(replyDomain);
	}

	@Override
	public List<ReplyDomain> replyList(Map<String, Integer> paging) throws Exception{
		return replyDAO.replyList(paging);
	}

	@Override
	public void addRereply(ReplyDomain replyDomain) throws Exception {
		replyDAO.addRereply(replyDomain);
	}

	@Override
	public void deleteRereply(int replyNo) throws Exception {
		replyDAO.deleteRereply(replyNo);
	}

	@Override
	public void modRereply(ReplyDomain replyDomain) throws Exception {
		replyDAO.modRereply(replyDomain);
	}
	
	@Override
	public ReplyDomain pagingInfo(int pageNum, int boardMyhomeArticleNo) throws Exception{
				
		int totalReplys = totalReplys(boardMyhomeArticleNo); // 총 게시글 수
		int totalPages = (totalReplys/10)+1; // 총 페이지 수 151개라면 15페이지가 아닌 16페이지여야 하기때문에 +1 // 맨 앞 숫자를 임의 변경하면 페이지 조절해서 테스트 가능
		int pagePcs = 10; // 하단에 표시할 페이지 갯수
		int startPage = (pageNum/pagePcs)*pagePcs+1; // 현재 페이지가 5이면 0*10+1=1 // 20이면 2*10+1=21
		int endPage = startPage+pagePcs-1; // 1+10-1=10 // 20이면 21+10 =31
				
				
		// 이전 페이지로 돌아갈 경우와 10단위 페이지 설정임.
		totalPages = (totalReplys%10==0)? totalPages-1:totalPages; // 만약 10으로 나누어지는 갯수라면 1페이지를 추가할 필요가 없기 때문에 // 맨 앞 숫자를 임의 변경하면 페이지 조절해서 테스트 가능
		// 20이면                                     20           21
				
		endPage = (pageNum%10==0)? startPage-1:endPage; // 위와 같은 이유로 페이지번호가 10으로 나누어진다면 1페이지를 더해줄 필요가 없기 때문
		// 20이면                                      20            31     20이됨.
		startPage = (pageNum%10==0)? pageNum-10+1:startPage;
		// 20이면                                   20-10+1                21      11이됨.
				
		// 이로써 20으로 페이지 번호가 들어오게 되면 11부터 20까지 페이지를 표시하게 됨.
				
				
		// 토탈 페이지가 앤드 페이지 보다 크다면 페이지가 무한정 생성되고 존재해서는 안되는 일이기에 설정
		endPage = totalPages<endPage? totalPages:endPage;
		
		
		System.out.println("totalReplys" + totalReplys);
		System.out.println("totalPages" + totalPages);
		System.out.println("pagePcs" + pagePcs);
		System.out.println("startPage" + startPage);
		System.out.println("endPage" + endPage);
				
		return new ReplyDomain(totalReplys, totalPages, pagePcs, startPage, endPage);
				
	}

	@Override
	public int totalReplys(int boardMyhomeArticleNo) throws Exception{
		int totalReplys = replyDAO.totalReplys(boardMyhomeArticleNo);
		return totalReplys;
	}

}
