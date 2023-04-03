<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 로그인 여부 검증
        로그인 상태 : 현재 화면
        로그아웃 상태 : 로그인이 필요한 화면입니다. 메세지 출력 후 loginForm.jsp 페이지로 이동. --%>
<%
   String login = (String)session.getAttribute("login"); //login.jsp => session.setAttribute("login", id); 여기서 "login"이라는 이름으로 id를 session에 저장함.
   if(login != null) { //session에 저장된 id 값이 있는 상태 = login 되어있는 상태
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
</head>
<body>
   <h3><%=login %>로 로그인 되었습니다.</h3>
   <h3><a href="logout.jsp">로그아웃</a></h3>
   <h3><a href="info.jsp?id=<%=login %>">나의 정보 보기</a></h3>
   <%  if(login.equals("admin")) { //id가 admin이라면, (관리자라면)%>
    	  <h3><a href="list.jsp">회원목록 보기</a></h3>
   <%} %>    
</body>
</html>
<% } //if(login !=null) 구문의 끝  
  else { %>
    <script>
       alert("로그인이 필요합니다."); 
       location.href="loginForm.jsp";
    </script> 
<% } %>