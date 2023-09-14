package kr.or.ddit.enrollment.controller;

import java.time.LocalDate;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.college.dao.CollegeDAO;
import kr.or.ddit.college.vo.CollegeVO;
import kr.or.ddit.common.dao.CommonDAO;
import kr.or.ddit.common.vo.ClassificationVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.common.vo.SimpleCondition;
import kr.or.ddit.department.dao.DepartmentDAO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.enrollment.dao.EnrollmentDAO;
import kr.or.ddit.enrollment.service.EnrollmentService;
import kr.or.ddit.enrollment.vo.EnrollmentVO;
import kr.or.ddit.lecture.service.LectureService;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.schedule.vo.AcademicScheduleVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/enrollment")
public class EnrollmentRetrieveController {
	
	private static final LocalDate SystemClock = null;
	@Inject
	private LectureService lService;
	@Inject
	private EnrollmentService eService;
	
	@Inject
	private CollegeDAO collegeDAO;
	@Inject
	private DepartmentDAO departmentDAO;
	@Inject
	private CommonDAO commonDAO;
	@Inject
	private EnrollmentDAO enrollmentDAO;
	
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
	
	// 수강목록 껍데기 페이지를 로딩
	@RequestMapping("stuEnrollmentList.do")
	public void enrollmentList(
		@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
		, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
		, @RequestParam Map<String,Object> detailCondition
		, Model model
	) {

	}
	// 강의 목록 부분 출력
	@RequestMapping("lectureList.do")
	public String lectureList(
			@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, @RequestParam Map<String,Object> detailCondition
			, Model model
			
			) {
		PaginationInfo<LectureVO> paging = new PaginationInfo<>();
		paging.setScreenSize(30);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		detailCondition.put("lecStat", "1");
		detailCondition.put("lecSeme", "2");
		paging.setDetailCondition(detailCondition);
		paging.setScreenSize(10);
		
		List<LectureVO> lectureList = lService.retrieveLectureList(paging);
		paging.setDataList(lectureList);
		
		model.addAttribute("paging", paging);
		
		return "enrollment/ajax/stuLecture";
	}
	// 수강신청한 목록 부분 출력
	@GetMapping("fetchEnrollments.do")
	public String fetchEnrollmentsHtml2(
		Model model
		,Authentication authentication
	) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		String stCd = userDetails.getUsername();
	    List<EnrollmentVO> enrollmentList = enrollmentDAO.selectMyEnrollmentList(stCd);
		model.addAttribute("enrollmentList",enrollmentList);
		return "enrollment/ajax/stuEnrollment";
	}
	
	// 수강신청목록 전체 출력 (교직원)
	@RequestMapping("mngEnrollmentList.do")
	public void mngEnrollmentList(
			@RequestParam(name="page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, @RequestParam Map<String,Object> detailCondition
			, Model model
			
			) {
		PaginationInfo<EnrollmentVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		paging.setDetailCondition(detailCondition);
		
		List<EnrollmentVO> enrollmentList = eService.retrieveEnrollmentList(paging);
		paging.setDataList(enrollmentList);
		
		model.addAttribute("paging", paging);
		
	}
	
	@GetMapping("/check.do")
	@ResponseBody
	public String getMessageCount(
	) {
		String result = "fail";
		AcademicScheduleVO schedule = commonDAO.selectSchedule();
		LocalDate startTime = schedule.getAsStart();
		LocalDate endTime = schedule.getAsEnd();
		LocalDate now = LocalDate.now();
		
		log.info("Start!!!!!!!!!!!!!!!!!!!!!!!!"+startTime);
		log.info("end!!!!!!!!!!!!!!!!!!!!!!!!"+endTime);
		log.info("now!!!!!!!!!!!!!!!!!!!!!!!!"+now);
	    if (now.isEqual(startTime) || (now.isAfter(startTime) && now.isEqual(endTime)) || now.isBefore(endTime)) {
	        result = "success";
	    }
		return result;
    }
}
