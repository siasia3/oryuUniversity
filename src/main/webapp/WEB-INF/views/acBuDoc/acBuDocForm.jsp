<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<script
	src="${pageContext.request.contextPath}/resources/js/ckeditor/ckeditor.js"></script>
	
<!-- validate -->
<!-- 슈발 소문자...2 -->
<!-- end validate -->

	
<form:form method="post" modelAttribute="acBuDocVO"
	enctype="multipart/form-data">
	<form:hidden path="buDocCd" />

<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
      <div class="h-100">
      
      <div class="card-header" style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">학술사업 자료 등록</div>
      
	<table class="table table-bordered" style="width : 1600px; margin: 0 auto;">
		<tr>
			<th>학술사업코드</th>
			<td> 
			<input type="text" id="categoryNameInput" readonly placeholder="사업명">
			<input type="text" id="categoryInput" readonly placeholder="사업코드">
			<form:input path="acBuCd" class="form-control" id="categoryInput1" readonly="true" placeholder="필수입력" hidden="true"/>
			<form:errors path="acBuCd" class="error" />
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">사업코드선택</button> <!-- Modal -->
				<div class="modal fade" data-url="${viewURL }" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="exampleModalLabel">학술사업코드선택</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<a href="#" onclick="selectCategory('A001','경영');">경영(A001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('B001','예술');">예술(B001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('C001','의학');">의학(C001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('D001','인문');">인문(D001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('E001','자연과학');">자연과학(E001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('F001','공학');">공학(F001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('G001','농수해양');">농수해양(G001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('H001','사회과학');">사회과학(H001) </a><br>
								<hr />
								<a href="#" onclick="selectCategory('I001','기초과학');">기초과학(I001) </a><br>
								<hr />
								<pre>선택한 코드 : <input id="modalInput" disabled="disabled" />
								</pre>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
		
		<tr>
		    <th>분류 선택</th>
		    <td>
		        <label >
		            <input type="radio" name="documentType" value="Plan" onclick="updateDocumentType('학술사업계획서')" checked >
		            학술사업계획서
		        </label>
		        <label>
		            <input type="radio" name="documentType" value="Report" onclick="updateDocumentType('학술사업보고서')" >
		            학술사업보고서
		        </label>
		    <input type="hidden" id="buDocClass" name="buDocClass" />
		    </td>
		</tr>

		<tr>
			<th>제목</th>
			<td><form:input id="buDocNm" path="buDocNm" class="form-control" placeholder="ex)생성형 AI 시대 리터러시 교육의 새로운 전환"/> 
			<form:errors path="buDocNm" class="error" /></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><form:input path="buDocAutNm" class="form-control" value ="${memName}"/>
			<form:errors path="buDocAutNm" class="error" /></td>
		</tr>
		<tr>
			<th>내용(요약)</th>
			<td><form:textarea id="buDocShortCont" path="buDocShortCont" class="form-control" placeholder="ex) 본 연구는 2013년 1학년 2학기에 전국 42개의 연구학교들이 자유학기제를 시범 적용을 한 후 제출한 보고서를 바탕으로 그 교육과정의 편성과 운영의 특징을 분석하였다. 그 결과 공통과정에서 필수교과의 시수를 전체 시수의 64.4%로 대폭 감축하였고 자율과정의 시수를 증배하였다. 특히 창의적 체험활동에 해당하는 시수를 대폭 증배하여 자율과정을 운영하였다. 본 연구에서는 자유학기제의 운영 모형을 중점 활동별 운영 모형과 교육과정 연계에 따른 운영 모형들 중 어떤 것을 채택하였는지, 그리고 핵심 특성인 자율과정을 학교별로 어떻게 구성하였는지를 중심으로 분석하였다. 중점 활동별 운영 모형은 예술·체육 중점 모형이 가장 많았고, 자율과정은 예술·체육 활동의 시간 비중이 가장 컸으며, 진로탐색 활동, 동아리활동, 학생 선택프로그램 순으로 적었다. 교육과정 연계에 따른 운영 모형은 학교의 정규 교육과정만으로 운영한 학교는 42.9%, 방과후학교와 연계하여 운영한 학교는 47.6%, 토요 프로그램과 연계한 학교는 2.4%, 방과후학교와 토요 프로그램 모두와 연계한 학교가 7.1%로 나타났다. 대다수 학교들이 예술 체육 수업을 확대 강화하는 선에 그치고 있으나, 자유학기제는 중학교 교육을 획기적으로 바꿀 수 있는 여지가 있었다. 연구 결과를 중심으로, 자유학기제 실시에 있어 학생의 선택권 확대, 학교중심 교육과정의 재구성, 공통과정과 자율과정의 연계, 준고교(junior high school)가 아니라 본래의 중학교(middle school)로서 정체성 회복 등을 논하였다."/>
				<form:errors path="buDocShortCont" class="error" /></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><form:textarea id="buDocCont" path="buDocCont" class="form-control" /> <form:errors
					path="buDocCont" class="error" /></td>
		</tr>

		<tr>
			<th>첨부파일</th>
			<td><input type="file" name="acBuDocFiles" multiple /></td>
		</tr>
		
		<tr>
			<c:url value='/acBuDoc/acBuDocList.do' var="ListURL">
				<c:param name="what" value="${acBuDocVO.buDocCd }" />
			</c:url>

			<td colspan="3">
			<input id="auto" class="btn btn-outline-info" style=" border-radius: 10px;" type="button" value="자동완성기능">
			<input type="submit" class="btn btn-primary"value="저장"> 
			<!--             <input type="reset" class="btn btn-danger" value="취소"> -->
				<a class="btn btn-danger" href="${ListURL }">취소</a></td>
		</tr>
	</table>
		<br>
	      </div>
   </div>
</form:form>

<script>
	CKEDITOR
			.replace(
					'buDocCont',
					{
						filebrowserImageUploadUrl : '${pageContext.request.contextPath }/uploadImage.do'
					});
</script>
<<script type="text/javascript">
$('#auto').on('click', function () {

	$('#categoryNameInput').val("경영");
	$('#categoryInput').val("A001");
	$('#buDocNm').val("테스트");
	$('#buDocShortCont').val("테스트");
	const ckEditorInstance = CKEDITOR.instances.buDocCont;
	ckEditorInstance.insertHtml("테스트");
}); 

</script>

<script>
   // 모달 창 열기 함수
   function openModal() {
      document.getElementById('myModal').style.display = 'flex';
   }

   // 모달 창 닫기 함수
   function closeModal() {
      document.getElementById('myModal').style.display = 'none';
   }

   // 모달 창 열기 함수
   function openModal() {
      document.getElementById('myModal').style.display = 'flex';
   }

   // 모달 창 닫기 함수
   function closeModal() {
      document.getElementById('myModal').style.display = 'none';
   }

   // 선택한 카테고리를 입력 필드에 설정하는 함수
   function selectCategory(category, categoryName) {
        document.getElementById('categoryInput').value = category;
        document.getElementById('categoryInput1').value = category;
        document.getElementById('modalInput').value = category;
        document.getElementById('categoryNameInput').value = categoryName;
		
        closeModal();
    }

</script>

<script>
    function updateDocumentType(type) {
        var buDocClassInput = document.getElementById('buDocClass'); 
        console.log(type);
        if(type == '학술사업계획서'){
            buDocClassInput.value = '학술사업계획서';
        }else if(type == '학술사업보고서'){
            buDocClassInput.value = '학술사업보고서';
        }else{
        	buDocClassInput.value = '선택하지않음';
        }
        
    }
    
</script>






