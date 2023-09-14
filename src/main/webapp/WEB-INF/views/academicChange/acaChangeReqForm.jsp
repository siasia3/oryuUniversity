<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="${pageContext.request.contextPath}/resources/js/ckeditor/ckeditor.js"></script>
<style>
  .narrow-td {
   wide:85% ; /* 원하는 값으로 조정 */
  }
  .narrow-th {
   wide:15% ; /* 원하는 값으로 조정 */
  }
  }
  th{
width: 10%;
}
.gradInfo {
		background-color: rgba(0, 0, 0, 0.03);
		margin-left: 109px;
    	width: 84%;
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	.gradInfo-header {
		margin: 20px 0 11px 40px;
		font-size: 14px;
		font-weight: bold;
	}
	.gradInfo-body {
		margin: -13px 40px 13px 40px;
		font-size: 12px;
	}
	.circle {
	    width: 4px;
	    height: 4px;
	    background-color: black;
	    border-radius: 50%;
	    display: inline-block;
	    margin: 0 12px 3px 6px;
	}
	#dynamic-forms {
		display: inline-block;
		vertical-align: top; 
	}
	.btnStyle{
		width: 22%;
	    margin-top: -170px;
	    padding: 10px;
	    border-radius: 10px;
	}

</style>


<div class="card box-shadow d-flex m-4" style="min-height: 87%, min-width: 50%;">
   <div class="h-100">
      <div class="custom-card">
         <div class="card-header" style="border-radius: 20px 20px 0 0; background-color:#154FA9; font-weight:bold; color:white;">학적 변동 신청</div>
         <div class="card-body">
				<div class="card gradInfo">
					<div class="gradInfo-header">
						<i class="mdi mdi-check-circle" style="color: green;"></i> 학적 변동 신청
						<hr style="border-color: black;">
					</div>
					<div class="gradInfo-body">
						<div class="circle"></div> 일발 휴학 : 질별, 가사사정, 해외유학, 해외 연수, 임신, 출산, 육아 휴학, 수학상 지장 등이 현저하다고 인정될 떄 .<br>
				    	<div class="circle"></div> 군입대 휴학 : 병역의무를 위해 입영.<br>
					</div>
				</div>
			</div>
         <div class="card-body">
<form:form method="post" modelAttribute="change" enctype="multipart/form-data">
	<table class="table table-border" style="margin-left: 109px;
    width: 84%;">	
			<tr>
				<th class="narrow-th">이름</th>
					<td class="narrow-td" >${info.stNm}</td>
				<th class="narrow-th">학번</th>
					<td class="narrow-td" >${info.stCd}</td>
					<th class="narrow-th">현재 학적 상태</th>
					<td>${info.stStatus}</td>
					<th class="narrow-th">신청항목</th>
				<td class="narrow-td">
					<select name="acChDiv">
			            <c:choose>
			                <c:when test="${info.stStatus eq '재학' }">
			                    <option value="일반휴학">일반휴학</option>
			                    <option value="군휴학">군휴학</option>
			                </c:when>
			               	<c:otherwise>
			                    <option value="재학">복학</option>
			               	</c:otherwise>
			            </c:choose>
	        		</select>
				</td>
			</tr>
			<tr hidden="true">
				<th>학번</th>
				<td><input type="hidden" name="StCd" value="${info.stCd}" readonly>
				${info.stCd}</td>
			</tr>
			
			<c:if test="${info.stStatus eq '재학' }">
			<tr>
				<th class="narrow-th">휴학학기선택</th>
			<td class="narrow-td">
			<select name="acChDate" id="acChDate">
				 <option value="">선택</option>
				 <option value="1">1학기</option>
				 <option value="2">2학기</option>
				 <option value="3">3학기</option>
				 <option value="4">4학기</option>
			</select>
			</td>
				<th>휴학기간</th>
					<td id="acChStaLea">
				${change.acChStaLea}</td>
				<td>에서</td>
					<td style="width:1%" id="acChEndLea">
				${change.acChEndLea}</td>
				<td>까지</td>
			</tr>
			</c:if>
			<tr>
				<th>변동사유</th>
				<td colspan="7">
				<form:textarea path="acChRe" class="form-control form-control-lg" />
				<form:errors path="acChRe" class="error" />
				</td>
			</tr>
			<tr hidden="true">
				<td><input type="text" name="acChSta" value="요청" readonly></td>
			</tr>
			
			<tr>
				<th>첨부파일</th>
				<td colspan="7">
					<input type="file" name="acaChFiles" multiple/>
				</td>
			</tr>
			
			<tr>
			<td colspan="8">
				<input class="btn btn-outline-success" id="acaChangeReqInsert" type="submit" value="신청"> 
				<input class="btn btn-outline-danger" type="reset"value="취소" onclick="history.back();">
			</td>
		</tr>
		</table>
		
</form:form>
 </div>
   </div>
   </div>
   </div>
   
<script>
       CKEDITOR.replace( 'acChRe',{
   	      filebrowserImageUploadUrl: '${pageContext.request.contextPath}/academicChange/uploadImage.do',

       } );
       
       $(acaChangeReqInsert).on("click",function(e){
           e.preventDefault();
           Swal.fire({
              title: '학적변동을 신청하시겠습니까?',
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
                 Swal.fire('학적변동을 신청하였습니다.', '', 'success').then(()=>{
                    $(change).submit();
                 });
              }
           });
        })

    // 이 부분은 AJAX 요청을 보내는 부분입니다.
       document.getElementById("acChDate").addEventListener("change", function () {
           var selectedValue = this.value;  // 선택된 select 값

           $.ajax({
        	    type: "GET",
        	    url: "${pageContext.request.contextPath}/academicChange/dateCalculate.do?acChDate=" + selectedValue,
        	    dataType: "text", // JSON 응답을 예상합니다.
        	    success: function (response) {
        	    	console.log("response : "+response)
        	    	console.log("acChstaLea 확인: " + $(response).find("#acChStaLea").text());
        	        var acChStaLea = $(response).find("#acChStaLea").text(); // 받아온 데이터의 속성에 따라 수정
        	        var acChEndLea = $(response).find("#acChEndLea").text(); // 받아온 데이터의 속성에 따라 수정
        	        console.log("확인 : " + acChStaLea);
        	        console.log("확인2 : " + acChEndLea);
        	        // 데이터를 업데이트
        	        document.getElementById("acChStaLea").innerHTML = '<input type="text" name="acChStaLea" value="' + acChStaLea.trim() + '" readonly>';
        	        document.getElementById("acChEndLea").innerHTML = '<input type="text" name="acChEndLea" value="' + acChEndLea.trim() + '" readonly>';
        	    },
        	    error: function () {
        	        alert("오류가 발생했습니다.");
        	    }
        	});
       });
   </script>