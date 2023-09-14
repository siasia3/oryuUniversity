<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
   <div class="h-100">
      <div class="custom-card">
         <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">학적 변동 신청서 세부내용</div>
         <div class="card-body">
<table class="table">
	<tr>
		<td colspan="11"><h2>${acaChange.studentVO.stNm }</h2></td>
	</tr>
	<tr>
		<th>신청일</th>
		<td>${acaChange.acChAppDate }</td>
		<th>답변일</th>
		<td>${acaChange.acChCerDate }</td>
		<th>현재 학적 상태</th>
		<td>${acaChange.studentVO.stStatus }</td>
	</tr>
	<tr>
		<th>신청항목</th>
		<td>${acaChange.acChDiv }</td>
		<th>신청상태</th>
		<td>${acaChange.acChSta } </td>
		<th>휴학기간</th>
		<td colspan="5">${acaChange.acChStaLea } ~ ${acaChange.acChEndLea }</td>
		
	</tr>
	<tr>
		<th>내용</th>
		<td colspan="11">${acaChange.acChRe }</td>
	</tr>
	<tr>
		<th >첨부파일</th>
		<td colspan="5">
			<c:if test="${not empty acaChange.fileGroup and not empty acaChange.fileGroup.detailList }">
				<c:forEach items="${acaChange.fileGroup.detailList }" var="fileDetail">
					<c:url value="/academicChange/download.do" var="downloadURL">
						<c:param name="atchFileId" value="${fileDetail.atchFileId }" />
						<c:param name="fileSn" value="${fileDetail.fileSn }" />
					</c:url>
					
					<a href="${downloadURL }">${fileDetail.orignlFileNm }</a>
				</c:forEach>
			</c:if>
		</td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="11">
    <sec:authorize access="hasRole('ROLE_ST')"><!-- 학생 -->
        <input class="btn btn-outline-success" type="button" value="확인" onclick="history.back();">
    </sec:authorize>
    <sec:authorize access="hasRole('ROLE_TS')"><!-- 교직원 -->
    <c:if test="${acaChange.acChSta eq '요청' }">
    	<input class="btn btn-outline-success" type="button" value="승인" id="pass">
    	<input class="btn btn-outline-danger" type="button" value="거절" id="noPass">
    </c:if>
    	<input class="btn btn-outline-secondary" type="button" value="뒤로가기" onclick="history.back();">
    </sec:authorize>
</td>
	</tr>
</table>
</div>
</div>
</div>
</div>

<script>

$(pass).on("click",function(e){
    e.preventDefault();
    Swal.fire({
       title: '학적변동을 승인하시겠습니까?',
       //text: '다시 되돌릴 수 없습니다. 신중하세요.',
       icon: 'question',
       
       showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
       confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
       cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
       confirmButtonText: '승인', // confirm 버튼 텍스트 지정
       cancelButtonText: '취소', // cancel 버튼 텍스트 지정
       
       reverseButtons: false, // 버튼 순서 거꾸로
       
    }).then(result => {
       // 만약 Promise리턴을 받으면,
       if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
          Swal.fire('학적변동이 승인되었습니다.', '', 'success').then(()=>{
        	  approvalRequest();
          });
       }
    });
 })
 
 $(noPass).on("click",function(e){
    e.preventDefault();
    Swal.fire({
       title: '학적변동을 거절하시겠습니까?',
       //text: '다시 되돌릴 수 없습니다. 신중하세요.',
       icon: 'question',
       
       showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
       confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
       cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
       confirmButtonText: '거절', // confirm 버튼 텍스트 지정
       cancelButtonText: '취소', // cancel 버튼 텍스트 지정
       
       reverseButtons: false, // 버튼 순서 거꾸로
       
    }).then(result => {
       // 만약 Promise리턴을 받으면,
       if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
          Swal.fire('학적변동이 거절되었습니다.', '', 'success').then(()=>{
        	  refuseRequest();
          });
       }
    });
 })
 
 
	function approvalRequest() {
		window.location.href = "${pageContext.request.contextPath}/academicChange/requestProcessPass.do?what=${acaChange.acChCd}&process=승인&who=${acaChange.stCd }&div=${acaChange.acChDiv }";
	}
	function refuseRequest() {
		window.location.href = "${pageContext.request.contextPath}/academicChange/requestProcessNoPass.do?what=${acaChange.acChCd}&process=거절";
	} 
	
</script>