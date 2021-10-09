package kr.co.farmstory3.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory3.dao.ArticleDao;
import kr.co.farmstory3.vo.ArticleVo;

public class CommentService implements CommonService{

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String parent = req.getParameter("parent");
		String content = req.getParameter("content");
		String uid = req.getParameter("uid");
		String regip = req.getParameter("regip");
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		
		ArticleVo vo = new ArticleVo();
		vo.setParent(parent);
		vo.setContent(content);
		vo.setUid(uid);
		vo.setRegip(regip);
		ArticleDao.getInstance().insertComment(vo);
		ArticleDao.getInstance().updateCommentCountPlus(parent);
		
		return "redirect:/board/view.do?seq="+parent+"&group="+group+"&cate="+cate;
	}

}
