<%@page import="test.TestDao"%>
<%@page import="test.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
   request.setCharacterEncoding("UTF-8");
   Book book = new Book();
   book.setWriter(request.getParameter("writer"));
   book.setTitle(request.getParameter("title"));
   book.setContent(request.getParameter("content"));
   
   TestDao dao = new TestDao();
   String msg="방명록 등록 실패";
   String url="testForm.jsp";
   if(dao.insert(book)) {
	   msg="방명록 등록 완료!";
	   url="book.jsp";
   }
%>
<script>
   alert("<%=msg%>");
   location.href="<%=url%>";
</script>