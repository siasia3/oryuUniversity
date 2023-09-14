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
      <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">교직원 정보 관리</div>
<form:form method="post" modelAttribute="staff"
	enctype="multipart/form-data"
	action="${pageContext.request.contextPath}/staff/staffUpdate.do">
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-4">
				<!-- 직번 입력 -->
				<div class="mb-3">
					<label class="form-label">직번</label>
					<form:input path="tsCd" class="form-control" oninput="hideErrorMessage('staffIdError')" readonly="true" />
					<form:errors path="tsCd" class="error" />
					<span id="staffIdError" class="error"></span>
				</div>
				<!-- 부서 선택 -->
				<div class="mb-3">
					<label class="form-label">부서</label>
					<form:select path="tsDep" id="tsDepSelect" class="form-select"
						style="height: 46px; width: -webkit-fill-available;" oninput="hideErrorMessage('tsDepNotSelect')">
						<form:option value="" label="부서선택" />
						<form:option value="행정" label="행정" />
						<form:option value="학사" label="학사" />
					</form:select>
					<form:errors path="tsDep" class="error" />
					<span id="tsDepNotSelect" class="error"></span>
				</div>
				<!-- 이름 입력 -->
				<div class="mb-3">
					<label class="form-label">이름</label>
					<form:input path="tsNm" class="form-control" oninput="hideErrorMessage('staffNmError')" />
					<form:errors path="tsNm" class="error" />
					<span id="staffNmError" class="error"></span>
				</div>
				<!-- 전화번호 입력 -->
				<div class="mb-3">
					<label class="form-label">전화번호</label>
					<form:input path="tsPh" class="form-control" oninput="hideErrorMessage('staffPhError')" />
					<form:errors path="tsPh" class="error" />
					<span id="staffPhError" class="error"></span>
				</div>
				<div class="mb-3" style="display: flex; margin-top: -17px; margin-bottom: 5px !important;">
					<div style="padding: 13.5px; display: flex; align-items: center;">
						<!-- 교직원정보수정 버튼 -->
						<button type="submit"
							class="btn btn-outline-info narrow-modal-button ml-2"
							style="margin-right: 20px;"
							onclick="registerstaffAndSubmitForm(event)">수정</button>
						<button type="button"
							class="btn btn-outline-danger narrow-modal-button ml-2"
							style="margin-right: 20px;"
							onclick="deletestaffAndSubmitForm(event)">삭제</button>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<!-- 주민등록번호 입력 -->
				<div class="mb-3">
					<label class="form-label">주민등록번호</label>
					<div class="input-group">
						<form:input path="tsReg1" class="form-control" oninput="hideErrorMessage('staffRegError')" readonly="true" />
						<span class="input-group-text" style="background-color: white;">-</span>
						<form:input path="tsReg2" class="form-control" readonly="true" />
					</div>
					<form:errors path="tsReg1" class="error" />
					<span id="staffRegError" class="error"></span>
					<form:errors path="tsReg2" class="error" />
				</div>
				<!-- 이메일 입력 -->
				<div class="mb-3">
					<label class="form-label">이메일</label>
					<form:input path="tsEmail" type="email" class="form-control" oninput="hideErrorMessage('staffEmailError')" />
					<form:errors path="tsEmail" class="error" />
					<span id="staffEmailError" class="error"></span>
				</div>
				<!-- 주소 입력 -->
				<div class="mb-3">
					<label class="form-label">주소</label>
					<div class="input-group">
						<form:input path="tsAddr1" id="address" class="form-control" oninput="hideErrorMessage('staffAdd1Error')" />
						<button type="button" id="address_btn" class="btn btn-secondary">주소
							검색</button>
					</div>
					<form:errors path="tsAddr1" class="error" />
					<span id="staffAdd1Error" class="error"></span>
				</div>
				<!-- 상세주소 입력 -->
				<div class="mb-3">
					<label class="form-label">상세주소</label>
					<form:input path="tsAddr2" id="address_detail" class="form-control" oninput="hideErrorMessage('staffAdd2Error')" />
					<form:errors path="tsAddr2" class="error" />
					<span id="staffAdd2Error" class="error"></span>
				</div>
			</div>
			<!-- 프로필사진 -->
			<div class="col-md-4">
				<label class="form-label">프로필사진</label>
				<div>
					<img id="imagePreview"
						src="<c:url value='/resources/profileImages/${staff.tsFic }' />"
						style="max-width: 350px; max-height: 350px; border: 1px solid #ccc;">
				</div>
				<div class="mb-3">
					<input type="file" name="tsImage" accept="image/*"
						class="form-control" onchange="previewImage(event)"
						style="margin-top: 22px;">
					<form:errors path="tsFic" class="error" />
				</div>
			</div>
		</div>
	</div>
	<form:input path="tsPass" type="hidden"/>
</form:form>
</div></div>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function registerstaffAndSubmitForm(event) {
		event.preventDefault();
		
		var department = document.getElementById("tsDepSelect").value;
		var staffId = document.getElementById("tsCd").value;
		var staffNm = document.getElementById("tsNm").value;
		var staffPh = document.getElementById("tsPh").value;
		var staffReg = document.getElementById("tsReg1").value;
		var staffEmail = document.getElementById("tsEmail").value;
		var staffAdd1 = document.getElementById("address").value;
		var staffAdd2 = document.getElementById("address_detail").value;

		if (!staffId) {
		    document.getElementById("staffIdError").innerText = "직번을 입력해주세요." }
		if (!department) {
			document.getElementById("tsDepNotSelect").innerText = "부서를 선택해주세요." }
		if (!staffNm) {
			document.getElementById("staffNmError").innerText = "이름을 입력해주세요." }
		if (!staffPh) {
			document.getElementById("staffPhError").innerText = "번호를 입력해주세요." }
		if (!staffReg) {
			document.getElementById("staffRegError").innerText = "주민번호를 입력해주세요." }
		if (!staffEmail) {
			document.getElementById("staffEmailError").innerText = "이메일을 입력해주세요." }
		if (!staffAdd1) {
			document.getElementById("staffAdd1Error").innerText = "주소를 입력해주세요." }
		if (!staffAdd2) {
			document.getElementById("staffAdd2Error").innerText = "상세주소를 입력해주세요." }
		
		if (staffId && department && staffNm && 
				staffPh && staffReg && staffEmail &&
				staffAdd1 && staffAdd2) {
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
	
	function deletestaffAndSubmitForm(event) {
		event.preventDefault();
		var tsCd = document.getElementById("tsCd").value;
	
	    $.ajax({
	        type: "POST",
	        url: "${pageContext.request.contextPath}/staff/staffDelete.do",
	        data: {
	        	who: tsCd
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
	            			window.location.href = "${pageContext.request.contextPath}/staff/staffFrameList.do";
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