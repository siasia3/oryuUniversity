package kr.or.ddit.clubMember.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.clubMember.service.ClubMemberService;

@Controller
public class ClubMemberHeadUpdate {

//	@Inject
//	private ClubMemberService service;
//	
//	@RequestMapping("/clubMember/HeadUpdate.do")
//	public String HeadDown(
//			@RequestParam (name="stCd1") String stCd1
//			,@RequestParam (name="stCd2") String stCd2
//			,Model model
//			) {
//		int success = service.clubHeadUpdate(stCd1,stCd2);
//		if(success > 0 )
//		{
//			String message = "부장 교체 성공";
//			model.addAttribute("message", message);
//			return "redirect:/club/clubListView.do";
//		}else {
//				String message = "부장 교체 실패";
//				model.addAttribute("message", message);
//				return "redirect:/club/clubListView.do";
//		}
//		
//		
//	}
	
	
	
}
