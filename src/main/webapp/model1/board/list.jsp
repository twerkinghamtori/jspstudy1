<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="model.Board"%>
<%@page import="java.util.List"%>
<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1.한페이지당 10건의 게시물을 출력 pageNum 파라미터값을 저장 => 없는 경우는 1로 설정
     2.최근 등록된 게시물이 가장 위에 배치.
     3.db에서 해당 페이지에 출력될 내용을 조회하여 화면에 출력. 
               게시물을 출력하는 부분. 
               페이지 구분 출력 부분.
--%>
<%
   if(request.getParameter("boardid") != null) { 
	   session.setAttribute("boardid", request.getParameter("boardid"));
	   session.setAttribute("pageNum","1");
   }
   String boardid = (String)session.getAttribute("boardid");
   if(boardid == null) boardid="1"; //parameter가 안들어오면(null 이면) boardid=1, 공지사항.
   int pageNum=1;
   try {
	   pageNum = Integer.parseInt(request.getParameter("pageNum")); //pageNum에 오류가 나도(null or "a" 등등) 1로 인식하겠음.
   } catch(NumberFormatException e) {}
   
   int limit=10;
   BoardDao dao = new BoardDao();
   int boardcount = dao.boardCount(boardid); //boardCount = "게시판 종류별" 전체 등록 게시물 건수 => maxNum()은 삭제되거나 다른 boardid일떄 안되니까.
   List<Board> list = dao.list(boardid, pageNum, limit);
   
   //페이징 부분 시작.
// int maxpage = (int)Math.ceil(((double)boardcount/limit)); //필요한 페이지 개수 , Math.ceil() 하면 안되나? 
   int maxpage = (int)((double)boardcount/limit + 0.95);
   int startpage = ((int)(pageNum/10.0 + 0.9) -1)*10 +1; //화면에 출력될 시작 페이지 ex. [21]...[30] 에서 21
   int endpage = startpage + 9; //ex. [21]...[30] 에서 30
   if(endpage > maxpage) endpage = maxpage;
   
   String boardName = "공지사항";
   switch(boardid) {
   case "2" : boardName = "자유게시판"; break;
   case "3" : boardName = "QnA"; break;
   }
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 목록 보기</title>
</head>
<body>
<table>
   <caption><%=boardName%></caption>
<% if(boardcount ==0) {%>
   <tr>
      <td colspan="5"> 등록된 게시글이 없습니다.</td>
   </tr>
<% } else { %>
   <tr>
      <td colspan="5" style="text-align:right">글개수:<%=boardcount %></td>
   </tr>
   <tr>
      <th width="8%">번호</th>
      <th width="50%">제목</th>
      <th width="14%">작성자</th>
      <th width="17%">등록일</th>
      <th width="11%">조회수</th>
   </tr>
      <% int boardnum = boardcount-(pageNum-1)*10 +1;
         for(Board b : list) {
         boardnum--;
         Date date = b.getRegdate();
         Date date2 = new Date();
         SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
         %>
       <tr>
          <td><%=boardnum%></td>
          <%if(b.getFile1() == null) { %>
          <td style="text-align:left">
             &nbsp;&nbsp;&nbsp;<a href="info.jsp?num=<%=b.getNum() %>"><%=b.getTitle() %></a>
          </td>
          <%} else { 
              String path = application.getRealPath("/") + "model1/board/file/"; //web에서 절대경로로 경로탐색이 불가함.%> 
              <td style="text-align:left">
<%--              <a href="<%=path%><%=b.getFile1() %>">@</a>   --> <!-- web에서 절대경로로 경로탐색이 불가함. --> --%>           
                 <a href="file/<%=b.getFile1() %>">@</a> <!-- 현재폴더(file/) 밑에서 파일이름으로 찾을 것. 
                 http://localhost:8080/jspstudy1/model1/board/file/dog.jpg 로 요청 받게됨. 	-->
                 <a href="info.jsp?num=<%=b.getNum() %>"><%=b.getTitle() %></a>
              </td>
          <%} %>
          <td><%=b.getWriter() %></td>
          <% if(!sf.format(date2.getTime()).equals(sf.format(date))) {
        	  SimpleDateFormat sf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>
        	  <td><%=sf2.format(date) %></td>
          <% } else {
              SimpleDateFormat sf3 = new SimpleDateFormat("HH:mm:ss");%> 
              <td><%=sf3.format(date) %></td>        
          <% } %> 
          <td><%=b.getReadcnt() %></td>          
       </tr>
    <% } %>
    <%--페이지 처리 : [이전] 1,...,10 [다음]--%>
    <tr>
       <td colspan="5">
       <%if(pageNum <=1) {%> 
          [이전] 
       <%} else{ %>
          <a href="list.jsp?pageNum=<%=pageNum-1 %>">[이전]</a> 
       <%} %>
       <%for(int a=startpage; a<=endpage; a++) {%>
            <%if(a==pageNum) { //현재 보고있는 페이지는 하이퍼링크를 안거는거임. %> 
               [<%=a %>]
            <%} else { %>
                <a href="list.jsp?pageNum=<%=a %>">
                [<%=a %>]
                </a>
            <%} %>
       <%} %>
       <%if(pageNum >= maxpage) { %>
           [다음]
      <% } else { %>
            <a href="list.jsp?pageNum=<%=pageNum+1 %>">
               [다음]
            </a> 
       <%} %>               
       </td>
    </tr>
<%} %>
    <tr>
       <td colspan="5" style="text-align:right">
       <% String login = (String)session.getAttribute("login");
          if(!boardid.equals("1") || (login != null && login.equals("admin"))) { //공지사항에는 글쓰기버튼이 없음. admin만 쓸 수 있음. %>
             <p align="right">
                <a href="writeForm.jsp">[글쓰기]</a> <!-- boardcount가 0이어도 글쓰기 버튼이 있어야함. -->
             </p>
        <%} %>
       </td>
    </tr>
</table>
</body>
</html>