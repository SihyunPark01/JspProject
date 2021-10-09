package kr.co.farmstory3.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmstory3.dao.ArticleDao;
import kr.co.farmstory3.vo.ArticleVo;
import kr.co.farmstory3.vo.MemberVo;

public class ViewService implements CommonService {
	
	//modifyService랑 viewService만 get,post방식으로 분기하면 됨.

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {

		HttpSession sess = req.getSession();
		
		String seq = req.getParameter("seq");
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		//String includeFile = "./_aside"+group+".jsp";
		
		MemberVo sessMember = (MemberVo) sess.getAttribute("sessMember");
		
		if(sessMember == null) {
			
			return "redirect:/member/login.do?success=102";
			
		} else {
			ArticleVo article1 = new ArticleVo();
			ArticleDao dao = ArticleDao.getInstance();
			
			dao.updateArticleHit(seq); //
			article1 = dao.selectArticle(seq);
			
			req.setAttribute("article", article1);
			
			List<ArticleVo> comments = dao.selectComments(seq);
			//List<ArticleVo> comments = new ArrayList<>();
			//comments = dao.selectComments(seq);
			req.setAttribute("comments", comments);
			
			req.setAttribute("group", group);
			req.setAttribute("cate", cate);
			
			return "/board/view.jsp";
		}
	}
}
