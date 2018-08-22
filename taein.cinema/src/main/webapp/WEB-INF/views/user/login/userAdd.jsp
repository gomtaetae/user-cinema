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
#addMsg{
	text-align : center;
}
form input.error, from textarea.error{
  border:1px dashed red;
}

form label.error{
  margin-left:10px;
  color:red;
}
</style>
<script>
$.validator.addMethod(
	"password",
	function(value, element){
		return this.optional(element)
		|| /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,12}$/i.test(value);
	},
	"8자 이상 12자 이하, 영문자와 숫자를 입력하세요."
);

$(function(){
	$("form").validate({
		rules:{
			userId:{
				required:true,
				minlength:2
			},
			userPw:{
				required:true
			},
			confirmPassword:{
				required:true,
				equalTo:"#userPw"
			},
			userName:{
				required:true,
				minlength:2
			},
			userGen:"required",
			userEmail:{
				required:true,
				email:true
			},
			userPTNum:"required",
			userPFrontNum:{
				required:true,
				minlength:3
			},
			userPBackNum:{
				required:true,
				minlength:4
			}
		},
		messages:{
			userId:{
				required:"아이디를 입력하세요.",
				minlength:"2자 이상 입력하세요."
			},
			userPw:{
				required:"암호를 입력하세요."
			},
			confirmPassword:{
				required:"암호를 입력하세요.",
				equalTo:"위 암호와 똑같이 입력하세요."
			},
			userName:{
				required:"이름을 입력하세요.",
				minlength:"2자 이상 입력하세요."
			},
			userGen:"성별을 선택하세요.",
			userEmail:{
				required:"이메일 주소를 입력하세요.",
				email:"이메일 형식에 맞춰 입력하세요."
			},
			userPTNum:"핸드폰 통신사 번호를 선택하세요.",
			userPFrontNum:{
				required:"핸드폰 중간 번호를 입력하세요.",
				minlength:"번호 3개 이상 입력하셔야 합니다."
			},
			userPBackNum:{
				required:"핸드폰 뒷 번호를 입력하세요.",
				minlength:"번호 4개를 입력하셔야 합니다."
			}
		},
		sumitHandler:function(){
			$(form).submit();
		}
	});
});
</script>

<script>
$(function(){
	$("#overlap").bind("click",function(){
		$.ajax({
			url:"overLap",
			method:"post",
			data:{
				userId:$("#userId").val()
			},
			success:function(result){
				if(result.is === true){
					$("#msgModal #msg").text(result.overId);
					$("#userId").val("");
				}
				else $("#msgModal #msg").text("사용할 수 있는 아이디입니다.");
			},
			error:function(a,b,errMsg){
				$("#msgModal #msg").text("중복체크 실패: "+errMsg);
			},
			complete:function(){
				$("#msgModal").modal("show");
			}
		});
	});
});
</script>
<script>
$(function(){
	$("#userAdd").bind("click", function(){
		$.ajax({
			url: "userAdd",
			method: "post",
			data: $("#userAddForm").serialize(),
			success:function(result){
				if(result.is === true){
					$("#msgModal #msg").text("이미 등록된 아이디입니다. 아이디 중복체크 후 회원가입해주세요.");
					$("#userId").val("");
					$("#msgModal").modal("show");
				}else {
					location.href = "userAddResult";
				}
			},
			error:function(a,b,errMsg){
				$("#msgModal #msg").text("모든 값을 입력하셔야 회원가입할 수 있습니다.");
				$("#msgModal").modal("show");
			}
		});
	});
});
</script>
</head>
<body>
<div class="container">
<form id="userAddForm" method="post" class="form-horizontal">	
	<fieldset>
		<legend>회원가입</legend>		
<div id="msgModal" class="modal fade">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <p id="msg">체크 성공</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="close" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

		<div class="form-group">
			<input id="userId" name="userId" type="text" maxlength="12" placeholder = "아이디 입력">
			<input type="button" id="overlap" value="아이디 중복체크"/>
			<small class = "help-block">*아이디를 2자 이상 입력하신 후, 중복체크를 해주세요.</small>
		</div>
		<div class="form-group">
			<input name="userPw" id="userPw" type="password" maxlength="12" placeholder = "암호 입력 ">
			<small class = "help-block">*8자 ~ 12자. 영문과 숫자를 혼합하여 입력해주세요.</small>
		</div>
		<div class="form-group">
			<input name="confirmPassword" id="userPw2" type="password" maxlength="12" placeholder = "암호 확인">
			<small class = "help-block">*위 암호를 다시 한 번 입력해주세요.</small>
		</div>
		<div class="form-group">
			<input name="userName" id="userName" type="text" maxlength="12" placeholder = "이름 입력">
		</div>
		<div class="form-group">
			<label>
			<input type = "radio" id="userGen1" name = "userGen" value = "남" checked> 남자
			</label>
			<label>
			<input type = "radio" id="userGen2" name = "userGen" value = "여"> 여자
			</label>
		</div>
		<div class="form-group">
			<input name="userEmail" id="userEmail" type="email" maxlength="25" placeholder = "이메일 입력">
		</div>
		<div class="form-group">
			<input name="userDate" id="userDate" type="date" placeholder = "생년월일 선택">
		</div>
		<div class = "form-group" >
		<label class = "col-sm-2 col-xs-12 control-label" >휴대전화</label>
					<div class = "col-sm-2 col-xs-4 col-sm-phone">
						<select name = "userPTNum" id="userPTNum" class = "form-control">
							<option value = "">-앞자리-</option>
									<option value = "010">010</option>
									<option value = "011">011</option>
									<option value = "016">016</option>
									<option value = "017">017</option>
									<option value = "019">019</option>
						</select>
					</div>
					<div class = "col-sm-4 col-xs-4 col-sm-phone">
						<input type = "number" maxlength="4" oninput="maxLengthCheck(this)" name = "userPFrontNum" id="userPFrontNum" class = "form-control">
					</div>
					<div class = "col-sm-4 col-xs-4">
						<input type = "number" maxlength="4" oninput="maxLengthCheck(this)" name = "userPBackNum" id="userPBackNum" class = "form-control">
					</div>
		<div class = "form-group">
			<label class = "col-sm-2 col-xs-12 control-label" >홍보수신</label>
				<div class = "col-sm-10 col-xs-12 ">
					<label class = "checkbox-inline "><input type = "checkbox" id="userMailing" name = "userMailing" value = "Y" checked> 이메일 수신동의</label>
					<label class = "checkbox-inline"><input type = "checkbox" id="userSms" name = "userSms" value = "Y"> SMS 수신동의</label>
					<small class = "help-block">*필수정보 및 공지사항은 수신될 수 있습니다.</small>
				</div>
		</div>
		<input type="button" id="userAdd" class="btn btn-default" value="가입하기">
	</fieldset>
</form>
<script>
function maxLengthCheck(object){
	if(object.value.length > object.maxLength){
		object.value = object.value.slice(0, object.maxLength);
	}
}
</script>

</div>
</body>