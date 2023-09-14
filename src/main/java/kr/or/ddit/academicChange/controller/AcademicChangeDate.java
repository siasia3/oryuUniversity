package kr.or.ddit.academicChange.controller;

import java.time.LocalDate;
import java.time.Month;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.academicChange.vo.AcademicChangeVO;
import kr.or.ddit.student.service.StudentService;
import kr.or.ddit.student.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/academicChange/dateCalculate.do")
public class AcademicChangeDate {
	@Inject
	private StudentService stuService;
	
	@GetMapping
	public String dateCalculate(
			@RequestParam(name="acChDate") int acChDate
			,Model model
			, Authentication principal
			) {
		
		AcademicChangeVO acCh = new AcademicChangeVO();
		LocalDate currentDate = LocalDate.now();
        Month currentMonth = currentDate.getMonth();
        int currentYear = currentDate.getYear();
        
        
		if(acChDate == 1)
		{
			if(3>currentMonth.getValue()) { // 3월 전 
				acCh.setAcChStaLea(LocalDate.of(currentYear, 3, 1)); // 요번년 3월 1일 부터
				acCh.setAcChEndLea(LocalDate.of(currentYear, 9, 1)); // 요번년 9월 1일 까지
				log.info("1번 오늘 몇월인가? "+currentMonth.getValue());
																	
			}else if(currentMonth.getValue()>3 && currentMonth.getValue()<9) {	// 요번 년 3월 이후부터 요번년 9월 1일 전까지
				acCh.setAcChStaLea(LocalDate.of(currentYear, 9, 1)); //요번년 9월 1일 부터
				acCh.setAcChEndLea(LocalDate.of(currentYear+1, 3, 1)); // 다음년 3월 1일 까지
				log.info("2번 오늘 몇월인가? "+currentMonth.getValue());
			}else { 													// 만약 9월 이후에 신청할시
				acCh.setAcChStaLea(LocalDate.of(currentYear+1, 3, 1)); // 다음년 3월 1일 부터
				acCh.setAcChEndLea(LocalDate.of(currentYear+1, 9, 1)); // 다음년 9월 1일 까지
				log.info("3번 오늘 몇월인가? "+currentMonth.getValue());
			}
		}else if(acChDate == 2) {
			if(3>currentMonth.getValue()) {
				acCh.setAcChStaLea(LocalDate.of(currentYear, 3, 1));
				acCh.setAcChEndLea(LocalDate.of(currentYear+1, 3, 1));
			}else if(currentMonth.getValue()>3 && currentMonth.getValue()<9) {
				acCh.setAcChStaLea(LocalDate.of(currentYear, 9, 1)); 
				acCh.setAcChEndLea(LocalDate.of(currentYear+1, 9, 1));
			}else { 													
				acCh.setAcChStaLea(LocalDate.of(currentYear+1, 3, 1)); 
				acCh.setAcChEndLea(LocalDate.of(currentYear+2, 3, 1)); 
			}
		}else if(acChDate == 3) {
			if(3>currentMonth.getValue()) {
				acCh.setAcChStaLea(LocalDate.of(currentYear, 3, 1));
				acCh.setAcChEndLea(LocalDate.of(currentYear+1, 9, 1));
			}else if(currentMonth.getValue()>3 && currentMonth.getValue()<9) {
				acCh.setAcChStaLea(LocalDate.of(currentYear, 9, 1)); 
				acCh.setAcChEndLea(LocalDate.of(currentYear+2, 3, 1));
			}else { 												
				acCh.setAcChStaLea(LocalDate.of(currentYear+1, 3, 1));  
				acCh.setAcChEndLea(LocalDate.of(currentYear+2, 9, 1)); 
			}
		}else if(acChDate == 4) {
			if(3>currentMonth.getValue()) {
				acCh.setAcChStaLea(LocalDate.of(currentYear, 3, 1));
				acCh.setAcChEndLea(LocalDate.of(currentYear+2, 3, 1));
			}else if(currentMonth.getValue()>3 && currentMonth.getValue()<9) {
				acCh.setAcChStaLea(LocalDate.of(currentYear, 9, 1)); 
				acCh.setAcChEndLea(LocalDate.of(currentYear+2, 9, 1));
			}else { 												
				acCh.setAcChStaLea(LocalDate.of(currentYear+1, 3, 1));  
				acCh.setAcChEndLea(LocalDate.of(currentYear+3, 3, 1)); 
			}
		}
		StudentVO info = new StudentVO();
		info = stuService.retrieveStudent(principal.getName());
		model.addAttribute("info", info);
			model.addAttribute("change", acCh);
		
			return "academicChange/acaChangeReqForm";
	}
	
	
}
