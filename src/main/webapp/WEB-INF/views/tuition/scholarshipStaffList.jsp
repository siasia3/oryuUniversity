<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style>
.btn {
	padding-bottom: 10px;
	padding-top: 10px;
}
.table td {
	padding: 0.825rem;
	text-align: center;
}
.table th {
	text-align: center;
}
.custom-modal-size {
    max-width: 700px; /* 원하는 최대 가로폭을 지정 */
    width: 80%; /* 모달의 가로폭을 지정한 최대 가로폭의 비율로 조정*/
    margin: auto; /* 가운데 정렬을 위해 마진을 auto로 설정 */
}
.col-form-label{
	font-weight: bold;
}
.modal-title {
    font-size: 24px; /* 원하는 글씨 크기로 조정 */
    font-weight: bold; /* 굵게 표시 */
}
.modal-body {
    max-height: calc(100vh - 280px); /* 예시로 모달 높이 제한 */
    overflow-y: auto;
}
#exampleModal {
    position: fixed;
    top: 45%;
    left: 50%;
    transform: translate(-50%, -50%);
}
.file-link {
    display: block;
    margin-top: 5px;
    margin-bottom: 5px;
}
#message-text2 {
  		height: 200px;
  }
</style>
<div class="card box-shadow d-flex m-4" style="min-height: auto;">
      <div class="h-100">
      <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">장학금 관리</div>

<table style="margin-bottom: 15px;">
	<td style="padding-left: 380px; padding-top:30px; padding-bottom:15px; width: auto;"><select name="semesterCd" class="form-select"
				id="selectSemesterCd">
					<option value>년도/학기</option>
						<option value="20211">2021년 1학기</option>
						<option value="20212">2021년 2학기</option>
						<option value="20221">2022년 1학기</option>
						<option value="20222">2022년 2학기</option>
						<option value="20231">2023년 1학기</option>
						<option value="20232">2023년 2학기</option>
			</select></td>
	<td style="padding-left: 20px; padding-top:30px; padding-bottom:15px; width: auto;"><select name="dtCd" class="form-select"
				id="selectDepartment">
					<option value>학과선택</option>
					<c:forEach items="${departmentList }" var="department">
						<option value="${department.dtCd }">${department.dtNm }</option>
					</c:forEach>
			</select></td>
	<td style="padding-left: 20px; padding-top:30px; padding-bottom:15px; width: auto;"><select name="tuSchSta" class="form-select"
				id="selectStatus">
					<option value>신청상태</option>
						<option value="대기">대기</option>
						<option value="승인">승인</option>
						<option value="반려">반려</option>
			</select></td>
		<div colspan="11" style="border-radius: 20px">
			<td style="padding-left: 20px; padding-top:30px; padding-bottom:15px;">
				<div id="searchUI" class="form-inline">
					<form:select class="form-select mr-2" path="simpleCondition.searchType" style="width: auto;">
						<form:option value="name" label="이름" />
						<form:option value="stnum" label="학번" />
					</form:select>
					<form:input class="form-control mr-2" path="simpleCondition.searchWord" style="height: 37px" />
					<input type="button" value="검색" id="searchBtn" class="btn btn-success text-center" />
				</div>
			</td>
		</div>
</table>

<div id="tuitionList"></div>

</div></div>
<form:form id="searchForm" modelAttribute="simpleCondition" method="get">
	<form:hidden path="searchType" />
	<form:hidden path="searchWord" />
	<input type="hidden" name="page" id="page" />
</form:form>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog custom-modal-size">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">장학 신청</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="padding-bottom: 10px; padding-top: 10px;">
      	<form method="post" enctype="multipart/form-data">
          <div class="row mb-3">
          <div class="col">
            <label for="message-text" class="col-form-label">년도</label>
            <input name="semesterCd1" class="form-control" readonly="true"
            	style="background-color: white;" />
          </div>
          <div class="col">
            <label for="message-text" class="col-form-label">학기</label>
            <input name="semesterCd2" class="form-control" readonly="true" 
            	style="background-color: white;" />
            </div>
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">장학종류</label>
            <input name="tuSchType" class="form-control" readonly="true"
            	style="background-color: white;" />
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">내용</label>
            <textarea class="form-control" id="message-text" style="height: 250px; background-color: white;" name="tuSchCon" readonly="true"></textarea>
          </div>
          <div class="mb-3">
            <label for="file-input" class="col-form-label">첨부파일</label>
            <div name="file" class="form-control" id="file-download" style="height: auto;"></div>
          </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-info" id="approveButton">승인</button>
	        <button type="button" class="btn btn-danger" id="rejectButton">반려</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	      </div>
	    </form>
    </div>
  </div>
</div>

<!-- 반려내용 입력 모달 창 -->
<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog custom-modal-size">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">반려요청</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">반려사유 입력</label>
            <textarea class="form-control" id="message-text2"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="sendMessageButton">전송</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<script>

$(document).ready(function() {
	//페이지 처음 로딩
	fetchTuition();

	// 검색 조건 변경 이벤트 처리
	$("#selectSemesterCd").on("change", function() {
    	$("#page").val(1); // 검색 조건이 변경되면 페이지 번호 초기화
    	fetchTuition(); // 검색 조건이 변경 되면 장학신청 현황을 업데이트
	});
	
	$("#selectDepartment").on("change", function() {
    	$("#page").val(1);
    	fetchTuition();
	});
	
	$("#selectStatus").on("change", function() {
    	$("#page").val(1);
    	fetchTuition();
	});
	
	$("#searchBtn").on("click", function() {
		fetchTuition(); // 검색 버튼 클릭 시 장학신청 현황 업데이트
    });
	
});

//학생들에게 받은 장학신청 목록 불러오기
function fetchTuition() {
	const selectedSemesterCd = $("#selectSemesterCd").val();
	const selectedDepartment = $("#selectDepartment").val();
	const selectedTuSchSta = $("#selectStatus").val();
	const selectedPage = $("#page").val();
    const selectedSearchType = $("#searchType").val();
    const selectedSearchWord = $("#searchWord").val();
    
    $.ajax({
    	url : "/oryuUniversity/scholarship/scholarshipApplyRetrieve.do",
    	method : "get",
    	dataType : "html",
    	data : {
    		semesterCd : selectedSemesterCd,
    		dtCd: selectedDepartment,
    		tuSchSta: selectedTuSchSta,
            page: selectedPage,
            searchType: selectedSearchType,
            searchWord: selectedSearchWord
    	},
    	success : function(data) {
    		$("#tuitionList").html(data);
    	},
    	error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
    	}
    });
}

function fn_paging(page) {
	searchForm.page.value = page;
	fetchTuition();
}
</script>