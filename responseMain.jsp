<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체 - Response</title>
</head>
<body>
<h2>1. 로그인 폼</h2>
<% 
String loginErr = request.getParameter("loginErr");
if(loginErr != null){
	out.print("로그인 실패");
}
%>
<form method="post" action="./responseLogin.jsp">
 아이디 : <input type="text" name="user_id"><br>
 패스워드 : <input type="password" name="user_pwd"><br>
 <input type="submit" value="로그인">
</form>

<h2>2. HTTP응답 해더 설정하기</h2>
<form method="get" action="./responseHeader.jsp">
 아이디 : <input type="text" name="user_id"><br>
 패스워드 : <input type="password" name="user_pwd"><br>
 <input type="submit" value="로그인">
</form>

</body>
</html>