package kr.or.ddit.tuition.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.tuition.service.TuitionService;
import kr.or.ddit.tuition.vo.TuitionVO;

@Controller
@RequestMapping("/tuition/studentScholarshipApply.do")
public class ScholarshipRetrieveController {
	
	@Inject
	private TuitionService service;
	
	@ModelAttribute("tuition")
	public TuitionVO tuition() {
		return new TuitionVO();
	}
	
	@GetMapping
	public String getHandler(
		Authentication authentication
		, Model model
	){
		String stCd = authentication.getName();
		List<TuitionVO> tuitionList = service.retrieveStudentApplyScholarship(stCd);
		List<TuitionVO> tuitionList2 = service.retrieveStudentTuition(stCd);
		model.addAttribute("tuitionList", tuitionList);
		model.addAttribute("tuitionList2", tuitionList2);
		
		return "tuition/studentScholarshipApply";
	}

	@PostMapping
	public String postHandler(
		@ModelAttribute("tuition") TuitionVO tuition
		, Model model
	){
		service.applyScholarship(tuition);
		
		List<TuitionVO> tuitionList = service.retrieveStudentApplyScholarship(tuition.getStCd());
		List<TuitionVO> tuitionList2 = service.retrieveStudentTuition(tuition.getStCd());
		model.addAttribute("tuitionList", tuitionList);
		model.addAttribute("tuitionList2", tuitionList2);
		return "tuition/studentScholarshipApply";
	}
	
}
