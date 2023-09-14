<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<form:form method="post" modelAttribute="lecture" enctype="multipart/form-data" style="margin-top: -36px;">
	
	<table class="table">
		
		<tr>
			<th>강의코드</th>
			<c:if test="${empty lecture.lecCd }">
				<td>강의코드는 자동으로 입력됩니다.</td>
			</c:if>
			<c:if test="${not empty lecture.lecCd }">
				<td>${lecture.lecCd }</td>
			</c:if>
			
			<th>강의명</th>
			<td>
			<form:input id="1" class="form-control" type="text" path="lecLectTitle" value="${lecture.lecLectTitle }" />
			<form:errors path="lecLectTitle" class="error" />
			</td>
		</tr>

		<tr>
			<th>단대</th>
			<td>
			<span>${prof.colgeNm }</span>
			</td>

			<th>학과</th>
			<td>
			<span>${prof.dtNm }</span>
			</td>
		</tr>

		<tr>
			<th>과목</th>
			<td>
			<form:select path="subjCd" class="form-select">
				<form:option value="" label="과목선택" />
				<c:forEach items="${subjectList2 }" var="subject">
					<form:option value="${subject.subjCd }" class="${subject.dtCd }" label="${subject.subjNm}" />
				</c:forEach>
			</form:select>
				 <form:errors path="subjCd" class="error" />
			</td>

			<th>교수</th>
			<td>
			<span>${prof.prNm }</span>
			<form:hidden id="prCd" path="prCd" value="${prof.prCd }" name="prCd"/>
			</td>
		</tr>

		<tr>
			<th>강의학점</th>
			<td>
			<form:select id="2" class="form-control" path="lecLectCred">
				<form:option value="" label="-- 선택하세요 --" />
				<form:option value="1" label="1학점" />
				<form:option value="2" label="2학점" />
				<form:option value="3" label="3학점" />
			</form:select>
			<form:errors path="lecLectCred" class="error" />
			</td>
			
			<th>강의분반</th>
			<td>
			<form:input id="3" class="form-control" type="text" path="lecLectDivision" value="${lecture.lecLectDivision }" />
			<form:errors path="lecLectDivision" class="error" />
			</td>
		</tr>
		
		<tr>
			<th>학년코드</th>
			<td>
			<form:select id="4" class="form-control" path="lecGraCd">
				<form:option value="" label="-- 선택하세요 --" />
				<form:option value="1" label="1학년" />
				<form:option value="2" label="2학년" />
				<form:option value="3" label="3학년" />
				<form:option value="4" label="4학년" />
			</form:select> <form:errors path="lecGraCd" class="error" />
			</td>

			<th>학기코드</th>
			<td>
			<form:select id="5" class="form-control" path="lecSemeCd">
				<form:option value="" label="-- 선택하세요 --" />
				<form:option value="1" label="1학기" />
				<form:option value="2" label="2학기" />
				<form:option value="3" label="하계학기" />
				<form:option value="4" label="동계학기" />
			</form:select>
			<form:errors path="lecSemeCd" class="error" />
			</td>
		</tr>
		
		<tr>
			
			<th>제한인원</th>
			<td>
			<form:input id="6" class="form-control" type="text" path="lecEnroLimit" value="${lecture.lecEnroLimit }" />
			<form:errors path="lecEnroLimit" class="error" />
			</td>
			<th>강의계획서</th>
			<td>
			<form:input type="file" class="form-control" path="lectureFiles" name="lectureFiles" value="${lecture.atchFileId }" />
			</td>		
		</tr>
		
		<tr>
			<th>중간고사비율</th>
			<td>
			<form:input id="7" class="form-control" type="number" path="grMid" value="${lecture.grMid }" />
			<form:errors path="grMid" class="error" />
			</td>

			<th>기말고사비율</th>
			<td>
			<form:input id="8" class="form-control" type="number" path="grFinal" value="${lecture.grFinal }" />
			<form:errors path="grFinal" class="error" />
			</td>
		</tr>
		
		<tr>
			<th>출석비율</th>
			<td>
			<form:input id="9" class="form-control" type="number" path="grAttend" value="${lecture.grAttend }" />
			<form:errors path="grAttend" class="error" />
			</td>

			<th>과제비율</th>
			<td>
			<form:input id="10" class="form-control" type="number" path="grAssi" value="${lecture.grAssi }" />
			<form:errors path="grAssi" class="error" />
			</td>
		</tr>
	</table>
<div class="row justify-content-center">
	<div class="col">
		<input id="auto" class="btn btn-outline-info" style=" border-radius: 10px;" type="button" value="자동완성기능">
	</div>
	<div class="col-7"></div>
	<c:if test="${empty lecture.lecCd }">
	<div class="col">
		<input id="submitBtn" class="btn btn-outline-success" style=" border-radius: 10px;" type="button" value="요청">
	</c:if> 
	<c:if test="${not empty lecture.lecCd }">
		<div class="col">
		<input id="submitBtn2" class="btn btn-outline-success" style=" border-radius: 10px;" type="button" value="수정">
	</c:if>
	<c:url value='/lecture/prfLectureList.do' var="ListURL" /> 
	<a class="btn btn-outline-danger" style="border-radius: 10px;" href="${ListURL }">취소</a>
	</div>
</div>	
</form:form>
<script>
//자동완성 버튼
$('#auto').on('click', function () {

	$('#1').val("테스트강의명");
	$('#2').val("3");
	$('#3').val("01");
	$('#4').val("4");
	$('#5').val("2");
	$('#6').val("30");
	$('#7').val("40");
	$('#8').val("30");
	$('#9').val("10");
	$('#10').val("20");
}); 
//등록버튼에 스윗 알람
$('#submitBtn').on('click', function () {
	Swal.fire({
	    title: '강의를 요청하시겠습니까?',
	    icon: 'info',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '등록',
	    cancelButtonText: '취소',
	}).then(result => {
	    if (result.isConfirmed) {
	    	insertLecture();
	    }
	});
});

//등록펑션
function insertLecture() {
	event.preventDefault();
	
	const subjCd = $("select[name='subjCd']").val(); // 과목코드
	const prCd = $("input[name='prCd']").val();// 교번
	const lecLectTitle = $("input[name='lecLectTitle']").val(); // 강의명
	const lecGraCd = $("select[name='lecGraCd']").val(); // 학년코드
	const lecSemeCd = $("select[name='lecSemeCd']").val(); // 학기코드
	const lecLectCred = $("select[name='lecLectCred']").val(); // 강의학점
	const lecEnroLimit = $("input[name='lecEnroLimit']").val(); // 제한인원
	const lecLectDivision = $("input[name='lecLectDivision']").val(); // 강의분반
	const grMid = $("input[name='grMid']").val(); // 중간고사비율
	const grFinal = $("input[name='grFinal']").val(); // 기말고사비율
	const grAttend = $("input[name='grAttend']").val(); // 참석비율
	const grAssi = $("input[name='grAssi']").val(); // 과제비율
	const lectureFiles = document.querySelector('input[name="lectureFiles"]').files[0]; // 강의계획서 파일

	if (!lecLectTitle) {
    	Swal.fire({
  		  title:'강의명을 입력해주세요.',
  		  icon: 'info',
 		});
        return;
    }
	if (!subjCd) {
		Swal.fire({
  		  title:'과목을 선택해주세요.',
  		  icon: 'info',
 		});
        return;
    }
    if (!prCd) {
    	Swal.fire({
    		  title:'교수를 선택해주세요.',
    		  icon: 'info',
   		});
        return;
    }
    if (!lecGraCd) {
    	Swal.fire({
   		  title:'학년을 선택해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecSemeCd) {
      	Swal.fire({
   		  title:'학기를 선택해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecLectCred) {
    	Swal.fire({
   		  title:'강의학점을 선택해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecEnroLimit) {
    	Swal.fire({
   		  title:'제한인원을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecLectDivision) {
    	Swal.fire({
   		  title:'강의분반을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grMid) {
    	Swal.fire({
   		  title:'중간고사 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grFinal) {
    	Swal.fire({
   		  title:'기말고사 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grAttend) {
    	Swal.fire({
   		  title:'출석 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grAssi) {
    	Swal.fire({
   		  title:'과제 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lectureFiles) {
    	Swal.fire({
   		  title:'강의계획서 파일을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    const a = parseInt(document.querySelector('input[name="grMid"]').value);
    const b = parseInt(document.querySelector('input[name="grFinal"]').value);
    const c = parseInt(document.querySelector('input[name="grAttend"]').value);
    const d = parseInt(document.querySelector('input[name="grAssi"]').value);

    const totalRatio = a + b + c + d;
    if (totalRatio !== 100) {
    	Swal.fire({
   		  title:'중간고사 비율, 기말고사 비율, 출석비율, 과제비율의 합은 100이어야 합니다.',
   		  icon: 'info',
   		});
        return;
    }
    
	const formData = new FormData();
	
	formData.append("subjCd", subjCd);
	formData.append("prCd", prCd);
	formData.append("lecLectTitle", lecLectTitle);
	formData.append("lecGraCd", lecGraCd);
	formData.append("lecSemeCd", lecSemeCd);
	formData.append("lecLectCred", lecLectCred);
	formData.append("lecEnroLimit", lecEnroLimit);
	formData.append("lecLectDivision", lecLectDivision);
	formData.append("grMid", grMid);
	formData.append("grFinal", grFinal);
	formData.append("grAttend", grAttend);
	formData.append("grAssi", grAssi);
	formData.append("lectureFiles", lectureFiles);
	
	$.ajax({
		url: "/oryuUniversity/lecture/lectureRequest.do",
		type: "post",
		data: formData,
		contentType: false,
		processData: false,
		success: function(response) {
			Swal.fire({
				title:response,
				icon: 'success',
			}).then(result => {
				if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					window.location.href = "<%=request.getContextPath()%>/lecture/prfLectureList.do";	
				}
			})
		},
		error : function(error) {
			Swal.fire({
    		  title:error,
    		  icon: 'error',
			});
		}
	});
};
//수정버튼에 스윗 알람
$('#submitBtn2').on('click', function () {
	Swal.fire({
	    title: '강의를 수정하시겠습니까?',
	    icon: 'info',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '등록',
	    cancelButtonText: '취소',
	}).then(result => {
	    if (result.isConfirmed) {
	    	updateLecture();
	    }
	});
});

//강의수정
function updateLecture(event) {

    const lecCd = "${lecture.lecCd}"; // 강의코드
    const subjCd = $("select[name='subjCd']").val(); // 과목코드
	const prCd = $("input[name='prCd']").val(); // 교번
    const lecLectTitle = $("input[name='lecLectTitle']").val(); // 강의명
    const lecGraCd = $("select[name='lecGraCd']").val(); // 학년코드
    const lecSemeCd = $("select[name='lecSemeCd']").val(); // 학기코드
    const lecLectCred = $("select[name='lecLectCred']").val(); // 강의학점
    const lecEnroLimit = $("input[name='lecEnroLimit']").val(); // 제한인원
    const lecLectDivision = $("input[name='lecLectDivision']").val(); // 강의분반
    const grMid = $("input[name='grMid']").val(); // 중간고사비율
    const grFinal = $("input[name='grFinal']").val(); // 기말고사비율
    const grAttend = $("input[name='grAttend']").val(); // 참석비율
    const grAssi = $("input[name='grAssi']").val(); // 과제비율
    const lectureFiles = document.querySelector('input[name="lectureFiles"]').files[0]; // 강의계획서 파일

 // 필수 조건 검사
    if (!lecCd) {
    	Swal.fire({
   		  title:'강의코드가 없습니다.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecLectTitle) {
    	Swal.fire({
  		  title:'강의명을 입력해주세요.',
  		  icon: 'info',
 		});
        return;
    }
    if (!subjCd) {
		Swal.fire({
  		  title:'과목을 선택해주세요.',
  		  icon: 'info',
 		});
        return;
    }
    if (!prCd) {
    	Swal.fire({
    		  title:'교수를 선택해주세요.',
    		  icon: 'info',
   		});
        return;
    }
    if (!lecGraCd) {
    	Swal.fire({
   		  title:'학년을 선택해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecSemeCd) {
      	Swal.fire({
   		  title:'학기를 선택해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecLectCred) {
    	Swal.fire({
   		  title:'강의학점을 선택해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecEnroLimit) {
    	Swal.fire({
   		  title:'제한인원을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lecLectDivision) {
    	Swal.fire({
   		  title:'강의분반을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grMid) {
    	Swal.fire({
   		  title:'중간고사 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grFinal) {
    	Swal.fire({
   		  title:'기말고사 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grAttend) {
    	Swal.fire({
   		  title:'출석 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!grAssi) {
    	Swal.fire({
   		  title:'과제 비율을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    if (!lectureFiles) {
    	Swal.fire({
   		  title:'강의계획서 파일을 입력해주세요.',
   		  icon: 'info',
   		});
        return;
    }
    
    const a = parseInt(document.querySelector('input[name="grMid"]').value);
    const b = parseInt(document.querySelector('input[name="grFinal"]').value);
    const c = parseInt(document.querySelector('input[name="grAttend"]').value);
    const d = parseInt(document.querySelector('input[name="grAssi"]').value);

    const totalRatio = a + b + c + d;
    if (totalRatio !== 100) {
    	Swal.fire({
   		  title:'중간고사 비율, 기말고사 비율, 출석비율, 과제비율의 합은 100이어야 합니다.',
   		  icon: 'info',
   		});
        return;
    }
    
	const formData = new FormData();
	formData.append("lecCd", lecCd); // 강의코드 추가
	formData.append("subjCd", subjCd);
	formData.append("prCd", prCd);
	formData.append("lecLectTitle", lecLectTitle);
	formData.append("lecGraCd", lecGraCd);
	formData.append("lecSemeCd", lecSemeCd);
	formData.append("lecLectCred", lecLectCred);
	formData.append("lecEnroLimit", lecEnroLimit);
	formData.append("lecLectDivision", lecLectDivision);
	formData.append("grMid", grMid);
	formData.append("grFinal", grFinal);
	formData.append("grAttend", grAttend);
	formData.append("grAssi", grAssi);
	formData.append("lectureFiles", lectureFiles);
	
	$.ajax({
	    url: "/oryuUniversity/lecture/lectureUpdate.do",
	    type: "post",
	    data: formData,
	    contentType: false,
	    processData: false,
	    success: function(response) {
	    	Swal.fire({
      		  title:response,
      		  icon: 'success',
     		}).then(result => {
				if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					window.location.href = "<%=request.getContextPath()%>/lecture/prfLectureList.do";	
				}
	     	})
	    },
	    error : function(error) {
			Swal.fire({
	    		  title:error,
	    		  icon: 'error',
			});
		}
	});
};
</script>
