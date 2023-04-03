<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 관리자만 사용가능 페이지 => 검증
         -로그아웃 상태 : 로그인이 필요합니다. 메세지 출력 후 loginForm.jsp로 이동
         -로그인 상태,관리자x : 관리자만 이용가능합니다. 메세지 출력 후 main.jsp로 이동
     2. db에서 모든 회원정보를 조회. List<Member> 객체로 리턴.(MemberDao.list() 함수를 생성해야함)
     3. List객체를 이용하여 화면에 출력.
         - --%>
<%
   String login = (String)session.getAttribute("login");
   if(login==null) { %>
	   <script>
	   alert("로그인이 필요합니다.");
	   locatin.href="loginForm.jsp";
	   </script>
<% } else if(!login.equals("admin")) {%>  
       <script>
       alert("관리자만 접근가능합니다.");
       location.href = "main.jsp";
       </script> 
<% } else {
       List<Member> list = new MemberDao().list();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<table>
   <caption>회원목록</caption>
   <tr>
      <th>아이디</th>
      <th>사진</th>
      <th>이름</th>
      <th>성별</th>
      <th>전화번호</th>
      <th>&nbsp;</th>
   </tr>
   <% for(Member m : list) { %>
   <tr>
      <td><a href="info.jsp?id=<%=m.getId()%>"><%=m.getId() %></a></td>
      <td><img src="picture/<%=m.getPicture()%>" width="30" height="30"></td>
      <td><%=m.getName() %></td>
      <td><%=m.getGender()==1?"남":"여" %></td>
      <td><%=m.getTel() %></td>
      <td>
        <a href="updateForm.jsp?id=<%=m.getId()%>">수정</a>
        <a href="deleteForm.jsp?id=<%=m.getId()%>">강제탈퇴</a>
      </td>
   </tr>
   <% } %>
</table>
</body>
</html>
<% } %>