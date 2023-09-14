package kr.or.ddit.graduation.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.college.vo.CollegeVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.common.vo.SimpleCondition;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.graduation.service.GraduationService;
import kr.or.ddit.graduation.vo.GraduationVO;
import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.validate.groups.UpdateGroup;

@Controller
public class GraduationRetrieveController {

	@Inject
	private GraduationService service;
	@Inject
	private StudentService stService;
	@Inject
	private DepartmentDAO departmentDAO;
	
	@ModelAttribute("graduation")
	public GraduationVO graduation() {
		return new GraduationVO();
	}
	@ModelAttribute("departmentList")
	public List<DepartmentVO> departmentList(){
		List<DepartmentVO> dList = departmentDAO.selectDepartmentList();
		return dList;
	}
	
	@RequestMapping(value="/graduation/changeCond.do", produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
	@ResponseBody
	public List<GraduationVO> getHandler (
		@RequestParam String colgeCd
	) {
		List<GraduationVO> gradCondList = service.changeGraduationCond(colgeCd);
		return gradCondList;
	}
	
	@RequestMapping("/graduation/graduationList.do")
	public String getHandler(Model model) {
		
		List<GraduationVO> graduationTypeList = service.retrieveGraduationTypeList();
		List<CollegeVO> collegeTypeList = service.retrieveCollegeTypeList();
		List<GraduationVO> graduationConditionList = service.retrieveGraduationConditionList();

		model.addAttribute("graduationTypeList", graduationTypeList);
		model.addAttribute("collegeTypeList", collegeTypeList);
		model.addAttribute("graduationConditionList", graduationConditionList);
		
		return "graduation/graduationList";
	}
	
	// 학생목록 껍데기 페이지를 로딩
	@RequestMapping("/graduation/studentFrameList.do")
	public String enrollmentList(
		@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
		, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
		, @RequestParam Map<String,Object> detailCondition
		, Model model
	) {
		return "graduation/graduationStaffList";
	}
	
	@RequestMapping("/graduation/studentList.do")
	public String getHandler2(
		@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
		, SimpleCondition simpleCondition
		, @RequestParam Map<String,Object> detailCondition
		, Model model
	){
		PaginationInfo<StudentVO> paging = new PaginationInfo<>(10, 5);
		paging.setSimpleCondition(simpleCondition);
		paging.setCurrentPage(currentPage);
		paging.setDetailCondition(detailCondition);
		
		List<StudentVO> studentList = stService.retrieveStudentListAsc(paging);
		paging.setDataList(studentList);
		
		model.addAttribute("paging", paging);
		
		return "graduation/ajax/graduationStaffList2";
	}
	
	@PostMapping("/graduation/updateGraduation.do")
	public String postHandler(
		@Validated(UpdateGroup.class) @ModelAttribute("graduation") GraduationVO graduation
		, Errors errors
		, Model model
	){
		String gradCondType = graduation.getGeGradCondType();
		String gradCond = graduation.getGradCond();
		String colgeCd = graduation.getColgeCd();
		
		String[] gradCondTypeList = gradCondType.split(",");
		String[] gradCondList = gradCond.split(",");
		
		if(!errors.hasErrors() && gradCondList.length != 0) {
			
			for (int i = 0; i < gradCondTypeList.length; i++) {
				String condType = gradCondTypeList[i];
				String cond = gradCondList[i];
				
				GraduationVO gradVO = new GraduationVO();
				gradVO.setGeGradCondType(condType);
				gradVO.setGradCond(cond);
				gradVO.setColgeCd(colgeCd);
				
				service.modifyGraduation(gradVO);
			}
		}
			return "redirect:/graduation/graduationList.do";
	}
	
	@PostMapping("/graduation/insertGraduation.do")
	public String postHandler2(
		@ModelAttribute("graduation") GraduationVO graduation
		, Errors errors
		, Model model
	){
		String gradCondType = graduation.getGeGradCondType();
		String gradCond = graduation.getGradCond();
		String colgeCd = graduation.getColgeCd();
		
		String[] colgeCdList = colgeCd.split(",");
		String[] gradCondList = gradCond.split(",");
		
		if(!errors.hasErrors() && gradCondList.length != 0) {
			
			for(int i = 0; i < colgeCdList.length; i++) {
				String colCd = colgeCdList[i];
				String cond = gradCondList[i];
				
				GraduationVO gradVO = new GraduationVO();
				gradVO.setGeGradCondType(gradCondType);
				gradVO.setColgeCd(colCd);
				gradVO.setGradCond(cond);
				
				service.createGraduation(gradVO);
			}
		}
		return "redirect:/graduation/graduationList.do";
	}
	
	@RequestMapping("/graduation/deleteGraduation.do")
	public String postHandler3(
		@ModelAttribute("geGradCondType") String geGradCondType
		, Errors errors
		, Model model
	){
		if(!errors.hasErrors()) {
			service.removeGraduation(geGradCondType);
		}
		return "redirect:/graduation/graduationList.do";
	}
	
}
