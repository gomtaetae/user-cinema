<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script	src="http://cdn.jsdelivr.net/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<link rel="stylesheet" href="http://common.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<style>
#inquiryIdOk{
	float: right;
}
#all{
	text-align:center;
}
table{
	margin:auto;
}
</style>
<script>
$(function(){
	$("form").validate({
		rules:{
			userName:{
				required:true
			},
			userEmail:{
				required:true
			}
		},
		messages:{
			userName:{
				required:"가입한 이름을 입력하세요."
			},
			userEmail:{
				required:"가입한 이메일을 입력하세요."
			}		
		},
		sumitHandler:function(){
			$(form).submit();
		}
	});
});
</script>

</head>
<body>
<div class="container">
<%
if(request.getAttribute("inqNum")!=null){
%>
	<script>
		location.href="/inquiryIdNum";
	</script>
<%
}else{
%>
<div id = "all">
<h2>아이디찾기</h2>
<hr>
<h3>이메일로 인증</h3>
<small class = "help-block">*이름과 가입 시 사용했던 이메일 주소가 입력한 이름과 이메일 주소와 같아야, 인증번호를 받을 수 있습니다.</small>
<br>
<form method="post">
<table>
	<tr>
		<th width="100">이름</th>
		<td width="300"><input class="form-control" maxlength="12" id="userName" name="userName" type="text" placeholder="이름을 입력하세요."></td>
		<td></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td ><input class="form-control" maxlength="25" id="userEmail" name="userEmail" type="email" placeholder="이메일 주소를 입력하세요."></td>
		<td>&nbsp;<button type="submit" formaction="/inquiryId" class="btn btn-default" id="confiNum" name="confiNum">인증번호 받기</button></td>
	</tr>
</table>
<br>
<hr>
<a href ="/logOut">로그인 하러가기</a> |	
<a href ="/inquiryPw">비밀번호 찾기</a>
</form>

<div id="msgModal" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <p id="msg">${err}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="close" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<%
	if(request.getAttribute("err")!=null){
%>
	<script>
		$("#msgModal").modal("show");
	</script>
<%
	}

}
%>
</div>
</div>
</body>