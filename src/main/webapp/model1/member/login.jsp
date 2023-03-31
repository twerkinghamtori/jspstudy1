<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- 
    1. 파라미터 저장.
    2. db에서 id에 해당하는 정보를 읽어서 Member객체에 저장.
    3. db에 있는 내용과 입력된 내용을 비교 
       -id가 존재? : 없는 경우 : 아이디 없음 메세지 출력하고, loginForm.jsp 페이지로 이동
       -         : 있는 경우 : 비밀번호를 비교.
       -비밀번호 비교 : 일치 : session객체에 login 정보를 등록, main.jsp 페이지로 이동
                   : 불일치 : 비밀번호가 일치하지 않습니다 메세지를 출력하고, loginForm.jsp 페이지로 이동--%>
<% 
  //1
  request.setCharacterEncoding("UTF-8");
  String id = request.getParameter("id");
  String pass = request.getParameter("pass");
  //2
  Member mem = new MemberDao().selectOne(id);
  //3
  String msg = "아이디가 존재하지 않습니다.";
  String url = "loginForm.jsp";
  if(mem != null) { //아이디가 존재.
	  if(pass.equals(mem.getPass())) {//비밀번호 일치
		  session.setAttribute("login", id);
	      msg = mem.getName() + "님이 로그인 했습니다.";
	      url = "main.jsp";
	  } else { //비밀번호 틀림
		  msg="비밀번호가 일치하지 않습니다.";
	  }
  }
%>
<script>
     alert("<%=msg%>");
     location.href="<%=url%>";
</script>