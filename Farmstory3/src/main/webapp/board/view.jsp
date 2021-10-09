<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../_header.jsp" %>
 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	$(document).ready(function(){
    		
    		// 댓글 삭제
    		$('.btnCommentDel').click(function(){
    			var result = confirm('정말 삭제 하시겠습니까?');
    			return result;
    		});
    		
    		var content = '';

    		// 댓글 수정
    		$('.btnCommentModify').click(function(){
    			
    			var tag = $(this);
    			var mode = $(this).text();    			    			
    			var textarea = $(this).parent().prev();
    			
    			if(mode == '수정'){
    				// 수정모드
    				content = textarea.val(); 
    				
    				$(this).prev().css('display', 'none');
    				$(this).next().css('display', 'inline');
    				$(this).text('수정완료');
    				textarea.attr('readonly', false).focus();
        			textarea.css({
        				'background': 'white',
        				'outline': '1px solid gray'
        			});
        			
    			}else{
    				// 수정완료 모드
    				var seq     = textarea.attr('data-seq');
    				var comment = textarea.val(); 
    				var jsonData = {
    						'seq': seq,
    						'comment': comment
    					};
    				
    				$.ajax({
    					url: '/Farmstory3/board/updateComment.do',
    					type: 'post',
    					data: jsonData,   // 서버로 전송하는 데이터(JSON) 지정
    					dataType: 'json', // 서버로 부터 전달되는 데이터 종류
    					success: function(data){
    						if(data.result == 1){
    							alert('댓글 수정이 성공 했습니다.');
    							
    							// 수정모드 해제
    							tag.text('수정');
    							tag.prev().css('display', 'inline');
    							tag.next().css('display', 'none');    			    			    							
    			    			textarea.attr('readonly', true);
    			    			textarea.css({
    			    				'background': 'transparent',
    			    				'outline': 'none'
    			    			});
    			    			
    						}else{
    							alert('댓글 수정이 실패 했습니다.');
    						}
    					}
    				});
    			}
    			return false;
    		});
    		
    		// 댓글 수정 취소
    		$('.btnCommentCancel').click(function(e){
    			e.preventDefault();
    			$(this).prev().text('수정');
    			$(this).prev().prev().css('display', 'inline');
    			$(this).css('display', 'none');
    			
    			var textarea = $(this).parent().prev();
    			
    			textarea.val(content);
    			textarea.attr('readonly', true);
    			textarea.css({
    				'background': 'transparent',
    				'outline': 'none'
    			});	
    		});
    	});
    </script>
<jsp:include page="./_aside${group}.jsp">
	<jsp:param name="cate" value="${cate}"/>
</jsp:include>
<main>
        <section id="board" class="view">
            <table>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="title" value="${article.title}" readonly/></td>
                </tr>

				<c:if test="${article.file eq 1}">
	                <tr>
	                    <td>첨부파일</td>
	                    <td> 
	                    	<!-- 파일번호는 글 객체에 있다 -->
	                        <a href="/Farmstory3/board/fileDownload.do?fseq=${article.fb.fseq}">${article.fb.oriName}</a>
	                        <span>${article.fb.download} 회 다운로드</span>
	                    </td>
	                </tr>
                </c:if>
                
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea name="content" readonly>${article.content}</textarea>
                    </td>
                </tr>
            </table>
            
            <div>
           		 <c:if test="${sessMember.uid eq article.uid}">
	                <a href="/Farmstory3/board/delete.do?group=${group}&cate=${cate}&seq=${article.seq}" class="btnDelete">삭제</a>
	                <a href="/Farmstory3/board/modify.do?group=${group}&cate=${cate}&seq=${article.seq}&title=${article.title}&content=${article.content}" class="btnModify">수정</a>
	             </c:if>   
	             <a href="/Farmstory3/board/list.do?group=${group}&cate=${cate}" class="btnList">목록</a>
            </div>  
            
            <!-- 댓글리스트 -->
            <section class="commentList">
                <h3>댓글목록</h3>
                
                <c:forEach var="comment" items="${comments}">
                <article class="comment">
                    <span>
                        <span>${comment.nick}</span>
                        <span>${comment.rdate}</span>
                    </span>
                    <textarea name="comment" data-seq="${comment.seq}" readonly >${comment.content}</textarea>
                    <div>
                    	<c:if test="${sessMember.uid eq comment.uid}">
                        <a href="/Farmstory3/board/deleteComment.do?group=${group}&cate=${cate}&seq=${comment.seq}&parent=${comment.parent}" class="btnCommentDel">삭제</a>
                        <a href="#" class="btnCommentModify">수정</a>
                        <a href="#" class="btnCommentCancel" style="display:none">취소</a>
                        </c:if>
                    </div>
	               </article>
                </c:forEach>
                
                <c:if test="${comments.size() eq 0}">
                <p class="empty">
                    등록된 댓글이 없습니다.
                </p>
                </c:if>
            </section>

            <!-- 댓글입력폼 -->
            <section class="commentForm">
                <h3>댓글쓰기</h3>
                <form action="/Farmstory3/board/comment.do" method="post">
                	<input type="hidden" name="parent" value="${article.seq}"/>
                	<input type="hidden" name="uid" value="${sessMember.uid}"/>
                	<input type="hidden" name="group" value="${group}"/>
                	<input type="hidden" name="cate" value="${cate}"/>
                    <textarea name="content"></textarea>
                    <div>
                        <a href="#" class="btnCancel">취소</a>
                        <input type="submit" class="btnWrite" value="작성완료"/>
                    </div>
                </form>
            </section>
            
        </section>
  </main>
<%@ include file="../_footer.jsp" %>  