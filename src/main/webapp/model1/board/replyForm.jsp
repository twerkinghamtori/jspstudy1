<%@page import="model.Board"%>
<%@page import="model.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
1. 원글의 num을 파라미터로 저장 : num=원글의 번호
2. db에서 num의 게시물을 조회하여 원글의 num, grp, grplevel, grpstep 정보를 저장.(hidden 값으로 가지고 있는다)
3. 입력 화면 표시 --%>
<%
   int num = Integer.parseInt(request.getParameter("num")); //info.jsp에서 [답변]을 클릭할 때, 파라미터 넘겨줌. replyForm.jsp?num=@@ 형태로 넘김.
   BoardDao dao = new BoardDao();
   Board b = dao.selectOne(num);  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 답글쓰기</title>
</head>
<body>
   <form action="reply.jsp" method="post" name="f">
      <input type="hidden" name="num" value="<%=b.getNum() %>">
      <input type="hidden" name="grp" value="<%=b.getGrp() %>">
      <input type="hidden" name="grplevel" value="<%=b.getGrplevel() %>">
      <input type="hidden" name="grpstep" value="<%=b.getGrpstep() %>">
      <input type="hidden" name="boardid" value="<%=b.getBoardid() %>">
      
      <table>
         <caption>게시판 답글 등록</caption>
         <tr>
            <th>글쓴이</th>
            <td><input type="text" name="writer"></td>
         </tr>
         
         <tr>
            <th>비밀번호</th>
            <td><input type="password" name="pass"></td>
         </tr>
         
         <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="RE:<%=b.getTitle()%>"></td>
         </tr>
         
         <tr>
            <th>내용</th>
            <td><textarea name="content" rows="15"></textarea></td>
         </tr>
         
         <tr>
            <td colspan="2">
               <a href="javascript:document.f.submit()">[답변 글 등록]</a>
            </td>
         </tr>
      </table>
      
   </form>
</body>
</html>