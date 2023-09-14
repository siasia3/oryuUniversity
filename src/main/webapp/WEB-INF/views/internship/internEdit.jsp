<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="${pageContext.request.contextPath}/resources/js/ckeditor/ckeditor.js"></script>
<form:form method="post" modelAttribute="intern" enctype="multipart/form-data">
	<table class="table table-border" style="margin-left: 109px;
    width: 84%;">	
			<c:if test="${not empty intern.inteCd }">
			<tr hidden="true">
				<th>코드</th>
			<td><input type="hidden" name="inteCd" value="${intern.inteCd}" readonly>
			${intern.inteCd}</td>
			</tr>
			</c:if>
			
			<tr>
				<th>제목</th>
				<td>
					<div>
						<input type="text" name="inteTitle" value="${intern.inteTitle}">
					</div>
				</td>
				<th>회사명</th>
			<td colspan="3"><input type="text" name="inteCompNm" value="${intern.inteCompNm}"></td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th>근무지</th>
				<td><input type="text" name="inteRegion" value="${intern.inteRegion}" ></td>
				<th>기업상세주소</th>
				<td colspan="3"><input type="text" name="inteCompAddr" value="${intern.inteCompAddr}"></td>
			</tr>
			<tr>
				<th>담당자</th>
				<td><input type="text" name="inteContPerson" value="${intern.inteContPerson}"></td>
				<th>이메일</th>
				<td><input type="text" name="inteEmail" value="${intern.inteEmail}"></td>
				<th>전화번호</th>
				<td><input type="text" name="intePh" value="${intern.intePh}"></td>
			</tr>
			<tr>
				<th>인턴십기간(개월)</th>
				<td><input type="text" name="intePeri" value="${intern.intePeri}" ></td>
				 <th>인턴십시작일</th>
				<td><input type="date" name="inteStaDate" value="${intern.inteStaDate}" ></td>
				<th>인턴십종료일</th>
				<td><input type="date" name="inteEndDate" value="${intern.inteEndDate}" ></td>
			</tr>
			<tr>
				<th>기업소개</th>
				<td colspan="5">
				<form:textarea path="inteIntrd" class="form-control form-control-lg" />
				<form:errors path="inteIntrd" class="error" />
				</td>
			</tr>
			<tr>
			<th>기존 첨부파일</th>
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
		</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="4">
					<input type="file" name="inteFiles" multiple/>
				</td>
				<td>${fileDetail.orignlFileNm }</td>
			</tr>
			
			<tr>
			<td colspan="6">
				<input class="btn btn-outline-success" type="submit" id="insertBtn" value="확인"> 
				<input class="btn btn-outline-danger" type="reset"value="취소" onclick="history.back();">
			</td>
		</tr>
		</table>
</form:form>
<script>
       CKEDITOR.replace('inteIntrd',{
   	      filebrowserImageUploadUrl: '${pageContext.request.contextPath}/internship/uploadImage.do',
       } );
       
       $(insertBtn).on("click",function(e){
           e.preventDefault();
           Swal.fire({
              title: '인턴십을 등록하시겠습니까?',
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
                 Swal.fire('인턴십을 등록하였습니다.', '', 'success').then(()=>{
                    $(intern).submit();
                 });
              }
           });
        })
       
       
   </script>