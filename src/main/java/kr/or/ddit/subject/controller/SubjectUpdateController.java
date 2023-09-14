package kr.or.ddit.subject.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.college.dao.CollegeDAO;
import kr.or.ddit.college.vo.CollegeVO;
import kr.or.ddit.common.dao.CommonDAO;
import kr.or.ddit.common.validate.UpdateGroup;
import kr.or.ddit.common.vo.ClassificationVO;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.serviceresult.ServiceResult;
import kr.or.ddit.subject.service.SubjectService;
import kr.or.ddit.subject.vo.SubjectVO;

@Controller
@RequestMapping("/subject/")
public class SubjectUpdateController {
	
	@Inject
	private SubjectService service;
	@Inject 
	private DepartmentDAO departmentDAO;
	@Inject
	private CommonDAO commonDAO;
	@Inject
	private CollegeDAO collegeDAO;
	
	@ModelAttribute("departmentList")
	public List<DepartmentVO> departmentList(){
		return departmentDAO.selectDepartmentList();
	}
	@ModelAttribute("classificationList")
	public List<ClassificationVO> classificationList(){
		return commonDAO.selectClassificationList();
	}
	@ModelAttribute("collegeList")
	public List<CollegeVO> collegeList(){
		return collegeDAO.selectCollegeList();
	}
	
	
	
	@GetMapping("subjectUpdate.do")
	public String sujectForm(
			@RequestParam String subjCd
			, Model model
	) {
		SubjectVO subject = service.retrieveSubject(subjCd);
		model.addAttribute("subject",subject);
		return "subject/ajax/subjectForm";
	}
	
	@PostMapping(value = "subjectUpdate.do", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String subjectUpdate(
		@RequestBody SubjectVO subject
		, Errors errors
		, Model model
			
	) {
		int count = 0;
		String result = null;
		String name = subject.getSubjNm();
		count = service.modifySubject(subject);
		if(count>0) {
			result= name + "과목 수정 완료";
		}else {
			result= name + "과목 수정 실패, 다시 진행해주세요.";
		}  
		return result;
	}
		
}
	

