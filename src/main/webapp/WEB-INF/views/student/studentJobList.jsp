<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
.gradInfo {
	margin-top: 3px;
	background-color: rgba(0, 0, 0, 0.03);
	margin: 20px;
	padding-right: 40px;
	font-family: 'Noto Sans KR', sans-serif;
}

.gradInfo-header {
	margin: 20px 0 11px 40px;
	font-size: 14px;
	font-weight: bold;
}
.gradInfo-header2 {
	padding-right: 40px;
	margin: 20px 0 11px 40px;
	font-size: 14px;
	font-weight: bold;
}

.gradInfo-body {
	margin: -13px 11px 20px 40px;
	font-size: 12px;
}

.span-title {
	font-weight: bold;
	color: #248AFD;
	margin-right: 12px;
}

select {
	padding: 0; /* 위 아래 여백을 없애는 스타일 */
	display: inline-block; /* 셀렉트 박스를 인라인 블록 요소로 표시하여 텍스트 흐름을 방해하지 않도록 함 */
	vertical-align: middle; /* 수직 정렬을 가운데로 설정 */
}

button {
	margin-left: 10px;
}

.row {
	margin: 10px;
}

th {
	text-align: center;
}

td {
	text-align: center;
}
</style>
<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="h-100">
		<div class="custom-card">
			<div class="card-header"
				style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">취업관리</div>
			<div class="row">
				<div class="col-sm-5">
					<div class="row" style="margin-left: 5px;">
						<div class="col">
							<select name="year" class="form-select" id="selectYear3">
								<option value=>졸업연도</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
							</select>
						</div>
						<div class="col">
							<select name="college" class="form-select" id="selectCollege">
								<option value>단대</option>
								<c:forEach items="${collegeList }" var="college">
									<option value="${college.colgeCd }">${college.colgeNm }</option>
								</c:forEach>
							</select>
						</div>
						<div class="col">
							<select name="dtCd" class="form-select" id="selectDepartment">
								<option value>학과</option>
								<c:forEach items="${departmentList }" var="department">
									<option value="${department.dtCd }"
										class="${department.colgeCd }">${department.dtNm }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="card box-shadow">
					<div class="gradInfo-header2">
						<i class="mdi mdi-chart-line" style="color: green;"></i>취업률 목록
					</div>
					<div id="departmentList"></div>
					</div>
					<div class="row"></div>
					<div class="row"></div>
					<div class="card box-shadow">
					<div class="gradInfo-header2">
						<i class="mdi mdi-chart-line" style="color: green;"></i>취업 업데이트
					</div>
					<div id="updateForm"></div>
					</div>
					
				</div>
				<div class="col-sm-7">
					<div class="row" style="margin-left: 10px; width: 80%;">
						<div class="col">
							<select name="year" class="form-select" id="selectYear">
								<option value=>졸업연도</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
							</select>
						</div>
						<div class="col">
							<select name="status" class="form-select" id="selectStatus">
								<option value=>취업상태</option>
								<option value="미등록">미등록</option>
								<option value="취업">취업</option>
								<option value="미취업">미취업</option>
							</select>
						</div>
						<div class="col">
							<select name="year2" class="form-select" id="selectYear2">
								<option value=>취업연도</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
							</select>
						</div>

						<div class="col">
							<select name="category" class="form-select" id="selectCategory">
								<option value=>취업분야</option>
								<option value="공기업">공기업</option>
								<option value="사기업">사기업</option>
							</select>
						</div>
					</div>
					<div class="card box-shadow">
					<div class="gradInfo-header2">
						<i class="mdi mdi-chart-line" style="color: green;"></i>학생 취업 현황
					</div>
					<div id="studentList"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 검색조건 받기 -->
<form:form id="searchForm" method="get">
	<input type="hidden" name="college" id="college" />
	<input type="hidden" name="dtCd" id="dtCd" />
	<input type="hidden" name="year" id="year" />
	<input type="hidden" name="year2" id="year2" />
	<input type="hidden" name="page" id="page" />
	<input type="hidden" name="page2" id="page2" />
</form:form>
<script>
	let $dtCd2 = $('[name="dtCd"]');
	$('[name="college"]').on("change", function(event) {
		let colgeCd = $(this).val();
		if (colgeCd) {
			$dtCd2.find("option").hide();
			$dtCd2.find(`option:first`).show();
			$dtCd2.find(`option.\${colgeCd}`).show();
		} else {
			$dtCd2.find("option").show();
		}
	}).trigger("change");
</script>
<script>
$(document).ready(function() {
    // 페이지 처음 로딩
    fetchStudent();
    fetchDepartment();
    fetchUpdateForm();
    // 검색 조건 변경 이벤트 처리
    $("#selectYear, #selectCollege, #selectDepartment, #selectStatus, #selectYear2, #selectCategory, #selectYear3").on("change", function() {
        fetchDepartment(); // 검색 조건이 변경되면 학과별 현황을 업데이트
        fetchStudent(); // 검색 조건이 변경 되면 학생 현황을 업데이트
    });
    
    $("#studentList").on('click','tr', function(){
    	var clickSt = $(this).find("td[class='col-sm-1 stCd']").text();
    	$(stCd).val(clickSt);
    });
    
});
//학생목록 불러오기
function fetchStudent() {
	const selectedYear = $("#selectYear").val();
    const selectedCollege = $("#selectCollege").val();
    const selectedDepartment = $("#selectDepartment").val();
    const selectedStatus = $("#selectStatus").val();
    const selectedYear2 = $("#selectYear2").val();
    const selectedCategory = $("#selectCategory").val();
    const selectedPage = $("#page").val();

    $.ajax({
		url : "/oryuUniversity/student/studentManagementList.do",
		method : "get",
		dataType : "html",
		 data: {
	            year: selectedYear,
	            college: selectedCollege,
	            dtCd: selectedDepartment,
	            status: selectedStatus,
	            year2: selectedYear2,
	            category: selectedCategory,
	            page: selectedPage
        },
		success : function(data) {
			$("#studentList").html(data); // 수정된 부분
		},
		error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		},
	});
}

// 학과별 현황 조회 함수
function fetchDepartment() {
    const selectedYear = $("#selectYear3").val();
    const selectedCollege = $("#selectCollege").val();
    const selectedDepartment = $("#selectDepartment").val();
    const selectedPage = $("#page2").val();
    
    $.ajax({
        url : "/oryuUniversity/student/departmentList.do",
        method : "get",
        dataType : "html",
        data: {
            college: selectedCollege,
            dtCd: selectedDepartment,
            year: selectedYear,
            page: selectedPage
        },
        success : function(data) {
            $("#departmentList").html(data);
        },
        error : function(jqXHR, status, error) {
            console.log(jqXHR);
            console.log(status);
            console.log(error);
        }
    });
}

//업데이트 폼 불러오기
function fetchUpdateForm() {
    $.ajax({
		url : "/oryuUniversity/student/updateStatus.do",
		method : "get",
		dataType : "html",
		success : function(data) {
			$("#updateForm").html(data); // 수정된 부분
		},
		error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		},
	});
}

<!-- pagination -->
function fn_paging(page) {
	searchForm.page.value = page;
	fetchStudent();
}
function fn_paging2(page) {
	searchForm.page2.value = page;
	fetchDepartment();
}
</script>