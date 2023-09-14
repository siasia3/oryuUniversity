<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
	.error {
		color: red;
	}
	.mb-3 {
		margin-bottom: 1.6rem !important;
	}
</style>

<div class="card box-shadow d-flex m-4" style="min-height: auto;">
      <div class="h-100">
      <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">학생 정보 관리</div>
<form:form method="post" modelAttribute="student"
	enctype="multipart/form-data"
	action="${pageContext.request.contextPath}/student/studentUpdate.do">
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-4">
				<!-- 학번 입력 -->
				<div class="mb-3">
					<label class="form-label">학번</label>
					<form:input path="stCd" class="form-control" oninput="hideErrorMessage('studentIdError')" readonly="true" />
					<form:errors path="stCd" class="error" />
					<span id="studentIdError" class="error"></span>
				</div>
				<!-- 학과 선택 -->
				<div class="mb-3">
					<label class="form-label">학과</label>
					<form:select path="dtCd" id="dtCdSelect" class="form-select"
						style="height: 46px;" oninput="hideErrorMessage('dtCdNotSelect')">
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
				<div class="mb-3" style="display: flex; margin-top: -17px; margin-bottom: 5px !important;">
					<div style="padding: 13.5px; display: flex; align-items: center;">
						<!-- 학생정보수정 버튼 -->
						<button type="submit"
							class="btn btn-outline-info narrow-modal-button ml-2"
							style="margin-right: 20px;"
							onclick="registerStudentAndSubmitForm(event)">수정</button>
						<button type="button"
							class="btn btn-outline-danger narrow-modal-button ml-2"
							style="margin-right: 20px;"
							onclick="deleteStudentAndSubmitForm(event)">삭제</button>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<!-- 주민등록번호 입력 -->
				<div class="mb-3">
					<label class="form-label">주민등록번호</label>
					<div class="input-group">
						<form:input path="stReg1" class="form-control" oninput="hideErrorMessage('studentRegError')" readonly="true" />
						<span class="input-group-text" style="background-color: white;" >-</span>
						<form:input path="stReg2" class="form-control" readonly="true" />
					</div>
					<form:errors path="stReg1" class="error" />
					<span id="studentRegError" class="error"></span>
					<form:errors path="stReg2" class="error" />
				</div>
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
			</div>
			<!-- 프로필사진 -->
			<div class="col-md-4">
				<label class="form-label">프로필사진</label>
				<div>
					<img id="imagePreview"
						src="<c:url value='/resources/profileImages/${student.stFic }'/>"
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
	<form:input path="stPass" type="hidden"/>
</form:form>
</div></div>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function registerStudentAndSubmitForm(event) {
		event.preventDefault();
		
		var department = document.getElementById("dtCdSelect").value;
		var studentId = document.getElementById("stCd").value;
		var studentNm = document.getElementById("stNm").value;
		var studentPh = document.getElementById("stPh").value;
		var studentReg = document.getElementById("stReg1").value;
		var studentEmail = document.getElementById("stEmail").value;
		var studentAdd1 = document.getElementById("address").value;
		var studentAdd2 = document.getElementById("address_detail").value;

		if (!studentId) {
		    document.getElementById("studentIdError").innerText = "학번을 입력해주세요.";	}
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
		
		if (studentId && department && studentNm && 
				studentPh && studentReg && studentEmail &&
				studentAdd1 && studentAdd2) {
	        var form = $("form");
	        var formData = new FormData(form[0]);

	        $.ajax({
	            type: "POST",
	            url: form.attr("action"),
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	            	if(response == "ok") {
	            		Swal.fire({
	          			      icon: 'success',
	          			      title: '수정이 완료되었습니다.',
	          			      
	          			      confirmButtonColor: '#3085d6',
	          			      confirmButtonText: '확인'
	          			    });
	            	}else {
	            		Swal.fire({
	        			      icon: 'error',
	        			      title: '수정에 실패했습니다.',
	        			      
	        			      confirmButtonColor: '#3085d6',
	        			      confirmButtonText: '확인'
	        			    });
	            	}
	            },
	            error: function(xhr) {
	            	Swal.fire({
      			      icon: 'error',
      			      title: '수정에 실패했습니다.',
      			      
      			      confirmButtonColor: '#3085d6',
      			      confirmButtonText: '확인'
      			    });
	            }
	        });
	    }
	}
	
	function deleteStudentAndSubmitForm(event) {
		event.preventDefault();
		var stCd = document.getElementById("stCd").value;
	
	    $.ajax({
	        type: "POST",
	        url: "${pageContext.request.contextPath}/student/studentDelete.do",
	        data: {
	        	who: stCd
	        },
	        success: function(response) {
	            if (response.result == '삭제완료') {
	            	Swal.fire({
      			      icon: 'success',
      			      title: '삭제 처리가 완료되었습니다.',
      			      
      			      confirmButtonColor: '#3085d6',
      			      confirmButtonText: '확인'
      			    }).then(result => {
      			    	if(result.isConfirmed) {
	            			window.location.href = "${pageContext.request.contextPath}/student/studentFrameList.do";
      			    	}
      			    })
	            }else {
	            	Swal.fire({
      			      icon: 'error',
      			      title: '삭제 처리 도중 오류가 발생했습니다.',
      			      
      			      confirmButtonColor: '#3085d6',
      			      confirmButtonText: '확인'
      			    });
	            }
	        },
	        error: function(xhr) {
	        	Swal.fire({
  			      icon: 'error',
  			      title: '삭제 처리 도중 오류가 발생했습니다.',
  			      
  			      confirmButtonColor: '#3085d6',
  			      confirmButtonText: '확인'
  			    });
	        }
	    });
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
	
	window.onload = function(){
	    document.getElementById("address_btn").addEventListener("click", function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	                document.getElementById("address").value = data.address;
	                document.getElementById("address_detail").focus();
	            }
	        }).open();
	    });
	}
	
</script>