<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="container">
	<table class="table" style="height: 660px;">
		<thead class="table-light">
			<tr>
				<th>졸업연도</th>
				<th>단대</th>
				<th>학과</th>
				<th>학번</th>
				<th>학생명</th>
				<th>취업연도</th>
				<th>취업분야</th>
				<th>취업상태</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="studentList" value="${paging.dataList }" />
			<c:choose>
				<c:when test="${empty studentList }">
					<tr>
						<td colspan="8">조건에 맞는 학생이 없음.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${studentList }" var="student">
						<tr>
							<td class="col-sm-1">${student.stGrad}</td>
							<td class="col-sm-1">${student.colgeNm}</td>
							<td class="col-sm-1">${student.dtNm}</td>
							<td class="col-sm-1 stCd">${student.stCd}</td>
							<td class="col-sm-1">${student.stNm}</td>
							<td class="col-sm-1">${student.empYear}</td>
							<td class="col-sm-1">${student.empField}</td>
							<td class="col-sm-1"><c:choose>
									<c:when test="${student.empStat eq '미등록'}">
										<span class="badge badge-danger"> <c:out value="미등록" />
										</span>
									</c:when>
									<c:when test="${student.empStat eq '취업'}">
										<span class="badge badge-success"> <c:out value="취업" />
										</span>
									</c:when>
									<c:when test="${student.empStat eq '미취업'}">
										<span class="badge badge-warning"> <c:out value="미취업" />
										</span>
									</c:when>
									<c:otherwise>
									${student.empStat}
								</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
		<tfoot>
		</tfoot>
	</table>
	<div class="text-center mt-3 d-flex justify-content-center"
		id="pagination2">${paging.pagingHTML}</div>
</div>
