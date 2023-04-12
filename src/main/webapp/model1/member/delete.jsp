<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String id = request.getParameter("id");
   String pass = request.getParameter("pass");
   String login = (String)session.getAttribute("login");
   MemberDao dao = new MemberDao();
   Member mem2 = dao.selectOne(login);
   Member mem = dao.selectOne(id);
   String msg=null;
   String url=null;
   if(login == null) {%>
      <script>
         alert("로그인이 필요합니다.");
         location.href="loginForm.jsp";
      </script>
<% } else if(!id.equals(login) && !login.equals("admin")) {%>
      <script>
          alert("본인만 탈퇴 가능합니다."); //deleteForm.jsp 에서 처리했는데 또해야함? 보안상..
          location.href="main.jsp";
      </script>
<% } else if(id.equals("admin") && login.equals("admin")) { %>
      <script>
          alert("관리자는 탈퇴가 불가합니다.");
          location.href="list.jsp";
      </script>
<% } else {
	   if(!pass.equals(mem2.getPass())) { %>
	       <script>
	          alert("비밀번호가 틀렸습니다.");
	          location.href="deleteForm.jsp?id=<%=id%>";
	       </script>
	<% } else {
		if(dao.delete(id)) {
		   if(login.equals("admin")) { %>
			<script>	
			  alert("강제 탈퇴 완료");
			  location.href="list.jsp";
			</script>
	    <%} else { 
		    session.invalidate(); //로그아웃 %>
	        <script>
	        alert("탈퇴 완료");
	        location.href="loginForm.jsp"
	        </script>
	    <%} %>
	 <%} else {
		   if(login.equals("admin")) { %>
		    <script>
		    alert("강제 탈퇴 실패");
		    location.href="list.jsp";
		    </script>
	  <% } else {%>
	        <script>
	         alert("탈퇴 실패");
	         location.href="info.jsp?id=<%=id%>";
	        </script>
	<% }  %>      
	<%} %>
<% }%>
<% } %>