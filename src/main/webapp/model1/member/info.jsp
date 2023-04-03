<%@page import="model.Member"%>
<%@page import="model.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 아이디 파라미터값을 조회
     2. login 상태 검증
        - 로그아웃 상태 : "로그인하세요" 메세지 출력후에 loginForm.jsp로 이동
        - admin으로 로그인된 상태 : 모든 회원정보를 볼 수 있음.
        - 로그인 된 상태 : 다른 id를 조회하려고 하면 "내 정보 조회만 가능합니다." 메세지 출력후에 main.jsp로 이동
     3. DB에서 id에 해당하는 데이터를 조회
     4. 조회된 내용을 화면에 출력 --%>
<% 
   //1
   String id = request.getParameter("id");
   //2
   String login = (String)session.getAttribute("login");
   if(login==null) { //로그아웃 상태 %>
   <script>
      alert("로그인이 필요합니다.");
      location.href = "loginForm.jsp";
   </script>
<% } else if(!id.equals(login) && !login.equals("admin")) { //로그인정보와 id가 다르고, admin이 아닌경우(관리자가 아닌데 다른사람의 정보를 조회하려고 한 경우)%>
    <script>
      alert("내 정보만 조회 가능합니다.");
      location.href = "main.jsp";
    </script>
<%} else { // 접근이 올바른 경우 
	//mem : id 파라미터에 해당하는 db에 저장된 회원정보를 저장하고 있는 Member 객체
     Member mem = new MemberDao().selectOne(id); //login 값으로 읽으면 admin도 자기 정보만 조회할 수 있음. -> id값으로 읽어야 함. 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보 조회</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body> 
   <table>
     <caption>나의 정보 보기</caption>
     <tr>
        <td rowspan="6" width="30%">
           <img src="picture/<%=mem.getPicture()%>" width="200" height="210">
        </td>
        <th width="20%">
          아이디
        </th>
        <td>
           <%=mem.getId() %>
        </td>
     </tr>
     <tr>
        <th>이름</th>
        <td><%=mem.getName() %></td>
     </tr>
     <tr>
        <th>성별</th>
        <td><%=mem.getGender()==1?"남":"여" %></td>
     </tr>
     <tr>
        <th>전화번호</th>
        <td><%=mem.getTel() %></td>
     </tr>
     <tr>
        <th>이메일</th>
        <td><%=mem.getEmail() %></td>
     </tr>
     <tr>
        <td colspan="2">
           <a href="updateForm.jsp?id=<%=mem.getId()%>">수정</a>
           <a href="deleteForm.jsp?id=<%=mem.getId()%>">탈퇴</a>
        </td>
     </tr>
   </table>
</body>
</html>
<%} %>