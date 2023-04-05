<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
1. <sitemesh:write property='title'/> : joinForm.jsp 페이지의 title 태그의 내용을 여기에다가 붙혀줘.
2. <sitemesh:write property='head'/>  : joinForm.jsp 페이지의 head 태그 내용을 가져와서 붙혀줘.(단, title 제외.)
3. <sitemesh:write property='body'/>  : ,,
--%>
<%--
[http://localhost:8080/jspstudy1/mode1/member/joinForm.jsp]
1. request.getContextPath() : 프로젝트 path만 가지고 온다. => return /jspstudy1
2. request.getRequestURI(i) : 프로젝트+파일명 => return /jspstudy1/mode1/member/joinForm.jsp
3. request.getRequestURL(l) : 전체경로 => return http://localhost:8080/jspstudy1/mode1/member/joinForm.jsp
4. request.ServletPath()    : 파일명만 => /joinForm.jsp
5. request.getRealPath()    : 절대경로 => c:\project\webapps\...--%>

<% String path = request.getContextPath(); // "/jspstudy1" , request.getContextPath() = 프로젝트 path만 가지고옴.
//   System.out.println(path);%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><sitemesh:write property='title'/></title>
<link rel="stylesheet" href="<%=path %>/css/main.css">
<sitemesh:write property='head'/>
</head>
<body>
   <table>
      <tr>
         <td colspan="3" style="text-align:right">
         <% String login = (String)session.getAttribute("login");
            if(login == null) {%>
            <a href="<%=path%>/model1/member/loginForm.jsp">로그인</a>
            <a href="<%=path%>/model1/member/joinForm.jsp">회원가입</a>
         <% } else { %>
            <%=login %>님. <a href="<%=path %>/model1/member/logout.jsp">로그아웃</a>
         <% } %>
         </td>
      </tr>
      
      <tr>
         <td width="15%" valign="top">
            <a href="<%=path %>/model1/member/main.jsp">회원관리</a><br>
            <a href="<%=path %>/model1/board/list.jsp?boardid=1">공지사항</a><br>
            <a href="<%=path %>/model1/board/list.jsp?boardid=2">자유게시판</a><br>
            <a href="<%=path %>/model1/board/list.jsp?boardid=3">QnA</a><br>
         </td>
         <td colspan="2" style="text-align:left; vertical-align:top">
            <sitemesh:write property='body'/>
         </td>
      </tr>
      
      <tr>
         <td colspan="3">구디아카데미</td>         
      </tr>
   </table>
</body>
</html>