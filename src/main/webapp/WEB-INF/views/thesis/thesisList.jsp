<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<style>
.paging-info {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.paging-info p {
	margin: 0;
}

#videoContainer {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 300px; /* Adjust the height as needed */
}

#videoContainer video {
	max-width: 100%;
	max-height: 100%;
}

video {
	width: 100%;
	height: auto;
}

.clickable-block {
	display: block;
	text-decoration: none;
	color: #000;
}

.clickable-block:hover {
	background-color: #f0f0f0;
}

.table-container {
	width: 100%;
	overflow-x: auto;
}

.table {
	width: 100%;
	table-layout: fixed;
}

.table th, .table td {
	/*   padding: 8px; */
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
</style>

<%-- <a href="<c:url value='/thesis/thesisInsert.do'/>">논문등록</a> --%>

<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="h-100">
		<div class="card-header"
			style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">논문/연구
			목록</div>

		<table class="table">
			<tr>
				<td>
					<div id="searchUI" class="row justify-content-center">
						<div class="col-auto">
							<form:select path="simpleCondition.searchType"
								class="form-select">
								<form:option value="" label="전체" />
								<form:option value="thesAutNm1" label="작성자" />
								<form:option value="thesNm" label="제목" />
								<form:option value="thesCont" label="내용" />
							</form:select>
						</div>
						<div class="col-auto">
							<form:input path="simpleCondition.searchWord"
								class="form-control" />
						</div>
						<div class="col-auto">
							<input type="button" value="검색" id="searchBtn"
								class="btn btn-success" />
							<!-- 여긴 등록이 딱히 필요없음. <a href="<c:url value='/acBuDoc/insertAcBuDoc.do'/>" class="btn btn-primary"></a>  -->
						</div>

						<sec:authorize access="hasRole('ROLE_PR')">
							<div class="col-auto">
								<c:url value='/thesis/thesisInsert.do' var="insertURL">
									<c:param name="what" value="${thesisVO.thesSn }" />
								</c:url>
								<a class="btn btn-primary" href="${insertURL }">논문/연구 등록</a>
							</div>
						</sec:authorize>

					</div>
				</td>
			</tr>

		</table>


		<table class="table table-hover">
			<thead class="table-light">
				<tr>
					<th style="width: 5%; text-align: center;">번호</th>
					<th style="width: 10%; text-align: center;">분류</th>
					<th style="width: 20%; text-align: center;">제목</th>
					<th style="width: 15%; text-align: center;">저자</th>
					<th style="width: 35%; text-align: center;">요약</th>
					<th style="width: 15%; text-align: center;">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="thesisList" value="${paging.dataList }" />
				<c:if test="${empty thesisList }">
					<tr>
						<td colspan="6">검색결과 없음.</td>
					</tr>
				</c:if>
				<c:if test="${not empty thesisList }">
					<c:forEach items="${thesisList }" var="thesis">
						<c:url value="/thesis/thesisView.do" var="thesisURL">
							<c:param name="what" value="${thesis.thesSn }" />
						</c:url>
						<tr data-id="${thesis.thesSn}" class="clickable-row">
							<td style="width: 5%; text-align: center;">${thesis.rnum}</td>
							<td style="width: 10%; text-align: center;">${thesis.thesClNm}</td>
							<td style="width: 20%; text-align: center;">${thesis.thesNm}</td>
							<td style="width: 15%; text-align: center;">${thesis.thesAutNm1}</td>
							<td style="width: 35%; text-align: center;">${thesis.thesShortCont}</td>
							<td style="width: 15%; text-align: center;">${thesis.thesPostDate}</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
			<tfoot style="text-align: center;!important">
				<tr style="text-align: center;!important">
					<td colspan="6" style="text-align: center;!important">
						${paging.pagingHTML }</td>
				</tr>
			</tfoot>
		</table>
		<form:form id="searchForm" modelAttribute="simpleCondition"
			method="get">
			<form:hidden path="searchType" />
			<form:hidden path="searchWord" />
			<input type="hidden" name="page" />
		</form:form>

	</div>
</div>

<script src="<c:url value='/resources/js/app/member/memberList.js' />"></script>

<script>
	<!--논문상세보기로 이동 -->
	console.log
	document.addEventListener("DOMContentLoaded", function() {
	    $(".clickable-row").on("click", "td:not(.no-click)", function() {
	    	var id = $(this).parent().data("id");
	        window.location.href = "<%=request.getContextPath()%>/thesis/thesisView.do?what=" + id;
	      });
	});
	
	// 문서가 완전히 로드된 후에 실행
	document.addEventListener("DOMContentLoaded", function() {
	  // 클릭 가능한 행에 클릭 이벤트 리스너 추가
	  var clickableRows = document.querySelectorAll(".clickable-row");
	  clickableRows.forEach(function(row) {
	    row.addEventListener("click", function() {
	      var id = row.getAttribute("data-id");
	      // 페이지 이동
	      window.location.href = "<%=request.getContextPath()%>
	/thesis/thesisView.do?what="
																+ id;
													});
								});
					});
</script>
