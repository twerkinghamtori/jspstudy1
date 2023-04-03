<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--1.session에 로그인 정보 제거
    2. 로그아웃 메세지 출력 후 loginForm.jsp로 이동
     --%>
<% session.removeAttribute("login");  //session 객체는 그대로, login이라는 속성 정보만 제거.
   session.invalidate(); //session 유지 기간이 남았지만, 새로운 session객체로 새로고침. 이전에 등록된 속성들이 모두 제거됨.
//   response.sendRedirect("loginForm.jsp"); //이거 쓰면 브라우저가 loginForm.jsp를 요청하기 때문에, 알림창을 띄울 수 없음. (브라우저가 뭔가 해야하면 이거 못 씀.)
   
%>
<script>
  alert("로그아웃 되었습니다.");
  location.href = "loginForm.jsp"; //현재 페이지를 loginForm.jsp로 변경해주는 것.
</script>
