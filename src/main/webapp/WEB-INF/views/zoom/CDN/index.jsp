<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<head>
    <title>zoom - 화상강의</title>
    <meta charset="utf-8" />
    <link type="text/css" rel="stylesheet" href="https://source.zoom.us/2.9.5/css/bootstrap.css" />
    <link type="text/css" rel="stylesheet" href="https://source.zoom.us/2.9.5/css/react-select.css" />
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <script src="<%=request.getContextPath() %>/resources/js/jquery-3.7.0.min.js"></script>
    
    <style>
        .sdk-select {
            height: 34px;
            border-radius: 4px;
        }

        .websdktest button {
            float: right;
            margin-left: 5px;
        }

        #nav-tool {
            margin-bottom: 0px;
        }
        
        .navbar-brand{
        	color : #ffffff!important;
        	font-family: '양진체';
        	font-weight: bold;
        }
        
        .navbar-inverse .navbar-form {
		    border: none!important;
		}

        #show-test-tool {
            position: absolute;
            top: 100px;
            left: 0;
            display: block;
            z-index: 99999;
        }

        #display_name {
            width: 250px;
        }


        #websdk-iframe {
            width: 700px;
            height: 520px;
            /**border: 1px;
            border-color: red;**/
            border-style: dashed;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            left: 50%;
            margin: 0;
        }
    </style>
</head>

<body>
    <nav id="nav-tool" class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <h5 class="navbar-brand custom-bold">화상강의 설정</h5>
            </div>
            <div id="navbar" class="websdktest">
                <form class="navbar-form navbar-right" id="meeting_form">
                    <div class="form-group">
                        <input type="text" name="display_name" id="display_name" value="${memName}" maxLength="100"
                            placeholder="Name" class="form-control input-default" required style="width:200px">
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="meeting_number" id="meeting_number" maxLength="200"
                            style="width:200px" placeholder="Meeting Number" class="form-control input-default" required>
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="meeting_pwd" id="meeting_pwd" style="width:200px"
                            maxLength="32" placeholder="Meeting Password" class="form-control input-default">
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="meeting_email" id="meeting_email" value="rlafoghd359@naver.com" style="width:200px"
                            maxLength="32" placeholder="Email option" class="form-control input-default">
                    </div>
                    <div class="form-group">
                        <select id="meeting_role" class="sdk-select" style="width:200px;"
                         <sec:authorize access="hasRole('ROLE_ST')">
                         value="0"
                         </sec:authorize>
                         <sec:authorize access="hasRole('ROLE_PR')">
                         value="1"
                         </sec:authorize>
                         >
                        <sec:authorize access="hasRole('ROLE_ST')">
                            <option value=0 selected>참석자</option>
                         </sec:authorize>
                         <sec:authorize access="hasRole('ROLE_PR')">
                         	<option value=1 selected>호스트</option>
                         </sec:authorize>
                        </select>
                    </div>
                    <div class="form-group">
                        <select id="meeting_china" class="sdk-select" style="width:200px;">
                            <option value=0 selected>Global</option>
                            <option value=1>China</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <select id="meeting_lang" class="sdk-select" style="width:200px;">
                        	<option>== 언어 선택 ==</option>
                            <option value="en-US">English</option>
                            <option value="de-DE">German Deutsch</option>
                            <option value="es-ES">Spanish Español</option>
                            <option value="fr-FR">French Français</option>
                            <option value="jp-JP">Japanese 日本語</option>
                            <option value="pt-PT">Portuguese Portuguese</option>
                            <option value="ru-RU">Russian Русский</option>
                            <option value="zh-CN">Chinese 简体中文</option>
                            <option value="zh-TW">Chinese 繁体中文</option>
                            <option value="ko-KO" selected>Korean 한국어</option>
                            <option value="vi-VN">Vietnamese Tiếng Việt</option>
                            <option value="it-IT">Italian italiano</option>
                        </select>
                    </div>
                    <input type="hidden" value="" id="copy_link_value" />
                    <button type="submit" class="btn btn-primary" id="join_meeting">강의생성</button>
                    <button type="submit" class="btn btn-primary" id="clear_all">새로고침</button>
                    <button type="button" onclick="window.copyJoinLink('#copy_join_link')" class="btn btn-primary" id="copy_join_link">링크복사</button>

                </form>
            </div>
        </div>
    </nav>

    <script src="https://source.zoom.us/2.9.5/lib/vendor/react.min.js"></script>
    <script src="https://source.zoom.us/2.9.5/lib/vendor/react-dom.min.js"></script>
    <script src="https://source.zoom.us/2.9.5/lib/vendor/redux.min.js"></script>
    <script src="https://source.zoom.us/2.9.5/lib/vendor/redux-thunk.min.js"></script>
    <script src="https://source.zoom.us/2.9.5/lib/vendor/lodash.min.js"></script>
    <script src="https://source.zoom.us/zoom-meeting-2.9.5.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/zoom/tool.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/zoom/vconsole.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/zoom/index.js"></script>

    <script  type="text/javascript" charset="utf-8">
    	sessionStorage.setItem("contextpath", "${pageContext.request.contextPath}");
    	
    	
    	$(document).ready(function() {
    		$("#meeting_number").val("4862272535");
    		$("#meeting_pwd").val("R1NwTF");
    		$("#join_meeting").trigger("click");
   		});
    </script>
</body>

</html>