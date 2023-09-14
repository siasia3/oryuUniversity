<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>

<style>
.table th, .table td {
	/*   padding: 8px; */
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis; . paging-info { display : flex;
	justify-content: space-between;
	align-items: center;
}

.paging-info p {
	margin: 0;
}

}
#imageContainer {
	display: inline-block;
	width: 200px;
	height: 200px;
	overflow: hidden;
	position: relative;
}

#imageContainer img {
	position: absolute;
	top: 0;
	left: 0;
	transition: left 0.5s ease-in-out;
}
.modal .modal-dialog .modal-content .modal-body {
    padding: 0;
}
</style>

<div class="card box-shadow d-flex m-4" style="min-height: 87%;">
	<div class="h-100">
		<div class="card-header"
			style="border-radius: 20px 20px 0 0; background-color: #154FA9; font-weight: bold; color: white;">학술사업
			</div>
		<br>
		<div class="p-4">
			<div class="gradInfo-header">
            	<i class="mdi mdi-check-circle" style="color: green;"></i> 학술사업
            	<hr style="border-color: black;">
         	</div>
			<h3>${acBuDocVO.buDocNm }</h3>
			<div style="display: flex; justify-content: left; align-items:center;">
				<div class="d-flex justify-content-left col-md-4">
					<p>사업코드 : ${acBuDocVO.acBuCd } | 분류 : ${acBuDocVO.buDocClass } | 작성자 : ${acBuDocVO.buDocAutNm } | 작성일 : ${acBuDocVO.buDocPostDate }</p>
				</div>
				<div class="d-flex justify-content-end col-md-8" style="padding-bottom: 13px;">
					<button class="btn btn-inverse-info btn-fw" id="print-link"
						style="margin: 0 10px;">원본 출력</button>
					<button class="btn btn-inverse-info btn-fw" id="listenButton"
						style="margin: 0 10px;">논문 미리보기</button>
					<button class="btn btn-inverse-info btn-fw" id="copyButton"
						style="margin: 0 10px;">인용 하기</button>
				</div>
				<div id="textToCopy" style="display: none;">${acBuDocVO.buDocNm } : ${acBuDocVO.buDocAutNm }</div>	
			</div>
			
			<table class="table" style="margin: 0 auto;">
				<tr hidden="false">
					<th>번호</th>
					<td>(<%
					int randomNumber = (int) (Math.random() * 1000);
					String randomAlphabets = "";
					for (int i = 0; i < 3; i++) {
						char randomChar = (char) ('a' + Math.random() * ('z' - 'a' + 1));
						randomAlphabets += randomChar;
					}
					%><%=randomNumber%><%=randomAlphabets%>)
					</td>
					<!-- 해당 위치에 광고 및 홍보 배너 넣고 홍보 배너에서 이미지 출력, 이미지 클릭시 모달창 출력되어 홍보물 나옴. -->
				</tr>
	
				<tr>
					<th style=" background-color: rgba(241, 241, 241, 0.5);">요약내용</th>
					<td style="word-wrap: break-word; overflow-y: auto;">${acBuDocVO.buDocShortCont}</td>
				</tr>
				<tr>
					<th style=" background-color: rgba(241, 241, 241, 0.5);">내용</th>
					<td
						style="word-wrap: break-word; white-space: pre-line; overflow-y: auto;"><br><br>${acBuDocVO.buDocCont }<br><br></td>
				</tr>
				<tr>
					<th style=" background-color: rgba(241, 241, 241, 0.5);">첨부파일</th>
					<td><c:if
							test="${not empty acBuDocVO.fileGroup and not empty acBuDocVO.fileGroup.detailList }">
							<c:forEach items="${acBuDocVO.fileGroup.detailList }"
								var="fileDetail">
								<c:url value="/acBuDoc/acBuDocDownload.do" var="downloadURL">
									<c:param name="atchFileId" value="${fileDetail.atchFileId }" />
									<c:param name="fileSn" value="${fileDetail.fileSn }" />
								</c:url>
								<a href="${downloadURL }">${fileDetail.orignlFileNm } 다운로드</a>
							</c:forEach>
						</c:if></td>
	
				</tr>
			</table>
		</div>
		<div class="modal fade" id="pdfModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content" style="margin:0 auto;width:55%;">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel"></h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick=closeModal()>
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div id="modalBody" class="modal-body d-flex">
		      	<canvas id="pdf-render" style="align:center;"></canvas>
		      </div>
		      <div class="modal-footer">
		        <button type="button" onclick=closeModal2() class="btn btn-secondary" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<c:url value='/acBuDoc/acBuDocUpdate.do' var="updateURL">
			<c:param name="what" value="${acBuDocVO.buDocCd }" />
		</c:url>
		<c:url value='/acBuDoc/acBuDocDelete.do' var="deleteURL">
			<c:param name="what" value="${acBuDocVO.buDocCd }" />
		</c:url>
		<c:url value='/acBuDoc/acBuDocList.do' var="listURL" />
		<div style="padding-left: 26px;">
			<a class="btn btn-outline-primary" style="text-align: center;" href="${updateURL }">수정</a>
			<button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">삭제</button>
			<a class="btn btn-outline-secondary" href="${listURL }">목록</a>
		</div>
		
		<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">삭제하기</h5>
						<button type="button" class="btn-close"
							data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="deleteForm" action="${deleteURL}" method="get">
							<div class="mb-3">
								<label for="password" class="form-label">비밀번호</label> <input
									type="password" class="form-control" id="password"
									name="password">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-danger"
							onclick="submitDeleteForm()">삭제하기</button>
					</div>
				</div>
			</div>
		</div> 

		<div style="margin: 0 auto;padding: 20px;">
			<div>
			<div class="gradInfo-header">
            	<i class="mdi mdi-check-circle" style="color: green;"></i> 사업평가
            	<hr style="border-color: black;">
         	</div>
<!--          	<div> -->
<!--          		<table class="table text-center" style="width:50%;"> -->
<!-- 					<tr> -->
<!-- 						<td style="width:15%">평가명</td> -->
<!-- 						<td style="width:15%">평가자</td> -->
<!-- 						<td style="width:70%">평가내용</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<%-- 						<td style="text-align: center;  --%>
<%-- 							color:${acBuDocVO.buDocEvNm == '적합' ? 'green' : (acBuDocVO.buDocEvNm == '부적합' ? 'red' : 'orange')}; --%>
<%-- 							background-color:${acBuDocVO.buDocEvNm == '적합' ? 'lightgreen' : (acBuDocVO.buDocEvNm == '부적합' ? 'lightcoral' : 'lightsalmon')}; --%>
<%-- 							"> --%>
<%-- 							${acBuDocVO.buDocEvNm} --%>
<!-- 						</td> -->
<%-- 						<td>${acBuDocVO.buDocEvAutNm }</td> --%>
<%-- 						<td>${acBuDocVO.buDocEvCont }</td> --%>
<!-- 					</tr>					 -->
<!--          		</table> -->
<!--          	</div> -->
				<table class="table" style="margin: 0 auto;">
					<tr>
						<th 
							style="text-align: center; background-color: rgba(241, 241, 241, 0.5);">평가명</th>
						<td
							style="text-align: center; 
							color:${acBuDocVO.buDocEvNm == '적합' ? 'green' : (acBuDocVO.buDocEvNm == '부적합' ? 'red' : 'orange')};
							background-color:${acBuDocVO.buDocEvNm == '적합' ? 'lightgreen' : (acBuDocVO.buDocEvNm == '부적합' ? 'lightcoral' : 'lightsalmon')};
							">
							${acBuDocVO.buDocEvNm}
							</td>
					</tr>
					<tr>
						<th
							style="text-align: center; background-color: rgba(241, 241, 241, 0.5);">평가자</th>
						<td style="text-align: center;">${acBuDocVO.buDocEvAutNm }
						</td>
					</tr>
					<tr>
						<th
							style="text-align: center; background-color: rgba(241, 241, 241, 0.5);">평가내용</th>
						<td style="text-align: center;">${acBuDocVO.buDocEvCont }
						</td>
					</tr>

				</table>

			</div>
		</div>

	</div>
</div>



<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function submitDeleteForm() {
        var password = document.getElementById("password").value;

        if (password === "java") {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "${deleteURL}", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    closeModal();
                } else if (xhr.readyState === 4 && xhr.status !== 200) {
                    console.log("Error: 삭제할 수 없습니다.");
                }
            };
            xhr.send("${deleteURL}");
            alert("삭제되었습니다.");
            window.location.href = "${listURL}"; // 리스트로 이동
        } else {
            alert("비밀번호가 틀렸습니다.");
            closeModal();
        }
    }

    function closeModal() {
        var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        deleteModal.hide();
    }
    
    function closeModal2(){
    	$("#pdfModal").modal('hide');
    }
</script>

<!-- 이미지 변경되는 스크립트 -->
<script> 
    const imgFV = document.querySelector('#imageFastView');
    imgFV.style.display = 'block';
</script>

<script>
  const images = ['${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/학술사업배너이미지1.jpg'
	 				 , '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/학술사업배너이미지2.jpg'
	 				 , '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/학술사업배너이미지3.jpg'
	 				 , '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/학술사업배너이미지4.jpg'
	  				 , '${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/학술사업배너이미지5.jpg'
	  				 ]; 
  // 이미지 경로!
  let currentImageIndex = 0;

  function changeImage() {
    const imageContainer = document.getElementById('imageContainer');
    const image = imageContainer.querySelector('img');

    currentImageIndex = (currentImageIndex + 1) % images.length;
    image.src = images[currentImageIndex];
    image.style.left = '0';

    setTimeout(() => {
      image.style.left = '-100%';
    }, 2000);

    setTimeout(changeImage, 2000);
  }

  window.onload = changeImage;
</script>
<!-- 원본보기 미리보는 코드 -->
	<script> 
        function printPDF(pdfPath) {
            var pdfWindow = window.open(pdfPath, "_blank");
            pdfWindow.onload = function() {
                pdfWindow.print();
            };
        }

        var printLink = document.getElementById("print-link");
        printLink.addEventListener("click", function(event) {
            event.preventDefault();
            printPDF("${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/1234.pdf");
        });
    </script>
    
<!-- 인용하기 코드 -->
    <script>
        document.getElementById("copyButton").addEventListener("click", function() {
            // Get the text to copy
            var text = document.getElementById("textToCopy").innerText;
            console.log(text);

            // Create a temporary textarea to copy the text to the clipboard
            var tempTextArea = document.createElement("textarea");
            tempTextArea.value = text;
            document.body.appendChild(tempTextArea);

            // Select and copy the text
            tempTextArea.select();
            document.execCommand("copy");

            // Remove the temporary textarea
            document.body.removeChild(tempTextArea);

//             Notify the user that the text has been copied (you can customize this part)
            alert("출처 \"" + text + "\"가 복사되었습니다.");
            
//             Swal.fire({
//             	  'Alert가 실행되었습니다.',         // Alert 제목
//             	  '이곳은 내용이 나타나는 곳입니다.',  // Alert 내용
//             	  'success',                         // Alert 타입
//             	});
            
        });
    </script>
    
<!-- 오디오 읽어주는 코드 -->
<script>
        // 버튼을 클릭하면 PDF를 음성으로 읽어주는 함수를 호출합니다.
        const listenButton = document.getElementById("listenButton");

        listenButton.addEventListener("click", function() {
            // PDF.js를 초기화합니다.
            const pdfjsLib = window.pdfjsLib;
            pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://mozilla.github.io/pdf.js/build/pdf.worker.js';

            let pdfDoc = null;
            let pageNum = 1;
            let pageRendering = false;
            let pageNumPending = null;
            const scale = 1.5;
            const canvas = document.getElementById("pdf-render");
            const ctx = canvas.getContext("2d");

            function renderPage(num) {
                pageRendering = true;
                pdfDoc.getPage(num).then(function(page) {
                    const viewport = page.getViewport({ scale: scale });
                    canvas.height = viewport.height;
                    canvas.width = viewport.width;
                    const renderContext = {
                        canvasContext: ctx,
                        viewport: viewport
                    };
                    const renderTask = page.render(renderContext);
                    renderTask.promise.then(function () {
                        pageRendering = false;
                        if (pageNumPending !== null) {
                            renderPage(pageNumPending);
                            pageNumPending = null;
                        }
                    });
                });
                $(pdfModal).modal("show");

                // 페이지에서 텍스트 추출
                page.getTextContent().then(function(textContent) {
                    let text = "";
                    textContent.items.forEach(function(item) {
                        text += item.str + " ";
                    });
                    textContentForSpeech = text;
                    // 추출된 텍스트를 음성으로 읽어주는 함수 호출
                    readTextAloud(textContentForSpeech);
                });
            }

            // PDF 파일 로드 함수
            function loadPdf() {
                const pdfURL = "${pageContext.request.contextPath}/resources/images/acBuDocDashBoardImages/1234.pdf"; // 여기에 자신의 PDF 파일 경로 또는 URL을 넣으세요.
                pdfjsLib.getDocument(pdfURL).promise.then(function(pdfDoc_) {
                    pdfDoc = pdfDoc_;
                    renderPage(pageNum);
                });
            }

            // 추출된 텍스트를 음성으로 읽어주는 함수
            function readTextAloud(text) {
                // Web Speech API를 사용하여 추출된 텍스트를 음성으로 읽어줍니다.
                if ('speechSynthesis' in window) {
                    const utterance = new SpeechSynthesisUtterance(text);
                    speechSynthesis.speak(utterance);
                } else {
                    alert('브라우저에서 텍스트 음성으로 읽기를 지원하지 않습니다.');
                }
            }

            // PDF 로드 함수 호출
            loadPdf();
        });
    </script>
    
