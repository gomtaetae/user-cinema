<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<title>태인이네영화관-로그인페이지</title>
<title>logIn</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<style>
#title{
	text-align:center;
	font-size:25px;
}
#msg{
	color:red;
	text-align:center;
}

.member {
 font-size: 50px;
 text-shadow: 0 0 10px #666;
 color: #fff;
 margin: 0 auto;
 text-align: center;
 text-transform: capitalize;
 font-family: "맑은 고딕";
 font-style: italic;
}

body {
 font-family: "맑은 고딕";
 font-size: 12px;
}

.form {
 width: 498px;
 height: 300px;
 border-radius: 25px;
 border: 5px double #999;
 margin: 30px auto;
}

.form2 {
 width: 380px;
 min-width: 320px;
 height: 200px;
 margin: 60px auto;
 margin-left:20px;
}

.form3 {
 float: left;
 /*   background:#f00;  */
}

.form3 label {
 width: 100px;
 height: 20px;
 /*  display: block; */
 float: left;
}

.form4 {
 padding: 0px 0px 0px 70px;
}

#wrap {
 width: 600px;
 height: 500px;
 margin: 0 auto;
}

.clear {
 clear: both;
}

input[type="submit"] {
 float: left;
 /*  display:block; */
 height: 50px;
 background: #FFBB00;
 border-radius: 5px;
 border: none;
 font-family: "맑은 고딕";
}
input[type="button"] {
 height: 30px;
 background: gray;
 border-radius: 5px;
/*  width: 140px; */
 font-family:"맑은 고딕";
 margin-top:10px;
 margin-right:20px;
}
input[type="checkbox"] {
 margin-top:20px;
}

</style>
</head>
<body>
<div class="container">
	<br><br><br><br>
	<div class="well well-lg">
			<div id="wrap" class="alert alert-info">
				<strong>관리자 페이지 - 로그인</strong>
			<div class="form">
			<div class="form2">
			<div class="form3">
			</div>
			</div>
			</div>
			</div>
			
			<%
				if(session.getAttribute("userId")==null){
			
				String saveUserId = "";
				Cookie[] cookies = request.getCookies();
				if(cookies != null){
					for(Cookie cookie:cookies){
						if(cookie.getName().equals("saveUserId"))
							saveUserId = cookie.getValue();
					}
				}
			%>
			
			<form method="post" class="form-horizontal">
				<div class="form-group">
					<label class="control-label col-sm-2" for="id">ID:</label>
					<div class="col-sm-10">
					<input type="text" class="form-control" maxlength="12" id="id" name="userId" value="<%= saveUserId %>" placeholder="Enter Id" required>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">Password:</label>
					<div class="col-sm-10">
					<input type="password" class="form-control" maxlength="12" id="pwd" name="userPw" placeholder="Enter password" required>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<div class="checkbox">
						<label><input type="checkbox" name="remember" value="Y" checked>아이디 저장</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div id="loginBtn">
						<button type="submit" method="post" formaction="/logIn" class="btn btn-default">로그인</button>
					</div>
				</div>
				<div class="form-group">
					<strong id="msg">${msg}</strong>
				</div>
				<hr>
				<div id="inquiry" class="form-group">
					<div>
						<a href="/userAdd">회원가입</a> |						
						<a href="/inquiryId">아이디 찾기</a> |						
						<a href="/inquiryPw">비밀번호 찾기</a>
					</div>
				</div>
			</form>
			
			<%		
				}else{	
			%>
				${userId}로 로그인하셨습니다.<br>
				<a href ="#">메인으로</a>
				<a href ="/logOut">로그아웃</a>
			<%
				}
			%>
</div>
</body>