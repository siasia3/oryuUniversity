<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table class="table">
<tr><td><h4><br>학술사업계획서</h4></td></tr>
</table>
<table class="table">
	<tr>
		<td><h3>${aBPVO.buPlNm }</h3></td>
	</tr>
	<tr>
		<th>계획서번호</th>
		<td>${aBPVO.rnum }</td>
		<th>학술사업코드</th>
		<td>${aBPVO.acBuCd }</td>
		<th>학술사업계획서명</th>
		<td>${aBPVO.buPlNm }</td>
		<th>작성자</th>
		<td>${aBPVO.buPlAutNm }</td>
		<th>요약내용</th>
		<td>${aBPVO.buPlCont }</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${aBPVO.buPlCont }</td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>
			<c:if test="${not empty aBPVO.fileGroup and not empty aBPVO.fileGroup.detailList }">
				<c:forEach items="${aBPVO.fileGroup.detailList }" var="fileDetail">
					<c:url value="/academicBusinessPlan/aBPDownload.do" var="downloadURL">
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
	<c:url value='/academicBusinessPlan/aBPUpdate.do' var="updateURL">
		<c:param name="what" value="${aBPVO.buPlSn }" />
	</c:url>
	<c:url value='/academicBusinessPlan/aBPDelete.do' var="deleteURL">
		<c:param name="what" value="${aBPVO.buPlSn }" />
	</c:url>
	<c:url value='/academicBusinessPlan/aBPList.do' var="listURL" />
         <td colspan="2">
               <a class="btn btn-primary" href="${updateURL }">수정</a>
               <a class="btn btn-danger" href="${deleteURL }">삭제</a>
               <a class="btn btn-success" href="${listURL }">목록</a>
         </td>
   </tr>
</table>
















