package kr.or.ddit.academic.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.academic.service.AcademicNoticeService;
import kr.or.ddit.academic.vo.AcademicNoticeVO;

@Controller
@RequestMapping("academic/acaNoticeInsert.do")
public class AcademicNoticeInsertController {
	@Inject
	private AcademicNoticeService service;
	
	@ModelAttribute("acaNotice")
	public AcademicNoticeVO acaNotice() {
		return new AcademicNoticeVO();
	}
	
	@GetMapping
	public String getHandler() {
		return "academic/acaNoticeForm";
	}
	
	@PostMapping
	public String postHandler(
			Model model
			, @ModelAttribute("acaNotice") AcademicNoticeVO acaNotice
			, Errors errors
			, HttpSession session
	){
		
		String logicalViewName = null;
		if(!errors.hasErrors()) {
			String memName = (String)session.getAttribute("memName");
			acaNotice.setAnWriter(memName);
			
			boolean result = service.createAcademicNotice(acaNotice);
			if(result == true) {
				logicalViewName = "redirect:/academic/acaNoticeView.do?what=" + acaNotice.getAnNum();
			}else {
				model.addAttribute("message", "공지사항 등록 중 문제 발생");
				logicalViewName = "academic/acaNoticeForm";
			}
		}else {
			logicalViewName = "academic/acaNoticeForm";
		}
		
		return logicalViewName;
	}
	
}




