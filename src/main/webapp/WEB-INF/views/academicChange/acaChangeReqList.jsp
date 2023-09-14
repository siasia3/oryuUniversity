<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
.selectSearch {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>


<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
   <div class="h-100">
      <div class="custom-card">
         <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">학적 변동 신청 내역</div>
         <div class="card-body">
<table class="table" style="max-width: 1400px; margin: 0 auto;">
		<tr>
		<td colspan="8">
		<div id="searchUI" class="row justify-content-left">
		<div class="col-auto">
		<select name="acChSta" class="form-select" id="acChSta">
					<option value=""label="신청상태선택"/>
						<option value="요청" label="요청"/>
						<option value="승인" label="승인"/>
						<option value="거절" label="거절"/>
		</select> 
		</div>
	</div>
	</td>
    </tr>
		<tr>
			<th>학번</th>
			<th>이름</th>
			<th>요청사유</th>
			<th>신청항목</th>
			<th>신청일</th>
			<th>휴학기간</th>
			<th>신청상태</th>
		</tr>
	<tbody id="tableBody">
		<c:set var="acaChangeList" value="${acaChange }" />
		<c:choose>
			<c:when test="${empty acaChangeList }">
				<tr>
					<td colspan="8">조건에 맞는 게시글 없음.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${acaChangeList }" var="acaChange">
					<tr>
						<c:url value="/academicChange/acaChangeView.do" var="viewURL">
							<c:param name="what" value="${acaChange.acChCd }"></c:param>
						</c:url>
						<td><a href="${viewURL }">${acaChange.stCd }</a></td>
						<td>${acaChange.studentVO.stNm }</td>
						<td>${acaChange.acChRe }</td>
						<td>${acaChange.acChDiv }</td>
						<td>${acaChange.acChAppDate }</td>
						<td>${acaChange.acChStaLea } ~ ${acaChange.acChEndLea }</td>
						<td>
						<c:choose>
							<c:when test="${acaChange.acChSta eq '요청'}">
								<span class="badge badge-primary"> <c:out
												value="요청" />
								</span>
							</c:when>
							<c:when test="${acaChange.acChSta eq '승인'}">
								<span class="badge badge-info"> <c:out value="승인" />
								</span>
							</c:when>
							<c:when test="${acaChange.acChSta eq '거절'}">
								<span class="badge badge-danger"> <c:out
									value="거절" />
								</span>
							</c:when>
						</c:choose></td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</tbody>
</table>
  </div>
   </div>
   </div>
   </div>
   
   
   <script>
   
   
   $(document).ready(function () {
       $("#acChSta").on("change", function (event) {
           var acChSta = $("#acChSta").val(); // 선택된 값 가져오기
           var stCd = "${pageContext.request.userPrincipal.name}"; // 사용자의 인증 정보

           // AJAX 요청 보내기
           $.ajax({
               type: "GET", // 요청 메소드 설정
               url: "${pageContext.request.contextPath}/academicChange/acaChangeList.do?who="+stCd+"&acChSta="+acChSta, // 요청을 처리할 서버 URL
               success: function (response) {
                   // 요청이 성공적으로 처리되었을 때의 동작
                   var tableBodyContent = $(response).find("#tableBody").html();
                   
                   // 추출한 내용을 현재 문서의 #tableBody에 삽입
                   $("#tableBody").html(tableBodyContent);
               },
               error: function (error) {
                   // 요청이 실패했을 때의 동작
                   alert("처리 중 에러가 발생하였습니다.");
               }
           });
       });
   });

  
   if(message)
	 {
	   alert(message);
	 } 
		
   </script>