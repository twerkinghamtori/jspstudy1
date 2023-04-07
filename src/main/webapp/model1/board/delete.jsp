<%@page import="model.Board"%>
<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
1. num, pass 파라미터를 변수에 저장.
2. 비밀번호 검증
     틀린경우 : 비밀번호 오류 메세지 출력, deleteForm.jsp로 이동
3. 해당게시물이 공지사항 게시물인 경우 관리자만 삭제 가능
4. 게시물 삭제
     boolean BoardDao.delete(num)
     삭제 성공 : list.jsp 페이지로 이동
     삭제 실패 : 실패 메세지 출력 후 info.jsp 페이지로 이동 --%>
<%
   String login = (String)session.getAttribute("login");
   int num = Integer.parseInt(request.getParameter("num"));
   String pass = request.getParameter("pass");
   String boardid = (String)session.getAttribute("boardid");
   if(boardid==null) boardid="1";   
   BoardDao dao = new BoardDao();
   Board dbboard = dao.selectOne(num);
   if(!pass.equals(dbboard.getPass())) {%>
      <script>
      alert("비밀번호가 다릅니다.");
      location.href="deleteForm.jsp?num=<%=num%>";
      </script>
<%    return; //jsp servie 함수 종료.
   }
   if(dbboard.getBoardid().equals("1")) { 
      if(login==null || !login.equals("admin")) {%>
      <script>
         alert("관리자만 삭제 가능합니다.");
         location.href="list.jsp?boardid=<%=dbboard.getBoardid()%>";
      </script>
    <% return;
      } %>
 <%} 
  if(dao.delete(num)) {%> 
     <script>
       location.href="list.jsp?boardid=<%=dbboard.getBoardid()%>";
     </script>
<%} else{ %>  
     <script>
       alert("삭제 실패");
       location.href="info.jsp?num=<%=num%>";
     </script>
<%} %>