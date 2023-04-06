<%@page import="model.Board"%>
<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. num 파라미터 저장. session에서 boardid 조회하기
     2. num값의 게시물을 db에서 조회 BoardDao.selectOne(num)
     3. num값의 게시물의 조회수 증가시키기 void BoardDao.readcntAdd(num)
     4. 조회된 게시물 화면에 출력 --%>
<%
   int num = Integer.parseInt(request.getParameter("num")); //list.jsp에서 게시물 누르면서 num이라는 parameter가 전달됨.
   String boardid = (String)session.getAttribute("boardid");
   if(boardid==null) boardid="1";
   
   BoardDao dao = new BoardDao();
   Board b = dao.selectOne(num);
   
   dao.readcntAdd(num); //조회수 증가
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세 보기</title>
</head>
<body>
   <table>
      <caption>게시물 상세 보기</caption>
      <tr>
         <th width="20%">글쓴이</th>
         <td width="80%" style="text-align:left">
            <%=b.getWriter() %>
         </td>
      </tr>
      
      <tr>
         <th>제목</th>
         <td style="text-align:left;"><%=b.getContent() %></td>
      </tr>
      
      <tr>
         <th>내용</th>
         <td>
            <table style="width:100%; height:250px;">
               <tr>
                  <td style="border-width:0px; vertical-align:top; text-align:left">
                      <%=b.getContent() %>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
      
      <tr>
         <th>첨부파일</th>
         <td>
            <% if(b.getFile1() == null || b.getFile1().trim().equals("")) {%>
                &nbsp;
            <% } else { %>
                <a href="file/<%=b.getFile1() %>"><%=b.getFile1() %></a>
            <% } %>
         </td>
      </tr>
      
      <tr>
         <td colspan="2">
            <a href="replyForm.jsp?num=<%=b.getNum()%>">[답변]</a>
            <% String login = (String)session.getAttribute("login");
               if(!boardid.equals("1") || (login != null && login.equals("admin"))) {%>
                  <a href="updateForm.jsp?num=<%=b.getNum() %>">[수정]</a>
                  <a href="deleteForm.jsp?num=<%=b.getNum() %>">[삭제]</a>
            <% } %>
                  <a href="list.jsp">[목록]</a>
         </td>
      </tr>
   </table>
</body>
</html>