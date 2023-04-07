<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String id = request.getParameter("id");
   System.out.println(id);
   MemberDao dao = new MemberDao();
   Member mem = dao.selectOne(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>	
</head>
<body>
<% if(dao.selectOne(id) == null) { %>
<%=id %><br>
<h5 style="color:green">사용가능한 아이디 입니다.</h5>
<input type="button" value="닫기" onclick="javascript:self.close()">
<% } else{ %>
<script>
    opener.document.f.id.value="";
</script>
<%=id %><br>
<h5 style="color:red">사용할 수 없는 아이디 입니다.</h5>
<input type="button" value="닫기" onclick="javascript:self.close()">
<% } %>
</body>
</html>