<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 이미지 파일 업로드. request 객체 사용 불가
           이미지 파일 업로드 위치 : 현재폴더/picture 폴더로 설정
     2. opener 화면에 결과 전달 => javascript
     3. 현재화면 close() => javascript --%>
<% //path : 파일의 업로드 위치 = 현재폴더 + model/member/picture 폴더 생성.
   String path = application.getRealPath("") + "model1/member/picture/";
   String fname = null;
   File f = new File(path);
   if(!f.exists()) f.mkdirs(); //업로드 폴더가 없는 경우 폴더 생성.
   MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "UTF-8"); //업로드
   fname = multi.getFilesystemName("picture"); //업로드 된 파일의 이름을 fname에 저장.
%>
<script type="text/javascript">
   //opener : 현재 window를 open한 window => joinForm.jsp가 여기서 opener. pictureForm.jsp 아님? 젤 먼저 호출한거 찾아들어가는건가?
   img = opener.document.getElementById("pic"); //joinForm.jsp에 pic아이디를 가진 태그가 있음.
   img.src = "picture/<%=fname%>"; //joinForm.jsp에 이미지가 보여지게 됨.
   opener.document.f.picture.value="<%=fname%>"; //joinForm.jsp에 form태그(f)의 hidden태그(picture)
   self.close(); //현재 창 닫기.
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>