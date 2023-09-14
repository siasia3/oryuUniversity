<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
	<!-- 동아리 목록 -->
	<style>
.paging-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
.paging-info p {
        margin: 0;
    }
</style>
	<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
   <div class="h-100">
      <div class="custom-card">
         <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">동아리 목록</div>
         <div class="card-body">
	<table class="table table-border" style="margin-left: 109px;
    width: 84%;">
		<thead>
		<tr>
			<th>동아리 이름</th>
			<th>동아리 설명</th>
			<th>상세보기</th>
		</tr>
		</thead>
		<tbody>
                        <c:set var="clubList" value="${club.dataList}" />
                        <c:choose>
                           <c:when test="${empty clubList }">
                              <tr>
                                 <td colspan="3">소속된 동아리가 없습니다.</td>
                              </tr>
                           </c:when>
                           <c:otherwise>
                              <c:forEach items="${clubList }" var="clubMember">
                                 <tr>
                                    <td>${clubMember.clubNm }</td>
								    <td>${clubMember.clubDetail}</td>
									<td><a href="${pageContext.request.contextPath}/club/myClubView.do?what=${clubMember.clubCd}" data-who="${clubMember.clubCd}">상세보기</a></td>
                                 </tr>
                              </c:forEach>
                           </c:otherwise>
                        </c:choose>
                       
                     </tbody>
		<tfoot>
		<tr>
			<td colspan="3">
			<div class="d-flex justify-content-center mb-3">
				${club.pagingHTML}
				</div>
			</td>
		</tr> 
	</tfoot>
</table>
</div>
</div>
</div>
</div>