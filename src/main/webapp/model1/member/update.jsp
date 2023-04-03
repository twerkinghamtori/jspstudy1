<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 모든 파라미터를 Member Bean 객체에 저장.
     2. 입력된 비밀번호와 db에 저장된 비밀번호를 비교.
          관리자인 경우 관리자비밀번호와 비교.
          불일치 : '비밀번호 오류' 메세지 출력 후 updateForm.jsp로 페이지 이동
     3. 일치 : Member 객체의 내용으로 db를 수정.
              - 성공 : 회원정보 수정 완료 메세지 출력 후 info.jsp 페이지로 이동
              - 실패 : 회원정보 수정 실패 메세지 출력 후 updateForm.jsp 페이지로 이동 --%>
<%
   //1
   request.setCharacterEncoding("UTF-8");
   Member mem = new Member();   
   mem.setId(request.getParameter("id"));
   mem.setPass(request.getParameter("pass"));
   mem.setName(request.getParameter("name"));
   mem.setGender(Integer.parseInt(request.getParameter("gender")));
   mem.setTel(request.getParameter("tel"));
   mem.setEmail(request.getParameter("email"));
   mem.setPicture(request.getParameter("picture"));
   //2
   String login = (String)session.getAttribute("login");
   MemberDao dao = new MemberDao();
   Member mem2 = dao.selectOne(login);
   if(!mem.getPass().equals(mem2.getPass())) { %>
   <script>
      alert("비밀번호 오류");
      location.href="updateForm.jsp?id="+ <%=mem.getId()%>;
   </script>
   <%} else { 
	   if(dao.update(mem)) { %>
		  <script>
		  alert("회원정보 수정 완료");
		  location.href="info.jsp?id="+<%=mem.getId()%>;
		  </script> 
	<% } else {%>
	      <script>
	      alert("회원정보 수정 실패");
	      location.href = "updateForm.jsp?id="+ <%=mem.getId()%>; //post 방식인데 id=? 이거 어캐씀?
	      </script>
    <% } %>
  <%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>