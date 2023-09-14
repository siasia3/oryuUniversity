package kr.or.ddit.lecture.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.lecture.service.NoticeService;
import kr.or.ddit.lecture.vo.NoticeVO;

@Controller
@RequestMapping("lecture/noticeInsert.do")
public class NoticeInsertController {
	@Inject
	private NoticeService service;
	
	@ModelAttribute("notice")
	public NoticeVO notice() {
		return new NoticeVO();
	}
	
	@GetMapping
	public String getHandler() {
		return "lecture/notice/noticeForm";
	}
	
	@PostMapping
	public String postHandler(
			Model model
			, @ModelAttribute("notice") NoticeVO notice
			, Errors errors
			, HttpSession session
	) {
		String logicalViewName = null;
		if(!errors.hasErrors()) {
			
			notice.setLecCd((String)session.getAttribute("lecCd"));
			
			boolean result = service.createNotice(notice);
			if(result == true) {
				logicalViewName = "redirect:/lecture/noticeList.do?lecCd=" + notice.getLecCd();
			}else {
				model.addAttribute("message", "강의 공지 등록 중 문제 발생");
				logicalViewName = "lecture/notice/noticeForm";
			}
		}else {
			logicalViewName = "lecture/notice/noticeForm";
		}
		
		return logicalViewName;
	}
	
}

