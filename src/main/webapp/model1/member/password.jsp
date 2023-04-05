<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호 변경은 로그인한 정보로만 할 수 있도록 막아놨음. => session.getAttribute("login") --%>
<%
    request.setCharacterEncoding("UTF-8");
    String pass = request.getParameter("pass");
    String chgpass = request.getParameter("chgpass");
    String login = (String)session.getAttribute("login");
    if(login==null) {%>
    	<script>
    	  alert("로그인하세요.");
    	  opener.location.href="loginForm.jsp";
    	  self.close();
    	</script>
<%  } else {
	   MemberDao dao = new MemberDao();
	   Member mem = dao.selectOne(login);
	   if(!mem.getPass().equals(pass)) { %>	
		   <script>
		     alert("비밀번호 오류입니다.");
		     location.href="passwordForm.jsp";
		   </script>
<%     } else {
           if(dao.updatePass(login,chgpass)) {%>
        	   <script>
        	     alert("비밀번호 변경 성공.\\n 변경된 비밀번호로 다시 로그인하세요.");
        	     //opener.location.href="info.jsp?id=<%=login%>";
        	     //self.close();        	     
        	     opener.location.href="loginForm.jsp";
        	     self.close();
        	     session.invalidate();        	     
        	   </script>
<%         } else {%>
               <script>
                 alert("비밀번호 변경 실패");
                 opener.location.href="updateForm.jsp?id=<%=login%>";
                 self.close();
               </script>
<%         }%>                     
<%     }%>      	   
<% }%> 