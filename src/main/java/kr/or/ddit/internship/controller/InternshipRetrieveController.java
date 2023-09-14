package kr.or.ddit.internship.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.academicChange.vo.AcademicChangeVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.common.vo.SimpleCondition;
import kr.or.ddit.internship.service.InternshipService;
import kr.or.ddit.internship.vo.InternshipVO;

@Controller
public class InternshipRetrieveController {

	@Inject
	private  InternshipService service;
	
	@RequestMapping("/internship/internshipList.do")
	public String internshipList(
			@RequestParam(name = "page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, Model model
			) {
		
		PaginationInfo<InternshipVO> paging = new PaginationInfo<>();
		
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		
		List<InternshipVO> internList = service.internshipList(paging);
		paging.setDataList(internList);
		
		model.addAttribute("paging", paging);
		
		// 총 레코드 수 조회
        long totalRecord = service.getTotalRecordCount(paging);
        model.addAttribute("totalRecord", totalRecord);
		
		
		return "internship/internList";
	}
	
	@RequestMapping("/internship/internshipView.do")
	public String internshipView(
			@RequestParam(name="what", required = true)String inteCd
			,Model model
			) {
		InternshipVO result = service.internshipView(inteCd);
		model.addAttribute("intern",result);
		
		return "internship/internView";
	}
	
}


