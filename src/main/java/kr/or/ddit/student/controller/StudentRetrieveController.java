package kr.or.ddit.student.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.college.dao.CollegeDAO;
import kr.or.ddit.college.vo.CollegeVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.common.vo.SimpleCondition;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class StudentRetrieveController {

	@Inject
	private StudentService service;
	@Inject
	private CollegeDAO collegeDAO;
	@Inject
	private DepartmentDAO departmentDAO;
	
	@ModelAttribute("collegeList")
	public List<CollegeVO> collegeList(){
		return collegeDAO.selectCollegeList();
	}
	@ModelAttribute("departmentList")
	public List<DepartmentVO> departmentList(){
		List<DepartmentVO> dList = departmentDAO.selectDepartmentList();
		return dList;
	}
	
	// 학생목록 껍데기 페이지를 로딩
	@RequestMapping("/student/studentFrameList.do")
	public String enrollmentList(
		@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
		, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
		, @RequestParam Map<String,Object> detailCondition
		, Model model
	) {
		return "student/studentList";
	}
	
	@RequestMapping("/student/studentList.do")
	public String studentlist(
		@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
		, SimpleCondition simpleCondition
		, @RequestParam Map<String,Object> detailCondition
		, Model model
	){
		PaginationInfo<StudentVO> paging = new PaginationInfo<>(10, 5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		
		log.info("map : " + detailCondition+"=================================================================================================");
		
		List<StudentVO> studentList = service.retrieveStudentList(paging);
		paging.setDataList(studentList);
		
		model.addAttribute("paging", paging);
		
		return "student/ajax/studentList2";
		
	}
	
	@RequestMapping("/student/studentView.do")
	public String studentView(
		@RequestParam(name="who") String stCd
		, Model model
	){
		StudentVO student = service.retrieveStudent(stCd);
		model.addAttribute("student", student);
		
		return "student/studentView";
	}

	
}
