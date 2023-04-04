<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 파일 다운로드 http://servlets.com/cos => cos.jar파일 web-inf에 넣음. --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일업로드 예제</title>
<link rel="stylesheet" href="../../css/main.css">
</head>
<body>
<!-- enctype="multipart/form-date" => enctype(=encoding type)파일 업로드를 위한 설정. 파라미터 뿐만 아니라 업로드할 파일의 내용까지 서버로 전송.
                  (1) <input type="file"...> 태그가 존재해야함. => 선택된 파일의 내용까지 서버로 전송하겠음.
                  (2) method="post" 메서드는 반드시 post 방식이어야함
                  (3) upload.jsp 페이지는 request 객체를 직접 사용할 수 없음. => cos.jar에 설정된 multipart request를 사용해야함. -->
<form action="upload.jsp" method="post" enctype="multipart/form-data"> 
   <table>
      <tr>
         <th>올린사람</th>
         <td>
            <input type="text" name="name">
         </td>
      </tr>
      <tr>
         <th>제목</th>
         <td>
            <input type="text" name="title">
         </td>
      </tr>
      <tr>
         <th>파일</th>
         <td>
            <input type="file" name="file1">
         </td>
      </tr>
      <tr>
         <td colspan="2">
            <input type="submit" name="전송">
         </td>
      </tr>
   </table>
</form>
</body>
</html>