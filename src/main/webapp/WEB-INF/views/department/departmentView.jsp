<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>

  .bannerDepartment {
    position: relative;
    background-image: url('${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/공학대학배너2.jpg');
    background-size: cover;
    background-position: center;
    height: 300px; /* 필요에 따라 높이 조정 */
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1; /* 화면 우선순위 3 */  
  }

  .overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5); /* 필요에 따라 투명도 조정 */
    z-index: 2; /* 화면 우선순위 1 */    
  }

  .bannerDepartment h1 {
    color: white; /* 텍스트 색상 조정 */
    font-size: 64px; /* 폰트 크기 조정 */
    text-align: center;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.9); /* 선택적으로 텍스트 그림자 추가 */
    margin: 0;
    padding: 20px;
    z-index: 3; /* 텍스트가 커버 위에 보이도록 z-index 설정 */
  }

    .university-button {
/*      margin: 20px;  */
     background-color : white;
     width: 150px; 
     height: 50px;
     color: black;
     border-color: rgba(230, 230, 255, 0.3);
     margin: 10px 10px;

  }
  
      .university-button:hover {
/*      margin: 20px;  */
     background-color: white;
     opacity: 0.5;
     color: black;
  }	

  <!-- ul과 ui에 점없애는 css코드-->
  .ulUi {
  	list-style-type: none;
  }
  .ulUi2 {
  	list-style-type: none;
  	white-space: nowrap;
  }
  .ulUi p {
    margin-left: 30px; 
    margin-right: 30px; 
    text-align:left;
  }	
  <!-- p태그 부분 좌우 10px띄움 -->
  .pTagCssClass { /* style="margin-left: 30px; margin-right: 30px; text-align: left;" */
    margin-left: 30px;
    margin-right: 30px;
    text-align: left;
  }
	
	.card-body { /* table을 포함한 div class */
	    padding: 20px;
	}
	.card .card-body {
    padding: 4rem 14rem;
}
	
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	th, td {
	    padding: 10px;
	    text-align: center;
	}
	
	th {
	    background-color: #f2f2f2;
	}
	
	picImageClass { /* style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;" */
	   	 width: 50px; /* 이미지의 너비 */
	   	 height: 50px; /* 이미지의 높이 */
	   	 border-radius: 50%; /* 이미지를 동그랗게 만들기 위한 속성 */
	   	 object-fit: cover; /* 이미지를 화면에 꽉 차게 맞추기 위한 속성 */
		 display: block; /* 이미지를 가운데 정렬하기 위해 필요 */
		 margin: 0 auto; /* 이미지를 가운데 정렬 */
	}
	ui {
	background-color : black;
	}
	
	<!-- li태그 색변환 -->
        .nav-item a.nav-link {
            display: block;
            padding: 10px 20px;
            text-decoration: none;
            color: black;
            transition: background-color 0.3s, color 0.3s;
        }

        /* Style for the active link */
        .nav-item.active a.nav-link {
/*             background-color: blue; */
/*             opacity: 0.5; */
/*             color: white; */
		font-size:20px
        }

        /* Hover effect for links */
        .nav-item a.nav-link:hover {
            background-color: white;
            opacity: 0.5;
            color: black;
        }	
        
        <!-- 교수소개용 css -->
                /* Section container */
        .person-section {
            display: flex;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #ccc;
            width: 100%;
	        height: 500px;
	        border: 1px solid #003458;
        }

        /* Person image */
        .person-image {
            flex: 0 0 150px; /* Fixed width for the image column */
            margin-right: 20px;
	        width: 30%;
	        float: left;
	        box-sizing: border-box;
        }

        .person-image img {
            max-width: 100%;
            height: auto;
        }

        /* Person description */
        .person-description {
            flex: 1; /* Flexible width for the description column */
/*         width: 70%; */
/*         float: right; */
        box-sizing: border-box;
            
        }
	
</style>
<!-- body code start -->
<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
<div class="card-header" style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;"></div>
	<div class="h-100">
		<div style="overflow-x: auto;">
		<!-- 잡아줘요.모양 -->
		<section> <!-- 이미지 및 화면 분할용 섹션 -->
		<div class="bannerDepartment"> <!-- 배너용 div -->
			 <div class="overlay"></div> <!-- 사진어둡게하는 효과주는 div -->
			    <h1>공과대학교</h1>
		</div>
		</section>
    <div><br></div> <!-- 배너와 버튼의 간격을 벌려주는 div -->
    <!-- 대학 버튼들 -->
    <section style="border: 1px solid; padding: 2%; margin: auto 10%; border-color: lightgray; border-radius: 30px;"> 
    <!-- nav 학과선택 버튼 섹션 -->
    <div style="text-align: center; border:1px solid #;" > <!-- 학과 선택 버튼을 모두 포함한 div 버튼 화면 가운데 정렬. -->
    <button class="university-button" data-college="dept1">건축공학과</button>
    <button class="university-button" data-college="dept2">환경공학과</button>
    <button class="university-button" data-college="dept3">토목공학과</button>
    <button class="university-button" data-college="dept4">전기공학과</button>
    <button class="university-button" data-college="dept5">응용화학공학과</button>
    <button class="university-button" data-college="dept6">전자공학과</button>
    <button class="university-button" data-college="dept7">기계공학과</button>
    <!-- 필요한 만큼 대학 버튼을 추가하세요 -->
	</div>
	</section>
	<div><br></div> <!-- 학과버튼과 소개버튼의 간격을 벌려주는 div -->
    <!-------------------------------------------------------- 학과 탭들 -------------------------------------------------------------->
    
    <div style="text-align: center; margin: 50px 130px;"> <!-- 학과소개를 모두 포함한 div -->
    
    <div class="tab" id="dept1">
        <!-- 학과 소개 내용 -->
	    <ul class="nav nav-tabs">
	        <li class="nav-item" data-tab="dept1-1-intro">
	        <a class="nav-link active">
	        학과 소개</a></li>
	        <li class="nav-item" data-tab="dept1-2-intro">
	        <a class="nav-link active">
	        교수 소개</a></li>
	        <li class="nav-item" data-tab="dept1-3-intro">
	        <a class="nav-link active">
	        커리큘럼</a></li>
	        <li class="nav-item" data-tab="dept1-4-intro">
	        <a class="nav-link active">
	        연락처</a></li>
	    </ul>
        <!-- 필요한 만큼 탭 버튼을 추가하세요 -->
        <div class="sub-tab" id="dept1-1-intro">
            <!-- 학과 소개 내용 표시 -->
            <br><br>
            <h3>건축학과</h3>
            <span>Department of Architecture</span>
            <hr>
            <p class="pTagCssClass" style="margin-left: 30px; margin-right: 30px; text-align: left;">
            건축학은 공간과 조형에 대한 창의적인 사고를 바탕으로 한다. 건축가는 여기에 역사적, 문화적, 경제적, 기술적 측면 등을 함께 고려하여 건축물을 창작한다. 따라서 건축가로 성장하기 위해서는 건축에 연관된 다양한 상황과 현상들을 이해하고 통찰할 수 있는 능력을 키워야 한다. 본 교육과정은 건축설계를 중심에 놓고 이러한 다양한 측면으로부터의 접근을 시도한다. 조형 구성능력 에서 시작되는 교육은 사회문화 및 역사에 대한 인식을 통해 공간과 도시환경에 대한 물리적, 문화적 이해능력을 키우는 데까지 이어진다. 또한, 구조, 재료, 시공, 디지탈 기반 설계, 환경기술, 프로젝트 기획능력 등에 대한 교육을 통해 건축의 기술적인 측면 또한 함께 다루고 있다. 위 교육과정은 건축학인증 시스템과 연계되어 있다. 이를 통해 국제적으로 인증받을 수 있는 전문 건축가를 양성함을 목적으로 한다.
            건축학과는 건축물의 설계를 하는 건축사(Architect)가 되기 위한 건축학 교육을 하는 학과다. 미국식 학제를 따르고 다루는 과목수를 늘려 놓았기 때문에 4년제가 아닌 5년제로 운영된다. 이러한 5년제 커리큘럼은 국제 공통 기준을 맞추기 위한 목적도 있다. 따라서 한국의 KAAB 건축학교육인증을 받으면 이 인증이 해외에서도 유효하므로 다른 나라에서도 건축 설계 활동을 할 수 있다.건축학과는 일반적으로 건축대학, 공과대학, 미술대학 등의 단과대학에 편제된다.건축에 대해 잘 모르는 사람들은 건축학과와 건축공학과의 차이점을 잘 모르는 경우가 있다. 건축공학과는 4년제 학과로 건축물의 구조역학, 재료역학, 시공 등 기술과 관련된 분야에 집중하는 반면, 건축학과는 5년제 학과로 건축물의 설계, 디자인 분야에 집중한다는 점에서 차이점이 있다.건축학과 지원시 교수진, 건축 프로그램, 시설, 인프라, 학교의 지원 등등의 요소가 종합적으로 잘 어우러지는 대학에 진학하는게 바람직하다.
            </p>
            <ul class ="ulUi">
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-map-marker">위치 : 공과대학3층 301호</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-phone">대표전화 : 042-577-1235</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-email-variant">이메일 : OrYuUniversity.Arch.ac.kr</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
            </ul>
        </div>
<br><br>
		<hr>
        <!-- 학과 소개 내용 표시 끝-->
        
        <div class="sub-tab" id="dept1-2-intro">
            <!-- 교수 소개 내용 표시 -->
            
            <div> <!-- 박성우 건설공학과 학과장 소개 -->
                        
            </div>
            
			<table class="person-section">
			    <tr>
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지1.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>박성우</h2>
			            <ul>
			                <li class="ulUi2">건축공학과 교수(학과장)</li>
			                <li class="ulUi2">재직기간 : 2010.03 ~ </li>
			            </ul>
			        </td>
			        
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지3.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>윤영선</h2>
			            <ul>
			                <li class="ulUi2">건축공학과 교수(정교수)</li>
			                <li class="ulUi2">재직기간 : 2013.05 ~ </li>
			            </ul>
			        </td>
			    </tr>
			    
			    <tr>
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지4.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>류성한</h2>
			            <ul>
			                <li class="ulUi2">건축공학과 교수(정교수)</li>
			                <li class="ulUi2">재직기간 : 2013.06 ~ </li>
			            </ul>
			        </td>
			        
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지9.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>우진호</h2>
			            <ul>
			                <li class="ulUi2">건축공학과 교수(부교수)</li>
			                <li class="ulUi2">재직기간 : 2018.11 ~ </li>
			            </ul>
			        </td>
			    </tr>
			    
			   <tr>
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지7.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>이차선</h2>
			            <ul>
			                <li class="ulUi2">건축공학과 교수(조교수)</li>
			                <li class="ulUi2">재직기간 : 2020.06 ~ </li>
			            </ul>
			        </td>
			        
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지8.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>유동호</h2>
			            <ul>
			                <li class="ulUi2">건축공학과 교수(조교수)</li>
			                <li class="ulUi2">재직기간 : 2022.02 ~ </li>
			            </ul>
			        </td>
			    </tr>
			    
			</table>

            
        </div>
        <div class="sub-tab" id="dept1-3-intro">
            <!-- 교육과정 소개 내용 표시 -->
            
                    <!-- 교육과정 -->
        <div class= "card-body">
        <h3>교육과정</h3>
	        <div>
	        	<a class="nav-link" href="${pageContext.request.contextPath}/resources/images/departmentImage/공과대학교육과정.pdf" target="_blank">다운로드<i class="mdi mdi-file-pdf"></i></a>
	        </div>
	        <br><br>
	        <hr>
	        <table class="table-striped">
	        	<thead>
			        <tr>
			        	<td style="center;">학년</td>
			        	<td>교육과정</td>
			        </tr>
	        	</thead>
	        	<tbody>
			        <tr>
			        	<td>1학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">공학입문(Introduction of Engineering)</li>
			        			<li class="ulUi2" style="text-align:left;">실험통계학(Experimental Statistics)</li>
			        		</ul>
			        	</td>
			        </tr>
			       	<tr>
			        	<td>2학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">측량학 및 실습(Surveying and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">컴퓨터제도학(Computer Aided Drafting)</li>
			        			<li class="ulUi2" style="text-align:left;">공업수학(Engineering Mathematics)</li>
			        			<li class="ulUi2" style="text-align:left;">정역학 및 연습(Statics and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">건설지질학(Construction Geology)</li>
			        		</ul>
			        	</td>
			        </tr>
			        <tr>
			        	<td>3학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">유체역학(Fluid Mechanics)</li>
			        			<li class="ulUi2" style="text-align:left;">토질역학 및 실험(Soil Mechanics and Lab.)</li>
			        			<li class="ulUi2" style="text-align:left;">재료역학 및 실험(Mechanics of Materials and Lab)</li>
			        			<li class="ulUi2" style="text-align:left;">컴퓨터프로그래밍 및 실습(Computer Programming and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">수리학 및 실험(Hydraulics and Lab.)</li>
			        			<li class="ulUi2" style="text-align:left;">철근콘크리트구조공학 및 설계(RC Structural Engineering and Design)</li>
			        		</ul>
			        	</td>
			        </tr>
			        <tr>
			        	<td>4학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">건설시공학 및 실습(Construction Engineering and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">지역방재공학(Preventive Disaster of Agricultural and Rural Engineering)</li>
			        			<li class="ulUi2" style="text-align:left;">하천생태 및 수자원공학(River Ecosystem and Water Resources Engineering)</li>
			        			<li class="ulUi2" style="text-align:left;">인턴십Ⅰ(InternshipⅠ)</li>
			        			<li class="ulUi2" style="text-align:left;">인턴십Ⅱ(InternshipⅡ)</li>
			        			<li class="ulUi2" style="text-align:left;">부정정구조물해석 및 설계(Statically Indeterminated Structures and Design)</li>
			        		</ul>
			        	</td>
			        </tr>
	        	</tbody>
	        </table>
	        
	        <hr>
	        
        </div>
        
                <!-- 진학가이드 -->
<!--         <div> -->
<!--         	<h3>진학가이드</h3><br><br> -->
<!--         	<h4>관련 적성과 흥미 알아보기</h4><br><br> -->
<!--         	<p class="pTagCssClass" style="margin-left: 30px; margin-right: 30px; text-align: left;">건축은 현 시대의 문화, 예술, 기술을 반영한다. 따라서 평소에 사회의 다양한 분야에 걸쳐 고른 관심을 가지고 있으면 좋다. 공간 지각력이나 미적 감각이 뛰어나다면 빠르게 적응할 수 있다. 또한 사회와 공공성에 대한 관심이 있고, 복잡한 문제의 관계성을 이해할 수 있는 능력이 있다면 이 또한 큰 도움이 된다. 첨단 기술 분야에 대한 관심 또한 빠르게 변해가고 있는 건축계에서 좋은 관점을 키워줄 것이다.</p> -->

<!--             <br><br><h4>권장도서</h4><br><br> -->
<!--             <p class="pTagCssClass" style="margin-left: 30px; margin-right: 30px; text-align: left;">학과 생활을 안내하는 건축학과 편람을 제작하여 배포하며, 편람에 학생에게 추천하는 도서목록, 건축물 답사 100선 등 다양한 정보를 제공하고 있음 건축 뿐 아니라, 역사, 문화, 기술 등 다양한 분야의 책을 접할 것을 권장한다.</p> -->
<!--         </div> -->
<!--         <hr> -->
<!-- 		<!-- 졸업 후 진로 --> 
<!-- 		<h3>졸업 후 진로</h3><br><br> -->
<!-- 		<p>졸업 후 진출 분야</p><br><br> -->
<!-- 			<div > -->
<!-- 			<p class="pTagCssClass" style="margin-left: 30px; margin-right: 30px; text-align: left;"> -->
<!-- 				건축설계사무소에 주로 진출하여 건축물의 설계 및 감리 업무를 수행한다. 후에는 건축사 자격 취득을 통해 자신의 사무소를 개설하는 경우가 많다. 건축설계를 바탕으로 재료나 구조 디자인 분야 및 건설사로의 진출 또한 가능하며, 관련 연구소나 행정 기관으로 진출할 수도 있다. 이밖에 도시, 조경 등 큰 스케일의 계획 분야, 인테리어, 가구, 제품 디자인 등 공간디자인 능력을 바탕 으로 다양한 스케일의 계획 분야로도 나아갈 수 있다. 또한 금융, 부동산, 마케팅 등 기타 분야에서도 건축에 대한 지식을 갖춘 인재를 필요로 하고 있어, 선택 가능한 진로의 폭이 넓은 편이다. -->
<!-- 			</p> -->
<!-- 		</div><br><br> -->
		
		<div>
			<p>
				<img src="${pageContext.request.contextPath}/resources/images/departmentImage/건설공학소개이미지.jpg"alt="건설공학소개이미지">
				<img src="${pageContext.request.contextPath}/resources/images/departmentImage/건설공학소개이미지1.jpg"alt="건설공학소개이미지">
			</p>
			<p>
				<img src="${pageContext.request.contextPath}/resources/images/departmentImage/건설공학소개이미지2.jpg"alt="건설공학소개이미지">
			</p>
			<p>
				<img src="${pageContext.request.contextPath}/resources/images/departmentImage/건설공학소개이미지3.jpg"alt="건설공학소개이미지">
				<img src="${pageContext.request.contextPath}/resources/images/departmentImage/건설공학소개이미지4.jpg"alt="건설공학소개이미지">
			</p>
		</div>
        
        <hr>
            
        </div>
        <div class="sub-tab" id="dept1-4-intro">
            <!-- 연락처 내용 표시 -->
            
		        <!-- 연락처 -->
        <div class= "card-body">
	        <h3>담당 업무 및 전화번호</h3>
	        <br><br>
	        <hr>
	        <table class="table-striped" style="border:1px;">
		        <thead>
			        <tr>
			        	<td>사진</td>
			        	<td>이름</td>
			        	<td>담당업무</td>
			        	<td>연락처</td>
			        </tr>
			     </thead> 
			     <tbody>
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지1.jpg"
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>박성우</td>
			        	<td>교수(학과장)</td>
			        	<td>042-524-7750</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지6.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>유가영</td>
			        	<td>학과조교</td>
			        	<td>042-524-7751</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지3.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>윤영선</td>
			        	<td>교수</td>
			        	<td>042-524-7752</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지4.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>류성한</td>
			        	<td>교수</td>
			        	<td>042-524-7753</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지9.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>우진호</td>
			        	<td>부교수</td>
			        	<td>042-524-7754</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지7.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>이차신</td>
			        	<td>조교수</td>
			        	<td>042-524-7755</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지8.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>유동호</td>
			        	<td>조교수</td>
			        	<td>042-524-7756</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>이세아</td>
			        	<td>재료공학실험실</td>
			        	<td>042-524-7757</td>
			        </tr>
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지5.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>김중현</td>
			        	<td>토목과실험실</td>
			        	<td>042-524-7758</td>
			        </tr>
			     </tbody> 
	        </table>
        </div>
        <hr>            
            
        </div>
    </div>

    <!-- 필요한 만큼 학과 탭을 추가하세요 -->

    <div class="tab" id="dept2">
        <!-- 학과 소개 내용 -->
	    <ul class="nav nav-tabs">
	        <li class="nav-item" data-tab="dept2-1-intro">
	        <a class="nav-link active">
	        학과 소개</a></li>
	        <li class="nav-item" data-tab="dept2-2-intro">
	        <a class="nav-link active">
	        교수 소개</a></li>
	        <li class="nav-item" data-tab="dept2-3-intro">
	        <a class="nav-link active">
	        커리큘럼</a></li>
	        <li class="nav-item" data-tab="dept2-4-intro">
	        <a class="nav-link active">
	        연락처</a></li>
	    </ul>
        <!-- 필요한 만큼 탭 버튼을 추가하세요 -->
        <div class="sub-tab" id="dept2-1-intro">
            <!-- 학과 소개 내용 표시 -->
            <br><br>
            <h3>환경공학과</h3>
            <span>Department of Environmental Engineering</span>
            <hr>
            <p class="pTagCssClass" style="margin-left: 30px; margin-right: 30px; text-align: left;">
            환경공학과는 화학이나 생물학적 원리와 공학적 방법을 활용하여 환경오염의 측정, 처리 및 개선을 위한 방법을 배우는 곳입니다. 환경공학과는 환경공학 기술을 이용하여 삶의 터전을 보존하고 치료하는 
            분야에 종사할 전문 인력을 기르는 곳입니다.
			환경공학은 자연과학과 공학의 각종 지식과 기술이 융ㆍ복합적으로 요구되는 학문으로, 세계적으로 저탄소 녹색 성장이 중요해지고 우리나라도 발전함에 따라 앞으로 환경공학에 대한 관심도 높아지고 있습니다.
            </p>
            <ul class ="ulUi">
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-map-marker">위치 : 공과대학2층 201호</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-phone">대표전화 : 042-577-1235</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-email-variant">이메일 : OrYuUniversity.Arch.ac.kr</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
            </ul>
        </div>
        <div class="sub-tab" id="dept2-2-intro">
            <!-- 학과 소개 내용 표시 -->
            
            <table class="person-section">
			    <tr>
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지1.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>박성우</h2>
			            <ul>
			                <li class="ulUi2">환경공학과 교수(학과장)</li>
			                <li class="ulUi2">재직기간 : 2010.03 ~ </li>
			            </ul>
			        </td>
			        
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지3.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>윤영선</h2>
			            <ul>
			                <li class="ulUi2">환경공학과 교수(정교수)</li>
			                <li class="ulUi2">재직기간 : 2013.05 ~ </li>
			            </ul>
			        </td>
			    </tr>
			    
			    <tr>
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지4.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>류성한</h2>
			            <ul>
			                <li class="ulUi2">환경공학과 교수(정교수)</li>
			                <li class="ulUi2">재직기간 : 2013.06 ~ </li>
			            </ul>
			        </td>
			        
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지9.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>우진호</h2>
			            <ul>
			                <li class="ulUi2">환경공학과 교수(부교수)</li>
			                <li class="ulUi2">재직기간 : 2018.11 ~ </li>
			            </ul>
			        </td>
			    </tr>
			    
			   <tr>
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지7.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>이차선</h2>
			            <ul>
			                <li class="ulUi2">환경공학과 교수(조교수)</li>
			                <li class="ulUi2">재직기간 : 2020.06 ~ </li>
			            </ul>
			        </td>
			        
			        <td class="person-image" style="width: 50px !important; text-align: left !important;">
			            <img src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지8.jpg"
			                alt="Image of Professor Seongwoo Park."
			                style="margin: 0 20px; max-width: 150px !important; height: auto !important;">
			        </td>
			        <td class="person-description" style="width: calc(40% - 10px) !important; text-align: left !important;">
			            <h2>유동호</h2>
			            <ul>
			                <li class="ulUi2">환경공학과 교수(조교수)</li>
			                <li class="ulUi2">재직기간 : 2022.02 ~ </li>
			            </ul>
			        </td>
			    </tr>
			    
			</table>
            
        </div>
        <div class="sub-tab" id="dept2-3-intro">
            <!-- 학과 소개 내용 표시 -->
            
            <div class= "card-body">
        <h3>교육과정</h3>
	        <div>
	        	<a class="nav-link" href="${pageContext.request.contextPath}/resources/images/departmentImage/공과대학교육과정.pdf" target="_blank">다운로드<i class="mdi mdi-file-pdf"></i></a>
	        </div>
	        <br><br>
	        <hr>
	        <table class="table-striped">
	        	<thead>
			        <tr>
			        	<td style="center;">학년</td>
			        	<td>교육과정</td>
			        </tr>
	        	</thead>
	        	<tbody>
			        <tr>
			        	<td>1학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">공학입문(Introduction of Engineering)</li>
			        			<li class="ulUi2" style="text-align:left;">실험통계학(Experimental Statistics)</li>
			        		</ul>
			        	</td>
			        </tr>
			       	<tr>
			        	<td>2학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">측량학 및 실습(Surveying and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">컴퓨터제도학(Computer Aided Drafting)</li>
			        			<li class="ulUi2" style="text-align:left;">공업수학(Engineering Mathematics)</li>
			        			<li class="ulUi2" style="text-align:left;">정역학 및 연습(Statics and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">건설지질학(Construction Geology)</li>
			        		</ul>
			        	</td>
			        </tr>
			        <tr>
			        	<td>3학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">유체역학(Fluid Mechanics)</li>
			        			<li class="ulUi2" style="text-align:left;">토질역학 및 실험(Soil Mechanics and Lab.)</li>
			        			<li class="ulUi2" style="text-align:left;">재료역학 및 실험(Mechanics of Materials and Lab)</li>
			        			<li class="ulUi2" style="text-align:left;">컴퓨터프로그래밍 및 실습(Computer Programming and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">수리학 및 실험(Hydraulics and Lab.)</li>
			        			<li class="ulUi2" style="text-align:left;">철근콘크리트구조공학 및 설계(RC Structural Engineering and Design)</li>
			        		</ul>
			        	</td>
			        </tr>
			        <tr>
			        	<td>4학년</td>
			        	<td>
			        		<ul style="padding-left: 250px;">
			        			<li class="ulUi2" style="text-align:left;">건설시공학 및 실습(Construction Engineering and Practice)</li>
			        			<li class="ulUi2" style="text-align:left;">지역방재공학(Preventive Disaster of Agricultural and Rural Engineering)</li>
			        			<li class="ulUi2" style="text-align:left;">하천생태 및 수자원공학(River Ecosystem and Water Resources Engineering)</li>
			        			<li class="ulUi2" style="text-align:left;">인턴십Ⅰ(InternshipⅠ)</li>
			        			<li class="ulUi2" style="text-align:left;">인턴십Ⅱ(InternshipⅡ)</li>
			        			<li class="ulUi2" style="text-align:left;">부정정구조물해석 및 설계(Statically Indeterminated Structures and Design)</li>
			        		</ul>
			        	</td>
			        </tr>
	        	</tbody>
	        </table>
	        
	        <hr>
	        
        </div>
            
        </div>
        <div class="sub-tab" id="dept2-4-intro">
            <!-- 학과 소개 내용 표시 -->
            
               <div class= "card-body">
	        <h3>담당 업무 및 전화번호</h3>
	        <br><br>
	        <hr>
	        <table class="table-striped" style="border:1px;">
		        <thead>
			        <tr>
			        	<td>사진</td>
			        	<td>이름</td>
			        	<td>담당업무</td>
			        	<td>연락처</td>
			        </tr>
			     </thead> 
			     <tbody>
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지1.jpg"
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>박성우</td>
			        	<td>교수(학과장)</td>
			        	<td>042-524-7750</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지6.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>유가영</td>
			        	<td>학과조교</td>
			        	<td>042-524-7751</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지3.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>윤영선</td>
			        	<td>교수</td>
			        	<td>042-524-7752</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지4.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>류성한</td>
			        	<td>교수</td>
			        	<td>042-524-7753</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지9.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>우진호</td>
			        	<td>부교수</td>
			        	<td>042-524-7754</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지7.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>이차신</td>
			        	<td>조교수</td>
			        	<td>042-524-7755</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지8.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>유동호</td>
			        	<td>조교수</td>
			        	<td>042-524-7756</td>
			        </tr>
			        
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>이세아</td>
			        	<td>재료공학실험실</td>
			        	<td>042-524-7757</td>
			        </tr>
			        <tr>
			        	<td><img class="picImageClass" src="${pageContext.request.contextPath}/resources/images/departmentImage/담당자이미지5.jpg" 
			        	style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover; display: block; margin: 0 auto;"
			        	></td>
			        	<td>김중현</td>
			        	<td>토목과실험실</td>
			        	<td>042-524-7758</td>
			        </tr>
			     </tbody> 
	        </table>
        </div>
        <hr>            
           
            
        </div>
    </div>

    <div class="tab" id="dept3">
        <!-- 학과 소개 내용 -->
	    <ul class="nav nav-tabs">
	        <li class="nav-item" data-tab="dept3-1-intro">
	        <a class="nav-link active">
	        학과 소개</a></li>
	        <li class="nav-item" data-tab="dept3-2-intro">
	        <a class="nav-link active">
	        교수 소개</a></li>
	        <li class="nav-item" data-tab="dept3-3-intro">
	        <a class="nav-link active">
	        커리큘럼</a></li>
	        <li class="nav-item" data-tab="dept3-4-intro">
	        <a class="nav-link active">
	        연락처</a></li>
	    </ul>
        <!-- 필요한 만큼 탭 버튼을 추가하세요 -->
        <div class="sub-tab" id="dept3-1-intro">
            <!-- 학과 소개 내용 표시 -->ㅁㄴㅇ
        </div>
        <div class="sub-tab" id="dept3-2-intro">
            <!-- 학과 소개 내용 표시 -->ㄴㅇㄹ
        </div>
        <div class="sub-tab" id="dept3-3-intro">
            <!-- 학과 소개 내용 표시 -->ㄹ호
        </div>
        <div class="sub-tab" id="dept3-4-intro">
            <!-- 학과 소개 내용 표시 -->ㅗㅓㅏ
        </div>
    </div>

    <div class="tab" id="dept4">
        <!-- 학과 소개 내용 -->
	    <ul class="nav nav-tabs">
	        <li class="nav-item" data-tab="dept4-1-intro">
	        <a class="nav-link active">
	        학과 소개</a></li>
	        <li class="nav-item" data-tab="dept4-2-intro">
	        <a class="nav-link active">
	        교수 소개</a></li>
	        <li class="nav-item" data-tab="dept4-3-intro">
	        <a class="nav-link active">
	        커리큘럼</a></li>
	        <li class="nav-item" data-tab="dept4-4-intro">
	        <a class="nav-link active">
	        연락처</a></li>
	    </ul>
        <!-- 필요한 만큼 탭 버튼을 추가하세요 -->
        <div class="sub-tab" id="dept4-1-intro">
            <!-- 학과 소개 내용 표시 -->ㅁㄴㅇ
        </div>
        <div class="sub-tab" id="dept4-2-intro">
            <!-- 학과 소개 내용 표시 -->ㄴㅇㄹ
        </div>
        <div class="sub-tab" id="dept4-3-intro">
            <!-- 학과 소개 내용 표시 -->ㄹ호
        </div>
        <div class="sub-tab" id="dept4-4-intro">
            <!-- 학과 소개 내용 표시 -->ㅗㅓㅏ
        </div>
    </div>

    <div class="tab" id="dept5">
        <!-- 학과 소개 내용 -->
	    <ul class="nav nav-tabs">
	        <li class="nav-item" data-tab="dept5-1-intro">
	        <a class="nav-link active">
	        학과 소개</a></li>
	        <li class="nav-item" data-tab="dept5-2-intro">
	        <a class="nav-link active">
	        교수 소개</a></li>
	        <li class="nav-item" data-tab="dept5-3-intro">
	        <a class="nav-link active">
	        커리큘럼</a></li>
	        <li class="nav-item" data-tab="dept5-4-intro">
	        <a class="nav-link active">
	        연락처</a></li>
	    </ul>
        <!-- 필요한 만큼 탭 버튼을 추가하세요 -->
        <div class="sub-tab" id="dept5-1-intro">
            <!-- 학과 소개 내용 표시 -->ㅁㄴㅇ
        </div>
        <div class="sub-tab" id="dept5-2-intro">
            <!-- 학과 소개 내용 표시 -->ㄴㅇㄹ
        </div>
        <div class="sub-tab" id="dept5-3-intro">
            <!-- 학과 소개 내용 표시 -->ㄹ호
        </div>
        <div class="sub-tab" id="dept5-4-intro">
            <!-- 학과 소개 내용 표시 -->ㅗㅓㅏ
        </div>
    </div>

    <div class="tab" id="dept6">
        <!-- 학과 소개 내용 -->
	    <ul class="nav nav-tabs">
	        <li class="nav-item" data-tab="dept6-1-intro">
	        <a class="nav-link active">
	        학과 소개</a></li>
	        <li class="nav-item" data-tab="dept6-2-intro">
	        <a class="nav-link active">
	        교수 소개</a></li>
	        <li class="nav-item" data-tab="dept6-3-intro">
	        <a class="nav-link active">
	        커리큘럼</a></li>
	        <li class="nav-item" data-tab="dept6-4-intro">
	        <a class="nav-link active">
	        연락처</a></li>
	    </ul>
        <!-- 필요한 만큼 탭 버튼을 추가하세요 -->
        <div class="sub-tab" id="dept6-1-intro">
            <!-- 학과 소개 내용 표시 -->ㅁㄴㅇ
        </div>
        <div class="sub-tab" id="dept6-2-intro">
            <!-- 학과 소개 내용 표시 -->ㄴㅇㄹ
        </div>
        <div class="sub-tab" id="dept6-3-intro">
            <!-- 학과 소개 내용 표시 -->ㄹ호
        </div>
        <div class="sub-tab" id="dept6-4-intro">
            <!-- 학과 소개 내용 표시 -->ㅗㅓㅏ
        </div>
    </div>

    <div class="tab" id="dept7">
        <!-- 학과 소개 내용 -->
	    <ul class="nav nav-tabs">
	        <li class="nav-item" data-tab="dept7-1-intro">
	        <a class="nav-link active">
	        학과 소개</a></li>
	        <li class="nav-item" data-tab="dept7-2-intro">
	        <a class="nav-link active">
	        교수 소개</a></li>
	        <li class="nav-item" data-tab="dept7-3-intro">
	        <a class="nav-link active">
	        커리큘럼</a></li>
	        <li class="nav-item" data-tab="dept7-4-intro">
	        <a class="nav-link active">
	        연락처</a></li>
	    </ul>
        <!-- 필요한 만큼 탭 버튼을 추가하세요 -->
        <div class="sub-tab" id="dept7-1-intro">
            <!-- 학과소개 표시 -->7
        </div>
        <div class="sub-tab" id="dept7-2-intro">
            <!-- 교수소개 내용 표시 -->7
        </div>
        <div class="sub-tab" id="dept7-3-intro">
            <!-- 교육과정 표시 -->7
        </div>
        <div class="sub-tab" id="dept7-4-intro">
            <!-- 연락처 내용 표시 -->7
        </div>
    </div>
    </div>
		
		<!-- 잡아줘요.모양 끝 -->
		</div>
	</div>
</div>



        <div class="sub-tab" id="dept3-1-intro">
            <!-- 학과 소개 내용 표시 -->
            <br><br>
            <h3>토목공학과</h3>
            <span>Department of Architecture</span>
            <hr>
            <p class="pTagCssClass" style="margin-left: 30px; margin-right: 30px; text-align: left;">
            환경공학과는 화학이나 생물학적 원리와 공학적 방법을 활용하여 환경오염의 측정, 처리 및 개선을 위한 방법을 배우는 곳입니다. 환경공학과는 환경공학 기술을 이용하여 삶의 터전을 보존하고 치료하는 
            분야에 종사할 전문 인력을 기르는 곳입니다.
			환경공학은 자연과학과 공학의 각종 지식과 기술이 융ㆍ복합적으로 요구되는 학문으로, 세계적으로 저탄소 녹색 성장이 중요해지고 우리나라도 발전함에 따라 앞으로 환경공학에 대한 관심도 높아지고 있습니다.
            </p>
            <ul class ="ulUi">
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-map-marker">위치 : 공과대학2층 201호</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-phone">대표전화 : 042-577-1235</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
	            <li class ="ulUi2">
	            	<p style ="text-align: center;">
	            		<i class="mdi mdi-email-variant">이메일 : OrYuUniversity.Arch.ac.kr</i>
	            		<span>
	            		
	            		</span>
	            	</p>
	            </li>
            </ul>
        </div>




<!------------------------------------------------------------------------------- 스크립트 구간 ----------------------------------------------------------------->
    <script>
        // 탭 전환을 처리하는 JavaScript
        const universityButtons = document.querySelectorAll('.university-button');
        const tabs = document.querySelectorAll('.tab');
        const departmentButtons = document.querySelectorAll('.nav-item');
        const subTabs = document.querySelectorAll('.sub-tab');

        universityButtons.forEach(button => {
            button.addEventListener('click', () => {
                const college = button.getAttribute('data-college');
                tabs.forEach(tab => {
                    if (tab.id === college) {
                        tab.style.display = 'block';
                    } else {
                        tab.style.display = 'none';
                    }
                });
            });
        });

        departmentButtons.forEach(button => {
            button.addEventListener('click', () => {
                const tabId = button.getAttribute('data-tab');
                subTabs.forEach(tab => {
                    if (tab.id === tabId) {
                        tab.style.display = 'block';
                    } else {
                        tab.style.display = 'none';
                    }
                });
            });
        });
    </script>
    
    <!-- university-button이 눌리면 버튼의 background color를 바꿔줌. -->
	<script>
		  var buttons = document.querySelectorAll('.university-button');
		  buttons.forEach(function(button) {
		    button.addEventListener('click', function() {
		      buttons.forEach(function(btn) {
		        btn.style.backgroundColor = 'white'; // 다른 버튼이 눌리면 그외의 버튼들의 백그라운드 색을 흰색으로 해줌.
		      });
		      this.style.backgroundColor = 'rgba(230, 230, 253, 0.5)'; 
		      //버튼이 눌리면 해당 색을 버튼의 백그라운드 색으로 해줌.
		    });
		  });
	</script>

	<!-- 화면의 기본값을 설정한 스크립트 -->
	<script>
	    // 기본 상태를 설정하는 함수
	    function setDefaultState() {
	        const defaultDepartment = document.getElementById('dept1');
	        const defaultButton = document.querySelector('[data-college="dept1"]');
	        const defaultSubTab = document.getElementById('dept1-1-intro');
	        
	        // 기본 학과 섹션과 하위 탭을 표시합니다.
	        defaultDepartment.style.display = 'block';
	        defaultSubTab.style.display = 'block';
	        
	        // 기본 대학 버튼의 배경색을 설정합니다.
	        defaultButton.style.backgroundColor = 'rgba(230, 230, 253, 0.5)';
	        
	        // 다른 학과 섹션과 하위 탭을 숨깁니다.
	        const allTabs = document.querySelectorAll('.tab');
	        const allSubTabs = document.querySelectorAll('.sub-tab');
	        
	        allTabs.forEach(tab => {
	            if (tab !== defaultDepartment) {
	                tab.style.display = 'none';
	            }
	        });
	        
	        allSubTabs.forEach(subTab => {
	            if (subTab !== defaultSubTab) {
	                subTab.style.display = 'none';
	            }
	        });
	    }
	
	    // 페이지 로드 시 setDefaultState 함수를 호출합니다.
	    window.onload = setDefaultState;
	</script>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        const navItems = document.querySelectorAll('.nav-item');

        navItems.forEach(item => {
            item.addEventListener('click', () => {
                navItems.forEach(otherItem => {
                    otherItem.classList.remove('active');
                });
                item.classList.add('active');
            });
        });
    });
</script>



