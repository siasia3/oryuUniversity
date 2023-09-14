<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>	
	
	<!-- 동아리 개설신청 상세정보 -->
	<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
   <div class="h-100">
      <div class="custom-card">
         <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">개설 신청한 동아리 상세정보</div>
         <div class="card-body">
	<table class="table table-border">
		<tr>
			<th>동아리 대표 성명</th>
			<td>${club.studentVO.stNm}</td>
		</tr>
		<tr>
			<th>동아리 대표 학번</th>
			<td>${club.stCd }</td>
		</tr>
		<tr>
			<th>동아리명</th>
			<td>${club.clubNm }</td>
		</tr>
		<tr>
			<th>동아리 지도 교수</th>
			<td>${club.professorVO.prNm }</td>
		</tr>
		<tr>
			<th>동아리 설명</th>
			<td>${club.clubDetail }</td>
		</tr>
   		<tr>
   			 <th>동아리 계획서</th>
    		 <td><pre style="background-color: white;">${club.clubPlan}</pre></td>
		</tr>
		<tr>
			<th>동아리 상태</th>
			<td>${club.clubStatus }</td>
		</tr>
		
		<c:if test="${not empty club.clubRefuse}"><!-- 동아리 거절 내용이 있을경우 -->
		<th>동아리 거절 사유</th>
		<td>${club.clubRefuse }</td>
		</c:if>
		<tr>
			<td colspan="4">
			<sec:authorize access="hasRole('ROLE_TS')"><!-- 교직원 -->
				<input class="btn btn-outline-success" type="button" value="승인" id="approvalReq">
				<input class="btn btn-outline-danger" type="button" value="거절" id="refuseReq"> 
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_PR')"><!-- 교수 -->
						<input class="btn btn-outline-success" type="button" value="확인" id="confirmedReq">
						<input class="btn btn-outline-danger" type="button" value="거절" id="refuseReq">
			</sec:authorize>
			
			<input class="btn btn-secondary" type=button value="뒤로가기" onclick="history.back();"></td>
		</tr>
	</table>
	</div>
	</div>
	</div>
	</div>
	
<script>
document.addEventListener('DOMContentLoaded', function () {

    // 교수 역할인 경우에만 버튼 이벤트 리스너 등록
    if (${pageContext.request.isUserInRole('ROLE_PR')}) {
        const refuseReq = document.getElementById('refuseReq');
        const confirmedReq = document.getElementById('confirmedReq');

        refuseReq.addEventListener("click", function (e) {
            e.preventDefault();
            showConfirmationDialog("거절", "동아리개설 요청을 거절하였습니다.", "거절", () => refuseRequest());
        });

        confirmedReq.addEventListener("click", function (e) {
            e.preventDefault();
            showConfirmationDialog("확인", "승인 완료되었습니다.", "승인", () => confirmedRequest());
        });
    }else if (${pageContext.request.isUserInRole('ROLE_TS')}) {
        const approvalReq = document.getElementById('approvalReq');
        const refuseReq = document.getElementById('refuseReq');

        approvalReq.addEventListener("click", function (e) {
            e.preventDefault();
            showConfirmationDialog("승인", "승인 완료되었습니다.", "승인", () => approvalRequest());
        });
        refuseReq.addEventListener("click", function (e) {
            e.preventDefault();
            showConfirmationDialog("거절", "동아리개설 요청을 거절하였습니다.", "거절", () => refuseRequest());
        });
    }   
    
    function showConfirmationDialog(title, message, confirmText, callback) {
        Swal.fire({
            title: `${club.clubNm} 동아리 개설신청을 ${title}하시겠습니까?`,
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: confirmText,
            cancelButtonText: '취소',
            reverseButtons: false,
        }).then(result => {
            if (result.isConfirmed) {
                Swal.fire(title + ' 완료되었습니다.', '', 'success').then(() => {
                    callback();
                });
            }
        });
    }
    
    
    

    function approvalRequest() {
        window.location.href = "${pageContext.request.contextPath}/club/clubInsertApproval.do?who=${club.clubCd}&what=승인";
    }

    function refuseRequest() {
        window.location.href = "${pageContext.request.contextPath}/club/clubRequestRefuseGo.do?who=${club.clubCd}&what=거절";
    }

    function confirmedRequest() {
        window.location.href = "${pageContext.request.contextPath}/club/clubInsertApproval.do?who=${club.clubCd}&what=확인";
    }
});

const clubPlanElement = document.getElementById('clubPlan');

</script>
