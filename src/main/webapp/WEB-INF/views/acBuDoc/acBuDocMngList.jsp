<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<style>
.paging-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
.paging-info p {
        margin: 0;
    }
    .btn:focus-visible{
        color: #248AFD;
    	border-color: #248AFD;
    	background-color: white;
    }

</style>



<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="card-header"
		style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">
		학술사업평가</div>

	<div class="h-100">
		<div class="d-flexs">
			<div class="col-5.5">
				<!-- 미평가 테이블 -->
				
				
				<br>
				<div id="searchUI" class="row justify-content-center">
					<div class="col-auto">
						<form:select path="simpleCondition.searchType" class="form-select">
							<form:option value="" label="전체" />
							<form:option value="buDocNm" label="제목" />
							<form:option value="buDocAutNm" label="작성자" />
							<form:option value="buDocPostDate" label="내용" />
							<form:option value="buDocNm" label="평가명" />
						</form:select>
					</div>
					<div class="col-auto">
						<form:input path="simpleCondition.searchWord" class="form-control" />
					</div>
					<div class="col-auto">
						<input type="button" value="검색" id="searchBtn"
							class="btn btn-success" />
						<!-- 여긴 등록이 딱히 필요없음. <a href="<c:url value='/acBuDoc/insertAcBuDoc.do'/>" class="btn btn-primary"></a>  -->
					</div>
				</div>
				<br>
				<table class="table" style="width:60%">
					<thead class="table-light">
						<tr>
							<th>제목</th>
							<th>분류</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>상태</th>
							<th>평가하기</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="acBuDocMngList" value="${paging.dataList }" />
						<c:if test="${empty acBuDocMngList }">
							<tr>
								<td colspan="6">미평가된 내용 없음.</td>
							</tr>
						</c:if>
						<c:if test="${not empty acBuDocMngList }">
							<c:forEach items="${acBuDocMngList }" var="acBuDocVO">
								<tr data-id="${acBuDocVO.buDocEvNm}" class="clickable-row">
									<td style="width: 100%; text-align: left;">${acBuDocVO.buDocNm}</td>
									<td style="width: 100%; text-align: left;"><c:choose>
											<c:when test="${empty acBuDocVO.buDocClass}">
									      미분류
									    </c:when>
											<c:otherwise>
									      ${acBuDocVO.buDocClass}
									    </c:otherwise>
										</c:choose></td>
									<td style="width: 100%; text-align: left;">${acBuDocVO.buDocAutNm}</td>
									<td style="width: 100%; text-align: left;">${acBuDocVO.buDocPostDate}</td>
									<td style="width: 100%; text-align: left;"><c:choose>
											<c:when
												test="${empty acBuDocVO.buDocEvNm || acBuDocVO.buDocEvNm ne '적합'}">
									      평가 대기중
									    </c:when>
											<c:otherwise>
									      ${acBuDocVO.buDocEvNm}
									    </c:otherwise>
										</c:choose></td>
									<td style="width: 100%; text-align: left;">
										<button  
										class="btn btn-outline-info mb-3 modifyRow color-custom"  
										style="padding: 12px; border-radius: 10px;"
										data-cd=${acBuDocVO.buDocCd} 
										data-bs-toggle="modal" type="button" data-bs-target="#myModal">평가</button>
									</td>
								</tr>
							</c:forEach>
						</c:if>


					</tbody>

					<tfoot style="text-align: center;!important">
						<tr style="text-align: center;!important">
							<td colspan="6" style="text-align: center;!important">
								${paging.pagingHTML }
							</td>
						</tr>
					</tfoot>
				</table>
				<form:form id="searchForm" modelAttribute="simpleCondition" method="get" >
					<form:hidden path="searchType" />
					<form:hidden path="searchWord" />
					<input type="hidden" name="page" />
				</form:form>
				<!-- 미평가 테이블 끝 -->
				<div class="col-auto">
					<!-- 부적합 테이블 -->
				</div>
				<div class="col-5.5">
					<!-- 부적합 테이블 -->

				</div>
			</div>
		</div>
	</div>
</div>

<!-- 모달 코드 추가 -->

<div class="modal" data-url="${viewURL}" id="myModal"
	tabindex="-1">
	<div
		class="modal-dialog modal-xl modal-dialog-centered modal-fullscreen-sm-down">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">학술사업평가</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="buDocModal">
			
			
			
			</div>

		</div>
	</div>
</div>

<!-------------------------------------- 스크립트부분 ------------------------------------>
<script src="<c:url value='/resources/js/app/member/memberList.js' />"></script>


<script>

$('.modifyRow').on("click",function(){
	var buDocCd = $(this).data("cd");
	
	let setting = {
            url : `${pageContext.request.contextPath}/acBuDoc/acBuDocMngEdit.do`,
            data : {
           	 buDocCd:buDocCd
            },
            success : function(resp) {
           	 $(buDocModal).html(resp);
            }
         }
         $.ajax(setting);
});

</script>

