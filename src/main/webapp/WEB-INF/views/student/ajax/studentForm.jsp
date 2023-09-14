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
		<i class="mdi mdi-check-circle" style="color: green;"></i> 학생정보 등록
		<hr style="border-color: black; margin-bottom: 0.7rem; margin-top: 0.7rem;">
	</div>
	<div class="gradInfo-body">
    	<div>
			<button type="button" class="btn btn-outline-info narrow-modal-button mdi mdi-file-excel mdi-24px" 
				data-bs-toggle="modal" data-bs-target="#exampleModal" style="display: flex; justify-content: center; align-items: center; width: 125px;">학생일괄등록</button>
			<button type="button" class="btn btn-outline-info narrow-modal-button" style="width: 125px;" onclick="registerStudentAndSubmitForm(event)">학생개별등록</button>
		</div>
	    <div class="circle"></div> 학생 정보를 입력한 후, 오른쪽의 등록 버튼을 통해 학생 정보를 등록할 수 있습니다.<br>
	    <div class="circle"></div> 학생 일괄 등록 버튼을 통해 엑셀 파일을 첨부하여 여러명의 학생을 동시에 등록할 수 있습니다.
	</div>
</div>

<form:form method="post" modelAttribute="student"
	enctype="multipart/form-data"
	action="${pageContext.request.contextPath}/student/studentInsert.do">
	<div class="container mt-3">
		<div class="row">
			<div class="col-md-4">
				<!-- 학번 입력 -->
				<div class="mb-3">
					<label class="form-label">학번</label>
					<form:input path="stCd" class="form-control" oninput="hideErrorMessage('studentIdError')" />
					<form:errors path="stCd" class="error" />
					<span id="studentIdError" class="error"></span>
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
					<form:input path="stNm" class="form-control" oninput="hideErrorMessage('studentNmError')" />
					<form:errors path="stNm" class="error" />
					<span id="studentNmError" class="error"></span>
				</div>
				<!-- 전화번호 입력 -->
				<div class="mb-3">
					<label class="form-label">전화번호</label>
					<form:input path="stPh" class="form-control" oninput="hideErrorMessage('studentPhError')" />
					<form:errors path="stPh" class="error" />
					<span id="studentPhError" class="error"></span>
				</div>
				<!-- 주민등록번호 입력 -->
				<div class="mb-3">
					<label class="form-label">주민등록번호</label>
					<div class="input-group">
						<form:input path="stReg1" class="form-control" oninput="hideErrorMessage('studentRegError')" />
						<span class="input-group-text">-</span>
						<form:input path="stReg2" class="form-control" />
					</div>
					<form:errors path="stReg1" class="error" />
					<span id="studentRegError" class="error"></span>
					<form:errors path="stReg2" class="error" />
				</div>
			</div>
			<div class="col-md-4">
				<!-- 이메일 입력 -->
				<div class="mb-3">
					<label class="form-label">이메일</label>
					<form:input path="stEmail" type="email" class="form-control" oninput="hideErrorMessage('studentEmailError')" />
					<form:errors path="stEmail" class="error" />
					<span id="studentEmailError" class="error"></span>
				</div>
				<!-- 주소 입력 -->
				<div class="mb-3">
					<label class="form-label">주소</label>
					<div class="input-group">
						<form:input path="stAddr1" id="address" class="form-control" oninput="hideErrorMessage('studentAdd1Error')" />
						<button type="button" id="address_btn" class="btn btn-secondary">주소
							검색</button>
					</div>
					<form:errors path="stAddr1" class="error" />
					<span id="studentAdd1Error" class="error"></span>
				</div>
				<!-- 상세주소 입력 -->
				<div class="mb-3">
					<label class="form-label">상세주소</label>
					<form:input path="stAddr2" id="address_detail" class="form-control" oninput="hideErrorMessage('studentAdd2Error')" />
					<form:errors path="stAddr2" class="error" />
					<span id="studentAdd2Error" class="error"></span>
				</div>
				<!-- 비밀번호 입력 -->
				<div class="mb-3">
					<label class="form-label">비밀번호</label>
					<form:input path="stPass" id="stPass" type="password"
						class="form-control" oninput="hideErrorMessage('studentPassError')" />
					<form:errors path="stPass" class="error" />
					<span id="studentPassError" class="error"></span>
				</div>
				<!-- 비밀번호 확인 입력 -->
				<div class="mb-3">
					<label class="form-label">비밀번호 확인</label> <input id="stPassConfirm"
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
					<input type="file" name="stImage" accept="image/*"
						class="form-control" onchange="previewImage(event)"
						style="margin-top: 22px;">
					<form:errors path="stFic" class="error" />
				</div>
			</div>
		</div>
	</div>
</form:form>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function registerStudentAndSubmitForm(event) {
		event.preventDefault();
		
		var department = document.getElementById("dtCdSelect").value;
		var password = document.getElementById("stPass").value;
		var passwordConfirm = document.getElementById("stPassConfirm").value;
		var studentId = document.getElementById("stCd").value;
		var studentNm = document.getElementById("stNm").value;
		var studentPh = document.getElementById("stPh").value;
		var studentReg = document.getElementById("stReg1").value;
		var studentEmail = document.getElementById("stEmail").value;
		var studentAdd1 = document.getElementById("address").value;
		var studentAdd2 = document.getElementById("address_detail").value;

		if (!studentId) {
		    document.getElementById("studentIdError").innerText = "학번을 입력해주세요."	}
		if (!department) {
			document.getElementById("dtCdNotSelect").innerText = "학과를 선택해주세요." }
		if (!studentNm) {
			document.getElementById("studentNmError").innerText = "이름을 입력해주세요." }
		if (!studentPh) {
			document.getElementById("studentPhError").innerText = "번호를 입력해주세요." }
		if (!studentReg) {
			document.getElementById("studentRegError").innerText = "주민번호를 입력해주세요." }
		if (!studentEmail) {
			document.getElementById("studentEmailError").innerText = "이메일을 입력해주세요." }
		if (!studentAdd1) {
			document.getElementById("studentAdd1Error").innerText = "주소를 입력해주세요." }
		if (!studentAdd2) {
			document.getElementById("studentAdd2Error").innerText = "상세주소를 입력해주세요." }
		if (!password) {
			document.getElementById("studentPassError").innerText = "비밀번호를 입력해주세요." }
		
		if (password !== passwordConfirm) {
			Swal.fire({
			      icon: 'warning',
			      title: '비밀번호가 일치하지 않습니다',
			      
			      confirmButtonColor: '#3085d6',
			      confirmButtonText: '확인'
			    });
			return;
			}
		
		if (studentId && department && studentNm && 
				studentPh && studentReg && studentEmail &&
				studentAdd1 && studentAdd2 && password) {
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
		      			      title: '학번이 중복됩니다.',
		      			      
		      			      confirmButtonColor: '#3085d6',
		      			      confirmButtonText: '확인'
		      			    });
	            	}else if(response.result=='성공'){
	            		fetchStudent();
	            		fetchStudentForm();
	            		setTimeout(function(){
	            			Swal.fire({
		          			      icon: 'success',
		          			      title: '학생 정보가 등록되었습니다.',
		          			      
		          			      confirmButtonColor: '#3085d6',
		          			      confirmButtonText: '확인'
		          			    });
	            		}, 100);
	            	}else{
	            		Swal.fire({
	          			      icon: 'error',
	          			      title: '학생 정보 등록에 실패했습니다.',
	          			      
	          			      confirmButtonColor: '#3085d6',
	          			      confirmButtonText: '확인'
	          			    });
	            	}
	            },
	            error: function(xhr) {
	            	Swal.fire({
        			      icon: 'error',
        			      title: '학생 정보 등록에 실패했습니다.',
        			      
        			      confirmButtonColor: '#3085d6',
        			      confirmButtonText: '확인'
        			    });
	            }
	        });
	    }
	}
	
	$("#excelUploadButton").click(function() {
	    var form = $("#excelUploadForm");
	    var formData = new FormData(form[0]);

	    $.ajax({
	        type: "POST",
	        url: form.attr("action"),
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(response) {
	            if (response.result == '성공') {
	                fetchStudent();
	                fetchStudentForm();
	                Swal.fire({
        			      icon: 'success',
        			      title: '학생 일괄 등록이 완료되었습니다.',
        			      
        			      confirmButtonColor: '#3085d6',
        			      confirmButtonText: '확인'
        			    });
	            } else if (response.result == '중복') {
	            	Swal.fire({
	      			      icon: 'warning',
	      			      title: '학번이 중복됩니다.',
	      			      
	      			      confirmButtonColor: '#3085d6',
	      			      confirmButtonText: '확인'
	      			    });
	            }else {
	            	Swal.fire({
        			      icon: 'error',
        			      title: '학생 일괄 등록에 실패했습니다.',
        			      
        			      confirmButtonColor: '#3085d6',
        			      confirmButtonText: '확인'
        			    });
	            }
	        },
	        error: function(xhr) {
	        	Swal.fire({
  			      icon: 'error',
  			      title: '학생 일괄 등록에 실패했습니다.',
  			      
  			      confirmButtonColor: '#3085d6',
  			      confirmButtonText: '확인'
  			    });
	        }
	    });
	});
		
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

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel"
					style="font-weight: bold;">학생일괄등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<form action="${pageContext.request.contextPath}/Excel/insert.do"
				method="post" enctype="multipart/form-data" id="excelUploadForm">
				<div class="modal-body">
					<input type="file" name="file" accept=".xlsx, .xls">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="excelUploadButton">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>