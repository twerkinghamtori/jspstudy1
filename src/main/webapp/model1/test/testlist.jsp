<%@page import="test.TestDao"%>
<%@page import="test.Book"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 방명록 목록 조회하기
   1. db에서 방명록 목록 조회하기
   2. 조회된 내용 화면에 출력하기
--%>
<%
   request.setCharacterEncoding("UTF-8");
   Book book = new Book();
   book.setWriter(request.getParameter("writer"));
   book.setTitle(request.getParameter("title"));
   book.setContent(request.getParameter("content"));
   TestDao dao = new TestDao();
   dao.insert(book);
   List<Book> list = new TestDao().list();   
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<table>
   <caption>방명록</caption>
   <tr>
      <th>작성자</th>
      <th>제목</th>
      <th>내용</th>
   </tr>
   <% for(Book b : list) { %>
   <tr>
      <td><%=b.getWriter()%></td>
      <td><%=b.getTitle()%></td>
      <td><%=b.getContent()%></td>
   </tr>
   <%} %>
</table>
</body>
</html>