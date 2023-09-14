<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
.paging-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
.paging-info p {
        margin: 0;
    }
</style>
<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
   <div class="h-100">
      <div class="custom-card">
         <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">인턴십 신청 목록</div>
         <div class="card-body">

<table class="table" style="margin-left: 109px;
    width: 84%;">
<tr>
	<td>
	<div id="searchUI" class="row justify-content-center">
		<div  class="col-auto">
			<form:select path="simpleCondition.searchType" class="form-select">
				<form:option value="" label="전체" />
				<form:option value="inteTitle" label="제목" />
				<form:option value="inteRegion" label="근무지" />
				<form:option value="inteCompNm" label="기업명" />
				<form:option value="stCd" label="학번" />
				<form:option value="stNm" label="학생이름" />
				<form:option value="iaStat" label="합격여부" />
			</form:select>
		</div>
		<div  class="col-auto">
			<form:input path="simpleCondition.searchWord" class="form-control"/>
		</div>
		<div  class="col-auto">
			<input type="button" value="검색" id="searchBtn" class="btn btn-success"/>
		</div>
	</div>
	</td>
	</tr>
</table>
<table class="table" style="margin-left: 109px; width: 84%;">
	<thead class="table-light">
	
		<tr>
			<th>기업명</th>
			<th>제목</th>
			<th>지원학생학번</th>
			<th>지원학생이름</th>
			<th>학생전화번호</th>
			<th>합격여부</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="internList" value="${paging.dataList }" />
		<c:choose>
			<c:when test="${empty internList }">
				<tr>
					<td colspan="6">조건에 맞는 게시글 없음.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${internList }" var="intern">
					<tr>
						<c:url value="/internshipAPC/internshipAPCView.do" var="viewURL">
							<c:param name="what" value="${intern.iaCd }"></c:param>
						</c:url>
						<td>${intern.internshipVO.inteCompNm }</td>
						<td><a href="${viewURL }">${intern.internshipVO.inteTitle }</a></td>
						<td>${intern.studentVO.stCd }</td>
						<td>${intern.studentVO.stNm }</td>
						<td>${intern.studentVO.stPh }</td>
						<td>
						<c:choose>
							<c:when test="${intern.iaStat eq '신청'}">
								<span class="badge badge-primary"> <c:out
												value="신청" />
								</span>
							</c:when>
							<c:when test="${intern.iaStat eq '합격'}">
								<span class="badge badge-info"> <c:out value="합격" />
								</span>
							</c:when>
							<c:when test="${intern.iaStat eq '불합격'}">
								<span class="badge badge-danger"> <c:out
									value="불합격" />
								</span>
							</c:when>
						</c:choose>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
	
	<tfoot>
		<tr>
			<td colspan="6">
				<div class="d-flex justify-content-center mb-3">
				${paging.pagingHTML }
				</div>
			</td>
		</tr>
	</tfoot>
	
</table>
</div>
   </div>
   </div>
   </div>
 <form:form id="searchForm" modelAttribute="simpleCondition" method="get">
	<form:hidden path="searchType" />
	<form:hidden path="searchWord" />
	<input type="hidden" name="page" />
</form:form>   
    
 <script>
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
	      $(searchForm).submit();
	   });
	
    $(document).ready(function() {
        var message = message;/* 서버에서 받은 메시지 */
        
        if (message) {
            alert(message);
        }
    });
</script>
