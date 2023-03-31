<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- 1. 파라미터 정보를 Member객체에 저장.
         2. Member객체를 이용하여 db에 insert (member 테이블)
         3. 가입성공 : db에 등록 => loginForm.jsp 페이지로 이동
            가입실패 : joinForm.jsp 페이지로 이동 --%>
<% //1
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
   MemberDao dao = new MemberDao();
   String msg = "회원가입 실패";
   String url = "joinForm.jsp";
   //mem : 회원가입 정보를 저장하고 있는 Member 객체
   if(dao.insert(mem)) {
	   msg="회원가입 성공";
	   url = "loginForm.jsp";
   }
%>
<%--3 --%>
<script type="text/javascript">
   alert("<%=msg%>");
   location.href="<%=url%>";
</script>