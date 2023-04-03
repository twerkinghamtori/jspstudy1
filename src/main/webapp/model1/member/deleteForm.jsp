<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1.id 파라미터 저장
     2.로그인 정보 검증
        - 로그아웃 상태 : 로그인하세요. 출력 후 loginForm.jsp로 이동
        - 관리자 제외, 다른 사용자 탈퇴 불가. 본인만 탈퇴 가능합니다. 메세지 출력 후 main.jsp 페이지로 이동
     3. 화면출력 --%>
<%
   request.setCharacterEncoding("UTF-8");
   String id=request.getParameter("id");
   String login = (String)session.getAttribute("login");
   if(login==null) { %>
	 <script>
	  alert("로그인이 필요합니다.")
	  location.href="loginForm.jsp";
	 </script>   
<%} else if(!id.equals(login) && !login.equals("admin")) {%>
     <script>
      alert("본인만 탈퇴 가능합니다.");
      location.href="main.jsp";
     </script>
<%} else {%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴 전 비밀번호 입력화면</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
   <form action="delete.jsp" method="post" onsubmit="return inputcheck(this)">
     <input type="hidden" name="id" value="<%=id %>">
     <table>
        <caption>회원 비밀번호 입력</caption>
        <tr>
           <th>비밀번호</th>
           <td><input type="password" name="pass"></td>
        </tr>
        <tr>
           <td colspan="2">
              <input type="submit" value="탈퇴하기">
           </td>
        </tr>
     </table>
   </form>
</body>
</html>
<% } %>