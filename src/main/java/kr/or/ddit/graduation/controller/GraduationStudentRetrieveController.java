package kr.or.ddit.graduation.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.enrollment.service.EnrollmentService;
import kr.or.ddit.enrollment.vo.EnrollmentVO;
import kr.or.ddit.graduation.service.GraduationService;
import kr.or.ddit.graduation.vo.GraduationVO;

@Controller
public class GraduationStudentRetrieveController {

	@Inject
	private GraduationService service;
	@Inject
	private EnrollmentService service2;
	
	@RequestMapping("/graduation/graduationStudentList.do")
	public String graduationlist(
		Authentication authentication
		, Model model
	){
		String stCd = authentication.getName();
		List<GraduationVO> graduationList = service.retrieveGraduationStudentList(stCd);
		GraduationVO graduation = service.retrieveGraduationStudentBelong(stCd);
		model.addAttribute("graduationList", graduationList);
		model.addAttribute("graduation", graduation);

		//총 이수 학점
		String totalLectCred = service2.retrieveTotalLecCred(stCd);
		System.out.println("총 이수 학점 : "+totalLectCred); // totalLectCred = 총 이수 학점
		
		//총 전공 이수 학점
		String totalMajorLectCred = service2.retrieveTotalMajorLecCred(stCd);
		System.out.println("총 전공 이수 학점 : "+totalMajorLectCred);
		
		//전체 평균 성적
		List<EnrollmentVO> avgGradeList = service2.retrieveAvgGrade(stCd);
		double dbTotalAvgGrade = 0.0;
		
		for(EnrollmentVO avgGrade : avgGradeList) {
			dbTotalAvgGrade += Double.parseDouble(avgGrade.getAvgGrade());
		}
		double average = (avgGradeList.size() > 0) ? dbTotalAvgGrade / avgGradeList.size() : 0.0;
		String totalAvgGrade = String.format("%.1f", average);
		System.out.println("전체 평균 성적 : "+totalAvgGrade); // totalAvgGrade = 전체 평균 성적
		
		//전체 전공 평균 성적
		List<EnrollmentVO> majorAvgGradeList = service2.retrieveMajorAvgGrade(stCd);
		double dbTotalMajorAvgGrade = 0.0;
		
		for (EnrollmentVO majorAvgGrade : majorAvgGradeList) {
		    String majorAvgGradeStr = majorAvgGrade.getMajorAvgGrade();
		    if (majorAvgGradeStr != null) {
		        dbTotalMajorAvgGrade += Double.parseDouble(majorAvgGradeStr);
		    }
		}
		
		double majorAverage = (majorAvgGradeList.size() > 0) ? dbTotalMajorAvgGrade / majorAvgGradeList.size() : 0.0;
		String totalMajorAvgGrade = String.format("%.1f", majorAverage);
		System.out.println("전체 전공 평균 성적 : "+totalMajorAvgGrade); // totalMajorAvgGrade = 전체 전공 평균 성적
		
		List<String> studentValues = new ArrayList<>();
		studentValues.add("72");
		studentValues.add(totalMajorLectCred);
		studentValues.add(totalMajorAvgGrade);
		studentValues.add(totalLectCred);
		studentValues.add(totalAvgGrade);
		model.addAttribute("studentValues", studentValues);
		
		return "graduation/graduationStudentList";
	}
	
	@RequestMapping("/graduation/studentView.do")
	public String getHandler(
		@RequestParam("who") String stCd
		, Model model
	){
		List<GraduationVO> graduationList = service.retrieveGraduationStudentList(stCd);
		GraduationVO graduation = service.retrieveGraduationStudentBelong(stCd);
		model.addAttribute("graduationList", graduationList);
		model.addAttribute("graduation", graduation);
		model.addAttribute("who", stCd);

		//총 이수 학점
		String totalLectCred = service2.retrieveTotalLecCred(stCd);
		System.out.println("총 이수 학점 : "+totalLectCred); // totalLectCred = 총 이수 학점
		
		//총 전공 이수 학점
		String totalMajorLectCred = service2.retrieveTotalMajorLecCred(stCd);
		System.out.println("총 전공 이수 학점 : "+totalMajorLectCred);
		
		//전체 평균 성적
		List<EnrollmentVO> avgGradeList = service2.retrieveAvgGrade(stCd);
		double dbTotalAvgGrade = 0.0;
		
		for(EnrollmentVO avgGrade : avgGradeList) {
			dbTotalAvgGrade += Double.parseDouble(avgGrade.getAvgGrade());
		}
		double average = (avgGradeList.size() > 0) ? dbTotalAvgGrade / avgGradeList.size() : 0.0;
		String totalAvgGrade = String.format("%.1f", average);
		System.out.println("전체 평균 성적 : "+totalAvgGrade); // totalAvgGrade = 전체 평균 성적
		
		//전체 전공 평균 성적
		List<EnrollmentVO> majorAvgGradeList = service2.retrieveMajorAvgGrade(stCd);
		double dbTotalMajorAvgGrade = 0.0;
		
		for (EnrollmentVO majorAvgGrade : majorAvgGradeList) {
		    String majorAvgGradeStr = majorAvgGrade.getMajorAvgGrade();
		    if (majorAvgGradeStr != null) {
		        dbTotalMajorAvgGrade += Double.parseDouble(majorAvgGradeStr);
		    }
		}
		
		double majorAverage = (majorAvgGradeList.size() > 0) ? dbTotalMajorAvgGrade / majorAvgGradeList.size() : 0.0;
		String totalMajorAvgGrade = String.format("%.1f", majorAverage);
		System.out.println("전체 전공 평균 성적 : "+totalMajorAvgGrade); // totalMajorAvgGrade = 전체 전공 평균 성적
		
		List<String> studentValues = new ArrayList<>();
		studentValues.add("72");
		studentValues.add(totalMajorLectCred);
		studentValues.add(totalMajorAvgGrade);
		studentValues.add(totalLectCred);
		studentValues.add(totalAvgGrade);
		model.addAttribute("studentValues", studentValues);
		
		return "graduation/graduationStudentList";
	}
	
	@RequestMapping("/graduation/studentGraduation.do")
	public String getHandler2(
		@RequestParam("who") String stCd
	) {
		service.graduationStudent(stCd);
		
		return "redirect:/graduation/studentFrameList.do";
	}
}
