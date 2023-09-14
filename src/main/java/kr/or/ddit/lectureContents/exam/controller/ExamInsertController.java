
package kr.or.ddit.lectureContents.exam.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.validate.InsertGroup;
import kr.or.ddit.lectureContents.exam.service.ExamService;
import kr.or.ddit.lectureContents.vo.ExamQuestionVO;
import kr.or.ddit.lectureContents.vo.ExamVO;
import kr.or.ddit.serviceresult.ServiceResult;

@Controller
@RequestMapping("/lecture/examInsert.do")
public class ExamInsertController {
	
	@Inject
	ExamService service;
	
	@ModelAttribute("exam")
	public ExamVO exam(String examCd, String lecture, String type) {
		ExamVO exam = new ExamVO();
		List<ExamQuestionVO> examQueList = new ArrayList<ExamQuestionVO>();
		exam.setLecCd(lecture);
		exam.setExamType(type);
		if(!StringUtils.isBlank(examCd)) {
			exam = service.retrieveExamDetail(examCd);
			examQueList = service.retrieveExamQuestionList(examCd);
			
		}
		if(!(examQueList.size() > 0)){
			ExamQuestionVO examQue = new ExamQuestionVO();
			examQue.setExamCd(examCd);
			examQue.setEqType("객관식");
			examQueList.add(examQue);
		}
		Collections.sort(examQueList);
		exam.setExamQueList(examQueList);
		return exam;
	}
	@GetMapping
	public String examForm() {
		return "lecture/exam/examForm2";
	}
	@PostMapping(produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> examRegist(@Validated(InsertGroup.class) ExamVO exam, Errors errors) {
		Map<String, Object> respMap = new HashMap<>();
		if(!errors.hasErrors()) {
			ServiceResult result = service.registerExam(exam);
			switch(result) {
			case OK:
				respMap.put("examCd",exam.getExamCd());
				respMap.put("result", "성공");
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
