
package kr.or.ddit.lecture.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.college.dao.CollegeDAO;
import kr.or.ddit.college.vo.CollegeVO;
import kr.or.ddit.common.dao.CommonDAO;
import kr.or.ddit.common.vo.ClassificationVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.common.vo.SimpleCondition;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.lecture.service.LectureService;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.subject.dao.SubjectDAO;
import kr.or.ddit.subject.vo.SubjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lecture")
public class LectureRetrieveController {
	
	@Inject
	private LectureService service;
	@Inject
	private CollegeDAO collegeDAO;
	@Inject
	private DepartmentDAO departmentDAO;
	@Inject
	private CommonDAO commonDAO;
	
	@ModelAttribute("collegeList")
	public List<CollegeVO> collegeList(){
		return collegeDAO.selectCollegeList();
	}
	@ModelAttribute("departmentList")
	public List<DepartmentVO> departmentList(){
		List<DepartmentVO> dList = departmentDAO.selectDepartmentList();
		return dList;
	}
	@ModelAttribute("classificationList")
	public List<ClassificationVO> classificationList(){
		return commonDAO.selectClassificationList();
	}
	
	// 교직원 강의 목록
	@RequestMapping("mngLectureList.do")
	public void mngLectureList(
			@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, @RequestParam Map<String,Object> detailCondition
			, Model model
	) {
		
		PaginationInfo<LectureVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		// 수강,휴강 선택 출력 조건
		detailCondition.put("STAND", "STAND");
		paging.setDetailCondition(detailCondition);
		
		List<LectureVO> lectureList = service.retrieveLectureList(paging);
		paging.setDataList(lectureList);
		
		model.addAttribute("paging", paging);
		model.addAttribute("detail",detailCondition);
	}
	// 교직원 강의 요청목록
	@RequestMapping("mngLectureListReq.do")
	public void mnglectureListReq(
			@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, @RequestParam Map<String,Object> detailCondition
			, Model model
	) {
		PaginationInfo<LectureVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		// 요청,거절 선택 출력 조건 
		detailCondition.put("REQ", "REQ");
		paging.setDetailCondition(detailCondition);
		     
		List<LectureVO> lectureList = service.retrieveLectureList(paging);
		paging.setDataList(lectureList);
		
		model.addAttribute("paging", paging);
		model.addAttribute("detail",detailCondition);
	}
	// 교수 본인 강의 목록
	@RequestMapping("prfLectureList.do")
	public void prfLectureList(
			@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, @RequestParam Map<String,Object> detailCondition
			, Model model
			, Authentication authentication
	) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String prCd = userDetails.getUsername();
		PaginationInfo<LectureVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		
		// 수강,휴강 선택 및 본인 강의 출력 조건
		detailCondition.put("STAND", "STAND");
		detailCondition.put("prCd", prCd);
		paging.setDetailCondition(detailCondition);
	
		List<LectureVO> lectureList = service.retrieveLectureList(paging);
		paging.setDataList(lectureList);
		
		model.addAttribute("paging", paging);
		model.addAttribute("detail",detailCondition);
	}
	// 교수 본인 요청 강의 목록
	@RequestMapping("prfLectureListReq.do")
	public void prfLectureListReq(
			@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, @RequestParam Map<String,Object> detailCondition
			, Model model
			, Authentication authentication
	) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String prCd = userDetails.getUsername();
		PaginationInfo<LectureVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		// 요청,거절 선택 및 본인 강의 출력 조건
		detailCondition.put("REQ", "4");
		detailCondition.put("prCd", prCd);
		paging.setDetailCondition(detailCondition);
	
		List<LectureVO> lectureList = service.retrieveLectureList(paging);
		paging.setDataList(lectureList);
		
		model.addAttribute("paging", paging);
		model.addAttribute("detail",detailCondition);
	}
	// 학생 전체 강의 목록
	@RequestMapping("stuLectureList.do")
	public void stuLectureList(
			@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, @RequestParam Map<String,Object> detailCondition
			, Model model
			, Authentication authentication
	) {
		PaginationInfo<LectureVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		// 수강등록된강의 선택 출력 조건
		detailCondition.put("lecStat", "1");
		paging.setDetailCondition(detailCondition);
	
		List<LectureVO> lectureList = service.retrieveLectureList(paging);
		paging.setDataList(lectureList);
		
		model.addAttribute("paging", paging);
		model.addAttribute("detail",detailCondition);
	}

}
