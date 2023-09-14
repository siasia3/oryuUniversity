<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
.paging-info {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.paging-info p {
	margin: 0;
}

.table-padding {
	padding: 0 50px 0 50px;
}
</style>
<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="h-100">
		<div class="card-header"
			style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">
			학사 일정 목록</div>
		<div class="table-padding">
			<table class="table">
				<tr>
					<td>
						<div>

							<select name="asDistinction" class="form-select">
								<option value="">구분선택</option>
								<option value="등록/장학일정">등록/장학일정</option>
								<option value="졸업일정">졸업일정</option>
								<option value="학적일정">학적일정</option>
								<option value="수업일정">수업일정</option>
								<option value="행사일정">행사일정</option>
								<option value="학술사업일정">학술사업일정</option>
								<option value="수강신청일정">수강신청일정</option>
								<option value="공휴일">공휴일</option>
								<option value="기타">기타</option>
							</select>
						</div>
					</td>
					<td>
						<div>
							<select name="month" class="form-select">
								<option value="">월 선택</option>
								<c:forEach begin="1" end="12" var="month">
									<option value="${month}">${month}월</option>
								</c:forEach>
							</select>
						</div>
					</td>
					<td colspan="5">
						<div id="searchUI" class="row justify-content-center">
							<div class="col-auto">
								<form:select path="simpleCondition.searchType"
									class="form-select">
									<form:option value="" label="전체" />
									<form:option value="title" label="일정명" />
									<form:option value="content" label="내용" />
								</form:select>
							</div>
							<div class="col-auto">
								<form:input path="simpleCondition.searchWord"
									class="form-control" />
							</div>
							<div class="col-auto">
								<input type="button" value="검색" id="searchBtn"
									class="btn btn-success" /> <a
									href="<c:url value='/schedule/acaScheduleInsert.do'/>"
									class="btn btn-primary">새일정</a>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="5">
						<div class="paging-info">
							<p>총 ${totalRecord}건의 일정이 있습니다.</p>
							<p>페이지 ${paging.currentPage}/${paging.endPage}</p>
						</div>
					</td>
				</tr>
			</table>

			<table class="table">
				<thead class="table-light">
					<tr>
						<th>번호</th>
						<th>구분</th>
						<th>일정명</th>
						<th>시작일시</th>
						<th>종료일시</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="acaScheduleList" value="${paging.dataList }" />
					<c:choose>
						<c:when test="${empty acaScheduleList }">
							<tr>
								<td colspan="5">조건에 맞는 게시글 없음.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${acaScheduleList }" var="acaSchedule">
								<tr>
									<c:url value="/schedule/acaScheduleView.do" var="viewURL">
										<c:param name="what" value="${acaSchedule.asCd }"></c:param>
									</c:url>
									<td>${acaSchedule.rnum }</td>
									<td>${acaSchedule.asDistinction }</td>
									<td><a href="${viewURL }">${acaSchedule.asNm }</a></td>
									<td>${acaSchedule.asStart }</td>
									<td>${acaSchedule.asEnd }</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div class="d-flex justify-content-center mb-3 mt-4">
				${paging.pagingHTML }</div>

		</div>
	</div>
</div>

<form:form id="searchForm" modelAttribute="simpleCondition" method="get">
	<input type="hidden" name="page" />
	<input type="hidden" name="asDistinction"
		value="${detailCondition.asDistinction}" />
	<input type="hidden" name="month" value="${detailCondition.month}" />
	<form:hidden path="searchType" />
	<form:hidden path="searchWord" />
</form:form>
<script>
	function fn_paging(page) {
		searchForm.page.value = page;
		searchForm.requestSubmit();
	}

	$(searchBtn).on("click", function(event) {
		$(searchUI).find(":input[name]").each(function(idx, input) {
			let name = input.name;
			let value = $(input).val();
			$(searchForm).find(`[name=\${name}]`).val(value);
		});
		$(searchForm).submit();
	});
</script>




