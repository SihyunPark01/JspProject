package kr.co.farmstory3.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.farmstory3.dao.ArticleDao;

public class DeleteCommentService implements CommonService{

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String seq = req.getParameter("seq"); //댓글번호
		String parent = req.getParameter("parent"); //댓글번호

		ArticleDao.getInstance().deleteComment(seq);
		ArticleDao.getInstance().updateCommentCountMinus(parent);
		
		return "redirect:/board/view.do?group="+group+"&cate="+cate+"&seq="+parent;
	}

}
