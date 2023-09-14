<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
#curve_chart {
    margin-top: 15px;
/*     float: left; */
/*     width: 50%; */
    margin-left: 20px;
}

.avgInfo {
	background-color: rgba(0, 0, 0, 0.03);
    margin: -6px;
    padding-right: 40px;
    width: 102%;
    padding: 20px;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    margin-top: 14px;
}

.avgInfo-header {
	margin-top: -5px;
/*     color: slategray; */
    font-size: 23px;
    font-weight: bold;
    margin-left: -113px;
}

.avgInfo-body {
	margin-left: -30px;
    font-size: 12px;
}

.icon {
	margin-right: 15px;
	font-size: 21px;
}

.cardSetting {
    width: 48%;
    height: 374px;
}
.table-padding{
	margin: -7px 0px 25px 30px;
}
.gradInfo {
	height: 400px;
	width: 48%;
    margin: 21px 0 20px 26px;
    font-family: 'Noto Sans KR', sans-serif;
}

.gradInfo-header {
	padding-right: 40px;
	margin: 20px 0 11px 40px;
	font-size: 14px;
	font-weight: bold;
}
#barchart_values{
	margin: -34px 0 0 12px;
	width: 60%;
}
#barchart_values p{
	margin: 46px 0 0 79px;
}
.detailInfo{
    margin:-151px 0 24px 27px;
}
.percnetInfo{
	padding: 14px 0 0 45px;
    border-radius: 19px;
    height: 241px;
    background-color: rgba(0, 0, 0, 0.03);
    margin: 29px 0 0 -14px;
    width: 27%;
}
</style>
<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="h-100">
		<div class="card-header"
			style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">
			전체 성적 조회</div>
		<div class="d-flex flex-row">
		<div class="card box-shadow gradInfo">
			<div class="gradInfo-header">
				<i class="mdi mdi-chart-line" style="color: green;"></i>
				전체 학기 평균
				<hr style="border-color: black;">
			<div class="card avgInfo"></div>
			</div>
			<div id="curve_chart"></div>
		</div>
		
		<div class="card-body">
		<div class="card box-shadow" style="height: 550px; min-height: 144%;">
			<div class="gradInfo-header">
				<i class="mdi mdi-format-list-bulleted" style="color: green; "></i>
				전체 학기 성적 목록
				<hr style="border-color: black;">
				</div>
				<div class="table-padding">
					<div class="row" style="margin: -6px 0 11px 325px;">
						<div class="col-auto">
							<select name="year" class="form-select">
				               <option value>년도선택</option>
				               <c:forEach items="${stdAllGradeList }" var="year">
				                  <option value="${year.enrollmentYear }" >${year.enrollmentYear }</option>
				               </c:forEach>
							</select>
						</div>
						<div class="col-auto"> 
							<select name="semester" class="form-select">
					               <option value>학기선택</option>
					               <c:forEach items="${stdAllGradeList }" var="semester">
					                  <option value="${semester.semester }">${semester.semester }</option>
					               </c:forEach>
							</select>
						</div>
						<div class="col-auto">
							<input type="button" value="검색" id="searchBtn" class="btn btn-success" style="padding: 10px 20px;"/>
						</div>
					</div>
				<div class="flex-container" style="max-height: 650px; overflow-y: auto;">
					<table class="table box-shadow" id="myGrade" style="width: 96%; float: left;">
						<thead class="table-light">
							<tr>
								<th>년도</th>
								<th>학기</th>
								<th>과목</th>
								<th>이수구분</th>
								<th>학점</th>
								<th>등급</th>
								<th>평점</th>
								<th>취득여부</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="myGradeList" value="${stdAllGradeList}" />
							<c:choose>
								<c:when test="${empty myGradeList }">
									<tr>
										<td colspan="8">수강신청된 과목이 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${myGradeList}" var="stdGrade">
										<tr>
											<td>${stdGrade.enrollmentYear }</td>
											<td>${stdGrade.semester }</td>
											<td>${stdGrade.lecLectTitle }</td>
											<td>${stdGrade.subjComType }</td>
											<td>${stdGrade.lecLectCred }</td>
											<td>${stdGrade.graRating }</td>
											<td>${stdGrade.graAvgScore }</td>
											<td><c:choose>
													<c:when test="${stdGrade.graRating eq '-'}">
											            미취득
											        </c:when>
													<c:otherwise>
											            취득
											        </c:otherwise>
												</c:choose></td>
										</tr>
										<c:if test="${loop.index >= 13}">
				                            <style>
				                                .flex-container {
				                                    max-height: 550px;
				                                    overflow-y: auto;
				                                }
				                            </style>
				                        </c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		</div>
		</div>
		<div class="card cardSetting box-shadow detailInfo">
			<div class="gradInfo-header">
				<i class="mdi mdi-chart-bar" style="color: green;"></i>
				선택 학기 등급 비율
				<hr style="border-color: black;">
			</div>
			<div class="row">
				<div id="barchart_values"><p>선택한 학기의 등급별 비율을 표시합니다.<br>조회 하고싶은 학기를 선택해주세요.</p></div>
				<div id="printPercent"></div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

var chart;
var gradeChart;

// 평균 차트 그리기
function drawChart() {
  var avgGradeListJson = ${avgGradeListJson};
  var MajorAvgGradeListJson = ${MajorAvgGradeListJson};
  var data = new google.visualization.DataTable();

  data.addColumn('string', 'Year');
  data.addColumn('number', '전공');
  data.addColumn('number', '전체');

  for (var i = 0; i < avgGradeListJson.length; i++) {
    var enrollmentYear = avgGradeListJson[i].enrollmentYear + '년 ' + avgGradeListJson[i].semester + "학기";
    var avgGrade = parseFloat(avgGradeListJson[i].avgGrade);
    var majorAvgGrade = MajorAvgGradeListJson[i] ? parseFloat(MajorAvgGradeListJson[i].majorAvgGrade) : 0.0;
    data.addRow([enrollmentYear, majorAvgGrade, avgGrade]);
  }
  
  var options = { // 차트 옵션 설정
    title: '',
    curveType: 'none',
    legend: {
      position: 'top'
    },
    vAxis: {
      viewWindow: {
        min: 0,
        max: 5
      },
      format: '0.0',
      ticks: [0, 1, 2, 3, 4, 5],
      gridlines: {
        count: 1
      }
    },
    pointSize: 6,
    colors: ['#F16767', '#FFB84C'],
    chartArea: {
      width: '85%', 
      height: '70%',
    },
    backgroundColor: 'transparent',
  };
  
  chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
  chart.draw(data, options);
  
  google.visualization.events.addListener(chart, 'select', selectHandler);

	  function selectHandler() {
	  var selection = chart.getSelection();
	  if (selection.length > 0) {
	    var selectedItemYear = data.getValue(selection[0].row, 0);
	    var selectedItemMajor  = data.getValue(selection[0].row, 1);
	    var selectedItemTotal  = data.getValue(selection[0].row, 2);
	    
	    var yearAndSemester = selectedItemYear.split(' '); // 년도와 학기 정보 분리

        var selectedYear = yearAndSemester[0].replace('년', '');
        var selectedSemester = yearAndSemester[1].replace('학기', '');
	    
		drawAddChart(selectedYear, selectedSemester);
	  }
	}
}

	// 선택 학기 등급 비율 차트
	function drawAddChart(selectedYear, selectedSemester) {
	    var gradeData = [
	        ["Element", "Density", { role: "style" } ],
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
	
	    var myGradeList = ${stdAllGradeListJson};
	    
	    var filterData = myGradeList.filter(function(item){
	    	return item.enrollmentYear === selectedYear.trim() 
	    			&& item.semester === selectedSemester.trim();
	    });
	
	    for (var i = 0; i < filterData.length; i++) {
	        var grade = filterData[i].graRating;
	        // 등급에 해당하는 항목 찾고 갯수 증가
	        for (var j = 0; j < gradeData.length; j++) {
	            if (gradeData[j][0] === grade) {
	                gradeData[j][1]++;
	                break;
	            }
	        }
	    }
	
	    var title = selectedYear.trim() + "년" + selectedSemester.trim() + " 학기 등급 비율";
	    // 등급 데이터 배열 -> Google Charts 데이터 형식으로 변환
	    var data = google.visualization.arrayToDataTable(gradeData);
	    
	    var totalGrades = 0;
	    var gradeGroups = {};
	    
	    gradeGroups["A"] = 0;
	    gradeGroups["B"] = 0;
	    gradeGroups["C"] = 0;
	    gradeGroups["D"] = 0;
	    gradeGroups["F"] = 0;
	    
	    for(var i = 1; i < gradeData.length; i++){
	    	var grade = gradeData[i][0];
	        var count = gradeData[i][1];
	        
	     // 등급 그룹에 따라 각각의 등급 수 누적
	        if (grade === "A+" || grade === "A0" || grade === "A-") {
	            gradeGroups["A"] += count;
	        } else if (grade === "B+" || grade === "B0" || grade === "B-") {
	            gradeGroups["B"] += count;
	        } else if (grade === "C+" || grade === "C0" || grade === "C-") {
	            gradeGroups["C"] += count;
	        } else if (grade === "D+" || grade === "D0" || grade === "D-") {
	            gradeGroups["D"] += count;
	        } else if (grade === "F") {
	            gradeGroups["F"] += count;
	        }

	        totalGrades += count;
	    }
	    
        var printInfoDiv = document.getElementById('printPercent');
        printInfoDiv.innerHTML = '';
        
        var headerDiv = document.createElement('div');
        headerDiv.innerHTML = '<i class="mdi mdi-percent" style="color: salmon; margin: 0 5px 0 10px;"></i> 상세 비율';
        headerDiv.style.fontWeight = "bold";
        headerDiv.style.marginBottom = "-3px";
        printInfoDiv.appendChild(headerDiv);
       
        var hrElement = document.createElement('hr');
        hrElement.style.borderColor = "black";
        hrElement.style.marginLeft = "-45px";
        printInfoDiv.appendChild(hrElement);
        
        for (var group in gradeGroups) {
            if (gradeGroups.hasOwnProperty(group)) {
                var count = gradeGroups[group];
                var percentage = Math.round((count / totalGrades) * 100);
                var percentageText = percentage + '%';

                var gradeInfoDiv = document.createElement('p');
                var gradeSpan = document.createElement('span');
                gradeSpan.textContent = group + " 등급";
                gradeSpan.style.fontWeight = "bold";
                gradeSpan.style.color = "#007BFF";
                gradeInfoDiv.appendChild(gradeSpan);
                
                var iconHTML = '<i class="mdi mdi-arrow-right-drop-circle" style="color: slategray; margin: 0 15px 0 8px;"></i>';
                gradeInfoDiv.insertAdjacentHTML('beforeend', iconHTML);

                var percentageText = " 비율  " + percentage + '%';
                gradeInfoDiv.insertAdjacentHTML('beforeend', percentageText);

                gradeInfoDiv.style.margin = "10px 0";
                printInfoDiv.classList.add('percnetInfo');
                printInfoDiv.appendChild(gradeInfoDiv);

            }
        }
	    
	    var options = {
	        title: title,
	        width: 500,
	        height: 350,
	        bar: { groupWidth: "70%" },
	        legend: { position: "none" },
	        backgroundColor: 'transparent',
	        titlePosition: "out",
	        chartArea: { left: 110 }
	    };
	
	    var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
	    chart.draw(data, options);
	    
	}

   
   
   var avgGradeListJson = ${avgGradeListJson};
   var majorAvgGradeListJson = ${MajorAvgGradeListJson};
   
   // 전체 평균 계산
    function totalAverage(dataList) {
       var total = 0;
       var count = 0;
       for (var i = 0; i < dataList.length; i++) {
           var avgGrade = parseFloat(dataList[i].avgGrade);
           if (!isNaN(avgGrade)) {
               total += avgGrade;
               count++;
           }
       }
       if (count === 0) {
           return 0; 
       }
       return (total / count).toFixed(2); // 소수점 둘째 자리까지
   }

   // 전공 평균 계산
    function majorAverage(dataList) {
       var total = 0;
       var count = 0;
       for (var i = 0; i < dataList.length; i++) {
           var majorAvgGrade = parseFloat(dataList[i].majorAvgGrade);
           if (!isNaN(majorAvgGrade)) {
               total += majorAvgGrade;
               count++;
           }
       }
       if (count === 0) {
           return 0; 
       }
       return (total / count).toFixed(2);
   }
   
    var stdGradeList = ${stdGradeListJson};
    var totalLectCred = stdGradeList[0].totalLectCred;
    var avgGradeAverage = totalAverage(avgGradeListJson);
    var majorAvgGradeAverage = majorAverage(majorAvgGradeListJson);

    var avgInfoDiv = document.querySelector('.avgInfo');

    for (var i = 0; i < 3; i++) { 
        var avgInfoHeaderDiv = document.createElement('div');
        avgInfoHeaderDiv.className = 'avgInfo-header';

        var avgInfoBodyDiv = document.createElement('div');
        avgInfoBodyDiv.className = 'avgInfo-body';

        switch (i) {
            case 0:
                avgInfoBodyDiv.innerHTML = '<i class="mdi mdi-information icon" style="color: slategray; vertical-align: middle;"></i>총 전체평균&nbsp;&nbsp;&nbsp;|';
                avgInfoHeaderDiv.innerHTML = avgGradeAverage;
                break;
            case 1:
                avgInfoBodyDiv.innerHTML = "총 전공평균&nbsp;&nbsp;&nbsp;|";
                avgInfoHeaderDiv.innerHTML = majorAvgGradeAverage;
                avgInfoBodyDiv.style.marginTop = "4px";
                break;
            case 2:
                avgInfoBodyDiv.innerHTML = "총 이수학점&nbsp;&nbsp;&nbsp;|";
                avgInfoHeaderDiv.innerHTML = totalLectCred;
                avgInfoBodyDiv.style.marginTop = "4px";
                break;
            default:
                break;
        }

        avgInfoDiv.appendChild(avgInfoBodyDiv);
        avgInfoDiv.appendChild(avgInfoHeaderDiv);
    }
    
    // 중복 옵션 제거
    function removeDuplicateOptions(selectElement) {
        var options = selectElement.querySelectorAll('option');
        var optionValues = [];

        options.forEach(function (option) {
            var value = option.value;
            if (optionValues.indexOf(value) === -1) {
                optionValues.push(value);
            } else {
                selectElement.removeChild(option);
            }
        });
    }

    var yearSelect = document.querySelector('select[name="year"]');
    var semesterSelect = document.querySelector('select[name="semester"]');
    removeDuplicateOptions(yearSelect);
    removeDuplicateOptions(semesterSelect);
    
    // 검색 버튼 눌렀을 때
    document.getElementById('searchBtn').addEventListener('click', function () {
    	event.preventDefault();
        var selectedYear = document.querySelector('select[name="year"]').value;
        var selectedSemester = document.querySelector('select[name="semester"]').value;

        var tableRows = document.querySelectorAll('#myGrade tbody tr');
        
        tableRows.forEach(function (row) {
            var yearCell = row.querySelector('td:nth-child(1)').textContent;
            var semesterCell = row.querySelector('td:nth-child(2)').textContent;
            
            if (selectedYear === yearCell && selectedSemester === semesterCell) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
        
        var detailInfo = document.querySelector('.detailInfo');
        detailInfo.style.marginTop = '-151px';
    });



</script>