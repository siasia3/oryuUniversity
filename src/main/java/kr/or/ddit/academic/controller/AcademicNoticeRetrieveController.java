package kr.or.ddit.academic.controller;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.academic.service.AcademicNoticeService;
import kr.or.ddit.academic.vo.AcademicNoticeVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.common.vo.SimpleCondition;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/academic")
public class AcademicNoticeRetrieveController {
	private final AcademicNoticeService service;
	
	// 로그인한 사용자의 권한 리턴
	private String getUserRole(Authentication authentication) {
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
		String role = "";
		for(GrantedAuthority authority : authorities) {
			role = authority.getAuthority();
		}
		return role;
	}
	
	@RequestMapping("acaNoticeList.do")
	public void acaNoticeList(
			@RequestParam(name = "page", required = false, defaultValue = "1") long currentPage
			, @ModelAttribute("simpleCondition") SimpleCondition simpleCondition
			, Model model
			, Authentication authentication
			, @RequestParam Map<String, Object> detailCondition
	) {
		String role = getUserRole(authentication);
		detailCondition.put("role", role);

		PaginationInfo<AcademicNoticeVO> paging = new PaginationInfo<>();
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		paging.setDetailCondition(detailCondition);
		
		List<AcademicNoticeVO> acaNoticeList = service.retrieveAcademicNoticeList(paging);
		paging.setDataList(acaNoticeList);
		
		model.addAttribute("paging", paging);
		
		// 총 레코드 수 조회
        long totalRecord = service.getTotalRecordCount(paging);
        model.addAttribute("totalRecord", totalRecord);
	}
	
	@RequestMapping("acaNoticeView.do")
	public void acaNoticeView(
			@RequestParam("what") int anNum
			, Model model
			, Authentication authentication
	) {
		String role = getUserRole(authentication);
		model.addAttribute("role", role);
		
		service.increaseViews(anNum);
		
		AcademicNoticeVO acaNotice = service.retrieveAcademicNotice(anNum);
		model.addAttribute("acaNotice", acaNotice);
	}
}
