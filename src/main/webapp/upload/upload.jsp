<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. 브라우저로 부터 enctype="multipart/form-data" 형식으로 요청됨. => request 객체 사용 안됨. request 객체 안에 파라미터 정보, 파일 정보, 파일내용이 모두 저장되어있음.
                                                               => MultipartRequest(cos.jar에 있음) 객체를 사용해야함.      
--%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 결과</title>
</head>
<body>
<%
   String uploadPath = application.getRealPath("/")+"upload/"; //업로드 되는 실제 경로를 설정. webapplication 폴더/upload폴더
   int size=10*1024*1024; //업로드 가능한 최대 파일의 크기(10MB?)
   File f = new File(uploadPath);
   if(!f.exists()) f.mkdirs(); //만약 업로드 폴더가 없다면, 폴더 생성해.(make directory?)
   MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8");
   /*
      request : 요청 정보들. 파라미터, 파일 정보, 파일 내용,..
      uploadPath : 파일이 업로드 되는 폴더 경로
      size : 파일의 최대 업로드 사이즈
      "UTF-8" : 파라미터 인코딩 방식.
      => 객체 생성하면 업로드가 완성이 됨.
   */
   String name = multi.getParameter("name");
   String title = multi.getParameter("title");
   String fname = multi.getFilesystemName("file1"); //파일의 이름
%>
업로드 위치 : <%=uploadPath %><br>
올린사람 : <%=name %><br>
제목 : <%=title %><br>
파일 : <a href="<%=fname%>"><%=fname %></a><br>
<img src="<%=fname %>">
</body>
</html>