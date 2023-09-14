<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
.error {
	color: red;
}
.gradInfo {
	background-color: rgba(0, 0, 0, 0.03);
	margin: 10px;
	padding-right: 40px;
	font-family: 'Noto Sans KR', sans-serif;
}

.gradInfo-header {
	margin: 15px 0 11px 40px;
	font-size: 14px;
	font-weight: bold;
}
.gradInfo-body {
	margin: -13px 40px 5px 40px;
	font-size: 12px;
}
.circle {
    width: 4px;
    height: 4px;
    background-color: black;
    border-radius: 50%;
    display: inline-block;
    margin: 0 12px 3px 6px;
}
.narrow-modal-button {
	width: 100px; /* 원하는 가로폭을 지정 */
    padding: 7px; /* 원하는 패딩을 지정 */
    margin: -1px 10px 2px 10px;
    float: right;
}
</style>

<div class="card gradInfo">
	<div class="gradInfo-header">
		<i class="mdi mdi-check-circle" style="color: green;"></i> 교수정보 등록
		<hr style="border-color: black; margin-bottom: 0.7rem; margin-top: 0.7rem;">
	</div>
	<div class="gradInfo-body">
		<button type="button" class="btn btn-outline-info narrow-modal-button" style="width: 110px;" onclick="registerProfessorAndSubmitForm(event)">교수 등록</button>
	    <div class="circle"></div> 오른쪽의 버튼을 통해 교수정보를 등록할 수 있습니다.<br>
	    <div class="circle"></div> 하단의 리스트에서 교수정보를 조회 및 관리할 수 있습니다.
	</div>
</div>

<form:form method="post" modelAttribute="professor"
	enctype="multipart/form-data"
	action="${pageContext.request.contextPath}/professor/professorInsert.do">
	<div class="container mt-3">
		<div class="row">
			<div class="col-md-4">
				<!-- 교번 입력 -->
				<div class="mb-3">
					<label class="form-label">교번</label>
					<form:input path="prCd" class="form-control" oninput="hideErrorMessage('professorIdError')" />
					<form:errors path="prCd" class="error" />
					<span id="professorIdError" class="error"></span>
				</div>
				<!-- 학과 선택 -->
				<div class="mb-3">
					<label class="form-label">학과</label>
					<form:select path="dtCd" id="dtCdSelect" class="form-select"
						style="height: 46px; width: -webkit-fill-available;" oninput="hideErrorMessage('dtCdNotSelect')">
						<form:option value="" label="학과선택" />
						<form:options items="${departmentList }" itemLabel="dtNm"
							itemValue="dtCd" />
					</form:select>
					<form:errors path="dtCd" class="error" />
					<span id="dtCdNotSelect" class="error"></span>
				</div>
				<!-- 이름 입력 -->
				<div class="mb-3">
					<label class="form-label">이름</label>
					<form:input path="prNm" class="form-control" oninput="hideErrorMessage('professorNmError')" />
					<form:errors path="prNm" class="error" />
					<span id="professorNmError" class="error"></span>
				</div>
				<!-- 전화번호 입력 -->
				<div class="mb-3">
					<label class="form-label">전화번호</label>
					<form:input path="prPh" class="form-control" oninput="hideErrorMessage('professorPhError')" />
					<form:errors path="prPh" class="error" />
					<span id="professorPhError" class="error"></span>
				</div>
				<!-- 주민등록번호 입력 -->
				<div class="mb-3">
					<label class="form-label">주민등록번호</label>
					<div class="input-group">
						<form:input path="prReg1" class="form-control" oninput="hideErrorMessage('professorRegError')" />
						<span class="input-group-text">-</span>
						<form:input path="prReg2" class="form-control" />
					</div>
					<form:errors path="prReg1" class="error" />
					<span id="professorRegError" class="error"></span>
					<form:errors path="prReg2" class="error" />
				</div>
			</div>
			<div class="col-md-4">
				<!-- 이메일 입력 -->
				<div class="mb-3">
					<label class="form-label">이메일</label>
					<form:input path="prEmail" type="email" class="form-control" oninput="hideErrorMessage('professorEmailError')" />
					<form:errors path="prEmail" class="error" />
					<span id="professorEmailError" class="error"></span>
				</div>
				<!-- 주소 입력 -->
				<div class="mb-3">
					<label class="form-label">주소</label>
					<div class="input-group">
						<form:input path="prAddr1" id="address" class="form-control" oninput="hideErrorMessage('professorAdd1Error')" />
						<button type="button" id="address_btn" class="btn btn-secondary">주소
							검색</button>
					</div>
					<form:errors path="prAddr1" class="error" />
					<span id="professorAdd1Error" class="error"></span>
				</div>
				<!-- 상세주소 입력 -->
				<div class="mb-3">
					<label class="form-label">상세주소</label>
					<form:input path="prAddr2" id="address_detail" class="form-control" oninput="hideErrorMessage('professorAdd2Error')" />
					<form:errors path="prAddr2" class="error" />
					<span id="professorAdd2Error" class="error"></span>
				</div>
				<!-- 비밀번호 입력 -->
				<div class="mb-3">
					<label class="form-label">비밀번호</label>
					<form:input path="prPass" id="prPass" type="password"
						class="form-control" oninput="hideErrorMessage('professorPassError')" />
					<form:errors path="prPass" class="error" />
					<span id="professorPassError" class="error"></span>
				</div>
				<!-- 비밀번호 확인 입력 -->
				<div class="mb-3">
					<label class="form-label">비밀번호 확인</label> <input id="prPassConfirm"
						type="password" class="form-control" /> <span
						id="passwordMatchError" class="error"></span>
				</div>
			</div>
			<!-- 프로필사진 -->
			<div class="col-md-4">
				<label class="form-label">프로필사진</label>
				<div>
					<img id="imagePreview"
						src="<c:url value='/resources/images/user.jpg' />"
						style="max-width: 350px; max-height: 350px; border: 1px solid #ccc;">
				</div>
				<div class="mb-3">
					<input type="file" name="prImage" accept="image/*"
						class="form-control" onchange="previewImage(event)"
						style="margin-top: 22px;">
					<form:errors path="prPic" class="error" />
				</div>
			</div>
		</div>
	</div>
</form:form>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function registerProfessorAndSubmitForm(event) {
		event.preventDefault();
		
		var department = document.getElementById("dtCdSelect").value;
		var password = document.getElementById("prPass").value;
		var passwordConfirm = document.getElementById("prPassConfirm").value;
		var professorId = document.getElementById("prCd").value;
		var professorNm = document.getElementById("prNm").value;
		var professorPh = document.getElementById("prPh").value;
		var professorReg = document.getElementById("prReg1").value;
		var professorEmail = document.getElementById("prEmail").value;
		var professorAdd1 = document.getElementById("address").value;
		var professorAdd2 = document.getElementById("address_detail").value;

		if (!professorId) {
		    document.getElementById("professorIdError").innerText = "교번을 입력해주세요." }
		if (!department) {
			document.getElementById("dtCdNotSelect").innerText = "학과를 선택해주세요." }
		if (!professorNm) {
			document.getElementById("professorNmError").innerText = "이름을 입력해주세요." }
		if (!professorPh) {
			document.getElementById("professorPhError").innerText = "번호를 입력해주세요." }
		if (!professorReg) {
			document.getElementById("professorRegError").innerText = "주민번호를 입력해주세요." }
		if (!professorEmail) {
			document.getElementById("professorEmailError").innerText = "이메일을 입력해주세요." }
		if (!professorAdd1) {
			document.getElementById("professorAdd1Error").innerText = "주소를 입력해주세요." }
		if (!professorAdd2) {
			document.getElementById("professorAdd2Error").innerText = "상세주소를 입력해주세요." }
		if (!password) {
			document.getElementById("professorPassError").innerText = "비밀번호를 입력해주세요." }
		
		if (password !== passwordConfirm) {
			 Swal.fire({
			      icon: 'warning',
			      title: '비밀번호가 일치하지 않습니다',
			      
			      confirmButtonColor: '#3085d6',
			      confirmButtonText: '확인'
			    }); 
			return;
			}
		
		if (professorId && department && professorNm && 
				professorPh && professorReg && professorEmail &&
				professorAdd1 && professorAdd2 && password) {
	        var form = $("form");
	        var formData = new FormData(form[0]);

	        $.ajax({
	            type: "POST",
	            url: form.attr("action"),
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	            	if(response.result=='중복'){
	            		Swal.fire({
	      			      icon: 'warning',
	      			      title: '교번이 중복됩니다.',
	      			      
	      			      confirmButtonColor: '#3085d6',
	      			      confirmButtonText: '확인'
	      			    });
	            	}else if(response.result=='성공'){
	            		fetchProfessor();
	            		fetchProfessorForm();
	            		setTimeout(function(){
	            			Swal.fire({
	          			      icon: 'success',
	          			      title: '교수 정보가 등록되었습니다.',
	          			      
	          			      confirmButtonColor: '#3085d6',
	          			      confirmButtonText: '확인'
	          			    });
	            		}, 100);
	            	}else{
	            		Swal.fire({
	          			      icon: 'error',
	          			      title: '교수 정보 등록에 실패했습니다.',
	          			      
	          			      confirmButtonColor: '#3085d6',
	          			      confirmButtonText: '확인'
	          			    });
	            	}
	            },
	            error: function(xhr) {
	            	Swal.fire({
        			      icon: 'error',
        			      title: '교수 정보 등록에 실패했습니다.',
        			      
        			      confirmButtonColor: '#3085d6',
        			      confirmButtonText: '확인'
        			    });
	            }
	        });
	    }
	}
	
	// 이미지 미리보기 함수
	function previewImage(event) {
		var defaultProfileImageURL = "<c:url value='/resources/images/user.jpg' />";
		var imagePreview = document.getElementById("imagePreview");
		var file = event.target.files[0];

		if (file) {
			var reader = new FileReader();
			reader.onload = function(e) {
				imagePreview.src = e.target.result;
			};
			reader.readAsDataURL(file);
		} else {
			imagePreview.src = defaultProfileImageURL;
		}
	}
	
	function hideErrorMessage(elementId) {
	    document.getElementById(elementId).innerText = ""; // 오류 메시지 내용을 비움
	}
	
</script>