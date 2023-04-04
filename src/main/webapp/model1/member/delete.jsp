<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 파라미터 정보 저장
     2. 로그인정보 검증
          -로그아웃 상태 : 로그인하세요. 메세지 출력 후 loginForm.jsp로 이동
          -다른사람 탈퇴 시도, 관리자제외 : 본인만 탈퇴 가능합니다. 메세치 출력 후 main.jsp로 이동
     3. 관리자 탈퇴는 불가.
          - 관리자 정보 탈퇴 시 관리자는 탈퇴 불가. 메세지 출력 후 list.jsp로 이동
     4. 비밀번호 검증
          - 로그인 정보로 비밀번호 검증.
               -비밀번호가 틀림 : 비밀번호가 틀렸습니다 출력 후 deleteForm.jsp로 이동
               -비밀번호 맞음 : db에서 delete 실행. (MemberDao delete(id))
                        -일반사용자 : 로그아웃.(세션정보 종료) 탈퇴가 완료되었습니다.출력 후 loginForm.jsp로 이동
                        -관리자 : 탈퇴 완료 메세지 출력 후 list.jsp로 이동
     5. 탈퇴 실패 - 일반사용자 : 탈퇴 실패 메세지 출력 후 info.jsp로 이동
                - 관리자 : 탈퇴 실패 메세지 출력 후 list.jsp로 이동
--%>
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