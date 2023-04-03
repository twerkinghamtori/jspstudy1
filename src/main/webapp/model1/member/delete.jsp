<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String login = (String)session.getAttribute("login");
   Member mem = new Member();
   mem.setPass(request.getParameter("pass"));
   MemberDao dao = new MemberDao();
   Member mem2 = dao.selectOne(login);
   if(!mem.getPass().equals(mem2.getPass())) { %>
      <script>
         alert("비밀번호가 일치하지 않습니다.");
         location.href="deleteForm.jsp";
      </script>
<% } else {
      if(dao.delete(mem2.getId())) {%>
      <script>
         alert("탈퇴 성공");
         location.href="main.jsp"
      </script>
      <%} %>
<% } %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>