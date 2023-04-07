<%@page import="model.BoardDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="model.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
1. 파라미터 정보들을 Board 객체에 저장
2. 비밀번호 검증
      비밀번호 오류 메세지 출력 후 updateForm.jsp로 이동
3. 첨부파일의 변경이 없는 경우 file2 파라미터 내용을 다시 저장하기
   파라미터의 내용으로 해당 게시물의 내용을 수정하기.
      boolean BoardDao,update(Board)	
         수정성공 : info.jsp 페이지로 이동
         수정실패 : 수정실패 메세지 출력 후 updateForm.jsp로 이동 --%>
<%
   Board b = new Board();
   String path = application.getRealPath("/") + "model1/board/file/";
   MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "UTF-8");
   b.setNum(Integer.parseInt(multi.getParameter("num")));
   b.setFile1(multi.getFilesystemName("file1")); //file1 : 변경하려는 파일명, 변경하려는 파일명으로 board객체에 file1을 set
   b.setWriter(multi.getParameter("writer"));
   b.setPass(multi.getParameter("pass"));
   b.setTitle(multi.getParameter("title"));
   b.setContent(multi.getParameter("content"));
   if(b.getFile1()==null || b.getFile1().equals("")) { //만약 변경하려는 파일명이 null이거나 공백이라면, board 객체에 file1을 변경 전 파일명으로. 
	   b.setFile1(multi.getParameter("file2")); //file2는 type이 hidden 이라서 filesystemname 안해도 되는건가? 음...파라미터니까..? 뭔 차이지..
   } //file2 : 변경 전 파일명
   BoardDao dao = new BoardDao();
   Board dbboard = dao.selectOne(b.getNum());  //비밀번호 비교를 위해서 db에 저장된 pass와 파라미터로 받은 pass를 비교 
   if(!b.getPass().equals(dbboard.getPass())) {%>
   <script> //url입력할 때 파라미터 있는지 확인할 것.
      alert("비밀번호가 다릅니다.");
      location.href="updateForm.jsp?num=<%=b.getNum()%>"; 
   </script>
<%} else { 
       if(dao.update(b)) { %>
    	 <script>
    	  location.href="info.jsp?num=<%=b.getNum()%>";
         </script>
   <% } else {%> 
    	 <script>
    	   alert("수정 실패");
    	   location.href="updateForm.jsp?num=<%=b.getNum()%>";
    	 </script>
   <% } %>
<%} %>  
<!-- 밑에 html이 남아있으면 sitemesh 때문에 body부분을 먼저 가져오기 때문에 없애야 alert창이 뜸.
그럼 sitemesh가 alert창 보다 우선순위가 높은건가?	 -->