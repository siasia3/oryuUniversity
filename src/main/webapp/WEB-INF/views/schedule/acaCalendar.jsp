<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src='<%=request.getContextPath()%>/resources/fullcalendar-6.1.8/dist/index.global.js'></script>
<style>
  #calendar {
/*     width: 50%; */
/*    	margin: 0 auto; */
	flex: 1;
    padding: 20px;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }
 
	#listView {
	width: 40%;
	height: auto;
	margin-top: 44px;
	}
 
  .card.calendar-container {
	    display: flex;
	    flex-direction: row;
	    justify-content: space-between;
	    align-items: flex-start;
	    margin-left: 25px;
	    margin-top: 20px;
	    margin-right: 25px;
	}
	
	.card.calendar-container #calendar {
	    flex: 0.75;
	    margin-right: -20px;
	}
	
	.card.calendar-container #listView {
	    flex: 0.25;
	    height: 95%;
	}
	
	.card.box-shadow{
		margin: 30px;
	}

	.list-view {
	    flex: 0.25;
	    margin-left: 20px;
  	}
	
  .event-set {
    display: flex;
    flex-direction: column;
    padding: 10px 0;
/*     border-top: 1px solid #ccc; */
  }

  .event-title {
    display: flex;
    align-items: center;
    margin-bottom: 10px;
    padding-left: 30px;
  }

  .distinction-circle {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    margin-right: 5px;
  }

  .event-title span {
    font-weight: bold;
  }

  .event-date {
    font-size: 12px;
    color: #666;
    margin-left: 15px;
    margin-bottom: 10px;
    padding-left: 25px;
  }

  .separator {
	border: none;
    border-top: 1px solid #666;
    margin: 10px 25px 3px 25px;
  }
 
  .list-title {
	  font-size: 20px;
	  font-weight: bold;
	  margin-bottom: 10px;
	  padding: 20px;
	  border-bottom: 1px solid #ccc;
	}
	/* 일요일 색깔 */
   .fc-day-sun a {
     color: red;
     text-decoration: none;
   }

   /* 토요일 색깔 */
   .fc-day-sat a {
     color: blue;
     text-decoration: none;
   }
   .info-icon{
   	  padding: 20px;
	  position: relative;
  	  display: inline-block;
   }
	.info-text {
		  width: 200px;
		  padding: -1px 16px;
		  cursor: pointer;
	}
	
.arrow_box {
	display: none;
	position: absolute;
    width: 276px;
    height: 115px;
    padding: 14px;
    left: -13px;
    bottom: -109px;
    -webkit-border-radius: 8px;
    -moz-border-radius: 8px;
    border-radius: 8px;
    background: rgba(112, 128, 144, 0.9);
    color: white;
    font-size: 12px;
}

.arrow_box:after {
  position: absolute;
  bottom: 100%;
  left: 15%;
  width: 0;
  height: 0;
  margin-left: -10px;
  border: solid transparent;
/*   border-color: rgba(200, 200, 200, 0.9); */
  border-bottom-color:rgba(112, 128, 144, 0.9);
  border-width: 10px;
  pointer-events: none;
  content: ' ';
}

span:hover + div.arrow_box {
  display: block;
}
 
.circleInfo{
	margin: 5px 10px 0 10px;
	width: 10px;
    height: 10px;
    border-radius: 50%;
    line-height: 1.5;
}

.circleInfo-container{
	margin-top: 9px;
    display: flex;
}
.modal-dialog {
    max-width: 750px;
    width: 90%;
  }
</style>

<!-- 모달창 -->
<!-- <button type="button" class="btn btn-outline-light" data-toggle="modal" data-target="#exampleModal">일정 추가</button> -->

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="modalForm">
          <input type="hidden" id="asCd" name="asCd">
          <div class="form-row">
	          <div class="form-group col-md-6">
			    <label for="asDistinction">구분</label>
			    <select class="form-control" id="asDistinction" name="asDistinction">
			        <option value="전체" selected>전체</option>
			        <option value="등록/장학일정">등록/장학일정</option>
			        <option value="학적일정">학적일정</option>
			        <option value="수업일정">수업일정</option>
			        <option value="행사일정">행사일정</option>
			        <option value="학술사업일정">학술사업일정</option>
			        <option value="수강신청일정">수강신청일정</option>
			        <option value="기타">기타</option>
			    </select>
			  </div>
	          <div class="form-group col-md-6">
	            <label for="asNm">일정명</label>
	            <input type="text" class="form-control" id="asNm" name="asNm">
	          </div>
          </div>
          <div class="form-row">
	          <div class="form-group col-md-6">
	            <label for="asStart">시작일</label>
	            <input type="date" class="form-control" id="asStart" name="asStart">
	          </div>
	          <div class="form-group col-md-6">
	            <label for="asEnd">종료일</label>
	            <input type="date" class="form-control" id="asEnd" name="asEnd">
	          </div>
          </div>
          <div class="form-row">
          <div class="form-group col-md-6">
            <label for="asCont">메모</label>
            <textarea class="form-control" id="asCont" name="asCont" rows="4"></textarea>
          </div>
          <div class="form-group col-md-5" style="margin-left: 6px;">
		    <label for="asAccePerm">열람권한</label>
		    <div class="form-inline" style="margin-left: 13px; margin-top: 15px;">
		        <div class="form-check mr-3">
		            <input type="checkbox" class="form-check-input" id="asAccePermStudent" name="asAccePerm" value="student">
		            <label class="form-check-label" for="asAccePermStudent" style="margin-top: 8px; margin-left: 10px;">학생</label>
		        </div>
		        <div class="form-check">
		            <input type="checkbox" class="form-check-input" id="asAccePermProfessor" name="asAccePerm" value="professor">
		            <label class="form-check-label" for="asAccePermProfessor" style="margin-top: 8px; margin-left: 10px;">교수</label>
		        </div>
		        <button type="button" id="checkAllButton" class="btn btn-outline-light btn-sm" style="margin-left: 20px; margin-top: 2px;">전체</button>
		    </div>
		  </div>
		  </div>
      </div>
      <div class="modal-footer">
      	<input id="auto" class="btn btn-outline-info" style=" border-radius: 10px;" type="button" value="자동완성기능">
        <button type="submit" id="insertBtn" class="btn btn-primary">저장</button>
      	<button type="button" class="btn btn-danger" id="deleteButton">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
        </form>
    </div>
  </div>
</div>
 
 <div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="h-100">
<div class="card calendar-container">
  <div id="calendar" class="calendar"></div>
   <div id="listView" class="list-view card">
	<div class="info-icon">
        <i class="mdi mdi-information" style="margin-right: 8px; color: slategray"></i>
        <span class="info-text">일정 구분 정보</span>
        <div class="arrow_box">
        	<div class="circleInfo-container">
	        	<div class="circleInfo" style="background-color: #59C173"></div>
	        		<span style="margin-right: 28px;">등록/장학일정</span>
	        	<div class="circleInfo" style="background-color: #f64f59"></div>
	        		<span>학적일정</span>
        	</div>
        	<div class="circleInfo-container">
	        	<div class="circleInfo" style="background-color: #F27121"></div>
	        		<span style="margin-right: 54px;">수업일정</span>
	        	<div class="circleInfo" style="background-color: #12c2e9"></div>
	        		<span>행사일정</span>
        	</div>
        	<div class="circleInfo-container">
	        	<div class="circleInfo" style="background-color: #c471ed"></div>
	        		<span style="margin-right: 33px;">학술사업일정</span>
	        	<div class="circleInfo" style="background-color: #f5af19"></div>
	        		<span>수강신청일정</span>
        	</div>
        </div>
    </div>
   	<div class="card-header py-3 list-title box-shadow" style="border-radius: 20px 20px 0 0; font-size: 16px;">
   		<i class="mdi mdi-checkbox-marked-circle-outline" style="color: green; margin-right: 11px;"></i>
   		Schedule List
   	</div>
   </div>
</div>
</div>
</div>

<script>
//   '구분'에 따라 색깔 다르게 지정
  function getColorForDistinction(asDistinction) {
    if (asDistinction === '등록/장학일정') {
      return '#59C173';
    } else if (asDistinction === '학적일정') {
      return '#f64f59';
    } else if (asDistinction === '수업일정') {
      return '#F27121';
    } else if (asDistinction === '행사일정') {
      return '#12c2e9';
    } else if (asDistinction === '학술사업일정') {
      return '#c471ed';
    } else if (asDistinction === '수강신청일정') {
		 return '#f5af19';
    } else {
		 return '#FBD786';
    }
  }
 
  function getListView(data){
	  var listView = document.getElementById('listView');
	  
	  var existingEvents = listView.querySelectorAll('.event-set');
	    existingEvents.forEach(function(eventElement) {
	        eventElement.remove();
	    });
	  
      for (var i = 0; i < data.length; i++) {
          var event = data[i];
          var asDistinction = event.asDistinction;
          var eventTitle = event.title;
          var startDate = new Date(event.start);
          var endDate = new Date(event.end);
         
          // YYYY-MM-DD
          var formattedStartDate = startDate.toLocaleDateString('en-CA');
          var formattedEndDate = endDate.toISOString().split('T')[0];
          
         
          // 일정 세트
          var eventSetElement = document.createElement('div');
          eventSetElement.classList.add('event-set');

          // 일정 제목
          var eventTitleElement = document.createElement('div');
          eventTitleElement.classList.add('event-title');

          // 구분 동그라미
          var distinctionCircle = document.createElement('div');
          distinctionCircle.classList.add('distinction-circle');
          distinctionCircle.style.backgroundColor = getColorForDistinction(asDistinction);
          eventTitleElement.appendChild(distinctionCircle);
          
          var eventTitleText = document.createElement('span');
          eventTitleText.innerText = eventTitle;
          eventTitleElement.appendChild(eventTitleText);

          eventSetElement.appendChild(eventTitleElement);
         
          // 날짜
          var eventDateElement = document.createElement('div');
          eventDateElement.classList.add('event-date');
          eventDateElement.innerText = formattedStartDate + ' ~ ' + formattedEndDate;
          eventSetElement.appendChild(eventDateElement);
         
          // 구분선
          var separatorElement = document.createElement('hr');
          separatorElement.classList.add('separator');
          eventSetElement.appendChild(separatorElement);

          // 일정 세트 -> listView에 추가
          listView.appendChild(eventSetElement);
      }
  }


  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var startDateField  = document.getElementById('asStart');
    var endDateField  = document.getElementById('asEnd');
    var distinctionField = document.getElementById('asDistinction');
    var asContField = document.getElementById('asCont');
    var asAccePermCheckbox = document.getElementById('asAccePerm');
    var asAccePermStudentCheckbox = document.getElementById('asAccePermStudent'); 
    var asAccePermProfessorCheckbox = document.getElementById('asAccePermProfessor');
    const deleteButton = document.getElementById('deleteButton');
    
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView : 'dayGridMonth',
      locale : 'ko',
      headerToolbar : {
        start : "prev next",
        center : "title",
        <sec:authorize access="hasRole('ROLE_TS')">
        	end : 'insertButton'
        </sec:authorize>
    	<sec:authorize access="!hasRole('ROLE_TS')">
	    	end: false
    	</sec:authorize>
      },
      <sec:authorize access="hasRole('ROLE_TS')">
      customButtons: {
	   	  insertButton: {
	   	      text: '일정 추가',
	   	      click: function () {
	   	        $('#exampleModal').modal('show');
	   	     	deleteButton.style.display = 'none';
	   	      }
	   	    }
	   	  },
	  </sec:authorize>
     
      selectable : true, // 달력 일자 드래그 설정
      droppable : true,
      editable : true,
      dayMaxEvents: true, // 이벤트 오버 -> 높이 제한
      displayEventTime: false, // 시간 안 보이게
      eventSources : getEventSources(),

      // 수정
      eventClick : function(info) {
    	 deleteButton.style.display = 'block';
    	  
         var clickedEventId = info.event.id;
         var clickedEventTitle = info.event.title;
         var clickedEventStartDate = info.event.startStr;
         var clickedEventEndDate = info.event.endStr;
         var clickedEventDistinction = info.event.extendedProps.asDistinction;
         var clickedEventAsCont = info.event.extendedProps.data.asCont;
         var clickedEventAsAccePerm = info.event.extendedProps.data.asAccePerm;

         const enddateString = clickedEventEndDate.split('T')[0];
         const date = new Date(enddateString);
         const oneDayMilliseconds = 24 * 60 * 60 * 1000;
         const previousDate = new Date(date.getTime() - oneDayMilliseconds);

         // YYYY-MM-DD
         const formattedDate = previousDate.toLocaleDateString('en-CA');

         startDateField.value = clickedEventStartDate.split('T')[0];
         endDateField.value = formattedDate;
         document.getElementById('asCd').value = clickedEventId;
         document.getElementById('asNm').value = clickedEventTitle;
         document.getElementById('asCont').value = clickedEventAsCont;
         
         $('#asDistinction').val(clickedEventDistinction);
         distinctionField.value = clickedEventDistinction;
         
		 // 열람권한 체크박스 설정
		 if (clickedEventAsAccePerm === 'STUDENT') {
	        $('#asAccePermStudent').prop('checked', true);
	        $('#asAccePermProfessor').prop('checked', false);
	    } else if (clickedEventAsAccePerm === 'PROFESSOR') {
	        $('#asAccePermStudent').prop('checked', false);
	        $('#asAccePermProfessor').prop('checked', true);
	    } else if (clickedEventAsAccePerm === 'BOTH') {
	        $('#asAccePermStudent').prop('checked', true);
	        $('#asAccePermProfessor').prop('checked', true);
	    } else {
	        $('#asAccePermStudent').prop('checked', false);
	        $('#asAccePermProfessor').prop('checked', false);
	    }
         
		 $('#insertBtn').text('수정');
		 $('#exampleModal').modal('show');
      },
      
	     select: function(info) {
		    var clickedEventEndDate = info.endStr;
		    const date = new Date(clickedEventEndDate);
		    date.setDate(date.getDate() - 1); // 하루 빼기
		
		    const formattedDate = date.toISOString().split('T')[0]; // ISO 8601 형식으로 변환
		
		    startDateField.value = info.startStr;
		    endDateField.value = formattedDate;
		    $('#insertBtn').text('저장');
		    $('#exampleModal').modal('show');
		}

    });
    
    function getEventSources() {
  	  
        return {
          url: "<c:url value='/schedule/acaCalendarDS.do'/>",
//           textColor: 'black',
//           color: 'pink', // 기본 배경색
          success: function (data) {
       	   getListView(data);
       	   for (var i = 0; i < data.length; i++) {
              var asDistinction = data[i].asDistinction;
              data[i].backgroundColor = getColorForDistinction(asDistinction);
            }
          }
        };
      }
   
    calendar.render();
    
//모달 닫힐 때 입력 필드 값을 초기화
$('#exampleModal').on('hidden.bs.modal', function(){
	$('#asCd').val('');
	$('#asDistinction').val('');
	distinctionField.value = '전체';
	$('#asNm').val('');
	$('#asStart').val('');
	$('#asEnd').val('');
	$('#asCont').val('');
// 	$('#asAccePerm').val('');
	$('#asAccePermStudent').prop('checked', false);
    $('#asAccePermProfessor').prop('checked', false);
});

function insertEvent(){
	var formData = new FormData($('#modalForm')[0]);
	formData.append('distinctionField', '전체');
	
		$.ajax({
			type: 'POST',
			url: '<c:url value="/schedule/calendarEvent.do"/>',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response){
				$('#exampleModal').modal('hide');
				
				if(response.asCd){
					var updatedEvent = calendar.getEventById(response.asCd);
					if(updatedEvent){
						updatedEvent.setProp('title', response.asNm);
						updatedEvent.setProp('asDistinction', response.asDistinction);
						updatedEvent.setStart(response.asStart);
						updatedEvent.setEnd(response.asEnd);
						updatedEvent.setProp('asCont', response.asCont);
						updatedEvent.setProp('asAccePerm', { asAccePerm: response.asAccePerm });
						calendar.addEvent(updatedEvent);
						
					}
					
				} else{
					calendar.refetchEvents();
					
				}
			},
			error: function(xhr, status, error){
				console.error('Error saving event:', error);
			}
		});
}
  
$(insertBtn).on("click",function(e){
  e.preventDefault();
  var insertBtnText = $('#insertBtn').text();
  var title = insertBtnText === '수정' ? '해당 일정을 수정하시겠습니까?' : '학사일정을 등록하시겠습니까?';
  
  Swal.fire({
     title: title,
     icon: 'question',
     
     showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
     confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
     cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
     confirmButtonText: insertBtnText, // confirm 버튼 텍스트 지정
     cancelButtonText: '취소', // cancel 버튼 텍스트 지정
     
     reverseButtons: false, // 버튼 순서 거꾸로
     
  }).then(result => {
     // 만약 Promise리턴을 받으면,
     if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
    	 var successMessage = insertBtnText === '수정' ? '학사일정이 수정되었습니다.' : '학사일정이 등록되었습니다.';
        Swal.fire(successMessage, '', 'success').then(()=>{
        	insertEvent();
        });
     }
  });
});


	// 일정 삭제
	function deleteEvent() {
	    $('#exampleModal').modal('hide');
	    const eventIdToDelete = $('#asCd').val();
	    
	    const eventToDelete = calendar.getEventById(eventIdToDelete);
	    if (eventToDelete) {
	      eventToDelete.remove();
	    }
	    
	    $.ajax({
	        type: 'POST',
	        url: '<c:url value="/schedule/deleteEvent.do"/>',
	        data: { asCd: eventIdToDelete },
	        success: function (response) {
	            console.log('삭제 성공:', response);
	            calendar.render();
	        },
	        error: function (error) {
	            console.error('삭제 실패:', error);
	        }
	    });
	}
	
	$(deleteButton).on("click",function(e){
		  e.preventDefault();
		  Swal.fire({
		     title: '해당 일정을 삭제하시겠습니까?',
		     //text: '다시 되돌릴 수 없습니다. 신중하세요.',
		     icon: 'warning',
		     
		     showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		     confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		     cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		     confirmButtonText: '삭제', // confirm 버튼 텍스트 지정
		     cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		     
		     reverseButtons: true, // 버튼 순서 거꾸로
		     
		  }).then(result => {
		     if (result.isConfirmed) { 
		        Swal.fire('학사일정이 삭제되었습니다.', '', 'success').then(()=>{
		        	deleteEvent();
		        });
		     }
		  });
		});
	   
 	// 저장 버튼 클릭
    $(document).on('click', '#modalForm button[type="submit"]', function (event) {
      event.preventDefault();
      console.log('저장 버튼 클릭');
      // 모달 닫기
      $('#exampleModal').modal('hide');
    });

    // 취소 버튼 클릭
    $(document).on('click', '#exampleModal button[data-dismiss="modal"]', function () {
      console.log('취소 버튼 클릭');
      // 모달 닫기
      $('#exampleModal').modal('hide');
    });
  });
  
  // 체크박스 전체 선택 버튼
  document.addEventListener('DOMContentLoaded', function () {
	    const professorCheckbox = document.querySelector('input[value="professor"]');
	    const studentCheckbox = document.querySelector('input[value="student"]');
	    const checkAllButton = document.getElementById('checkAllButton');

	    // '전체' 버튼 클릭 이벤트 처리
	    checkAllButton.addEventListener('click', function () {
	        const isChecked = professorCheckbox.checked && studentCheckbox.checked;
	        professorCheckbox.checked = !isChecked;
	        studentCheckbox.checked = !isChecked;
	        updateCheckAllButton(); // '전체' 버튼 상태 업데이트
	    });

	    // 교수 또는 학생 체크박스 변경 시 '전체' 버튼 상태 업데이트
	    professorCheckbox.addEventListener('change', updateCheckAllButton);
	    studentCheckbox.addEventListener('change', updateCheckAllButton);

	    // '전체' 버튼 상태 업데이트 함수
	    function updateCheckAllButton() {
	        const isChecked = professorCheckbox.checked && studentCheckbox.checked;
	        checkAllButton.textContent = isChecked ? '전체 해제' : '전체';
	    }
	});
//자동완성 버튼
  $('#auto').on('click', function () {
  	$('#asDistinction').val("기타");
  	$('#asNm').val("서버 점검");
  	$('#asCont').val("오류대학교 서버점검 공지 드립니다. 09.25~09.29 해당 기간동안에는 서버점검 예정이니 양해부탁드립니다.}");
  }); 

  

</script>