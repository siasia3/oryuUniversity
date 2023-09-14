<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<style>
.min-height-div {
	min-height: 100px;
}
</style>

<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">동영상 강의</div>
	<div class="h-100">
		<div class="row">
			<div class="col-md-12">
				<div class="col-lg-12 stretch-card" style="height: 100%;">
					<div class="card">
						<div class="card-body">
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th>
												<h4>${videoLecture.vlsCd}. ${videoLecture.vlTitle}</h4>
											</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<div class="d-flex align-items-center">
													<div class="custom-flex-item">마감시간:
														${videoLecture.endTime}</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div
													class="d-flex align-items-center justify-content-center">
													<div>
														<video id="lectureVideo" width="750" height="500" controls>
															<c:forEach items="${videoLecture.fileGroup.detailList }"
																var="fileDetail">
																<c:url value="/video" var="videoURL">
																	<c:param name="cours"
																		value="${fileDetail.fileStreCours}" />
																</c:url>
																<source src="${videoURL}" type="video/mp4">
															</c:forEach>
														</video>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="d-flex align-items-center">
													<div class="custom-flex-item min-height-div">
														${videoLecture.vlCont}</div>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<div class="d-flex align-items-center justify-content-end">
													<div>
														<sec:authorize access="hasRole('ROLE_PR')">
															<a class="btn btn-primary btn-sm"
																href="${pageContext.request.contextPath}/lecture/videoLectureUpdate.do?vlsCd=${videoLecture.vlsCd}">수정</a>
														</sec:authorize>
														<a class="btn btn-primary btn-sm"
															href="${pageContext.request.contextPath}/lecture/videoLectureList.do?lecCd=${videoLecture.lecCd}">목록으로
															돌아가기</a>
													</div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		let video = document.getElementById('lectureVideo');
		console.log(video);
		
		// 비디오 재생 시간을 조절하는 함수
		function seekTo(event) {
		    const offsetX = event.offsetX; // 클릭한 위치의 X 좌표
		    const width = this.offsetWidth; // 비디오 태그의 너비
		    const seekTime = (offsetX / width) * video.duration; // 클릭한 위치의 비율에 따른 시간 계산
		    video.currentTime = seekTime; // 비디오의 재생 시간 변경
		}
		// 비디오 태그를 클릭할 때 seekTo 함수 호출
		video.addEventListener('click', seekTo);
	});

</script>

