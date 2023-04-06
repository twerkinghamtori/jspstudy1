<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String login = (String)session.getAttribute("login"); 
   String boardid = (String)session.getAttribute("boardid");
   if(boardid==null) boardid="1";%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<script type="text/javascript">
   function inputcheck() {
	   f = document.f;
	   if(f.name.value=="") {
		   alert("글쓴이를 입력하세요.")
		   f.name.focus();
		   return;
	   }
	   if(f.pass.value=="") {
		   alert("비밀번호를 입력하세요.")
		   f.pass.focus();
		   return;
	   }
	   if(f.title.value=="") {
		   alert("제목을 입력하세요.")
		   f.title.focus();
		   return;
	   }
	   if(f.content.value=="") {
		   alert("내용을 입력하세요.")
		   f.content.focus();
		   return;
	   }
	   f.submit(); //submit 발생 => form의 action 페이지로 요청을 해주는 기능.
   }
</script>
</head>
<body>
<form action="write.jsp" method="post" enctype="multipart/form-data" name="f"> <!-- enctype : request객체 못쓰겟구나.. -->
   <table>
      <caption>게시판 글쓰기</caption>
      <tr>
         <td>글쓴이</td>
         <td><input type="text" name="writer"></td>
      </tr>
      
      <tr>
         <td>비밀번호</td>
         <td><input type="password" name="pass"></td>
      </tr>
      
      <tr>
         <td>제목</td>
         <td><input type="text" name="title"></td>
      </tr>
      
      <tr>
         <td>내용</td>
         <td><textarea rows="15" name="content"></textarea></td>
      </tr>
      
      <tr>
         <td>첨부파일</td>
         <td><input type="file" name="file1"></td>
      </tr>
      
     
      <tr>
         <td colspan="2">
         <%if(!boardid.equals("1") || (login!=null && login.equals("admin"))) {%>
            <a href="javascript:inputcheck()">[게시물등록]</a>
         <%} else { %>
             &nbsp;
         <%} %>
         </td>
      </tr>
   </table>
</form>
</body>
</html>