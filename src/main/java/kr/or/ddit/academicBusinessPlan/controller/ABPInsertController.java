package kr.or.ddit.academicBusinessPlan.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.academicBusinessPlan.service.ABPService;
import kr.or.ddit.academicBusinessPlan.vo.ABPVO;

@Controller
@RequestMapping("academicBusinessPlan/aBPInsert.do")
public class ABPInsertController {
	
	@Inject
	private ABPService aBPService;
	
	@ModelAttribute("aBPVO")
	public ABPVO aBPVO() {
		return new ABPVO();
	}

	@GetMapping
	public String gerHandler() {
		return "academicBusinessPlan/aBPForm";
	}
	
	@PostMapping
	public String postHandler(
			Model model
			, @ModelAttribute("aBPService") ABPVO aBPVO
			, Errors errors
	){
		String logicalViewName = null;
		if(!errors.hasErrors()) {
			boolean result = aBPService.createABP(aBPVO);
			if(result == true) {
				logicalViewName = "redirect:/academicBusinessPlan/aBPList.do";
			}else {
				model.addAttribute("message", "등록 중 문제 발생");
				logicalViewName = "academicBusinessPlan/aBPForm";
			}
		}else {
			logicalViewName = "academicBusinessPlan/aBPForm";
		}
		
		return logicalViewName;
	}
	
}
