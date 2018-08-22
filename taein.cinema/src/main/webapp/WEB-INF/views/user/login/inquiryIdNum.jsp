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
#all, h2{
	text-align:center;
}
table{
	margin:auto;
}
#time{
	color: red;
	font-weight:bold;
}
</style>
<script>
$(function(){
	$("form").validate({
		rules:{
			confiNum:{
				required:true,
				minlength:6
			}
		},
		messages:{
			confiNum:{
				required:"인증번호를 입력하세요.",
				minlength:"인증번호는 6자리입니다."
			}			
		},
		sumitHandler:function(){
			$(form).submit();
		}
	});
});
</script>
<script>
function $ComTimer(){
}

$ComTimer.prototype = {
    comSecond : ""
    , fnCallback : function(){}
    , timer : ""
    , domId : ""
    , fnTimer : function(){
        var m = Math.floor(this.comSecond / 60) + ": " + (this.comSecond % 60) ;	
        this.comSecond--;			
        $("#time").html("&nbsp;&nbsp;"+m);
        if(this.comSecond <0){
        	clearInterval(this.timer);
        	$("#timeModal").modal("show");
        	}
    }
    ,fnStop : function(){
        clearInterval(this.timer);
    }
}

var AuthTimer = new $ComTimer()
AuthTimer.comSecond = 180;
AuthTimer.fnCallback = function(){alert("다시 인증을 시도해주세요.")}
AuthTimer.timer =  setInterval('AuthTimer.fnTimer()',1000);
AuthTimer.domId = document.getElementById("timer");
</script>
<div id="timeModal" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <p id="msg">인증시간이 초과되었습니다. 다시 인증을 시도해주세요.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="close" data-dismiss="modal" onclick="location.href='/inquiryId'">확인</button>
            </div>
        </div>
    </div>
</div>
<script>
$(function(){
	$("#inquiryIdOk").bind("click",function(){
		$.ajax({
			url:"inquiryIdOk",
			method:"get",
			data:{
				confiNum:$("#confiNum").val()
			},
			success:function(result){
				if(result.is === true){
					$("#all").empty();
					$("#all").append("<h4>귀하의 아이디는 "+result.userId+"입니다.</h4><br>" +
										"<a href ='/logOut'>로그인 하러가기</a> | " +	
										"<a href ='/inquiryPw'>비밀번호 찾기</a>");
					clearInterval(AuthTimer.timer);
				}else {
					$("#msgModal #msg").html("<p>"+result.errMsg+"</p>");
					$("#msgModal").modal("show");
				}
			},
			error:function(a,b,errMsg){
				$("#msgModal #msg").html("<p>인증 실패: "+errMsg+"</p>");
				$("#msgModal").modal("show");
			}
		});
	});
});
</script>
<div id="msgModal" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <p id="msg"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="close" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>
</head>
<body>
<div class="container">
<h2>아이디찾기</h2>
<hr>
<div id = "all">
<h3>인증번호 입력</h3>
<form>
<table>
	<tr>
		<td></td>
		<td width="300"><input id="confiNum" name="confiNum" maxlength="6" oninput="maxLengthCheck(this)" class="form-control" type="number" placeholder = "인증번호 6자리 숫자 입력"></td>
		<td><p id="time"></p></td>
	</tr>
	<tr>
		<td></td>
		<td colspan="2"><a href="#" id="msg" data-toggle="tooltip" data-placement="right"
		title="스팸 메일로 분류된 것은 아닌지 확인해 주세요. 스팸 메일함에도 메일이 없다면, 다시 한 번 '인증번호 받기'를 눌러주세요.">
		인증번호가 오지 않나요?</a></td>
	</tr>
</table>
<button type="button" class="btn btn-default" id="inquiryIdOk">확인</button>
<br>
<hr>
<a href ="/logOut">로그인 하러가기</a> |	
<a href ="/inquiryPw">비밀번호 찾기</a>
<script>
function maxLengthCheck(object){
	if(object.value.length > object.maxLength){
		object.value = object.value.slice(0, object.maxLength);
	}
}
</script>
</form>
</div>
</div>
<script>
$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
});
</script>
</body>