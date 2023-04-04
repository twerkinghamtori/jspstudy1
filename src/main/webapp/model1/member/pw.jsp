<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
  1. 파라미터 저장.
  2. db에서 id,email과 tel 을 이용하여 id값을 리턴
       pass = MemberDao.pwSearch(id,email,tel)
  3. 비밀번호 검증 
     비밀번호 찾은 경우 :화면에 앞 두자리는 **로 표시하여 화면에 출력. 닫기버튼 클릭시 
                     현재 화면 닫기
     비밀번호 못찾은 경우: 정보에 맞는 비밀번호를 찾을 수 없습니다.  메세지 출력후
                     pwForm.jsp로 페이지 이동. 
--%> 
<% 
   request.setCharacterEncoding("UTF-8");
   String id = request.getParameter("id");
   String email = request.getParameter("email");
   String tel = request.getParameter("tel");
   MemberDao dao = new MemberDao();
   String pass = dao.pwSearch(id, email, tel);
   if(pass==null) {%>
       <script>
          alert("정보에 맞는 비밀번호를 찾을 수 없습니다.");
          self.close();
       </script>
<% } else {%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h3>비밀번호는 <%=pass%> 입니다.</h3>
</body>
</html>
<% } %>