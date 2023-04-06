<%@page import="model.BoardDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="model.Board"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 파라미터값 Board 객체에 저장. boardid 파라미터가 없으면 1로 설정.
     2. num 프로퍼티를 db에 등록된 최대 num값+1
     3. db의 board 테이블에 등록
           -등록성공 : list.jsp
           -등록실패 : 메세지 출력 후 writeForm.jsp로 이동 --%>
<%
   String path = application.getRealPath("/") +"model1/board/file";
   File f = new File(path);
   if(!f.exists()) f.mkdirs();
   MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "UTF-8");
   Board board = new Board();
   board.setWriter(multi.getParameter("writer"));
   board.setPass(multi.getParameter("pass"));
   board.setTitle(multi.getParameter("title"));
   board.setContent(multi.getParameter("content"));
   board.setFile1(multi.getFilesystemName("file1")); //file 이름 가지고 올때는 getFilesystemName()임. getParameter()하지 않게 주의할 것
   String boardid = (String)session.getAttribute("boardid");
   if(boardid==null) boardid = "1";
   board.setBoardid(boardid);
   
   BoardDao dao = new BoardDao();
   int num = dao.maxnum(); //최대 num 값.
   board.setNum(++num);
   board.setGrp(num);
   
   if(dao.insert(board)) {
	   response.sendRedirect("list.jsp");
   } else {%>
       <script>
         alert("게시물 등록 실패");
         location.href="writeForm.jsp";
       </script>
<% } %>   
   
