<%@page import="model.MemberDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 아이디 파라미터값을 조회
     2. login 상태 검증
        - 로그아웃 상태 : "로그인하세요" 메세지 출력후에 loginForm.jsp로 이동
        - 로그인 된 상태 : 다른 id를 수정하려고 하면 "내 정보만 수정이 가능합니다." 메세지 출력후에 main.jsp로 이동
     3. DB에서 id에 해당하는 데이터를 조회
     4. 조회된 내용을 화면에 출력(수정 전 화면) --%>
<%
  String id = request.getParameter("id");
  String login = (String)session.getAttribute("login");
 
  if(login==null) { %>
  <script>
     alert("로그인이 필요합니다.");
     location.href="loginForm.jsp";
  </script>
<%} else if(!id.equals(login) && !id.equals("admin")) {%>
  <script>
     alert("내 정보만 수정이 가능합니다.");
     location.href="main.jsp";
  </script>
<%} else {
  Member mem = new MemberDao().selectOne(id);
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
  function inputcheck(f) {
	  if(f.pass.value == "") {
		  alert("비밀번호를 입력하세요.");
		  f.pass.focus();
		  return false;
	  }
  }
  function win_passchg() {
	  let op = "width=500, height=250, left=50, top=150";
	  open("passwordForm.jsp", "", op);
  }
  function win_upload() {
	  let op = "width=500, height=150, left=50, top=150";
	  open("pictureForm.jsp", "", op);
  }
</script>
</head>
<body>
  <form action="update.jsp" name="f" method="post" onsubmit="return inputcheck(this)">
     <input type="hidden" name="picture" value="<%=mem.getPicture()%>">
     <table>
        <caption>회원 정보 수정</caption>
        <tr>
           <td rowspan="4" valign="bottom">
              <img src="picture/<%=mem.getPicture()%>" width="100" height="120" id="pic"><br>
              <font size="1"><a href="javascript:win_upload()">사진수정</a></font>
           </td>
           <th>아이디</th>
           <td>
              <input type="text" name="id" readonly value="<%=mem.getId()%>"> <!-- read/only => 수정 불가. disabled=true => 파라미터값이 넘어오지 않음. -->
           </td>
        </tr>
        <tr>
           <th>비밀번호</th>
           <td>
              <input type="password" name="pass">
           </td>
        </tr>
        <tr>
           <th>이름</th>
           <td>
              <input type="text" name="name" value="<%=mem.getName()%>">
           </td>
        </tr>
        <tr>
           <th>성별</th>
           <td>
              <input type="radio" name="gender" value="1"<%=mem.getGender()==1?"checked":""%>>남 <!-- input(radio) 태그 checked => check 되어 있음. -->
              <input type="radio" name="gender" value="2"<%=mem.getGender()==2?"checked":""%>>여 <!-- 회원정보의 성별이 2이면, radio버튼 checked, 아니면 ""(공백) -->
           </td>
        </tr>
        <tr>
           <th>전화번호</th>
           <td colspan="2">
              <input type="text" name="tel" value="<%=mem.getTel()%>">
           </td>
        </tr>
        <tr>
           <th>이메일</th>
           <td colspan="2">
              <input type="text" name="email" value="<%=mem.getEmail()%>">
           </td>
        </tr>
        <tr>
           <td colspan="3">
              <input type="submit" value="회원정보수정">
              <% if(id.equals(login)) { //관리자로 로그인한 경우 비밀번호 수정은 불가하도록. %>
              <input type="button" value="비밀번호수정" onclick="win_passchg()">
              <%} %>
           </td>
        </tr>
     </table>
  </form>
</body>
</html>
<%} %>