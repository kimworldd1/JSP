# JSP
# 2장. 내장객체(Implicit Object)
=> 노션에 적음(https://www.notion.so/JSP-02-03-2a6755f7a8e44d31b6a39a61c56a0db5)
<aside>
💡 개요

### 학습목표

클라이언트의 요청을 받거나 응답할 때 사용되는 JSP의 기본 내장 객체들의 종류와 사용법을 익힘.

### 학습순서

[내장객체 소개](https://www.notion.so/JSP-02-03-2a6755f7a8e44d31b6a39a61c56a0db5) → [request](https://www.notion.so/JSP-02-03-2a6755f7a8e44d31b6a39a61c56a0db5) → response → out → application → exception

### 활용사례

내장객체를 사용하지 않는 JSP 프로그래밍은 없음. 웹 프로그래밍의 근간이 되는 요청과 응답부터 출력, 세션, 페이지와 애플리케이션 등 없어서는 안 될 개념들을 내장 객체로 제공하므로 수시로 광범위하게 활용됨.

</aside>

---

### 용어

- **[쿼리스트링](https://www.notion.so/JSP-02-03-2a6755f7a8e44d31b6a39a61c56a0db5)**
    
    URL의 뒤에 입력 데이터를 함께 제공하는 가장 단순한 데이터 전달방법. 주로 GET방식으로 데이터를 요청할 때 쓰이는 방법.

---

## 내장객체란

기본적인 요청과 응답, 화면 출력 등은 거의 웹 프로그래밍의 필수. JSP 내장객체는 요청과 응답 혹은 HTTP 헤더 등의 정보를 쉽게 다룰 수 있도록 해줌.


[[JSP] 내장 객체](https://velog.io/@xnfxnf97/JSP-%EB%82%B4%EC%9E%A5-%EA%B0%9D%EC%B2%B4)

내장객체는 JSP페이지가 실행될 때 컨테이너가 자동으로 생성해줌. 변도로 선언이나 객체 생성하지 않아도 즉시 사용가능. JSP는 실행될 때 자바 파일인 서블릿으로 변환되어 컴파일됨. 이 변환과정에서 `_jspService( )` 메서드가 생성되는데, 이 메서드 안에 아래 코드가 삽입됨.

```java
public void _jspService(){
	//...생략...
	final javax.sercler.jsp.PageContext pageContext;
	javax.servlet.http.HttpSession session = null;
	final javax.serclet.SerclerContext application;
	final.servlet.jsp.JspWriter out = null;
	final java.lang.Object page = this;
	javax.servlet.jsp.JspWriter _jspx_out = null;
	javax.servlet.jsp.PageContext _jspx_page_context = null;
	//...생략...
}
```

객체를 선언하고 초기화 하는 선언문임. 내장 객체의 참조변수를 컨테이너가 생성하는 부분.

### 내장객체의 특징

- 컨테이너가 미리 선언해놓은 참조 변수를 이용해 사용
- 별도의 객체 생성없이 각 내장 객체의 메서드를 사용할 수 있음
- JSP문서 안의 <% 스트립틀릿 %> 과 <%= 표현식 %>에서만 사용할 수 잇음
- <%! 선언부 %> 에서는 즉시 사용하는 건 불가능하고, 매개변수로 전달받아 사용할 수 있음
`_jspService( )` 메서드 외부에 생성됨.

### 내장객체의 종류

| 내장객체 | 타입 | 설명 |
| --- | --- | --- |
| request | javax.servlet.http.HttpServletRequest | 클라이언트의 요청 정보를 저장 |
| response | javax.servlet.http.HttpServletResponse | 클라이언트의 요청에 대한 응답 정보를 저장 |
| out | javax.serclet.jsp.JspWriter | JSP페이지에 출력할 내용을 담는 출력 스트림 |
| session | javax.servlet.http.HttpSession | 웹 브라우저 정보를 유지하기 위한 세션 정보를 저장
| application | javax.servlet.ServletContext | 웹 어플리케이션 관련 컨텍스트 정보를 저장 |
| pageContext | javax.servlet.jsp.PageContext | JSP페이지에 대한 정보를 저장
| page | java.lang.Object | JSP페이지를 구현한 자바 클래스의 인스턴스. 거의 사용되지 않음 |
| config | javax.servlet.ServletConfig | JSP페이지에 대한 설정 정보를 저장. 거의 사용되지 않음 |
| exception | java.lang.Throwable | 예외가 발생한 경우에 사용 |

## request 객체(p.86)

클라이언트(주로 웹 브라우저)가 전송한 요청 정보를 담고 있는 객체

### request 객체의 주요기능

- 클라이언트와 서버에 대한 정보 읽기
- 클라이언트가 전송한 요청 매개변수에 대한 정보 읽기
- 요청 **헤더 및 쿠키** 정보 읽기

### 클라이언트와 서버의 환경정보 읽기

클라이언트는 웹 브라우저를 통해 서버측으로 요청을 하게됨. 요청은 GET방식 또는 POST방식으로 구분됨. 요청URL, 포트번호, 쿼리스트링 등을 명시할 수 있음.

예제

```java
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체 - Request</title>
</head>
<body>
<h2>1. 클라이언트와 서버의 환경정보 읽기</h2>
<a href="./requestWebInfo.jsp?eng=Hello&han=안녕">GET방식 전송</a>
<br/>
<form method="post" action="requestWebInfo.jsp">
 영어 : <input type="text" name="eng" value="Bye"><br>
 한글 : <input type="text" name="han" value="잘가"><br>
 <input type="submit" value="POST 방식 전송">
</form>
<hr>
<h2>2. 클라이언트의 요청 매개변수 읽기</h2>
<form method="post" action="requestParameter.jsp" >
 아이디 : <input type="text" name="id" value=""><br>
 성별 : 
 <input type="radio" name="sex" value="남자">남자
 <input type="radio" name="sex" value="여자">여자<br>
 관심사항 : 
 <input type="checkbox" name="favo" value="경제">경제
 <input type="checkbox" name="favo" value="정치" checked>정치
 <input type="checkbox" name="favo" value="연애">연애<br>
 자기소개 : <br>
 <textarea name="intro" rows="4" cols="30"></textarea><br>
 <input type="submit" value="전송하기">
</form>
<hr>
<h2>3. HTTP 요청 헤더 정보 읽기</h2>
<a href="requestHeader.jsp">요청 헤더 정보 읽기</a>
</body>
</html>
```

### 1. 클라이언트와 서버의 환경정보 읽기(requestWebInfo.jsp)

```java
<h2>1. 클라이언트와 서버의 환경정보 읽기</h2>
<a href="./requestWebInfo.jsp?eng=Hello&han=안녕">GET방식 전송</a>
```

클라이언트의 요청에 따른 서버의 환경정보를 읽기 위해 링크를 생성. GET방식으로 전송되고, 링크 뒤에는 2개의 매개변수가 **[쿼리스트링](https://www.notion.so/JSP-02-03-2a6755f7a8e44d31b6a39a61c56a0db5)**으로 전달됨.

```java
<ul>
 <li>데이터 전송 방식 : <%= request.getMethod() %> </li>
 <li>URL : <%= request.getRequestURL() %> </li>
 <li>URI : <%= request.getRequestURI() %> </li>
 <li>프로토콜 : <%= request.getProtocol() %> </li>
 <li>서버명 : <%= request.getServerName() %> </li>
 <li>서버포트 : <%= request.getServerPort() %> </li>
 <li>클라이언트 IP주소 : <%= request.getRemoteAddr() %> </li>
 <li>쿼리스트링 : <%= request.getQueryString() %> </li>
 <li>전송된 값1 : <%= request.getParameter("eng") %> </li>
 <li>전송된 값1 : <%= request.getParameter("han") %> </li>
</ul>
```

**URL :** 호스트를 포함한 전체주소
**URI :** 호스트를 제외한 컨텍스트 루트부터의 주소

`getQueryString( )` 메서드는 요청 주소 뒷부분의 매개변수 전달을 위한 쿼리스트링 전제를 반환. 쿼리스트링 중 특정 키값을 얻어오려면 `request.getParameter("eng")` 처럼 메서드에 키값을 인수로 넣어주면됨.

- GET방식 전송
- POST방식 전송

POST방식이므로 주소표시줄에 경로 외 아무것도 표시되지 않음. 때문에 쿼리스트링 null이 출력됨. 전송된 값이 한글인 경우 깨져서 출력됨. 
⇒ request.setCharacterEncoding("UTF-8"); 인코딩

### 2. 클라이언트의 요청 매개변수 읽기(requestParameter.jsp)

form 태그 하위요소를 통해 입력한 값들도 서버로 전송됨. 전송된 값은 서버에서 읽은 후 변수에 저장. 컨트롤러나 모델에 전달됨. 
*8장, 14장 참조
ex) 회원가입, 로그인

```java
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>내장 객체 -request</title>
</head>
<body>
<% 
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String sex = request.getParameter("sex");
String[] favo = request.getParameterValues("favo");
String favoStr = "";
if(favo != null){
	for(int i = 0; i <favo.length; i++){
		favoStr += favo[i] + " ";
	}
}
String intro = request.getParameter("intro").replace("\r\n", "<br>");
%>
<ul>
 <li>아이디 : <%= id %></li>
 <li>성별 : <%= sex %></li>
 <li>관심사항 : <%= favoStr %></li>
 <li>자기소개 : <%= intro %></li>
</ul>
</body>
</html>
```

전송되는 값이 하나라면 `.getParameter( )` 로 받을 수 있으나, checkbox의 경우 보통 여러개를 체크함. (하나의 경우 `.getParameter( )` 가능) 복수인 경우 `.getParameterValue( )` 로 받아야함. 그리고 for문을 이용해 String 배열에 담긴 값들을 하나의 문자열로 합침.

```java
for(int i = 0; i <favo.length; i++){
		favoStr += favo[i] + " ";
	}
```

textarea 태그의 경우 여러줄을 입력할 수 있음. 때문에 `enter` 키를 `<br>` 태그로 변환해야 줄바꿈이 반영됨. `enter`키는 특수키호 `\r\n` 임

⇒ .replace(”값1”, “값2”);  값1을 값2로 바꿈

```java
String intro = request.getParameter("intro").replace("\r\n", "<br>");
```

### 3. HTTP 요청 헤더 정보 읽기(requestHeader.jsp)

**HTTP프로토콜은 헤더에 부가적인 정보를 담도록 함. 웹 브라우저의 종류나 선호하는 언어 등 일반적인 HTML 문서 데이터 외의 추가 정보를 서버와 클라이언트가 교환할 수 있도록 문서의 선두에 삽입할 수 있음.** 

```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 -request</title>
</head>
<body>
<h2>3. HTTP 요청 헤더 정보 읽기</h2>
<% 
Enumeration headers = request.getHeaderNames();
while(headers.hasMoreElements()){
	String headerName =(String)headers.nextElement();
	String headerValue = request.getHeader(headerName);
	out.print("헤더명 : " + headerName + ", 헤더값" + headerValue + "<br>");
}
%>
<p>이 파일을 직접 실행하면 referer 정보는 출력되지 않습니다.</p>
</body>
</html>
```

`.getHeaderNames( )` 메서드 : 모든 요청 헤더의 이름을 반환. 반환타입은 `Enumeration`

`.hasMoreElements( )`  : 출력할 요청 헤드명이 더 있는지 확인. 있으면 true, 없으면 false.

- **Enumeration 인터페이스 메서드**
    
    Enumertation 인터페이스는 Collection 프레임워크가 만들어기 전, Iterator의 이전 버전이다.가능하면 Enumeration 대신 Iteration를 사용을 권장하고 있다.
    
    - hasMoreElements( ) : 읽어올 요소가 남아있는지 확인. 있으면 true, 없으면 false. Iterator의 hasNext( )와 같음
    - nextElement( ) : 다음 요소를 읽어 옴. Iterator의 next( )와 같음

헤더명이 더 있다면 요청 헤더의 이름을 얻어온 다음, `.getHeader( )` 메서드에 헤더명을 건네 헤더값을 얻어옴.

- user-agent : 웹 브라우저의 종류를 알 수 있음. 크롬
- referer : 웹을 서핑하면서 링크를 통해 다른 사이트로 방문 시 남는 흔적을 말함. 여기서는 기록이 남지만 **requestHeader.jsp를 직접실행하면 남지 않음.** 웹 사이트 방문객이 어떤 경로로 접속했는지 알아볼 때 유용
- cookie : *4장. 참조

**학습 도서 : <성낙현의 JSP 자바 웹 프로그래밍> - 성낙현**
