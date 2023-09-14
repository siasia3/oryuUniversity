<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="card box-shadow d-flex m-4" style="min-height: 50%;">
   <div class="h-100">
      <div class="custom-card">
         <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">인턴십 상세보기</div>
         <div class="card-body">
<table class="table" style="margin-left: 109px;
    width: 84%;">
			<tr hidden="true">
				<th>코드</th>
			<td>${intern.inteCd}</td>
			</tr>
			<tr>
				<th>회사명</th>
			<td colspan="2" style="font-weight: bold;">${intern.inteCompNm}</td>
			<td></td>
			<td></td>
			<td></td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>기업주소</th>
				<td>${intern.inteCompAddr}</td>
				<th>근무지</th>
				<td colspan="3">${intern.inteRegion}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${intern.intePh}</td>
				<th>담당자</th>
				<td>${intern.inteContPerson}</td>
				<th>이메일</th>
				<td>${intern.inteEmail}</td>
			</tr>
			<tr>
				<th>인턴십기간(개월)</th>
				<td>${intern.intePeri}개월</td>
				 <th>인턴십시작일</th>
				<td>${intern.inteStaDate}</td>
				<th>인턴십종료일</th>
				<td>${intern.inteEndDate}</td>
			</tr>
			<tr>
				<th>기업소개</th>
				<td colspan="6">
					${intern.inteIntrd }
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
			<td>
				<c:if test="${not empty intern.fileGroup and not empty intern.fileGroup.detailList }">
					<c:forEach items="${intern.fileGroup.detailList }" var="fileDetail">
						<c:url value="/internship/download.do" var="downloadURL">
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
				<td colspan="6">
					<sec:authorize access="hasRole('ROLE_ST')"><!-- 학생 -->
						<input class="btn btn-outline-success" type="submit" value="신청하기"  id="reqInsert"> 
						<input class="btn btn-outline-secondary" type="button"value="뒤로가기" onclick="history.back();">
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_TS')"><!-- 교직원 -->
			    		<input class="btn btn-outline-primary" type="button" value="수정하기" id="reqUpdate">
			    		<input class="btn btn-outline-danger" type="button" value="삭제하기" id="reqDelete">
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
	$('#reqInsert').on("click",function(e){
        e.preventDefault();
        Swal.fire({
           title: '해당 인턴십 신청란으로 이동하시겠습니까?',
           //text: '다시 되돌릴 수 없습니다. 신중하세요.',
           icon: 'question',
           
           showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
           confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
           cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
           confirmButtonText: '신청', // confirm 버튼 텍스트 지정
           cancelButtonText: '취소', // cancel 버튼 텍스트 지정
           
           reverseButtons: false, // 버튼 순서 거꾸로
        }).then(result => {
           // 만약 Promise리턴을 받으면,
           if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
            	  internshipAPCinsert();
           }
        });
     });
  
     $('#reqUpdate').on("click",function(e){
        e.preventDefault();
        Swal.fire({
           title: '해당 인턴십 수정란으로 이동하시겠습니까?',
           //text: '다시 되돌릴 수 없습니다. 신중하세요.',
           icon: 'question',
           
           showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
           confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
           cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
           confirmButtonText: '수정', // confirm 버튼 텍스트 지정
           cancelButtonText: '취소', // cancel 버튼 텍스트 지정
           
           reverseButtons: false, // 버튼 순서 거꾸로
        }).then(result => {
           // 만약 Promise리턴을 받으면,
           if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
        	   internshipUpdate();
           }
        });
     });
     
     $('#reqDelete').on("click",function(e){
        e.preventDefault();
        Swal.fire({
           title: '해당 인턴십 삭제하시겠습니까?',
           //text: '다시 되돌릴 수 없습니다. 신중하세요.',
           icon: 'question',
           
           showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
           confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
           cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
           confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
           cancelButtonText: '취소', // cancel 버튼 텍스트 지정
           
           reverseButtons: false, // 버튼 순서 거꾸로
        }).then(result => {
           // 만약 Promise리턴을 받으면,
           if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
        	   Swal.fire('${intern.inteCompNm}회사의 인턴십이 삭제되었습니다.', '', 'success').then(()=>{
        		   internshipDelete();
                });
           }
        });
     });
     
    
     
     
     
     
	
	function internshipUpdate() {
		window.location.href = "${pageContext.request.contextPath}/internship/internshipUpdate.do?what=${intern.inteCd}";
	}
	function internshipDelete() {
		window.location.href = "${pageContext.request.contextPath}/internship/internshipDelete.do?what=${intern.inteCd}";
	}
	function internshipAPCinsert(){
		window.location.href = "${pageContext.request.contextPath}/internshipAPC/internshipAPCInsert.do?what=${intern.inteCd}";
	}
	</script>