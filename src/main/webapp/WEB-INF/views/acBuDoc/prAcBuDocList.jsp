<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 막대그래프 스크립트 -->

<style>
.paging-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
.paging-info p {
        margin: 0;
    }
    
#videoContainer {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 300px; /* Adjust the height as needed */
    }

#videoContainer video {
        max-width: 100%;
        max-height: 100%;
    }
    
video {
    width: 100%; 
    height: auto; 
  }
    
    
</style>
<!-- 학술사업 관리 대시보드 제목 -->
<table class="table">
<tr><td><h4><br>학술 사업 관리 대시보드</h4></td></tr>
</table>

 <!-- 학술사업 관리 대시보드 제목 끝 -->

<!-- 이미지 카테고리 --> 
<!-- 휠 페이지 1 -->
<div class="section">
<table>

  <tr>
    <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/경영.jpg" alt="Image 1" id="BusinessImage" onclick="changeText('Business') , showVideo('Business')" width="100" height="100">
      </div>
    </td>
    <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/공학.jpg" alt="Image 2" id="EngineeringImage" onclick="changeText('Engineering') , showVideo('Engineering')" width="100" height="100">
      </div>
    </td>
    <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/예술.jpg" alt="Image 3" id="ArtImage" onclick="changeText('Art') , showVideo('Art')" width="100" height="100">
      </div>
    </td>
    <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/의학.jpg" alt="Image 4" id="MedicineImage" onclick="changeText('Medicine') , showVideo('Medicine')" width="100" height="100">
      </div>
    </td>
    <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/인문.jpg" alt="Image 5" id="HumanitiesImage" onclick="changeText('Humanities') , showVideo('Humanities')" width="100" height="100">
      </div>
    </td>
    <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/자연과학.jpg" alt="Image 6" id="NaturalSciencesImage" onclick="changeText('NaturalSciences') , showVideo('NaturalSciences')" width="100" height="100">
      </div>
    </td>
    <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/기초과학.jpg" alt="Image 7" id="BasicSciencesImage" onclick="changeText('BasicSciences') , showVideo('BasicSciences')" width="100" height="100">
      </div>
    </td>
       <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/농수해양.jpg" alt="Image 8" id="AgricultureImage" onclick="changeText('Agriculture') , showVideo('Agriculture')" width="100" height="100">
      </div>
    </td>
       <td>
      <div>
        <img src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/사회과학.jpg" alt="Image 9" id="SocialSciencesImage" onclick="changeText('SocialSciences') , showVideo('SocialSciences')" width="100" height="100">
      </div>
    </td>
  </tr>

  <tr>
    <td style="text-align: center;">경영</td>
    <td style="text-align: center;">공학</td>
    <td style="text-align: center;">예술</td>
    <td style="text-align: center;">의학</td>
    <td style="text-align: center;">인문</td>
    <td style="text-align: center;">자연과학</td>
    <td style="text-align: center;">기초과학</td>
    <td style="text-align: center;">농수해양</td>
    <td style="text-align: center;">사회과학</td>
  </tr>



<tr>
    <td colspan="20">
        <div id="videoContainer">
            <video id="defaultVideo" controls style="width: 100%; height: auto;">
                <source src="${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/학술사업소개영상.mp4" type="video/mp4">
            </video>
        </div>
    </td>
</tr>


</table>
</div>
<!-- 이미지 카테고리 끝--> <!-- 이미지 설명 -->

<p id="selectedImageDescription" class="log">학술사업이란 연구과제, 학술활동에 대해 그 비용 및 환경등을 지원하고 보조하여, 원활한 학술 발전을 요하는 사업을 말한다.</p>

<!-- 이미지 설명 끝 -->
<div>
<!-- 휠페이지 2 -->

<!-- 학술 사업 관리 조건 검색 -->
<table class="table">
   <tr>
   <td>
   <div id="searchUI" class="row justify-content-center">
      <div  class="col-auto">
         <form:select path="simpleCondition.searchType" class="form-select">
            <form:option value="" label="전체" />
            <form:option value="buDocAutNm" label="작성자" />
            <form:option value="buDocNm" label="제목" />
            <form:option value="buDocCont" label="내용" />
         </form:select>
      </div>
      <div  class="col-auto">
         <form:input path="simpleCondition.searchWord" class="form-control"/>
      </div>
      <div  class="col-auto">
         <input type="button" value="검색" id="searchBtn" class="btn btn-success"/>
         <!-- 여긴 등록이 딱히 필요없음. <a href="<c:url value='/acBuDoc/insertAcBuDoc.do'/>" class="btn btn-primary"></a>  -->
      </div>
   </div>
   </td>
   </tr>

</table>

<!-- 학술 사업 관리 조건 검색 끝 -->


<!--  조건 검색 라인 -->

<table class="table"> <!-- 게시글 출력 -->
   <thead class="table-light">
      <tr>
         <th><Strong>학술자료목록</Strong>( 제목 | 작성자 | 작성일 )</th>
      </tr>
   </thead>

   <tbody>
      <c:set var="acBuDocList" value="${paging.dataList }" />
      <c:choose>
         <c:when test="${empty acBuDocList }">
            <tr>
               <td colspan="5">조건에 맞는 게시글 없음.</td>
            </tr>
         </c:when>
         <c:otherwise>
            <c:forEach items="${acBuDocList }" var="acBuDocVO">
               <tr>
                  <c:url value="/acBuDoc/acBuDocView.do" var="viewURL">
                     <c:param name="what" value="${acBuDocVO.buDocCd }"></c:param>
                     
                  </c:url>
                  <td><a href="${viewURL}">
                      ${acBuDocVO.buDocNm} |   ${acBuDocVO.buDocAutNm} | ${acBuDocVO.buDocPostDate}
                  </a></td>
               </tr>
            </c:forEach>
         </c:otherwise>
      </c:choose>
   </tbody>
   
   <tr>
        <td>
            <div class="paging-info">
                <p>총 ${totalRecord}건의 게시물이 있습니다.</p>
                <!-- <p>페이지 ${paging.currentPage}/${paging.endPage}</p>  -->
            </div>
        </td>
    </tr>
   
   <tfoot>
      <tr>
         <td colspan="5">
            <div class="d-flex justify-content-center mb-3">
            ${paging.pagingHTML }
            </div>
         </td>
      </tr>
   </tfoot>
</table>



<!-- 게시글 끝 -->
</div>
<!-- 휠페이지 3 -->
<!-- 연간 문서 제출건 막대그래프 -->

   <div>
      <canvas id="myChart"></canvas>
    </div>
    
<!-- 연간 문서 제출건 막대그래프 끝--> 
  
  
<div>
 <!-- serachForm은 검색하는 타입과 단어들을 받아서 검색하는 hidden된 코드들. -->
<form:form id="searchForm" modelAttribute="simpleCondition" method="get">
   <form:hidden path="searchType" />
   <form:hidden path="searchWord" />
   <input type="hidden" name="page" />
</form:form>
<!-- 페이징 펑션, click event -->
</div>



<!-- -----------------------------------------------스크립트----------------------------------------------- -->

<script>
   function fn_paging(page){
      searchForm.page.value = page;
      searchForm.requestSubmit();
   }

   $(searchBtn).on("click", function(event){
         $(searchUI).find(":input[name]").each(function(idx, input){
            let name = input.name;
            let value = $(input).val();
            $(searchForm).find(`[name=\${name}]`).val(value);
         });
         $(searchForm).submit();
      });
   </script>
  
<script >
   const ctx = document.getElementById('myChart');
   const years = [<c:forEach items="${selectYearlyCount}" var="item" varStatus="status">${item.postYear}<c:if test="${!status.last}">, </c:if></c:forEach>];
   const counts = [<c:forEach items="${selectYearlyCount}" var="item" varStatus="status">${item.count}<c:if test="${!status.last}">, </c:if></c:forEach>];
     
   new Chart(ctx, {
     type: 'bar',
     data: {
      labels: years,
      datasets: [{
        label: '등록된 자료 수',
        data: counts,
        borderWidth: 1
      }]
     },
     options: {
      scales: {
        y: {
         beginAtZero: true
        }
      }
     }
   });
</script>
  <!-- 막대그래프 값 스크립트 끝-->
  
<script type="text/javascript">
    // 이미지를 클릭했을 때 설명을 변경하는 함수
    function changeText(imageName) {
        // 선택된 이미지 설명을 표시할 요소
        const selectedImageDescriptionElement = document.getElementById('selectedImageDescription');
        
        // 각 이미지에 대한 설명 정의
        const descriptions = {
            'Business': '경영학은 마케팅, 생산관리, 인사관리, 재무관리, 경영정보, 국제경영 등 다양한 세부 전공으로 구분됩니다. 따라서 졸업 후 진출할 수 있는 분야도 다양하고, 해당 분야에 따라 요구되는 능력도 차이가 있습니다. 기본적으로 합리적인 의사결정능력과 창의력이 요구되며, 급변하는 환경에 빠르게 대처하기 위하여 새로운 기술개발과 글로벌 기업환경에 대한 지속적인 관심이 필요합니다.',
            'Engineering': '공학은 원천적으로 문제 해결을 중심으로 태어난 학문이므로, 이미 그 학문 자체가 융합의 성격을 가지고 있다. 단지 토목공학과나 기계공학과처럼 오랫동안 전수된 학문들은 마치 토목공학자는 토목 공사를 하는 사람이라거나 기계공학자는 기계를 다루는 기술자라는 식의 단순화된 업무 영역을 연상하게 되었다. 그러나 공학자(엔지니어)는 궁극적으로 인류가 기술적으로 최적화된 편리함을 누리도록 해 주는 일을 한다.',
            'Art': '예술(藝術, art)은 학문·종교·도덕 등과 같은 문화의 한 부문으로, 예술 활동(창작, 감상)과 그 성과(예술 작품)의 총칭이다. 문학, 음악, 미술, 영화, 무용 등의 공연예술이 포함된다. 그러나 이러한 예술작품을 다루는 학문은 인문학의 영역이다.',
            'Medicine': '의학이란 건강과 연관된 학문분야를 통합적으로 일컫는 말로서 김명 등은 지역사회의 조직화된 노력을 통해 건강수명(healthy life)의 연장과 개인이나 집단 또는 지역 간의 건강 격차를 해소하고, 신체적 · 정신적인 효율을 제고하기 위한 과학이라고 정의하였다.',
            'Humanities': '인문(人文, 영어: humanities)은 인간과 인간의 근원문제, 인간의 문화에 관심을 갖거나 인간의 가치와 인간만이 지닌 자기표현 능력을 바르게 이해하기 위한 과학적인 연구 방법에 관심을 갖는 학문 분야로서 인간의 사상과 문화에 관해 탐구하는 학문이다. 자연과학과 사회과학이 경험적인 접근을 주로 사용하는 것과는 달리, 분석적이고 비판적이며 사변적인 방법을 폭넓게 사용한다.',
            'NaturalSciences': '자연과학은 물질계에서 일어나는 현상을 과학적 방법이라는 특정한 방식으로 분석하여 얻은 지식 체계이다. 따라서 과학은 결론도 중요하지만, 결론을 이끌어내는 과정이 더욱 중요하다.과학에 의해 얻어진 지식체계는 경험적인 방법에 의해 추론된 것으로 절대적인 진리가 아니다. 예를 들어 아이작 뉴턴의 고전 역학은 조건에 따라 자연 현상을 설명하지 못할 수 있다. 그러나, 고전 역학의 실험 방법은 여전히 자연 과학의 한 분야이며 특정 조건 아래에서라면 뉴턴의 운동법칙은 여전히 유효하다. 충실하게 과학적 방법을 따른 실험을 통해 얻은 지식체계도 다른 증거에 의해 수정될 수 있기 때문에 과학은 언제나 반례가 나타날 수 있다는 것을 열어두어야 한다. 자연 과학에 대한 올바른 이해는 과학의 이러한 한계를 이해하는 것이 중요하다.',
            'BasicSciences': '기초과학(基礎科學, 영어: fundamental science 또는 basic science)이란 공학이나 응용과학 따위의 밑바탕이 되는 순수과학으로 자연과학의 기초 원리와 이론에 대한 학문을 뜻한다. 통상적인 의미로 기초과학은 영리 활동을 목적으로 두지 않은 순수한 지적 호기심에서 나오는 학문의 진리 탐구 자체를 목적으로 하는 학문 분야라는 뜻에서 순수과학(純粹科學, 영어: pure science)이라고도 한다.',
            'Agriculture': '농업 : 농업(農業, 영어: agriculture) 또는 농경(農耕)은 흙이나 토지를 이용하여 인간에게 유익(유용)한 식물(곡물, 채소, 과일, 화훼, 약재, 섬유 등)의 재배와 생산 그리고 가축들의 생산 및 품질 관리에 관계되는 온갖 활동과 연구를 일컫는다. 어업 : 어업(漁業)은 바다나 호수 등의 물 속에 사는 어패류, 물고기 따위의 수산물을 수확하는 직업이나 업종을 말한다. 어망을 사용한 어업은 그물어업, 망어업(網漁業)으로 부른다.',
            'SocialSciences': '사회과학(社會科學, 영어: social science)은 인간과 인간 사이의 관계에서 일어나는 사회 현상과 인간의 사회적 행동을 탐구하는 과학의 한 분야이다.',
            // 다른 이미지에 대한 설명 추가
        };
        
        // 클릭한 이미지에 대한 설명이 있는지 확인
        if (descriptions.hasOwnProperty(imageName)) {
            selectedImageDescriptionElement.textContent = descriptions[imageName];
        } else {
            selectedImageDescriptionElement.textContent = '설명이 없습니다.';
        }
    }
</script>
<!-- 비디오 스크립트 추가 -->
<script> 
    const videoUrls = {
        'Business': '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/경영소개동영상.mp4',
        'Engineering': '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/공학소개동영상.mp4',
        'Art': '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/예술소개동영상.mp4',
        'Medicine': '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/의예소개동영상.mp4',
        'Humanities': '{pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/인문학소개동영상.mp4',
        'NaturalSciences': '{pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/자연과학소개동영상.mp4',
        'BasicSciences': '{pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/기초과학소개동영상.mp4',
        'Agriculture': '{pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/농수산업소개동영상.mp4',
        'SocialSciences': '{pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/사회과학소개동영상.mp4',
        
    };
    
    function showVideo(code) {
        const videoUrl = videoUrls[code] || '';
        
        const videoContainer = document.getElementById('videoContainer');
        videoContainer.innerHTML = ''; // Clear previous video
        
        if (videoUrl) {
            const videoElement = document.createElement('video');
            videoElement.src = videoUrl;
            videoElement.controls = true;
            videoContainer.appendChild(videoElement);
        }
    }
</script>

<script>
    function redirectAuDocCd(buDocCd) {
        // 강의 상세 정보 페이지 URL을 생성하고 리다이렉션합니다.
        var detailUrl = '${pageContext.request.contextPath}/acBuDoc/acBuDocList.do?buDocCd=' + buDocCd; // 실제 URL에 맞게 수정해야 합니다.
        window.location.href = detailUrl;
    }
</script>



