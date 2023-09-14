package kr.or.ddit.lectureContents.exam.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.validate.InsertGroup;
import kr.or.ddit.lectureContents.exam.service.ExamService;
import kr.or.ddit.lectureContents.vo.ExamQuestionVO;
import kr.or.ddit.lectureContents.vo.ExamVO;
import kr.or.ddit.serviceresult.ServiceResult;

@Controller
@RequestMapping("/lecture")
public class ExamQueInsertController {
	@Inject
	ExamService service;
	
	@PostMapping(value="/examQueInsert.do", produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> examQuestionInsert(@Validated(InsertGroup.class) ExamQuestionVO examQue, Errors errors, String lecCd) {
		Map<String, Object> respMap = new HashMap<>();
		if(!errors.hasErrors()) {
			if(StringUtils.isBlank(examQue.getExamCd())) {
				ExamVO exam = new ExamVO();
				exam.setLecCd(lecCd);
				service.registerExam(exam);
				examQue.setExamCd(exam.getExamCd());
			}
			ServiceResult result = service.registerExamQue(examQue);
			switch(result) {
			case OK:
				respMap.put("result", "성공");
				respMap.put("examCd", examQue.getExamCd());
				respMap.put("eqCd", examQue.getEqCd());
				break;
			case FAIL:
				respMap.put("result", "실패");
			}
		}else {
			respMap.put("result", "실패");
		}
		return ResponseEntity.ok(respMap);
	}
	
	@PostMapping(value="/allExamQueInsert.do", produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> examQuestionsInsert(@Validated(InsertGroup.class) ExamVO exam, Errors errors, String lecCd) {
		Map<String, Object> respMap = new HashMap<>();
		List<String> eqCdList = new ArrayList<>();
		int score = 0;
		if(exam.getExamQueList().size()>0){
			List<ExamQuestionVO> examQueList = exam.getExamQueList();
			for(ExamQuestionVO examQue : examQueList) {
				score += examQue.getEqScore();
			}
			exam.setExamScore(score);
		}
		if(!errors.hasErrors()) {
			if(StringUtils.isBlank(exam.getExamCd())) {
				service.registerExam(exam);
				for(ExamQuestionVO examQue : exam.getExamQueList()) {
					examQue.setExamCd(exam.getExamCd());
				}
			}else {
				service.modifyExam(exam);
			}
			
			ServiceResult result = service.registerAllExamQue(exam.getExamQueList());
			for(ExamQuestionVO examQue : exam.getExamQueList()) {
				eqCdList.add(examQue.getEqCd());
			}
			switch(result) {
			case OK:
				respMap.put("result", "성공");
				respMap.put("eqCdList", eqCdList);
				break;
			case FAIL:
				respMap.put("result", "실패");
			}
		}else {
			respMap.put("result", "실패");
		}
		return ResponseEntity.ok(respMap);
	}

}
