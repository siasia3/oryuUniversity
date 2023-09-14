package kr.or.ddit.lectureContents.attendance.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.lectureContents.attendance.service.AttendanceService;
import kr.or.ddit.lectureContents.vo.AttendanceVO;
import kr.or.ddit.lectureSchedule.service.LectureScheduleService;
import kr.or.ddit.lectureSchedule.vo.LectureScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AttendanceScoreUpdateController {
   
   @Inject
   private AttendanceService service;
   @Inject
   LectureScheduleService lecScheService;
   
   @PostMapping("/lecture/attendScoreUpdate.do")
   @ResponseBody
   public Map<String, Object> attendanceScore(
           @RequestBody List<Map<String, Integer>> scoreInfoList,
           String lecCd,
           String stCd,
           HttpSession session
   ) {
       Map<String, Object> resultMap = new HashMap<>();
       List<Map<String, Integer>> resultMapList = new ArrayList<>();

       session.removeAttribute("lecCd");
       session.setAttribute("lecCd", lecCd);

       lecCd = scoreInfoList.get(0).get("lecCd").toString();
       

       for (Map<String, Integer> scoreInfo : scoreInfoList) {
           Integer absenceInput = scoreInfo.get("absence");
           Integer scoreInput = scoreInfo.get("score");

           Map<String, Integer> attendanceInfo = new HashMap<>();
           attendanceInfo.put("absenceInput", absenceInput);
           attendanceInfo.put("scoreInput", scoreInput);

           boolean result = service.modifyAttendScore(lecCd, absenceInput, scoreInput);
           if (result) {
               resultMapList.add(attendanceInfo);
           } else {
               Map<String, Integer> response = new HashMap<>();
               response.put("message", 0);
               resultMapList.add(response);
           }
       }

       resultMap.put("resultMapList", resultMapList);
       
       List<AttendanceVO> attendScoreList = service.retrieveAttendScore(lecCd);
       Map<String, Integer> attendScoreMap = new HashMap<>();
       for (AttendanceVO attend : attendScoreList) {
           stCd = attend.getStCd();
           service.modifyFinalAttend(lecCd, stCd);
           Integer atteScore = attend.getAtteScore();
           attendScoreMap.put(stCd, atteScore);
       }
       
       resultMap.put("attendScoreList", attendScoreMap);
       
       return resultMap;

   }
   
}