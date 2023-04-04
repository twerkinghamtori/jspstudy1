<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript">
    function input_check(f) {
    	if(f.id.value.trim()=="") {
    		alert("아이디를 입력하세요.");
    		f.id.focus();
    		return false;
    	}
    	if(f.pass.value.trim()=="") {
    		alert("비밀번호를 입력하세요.");
    		f.pass.focus();
    		return false;
    	}
    	if(f.name.value.trim()=="") {
    		alert("이름을 입력하세요.");
    		f.name.focus();
    		return false;
    	}
    	return true;
    }
    function win_upload() {
    	let op = "width=500, height=500, left=50, top=150";
    	open("pictureForm.jsp", "", op); //window.open("URL","팝업이름","팝업 옵션");
    }
</script>
</head>
<body>
   <form action="join.jsp" name="f" method="post" onsubmit="return input_check(this)">
       <%-- value = picture.jsp에서 업로드된 이미지의 이름 --%>
      <input type="hidden" name="picture" value="">
      <table>
         <tr>
            <td rowspan="4" valign="bottom">
               <img src="" width="100" height="120" id="pic"><br>
               <font size="1"><a href="javascript:win_upload()">사진등록</a></font>
            </td>
            <th>아이디</th>
            <td><input type="text" name="id"></td>
         </tr>
         <tr>
             <th>비밀번호</th>
             <td><input type="password" name="pass"></td>
         </tr>
         <tr>
             <th>이름</th>
             <td><input type="text" name="name"></td>
         </tr>
         <tr>
             <th>성별</th>
             <td>
                <input type="radio" name="gender" value="1" checked>남
                <input type="radio" name="gender" value="2" checked>여
             </td>             
         </tr>
         <tr>
             <th>전화번호</th>
             <td colspan="2"><input type="text" name="tel"></td>            
         </tr>
         <tr>
             <th>이메일</th>
             <td colspan="2"><input type="text" name="email"></td>            
         </tr>
         <tr>
             <td colspan="3"><input type="submit" value="회원가입"></td>
         </tr>
      </table>
   </form>
</body>
</html>