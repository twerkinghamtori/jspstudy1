<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 파라미터 값 저장(email, tel)
     2. db에서 두개의 파라미터를 이용해 id값을 리턴해주는 함수 => MemberDao.idSearch(email, tel) return id
     3. id 검증
          -id 존재 : 1. opener(loginForm) 윈도우에 id값을 전달 -> 현재화면 close
                    2. 화면에 뒤쪽 2자만 ** 표시하여 화면에 출력하기 -> 아이디 전송 버튼을 클릭하면 opener 윈도우에 id값 전달. 현재화면 close
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디찾기</title>
<script>
  function idsend(id) {
	  opener.document.f.id.value = id;
	  self.close();
  }           
</script>
</head>
<body>
    <h3>아이디는 <%=id.substring(0,id.length()-2) + "**" %> 입니다.</h3>
    <input type="button" value="아이디전송" onclick="idsend('<%=id.substring(0,id.length()-2)%>')">
</body>
</html>
<% } %>