package kr.or.ddit.club.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.club.service.ClubService;
import kr.or.ddit.club.vo.ClubVO;
import lombok.extern.slf4j.Slf4j;

//학생이 신청한 동아리신청서 목록과 세부내용
@Controller
@Slf4j
public class StudenClubInsertRequestRetrieve {
	@Inject
	private ClubService service;
	
	
	
	
	/**
	 * 학생이 신청한 동아리 신청서 목록
	 * @param model
	 * @return
	 */
	@RequestMapping("/club/clubInsertRequestListView.do")
	public String clubRequestListView(
			Model model
			,Authentication authentication
			,RedirectAttributes redirectAttributes
			) {
	    // 메시지를 모델에 추가하여 뷰로 전달
		List<ClubVO> InsertRequest = service.insertSListClub(Integer.parseInt(authentication.getName()));//세션 id 값
		// RedirectAttributes를 통해 Flash 속성에서 데이터를 읽음
		redirectAttributes.getFlashAttributes().get("message");
		log.info("플레시 확인이요 : "+(String) redirectAttributes.getFlashAttributes().get("message"));
		model.addAttribute("club", InsertRequest);
		return "club/clubInsertRequestListView";
	}
	
	
	
	/**
	 * 학생이 신청한 동아리 신청서 세부정보
	 * @param clubCd
	 * @return
	 */
	@RequestMapping("/club/clubInsertRequestView.do")
	public ModelAndView clubRequestView(
			@RequestParam(name = "who", required = true) String clubCd
			, Authentication authentication
			)
	{
		ModelAndView mav =new ModelAndView();
		ClubVO InsertRequest = service.InsertViewClub(clubCd);
		ClubVO check = service.checkClub(Integer.parseInt(authentication.getName()));
		mav.addObject("club", InsertRequest);
		mav.setViewName("club/clubInsertView");
		return mav;
	}
	
}
