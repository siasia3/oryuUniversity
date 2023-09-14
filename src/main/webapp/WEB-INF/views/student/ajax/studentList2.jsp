<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<table class="table table-hover"
	style="max-width: 1400px; margin: 0 auto;">
	<thead class="table-light">
		<tr>
			<th>번호</th>
			<th>학번</th>
			<th>학과</th>
			<th>이름</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody>
		<c:set var="studentList" value="${paging.dataList }" />
		<c:if test="${empty studentList }">
			<tr>
				<td colspan="8">검색결과 없음.</td>
			</tr>
		</c:if>
		<c:if test="${not empty studentList }">
			<c:forEach items="${studentList }" var="student">
				<c:url value="/student/studentView.do" var="studentURL">
					<c:param name="who" value="${student.stCd }" />
				</c:url>
				<tr>
					<td>${student.rnum }</td>
					<td><a href="${studentURL }">${student.stCd }</a></td>
					<td>${student.dtNm }</td>
					<td>${student.stNm }</td>
					<td>${student.stAddr1 } ${student.stAddr2 }</td>
					<td>${student.stPh }</td>
					<td>${student.stEmail }</td>
					<td>${student.stStatus }</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<div style="padding: 20px;">${paging.pagingHTML }</div>