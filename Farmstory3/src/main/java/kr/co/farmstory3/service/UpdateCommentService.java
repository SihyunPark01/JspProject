package kr.co.farmstory3.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.farmstory3.dao.ArticleDao;

public class UpdateCommentService implements CommonService{

	@Override
	public String requestProc(HttpServletRequest req, HttpServletResponse resp) {
		
		String seq = req.getParameter("seq"); //댓글번호
		String comment = req.getParameter("comment"); //수정한 댓글 내용
		
		int result = ArticleDao.getInstance().updateComment(seq, comment); //댓글 수정
		
		//String json = "{'result': "+result+"}";
		
		JsonObject json = new JsonObject(); //Json 생성
		json.addProperty("result", result); //result 결과값 1
		
		return "json:"+json.toString();
		//return "redirect:/board/view.do?group=Market&cate=market&seq=34124";
	}

}
