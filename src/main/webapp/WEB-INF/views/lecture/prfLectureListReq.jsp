<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
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
				style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">강의관리</div>
			<div class="card-body">
			<div class="card gradInfo">
			<div class="gradInfo-header">
				<i class="mdi mdi-check-circle" style="color: green;"></i> 요청 목록 페이지
				<hr style="border-color: black;">
			</div>
			<div class="gradInfo-body">
				<span class="span-title">검색자</span>
				|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단대,학과,이수구분,학년,학기,강의 상태를 선택하고 검색버튼을 눌러주세요.
			</div>
			<div class="gradInfo-body">
				<span class="span-title">강의상태 확인</span>
				|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;강의 등록 완료시 강의목록으로 이동 됩니다. 요청 거절을 확인한 후 담당 교직원에게 문의해주세요.
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-2">
				<select name="classfication" class="form-select">
					<option value>이수구분선택</option>
					<c:forEach items="${classificationList }" var="classification">
						<option value="${classification.cfCode }">${classification.cfName }</option>
					</c:forEach>
				</select>
			</div>
			<div class="col-2">
				<select name="grade" class="form-select">
					<option value>학년선택</option>
					<option value="1">1학년</option>
					<option value="2">2학년</option>
					<option value="3">3학년</option>
					<option value="4">4학년</option>
				</select>
			</div>
			<div class="col-2">
				<select name="semester" class="form-select">
					<option value>학기선택</option>
					<option value="1">1학기</option>
					<option value="2">2학기</option>
					<option value="3">하계학기</option>
					<option value="4">동계학기</option>
				</select>
			</div>
			<div class="col-2">
				<select name="lecStat" class="form-select">
					<option value>강의상태</option>
					<option value="4">등록요청</option>
					<option value="5">요청거절</option>
				</select>
			</div>
		</div>
		<div class="row justify-content-center">
			<div id="searchUI" class="col-1">
				<form:select path="simpleCondition.searchType" class="form-select">
					<form:option value="" label="전체" />
					<form:option value="lCode" label="강의코드" />
					<form:option value="lName" label="강의명" />
					<form:option value="sCode" label="과목코드" />
					<form:option value="sName" label="과목명" />
				</form:select>
			</div>
			<div id="searchUI" class="col-2">
				<form:input path="simpleCondition.searchWord" class="form-control" />
			</div>
			<div class="col-1">
				<input type="button" value="검색" id="searchBtn"
					class="btn btn-success" />
			</div>
		</div>
				<div class="row justify-content-center">
			<div class="col-8">
				<table class="table">
					<thead class="table-light">
						<tr>
<!-- 							<th><input id="toggleCheckBoxes" type="checkbox" -->
<!-- 								name="checkBox"></th> -->
							<th>과목명(과목코드)</th>
							<th>강의명(강의코드)</th>
<!-- 							<th>교수명</th> -->
							<th>학년,학기</th>
							<th>강의학점</th>
							<th>제한인원</th>
<!-- 							<th>강의분반</th> -->
<!-- 							<th>강의실(강의실코드)</th> -->
<!-- 							<th>강의시간</th> -->
							<th>강의계획서</th>
							<th>이수구분</th>
							<th>강의상태</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="lectureList" value="${paging.dataList }" />
						<c:choose>
							<c:when test="${empty lectureList }">
								<tr>
									<td colspan="8">조건에 맞는 과목이 없음.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${lectureList }" var="lecture">
									<tr data-id="${lecture.lecCd}" class="clickable-row">
<!-- 										<td class="col-1 no-click"><input type="checkbox" -->
<!-- 											name="checkBox"></td> -->
										<td class="col-1">${lecture.subject.subjNm}(${lecture.subject.subjCd})</td>
										<td class="col-1 lecCd" hidden="">${lecture.lecCd}</td>
										<td class="col-1 lecTitle">${lecture.lecLectTitle}(${lecture.lecCd})</td>
<%-- 										<td class="col-1">${lecture.professor.prNm}</td> --%>
										<td class="col-1">${lecture.lecGraCd}학년,${lecture.lecSemeCd}학기</td>
										<td class="col-1">${lecture.lecLectCred}학점</td>
										<td class="col-1">${lecture.lecEnroLimit}명</td>
<%-- 										<td class="col-1">${lecture.lecLectDivision}분반</td> --%>
<%-- 										<td class="col-1">${lecture.clasNm}(${lecture.clasCd})</td> --%>
<%-- 										<td class="col-1">${lecture.scheCds}</td> --%>
										<td class="col-xs-1 link-cell no-click"><c:if
												test="${not empty lecture.fileGroup and not empty lecture.fileGroup.detailList }">
												<c:forEach items="${lecture.fileGroup.detailList }"
													var="fileDetail">
													<c:url value="/download.do" var="downloadURL">
														<c:param name="atchFileId"
															value="${fileDetail.atchFileId }" />
														<c:param name="fileSn" value="${fileDetail.fileSn }" />
													</c:url>
													<a href="${downloadURL }"><i
														class="mdi mdi-briefcase-download menu-icon"></i></a>
												</c:forEach>
											</c:if></td>
										<td class="col-1"><c:choose>
												<c:when test="${lecture.subject.subjComType eq '1'}">
													<span class="badge badge-primary"> <c:out
															value="전공필수" />
													</span>
												</c:when>
												<c:when test="${lecture.subject.subjComType eq '2'}">
													<span class="badge badge-info"> <c:out
															value="전공선택" />
													</span>
												</c:when>
												<c:when test="${lecture.subject.subjComType eq '3'}">
													<span class="badge badge-secondary"> <c:out
															value="교양필수" />
													</span>
												</c:when>
												<c:when test="${lecture.subject.subjComType eq '4'}">
													<span class="badge badge-light"> <c:out
															value="교양선택" />
													</span>
												</c:when>
											</c:choose></td>	
										<td class="col-xs-1"><c:choose>
											<c:when test="${lecture.lecStat eq '4'}">
												<span class="badge badge-warning"> <c:out
														value="등록요청" />
												</span>
											</c:when>
											<c:when test="${lecture.lecStat eq '5'}">
												<span class="badge badge-danger"> <c:out
														value="요청거절" />
												</span>
											</c:when>
										</c:choose></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="7">
								<div class="d-flex justify-content-center mb-3">
									${paging.pagingHTML }</div>
									<td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="lectureDetail" tabindex="-1" aria-labelledby="lectureDetail" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content" style="width: 50%; margin: 0 auto;">
	      <div class="modal-header">
	        <h5 class="modal-title" id="lectureDetail">강의관리</h5>
	        <button onclick=closeModal() type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div id="detailBody" class="modal-body d-flex">
	      </div>
	      <div class="modal-footer">
	        <button onclick=closeModal() type="button" class="btn btn-secondary" data-dismiss="modal">목록</button>
	      </div>
	    </div>
	  </div>
	</div>		
<!-- 검색조건 받기 -->
<form:form id="searchForm" modelAttribute="simpleCondition" method="get">
	<input type="hidden" name="college" id="college" value="${detail.college }" />
	<input type="hidden" name="dtCd" id="dtCd" value="${detail.dtCd }" />
	<input type="hidden" name="classfication" id="classfication" value="${detail.classfication }" />
	<input type="hidden" name="lecStat" id="lecStat" value="${detail.lecStat }" />
	<input type="hidden" name="grade" id="grade" value="${detail.grade }" />
	<input type="hidden" name="semester" id="semester" value="${detail.semester }" />

	<form:hidden path="searchType" />
	<form:hidden path="searchWord" />
	<input type="hidden" name="page" />
</form:form>
<script>
<!-- 검색조건내에 조건걸기 -->
 	let $dtCd = $('[name="dtCd"]');
 	$('[name="college"]').on("change", function(event){
 		let colgeCd = $(this).val();
		if(colgeCd){
			$dtCd.find("option").hide();
			$dtCd.find(`option:first`).show();
 			$dtCd.find(`option.\${colgeCd}`).show();
 		}else{
 			$dtCd.find("option").show();
 		}
 	}).trigger("change")
<!-- pagination -->
	function fn_paging(page){
		searchForm.page.value = page;
		searchForm.requestSubmit();
	}
	$(searchBtn).on("click", function(event){
		$(searchUI).find(":input[name]").each(function(idx, input){
			let name = input.name;
			let value = $(input).val();
			$(searchForm).find(`[name=\${name}]`).val(value);
		});
		let college = $("select[name='college']").val();
		let dtCd = $("select[name='dtCd']").val();
		let lecStat = $("select[name='lecStat']").val();
		let classfication = $("select[name='classfication']").val();
		let grade = $("select[name='grade']").val();
		let semester = $("select[name='semester']").val();
		$("#searchForm input[name='college']").val(college);
    	$("#searchForm input[name='dtCd']").val(dtCd);
		$("#lecStat").val(lecStat);
		$("#classfication").val(classfication);
		$("#grade").val(grade);
		$("#semester").val(semester);
		
		$(searchForm).submit();
	})
</script>
<script>
	//모달 닫기
	function closeModal(){
		$("#lectureDetail").modal('hide');
	}
	
	// 강의 상세보기
	document.addEventListener("DOMContentLoaded", function() {
	    $(".clickable-row").on("click", "td:not(.no-click)", function() {
	    	var lecCd = $(this).parent().data("id");
	        
	        let setting = {
	                url : `${pageContext.request.contextPath}/lecture/lectureView.do`,
	                data : {
	               	 lecCd : lecCd
	                },
	                method: "post",
	                success : function(resp) {
	               	 $(detailBody).html(resp);
	               	 $("#lectureDetail").modal('show');
	                }
	             }
	             $.ajax(setting);
	      });
	});
</script>
<script>
<!--요청수락 버튼-->
$('#allowRow').on('click',function(){
	event.preventDefault();
    let $checkLecCd= $("input:checked").parent('td').siblings('.lecCd');
    let lecCd=[];
    for(let i = 0;i<$checkLecCd.length;i++){
    	lecCd.push($checkLecCd[i].innerText);
    }
    let setting = {
       url : "/oryuUniversity/lecture/allowLecture.do",
       method : "post",
       dataType : "text",
       traditional: true,
       data : {
    	   lecCd : lecCd
       },
       success : function(resp) {
          if(resp=="success"){
            alert("선택된 요청강의는 휴강상태로 전환 됩니다.")
            window.location.href="<%=request.getContextPath()%>/lecture/mnglectureListReq.do";
          }else{
			alert("요청된 작업 진행 실패");
          }
       },
       error : function(jqXHR, status, error) {
          console.log(jqXHR)
          console.log(status)
          console.log(error)
       }
    }

    $.ajax(setting);
 })
 <!--요청거절 버튼-->
$('#refuseRow').on('click',function(){
	event.preventDefault();
    let $checkLecCd= $("input:checked").parent('td').siblings('.lecCd');
    let lecCd=[];
    for(let i = 0;i<$checkLecCd.length;i++){
    	lecCd.push($checkLecCd[i].innerText);
    }
    let setting = {
       url : "/oryuUniversity/lecture/refuseLecture.do",
       method : "post",
       dataType : "text",
       traditional: true,
       data : {
    	   lecCd : lecCd
       },
       success : function(resp) {
          if(resp=="success"){
            alert("선택된 요청강의는 거절 됩니다.")
            window.location.href="<%=request.getContextPath()%>/lecture/mnglectureListReq.do";
          }else{
			alert("요청된 작업 진행 실패");
          }
       },
       error : function(jqXHR, status, error) {
          console.log(jqXHR)
          console.log(status)
          console.log(error)
       }
    }

    $.ajax(setting);
 })
</script>

