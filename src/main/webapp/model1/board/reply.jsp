<%@page import="model.BoardDao"%>
<%@page import="model.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
1. 파라미터 값을 Board 객체에 저장하기
    원글정보 : num, grp, grplevel, grpstep, boardid (hidden 태그로 들어옴) '페이지 소스보기'로 확인가능.
    답글정보 : writer, pass, title, content => 등록정보
2. 같은 grp 값을 사용하는 게시물들의 grpstep 값을 1 증가하기.
    void BoardDao.grpStepAdd(grp,grpstep)
3. Board 객체를 db에 insert 하기.
    num : maxnum+1
    grp : 원글과 동일.
    grplevel : 원글 +1
    grpstep : 원글 +1
    boardid : 원글과 동일
4. 등록 성공시 list.jsp 로 이동
       실패시 "답변 등록 시 오류 발생" 메세지 출력 후 replyForm.jsp로 이동 --%>
<%
   request.setCharacterEncoding("UTF-8");
   Board b = new Board();
   b.setWriter(request.getParameter("writer"));
   b.setPass(request.getParameter("pass"));
   b.setTitle(request.getParameter("title"));
   b.setContent(request.getParameter("content"));
   b.setBoardid(request.getParameter("boardid"));
   b.setGrp(Integer.parseInt(request.getParameter("grp")));
   b.setGrplevel(Integer.parseInt(request.getParameter("grplevel")));
   b.setGrpstep(Integer.parseInt(request.getParameter("grpstep")));
   
   BoardDao dao = new BoardDao();
   dao.grpStepAdd(b.getGrp(), b.getGrpstep());
   
   int grplevel = b.getGrplevel();
   int grpstep = b.getGrpstep();
   int num = dao.maxnum();
   b.setNum(++num);
   b.setGrplevel(grplevel + 1);
   b.setGrpstep(grpstep + 1);
   if(dao.insert(b)) {
	   response.sendRedirect("list.jsp?boardid="+b.getBoardid());
   } else { %>
<script>
   alert("답변 등록 시 오류발생");
   location.href="replyForm.jsp?num="+b.getNum();
</script>
<%}%>