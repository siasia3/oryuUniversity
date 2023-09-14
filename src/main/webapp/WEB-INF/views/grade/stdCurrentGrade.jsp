<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.gradInfo {
	background-color: rgba(0, 0, 0, 0.03);
	margin: 20px;
	padding-right: 40px;
	font-family: 'Noto Sans KR', sans-serif;
}
.gradInfo-list {
	padding-right: 40px;
	margin: -17px 8px -12px 8px;
    height: 550px;
    background-color: white;
}

.gradInfo-header {
	margin: 20px 0 11px 40px;
	font-size: 14px;
	font-weight: bold;
}
.info-box {
	position: relative;
    margin-bottom: 18px;
    margin-top: -5px;
    margin-left: 28px;
    width: 350px;
    background: #FFFFFF;
    padding: 10px 0px 11px 125px;
    border-radius: 15px;
    position: relative;
    box-shadow: inset -2px 1px 5px rgba(0, 0, 0, 0.1);
    font-size: 13px;
}
.label {
    border-radius: 15px 0 0 15px;
    display: inline-block;
    background-color: slategray;
    color: #FFFFFF;
    width: 100px;
    padding: 9px 20px;
    margin-top: -5px;
    position: absolute;
    left: 46px;
    z-index: 2;
    text-align: center;
    box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
    font-size: 13px;
}
.table-padding {
	padding: 0 50px 0 50px;
}
.flex-container {
    display: flex;
    align-items: flex-start;
    margin-left: 20px;
}
#barchart_values {
	width: 40%;
	height: 405px;
    margin-top: -75px;
    margin-left: -20px;
}
</style>
<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="h-100">
		<div class="card-header"
			style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">현재 학기 성적</div>
			<div class="card gradInfo">
				<div class="gradInfo-header">
					<i class="mdi mdi-check-circle" style="color: green;"></i> 
						현재 학기 수강 정보<hr style="border-color: black;">
				</div>
				<div class="gradInfo-body">
				    <div class="row">
				        <div class="col-md-3">
				                <span class="label">학번</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].stCd}" />
				                </div>
				        </div>
				        <div class="col-md-3">
				                <span class="label">성명</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].stNm}" />
				                </div>
				        </div>
				        <div class="col-md-3">
				                <span class="label">단과대</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].colgeNm}" />
				                </div>
				        </div>
				        <div class="col-md-3">
				                <span class="label">학과</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].dtNm}" />
				                </div>
				        </div>
				    </div>
				    <div class="row">
				    	<div class="col-md-3">
				                <span class="label">현재연도</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].enrollmentYear}" />
				                </div>
				        </div>
				        <div class="col-md-3">
				                <span class="label">현재학기</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].semester}" />
				                </div>
				        </div>
				        <div class="col-md-3">
				                <span class="label">수강학점</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].currentLectCred}" />
				                </div>
				        </div>
				        <div class="col-md-3">
				                <span class="label">학적상태</span>
					            <div class="info-box">
				                <c:out value="${stdGradeList[0].stStatus}" />
				                </div>
				        </div>
				    </div>
				</div>
			</div>
		<div class="card-body">
			<div class="card gradInfo-list box-shadow">
				<div class="gradInfo-header">
					<i class="mdi mdi-format-list-bulleted" style="color: green;"></i> 
						현재 학기 성적 정보<hr style="border-color: black;">
				</div>
			<div class="table-padding">
				<div class="flex-container">
				<table class="table box-shadow" style="width: 60%; float: left;">
					<thead class="table-light">
						<tr>
							<th>년도</th>
							<th>학기</th>
							<th>학기종류</th>
							<th>과목</th>
							<th>과목코드</th>
							<th>이수구분</th>
							<th>학점</th>
							<th>등급</th>
							<th>평점</th>
							<th>취득여부</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="myGradeList" value="${stdGradeList}" />
							<c:choose>
								<c:when test="${empty myGradeList }">
									<tr>
										<td colspan="10">수강신청된 과목이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${myGradeList}" var="stdGrade">
										<tr>
											<td>${stdGrade.enrollmentYear }</td>
											<td>${stdGrade.semester }</td>
											<td>정규</td>
											<td>${stdGrade.lecLectTitle }</td>
											<td>${stdGrade.subjCd }</td>
											<td>${stdGrade.subjComType }</td>
											<td>${stdGrade.lecLectCred }</td>
											<td>${stdGrade.graRating }</td>
											<td>${stdGrade.graAvgScore }</td>
											<td>
											    <c:choose>
											        <c:when test="${stdGrade.graRating eq '-'}">
											            미취득
											        </c:when>
											        <c:otherwise>
											            취득
											        </c:otherwise>
											    </c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
					</tbody>
				</table>
				<div id="barchart_values">
<!-- 					차트 -->
				</div>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript">
    google.charts.load("current", {packages:["corechart"]});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
        // 등급 데이터
        var gradeData = [
            ["등급", "등급별 취득 개수", { role: "style" } ],
            ["A+", 0, "color: #D0F5BE"],
            ["A0", 0, "color: #79E0EE"],
            ["A-", 0, "color: #FFE194"],
            ["B+", 0, "color: #FFB84C"],
            ["B0", 0, "color: #79E0EE"],
            ["B-", 0, "color: #79E0EE"],
            ["C+", 0, "color: #D0F5BE"],
            ["C0", 0, "color: #FEA1A1"],
            ["C-", 0, "color: #FFE194"],
            ["D+", 0, "color: #FBFFDC"],
            ["D0", 0, "color: #FFB84C"],
            ["D-", 0, "color: #22A699"],
            ["F", 0, "color: #F2BE22"],
        ];

        var myGradeList = ${stdGradeListJson};

        for (var i = 0; i < myGradeList.length; i++) {
            var grade = myGradeList[i].graRating;
            // 등급에 해당하는 항목 찾고 갯수 증가
            for (var j = 0; j < gradeData.length; j++) {
                if (gradeData[j][0] === grade) {
                    gradeData[j][1]++;
                    break;
                }
            }
        }

        // 등급 데이터 배열 -> Google Charts 데이터 형식으로 변환
        var data = google.visualization.arrayToDataTable(gradeData);

        var options = {
            title: "현재 학기 등급 비율",
            width: 700,
            height: 530,
            bar: { groupWidth: "70%" },
            legend: { position: "bottom" },
            backgroundColor: 'transparent',
            titlePosition: "out",
            chartArea: { left: 110 },
            hAxis: {
                format: '0',
                gridlines: { count: 6 },
//                 viewWindow: {
//                     min: 0,
//                     max: 5
//                 }
            },
            series: {
                0: { color: "#154FA9" }
            }
        };

        var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
        chart.draw(data, options);
    }

  </script>



