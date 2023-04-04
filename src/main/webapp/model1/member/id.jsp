<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 파라미터 값 저장(email, tel)
     2. db에서 두개의 파라미터를 이용해 id값을 리턴해주는 함수 => MemberDao.idSearch(email, tel) return id
     3. id 검증
          -id 존재 : opener(loginForm) 윈도우에 id값을 전달 -> 현재화면 close
          -id 존재x : 아이디를 찾을 수 없습니다. 현재화면을 idForm.jsp로 이동 --%>
<%
   request.setCharacterEncoding("UTF-8");
   String email = request.getParameter("email");
   String tel = request.getParameter("tel");
   MemberDao dao = new MemberDao();
   String id = dao.idSearch(email, tel);
   if(id==null) {%>
	   <script>
	   alert("아이디를 찾을 수 없습니다.")
	   location.href="idForm.jsp";
	   </script>
<% } else { %>
       <script>
       opener.document.f.id.value = '<%=id%>';
       self.close();
       </script>	    
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