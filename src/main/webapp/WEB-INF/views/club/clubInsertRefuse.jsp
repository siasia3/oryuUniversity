
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
	<!-- 거절사유 작성란 -->
	
	<form:form method="post" modelAttribute="club" action="${pageContext.request.contextPath}/club/clubRequestRefuse.do">
	<table>
		<tr>
			<td><input hidden="true" name="clubCd" type="text" value="${clubCd }"/></td>
			<td><input hidden="true" name="clubStatus" type="text" value="${clubStatus }"/></td>

		</tr>
		<tr>
			<th>거절사유</th>
			<td><textarea class="form-control form-control-lg" name="clubRefuse">${clubRefuse }</textarea><span
			class="error">${errors["clubRefuse"]}</span></td>
		</tr>
		<tr>
			<td colspan="2">
				<input class="btn btn-success" type="submit" value="확인"> 
				<input class="btn btn-danger" type="reset"value="취소">
			</td>
		</tr>
	</table>
	</form:form>
