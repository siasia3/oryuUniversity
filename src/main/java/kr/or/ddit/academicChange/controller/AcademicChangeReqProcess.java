package kr.or.ddit.academicChange.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.academicChange.service.AcademicChangeService;
import lombok.extern.slf4j.Slf4j;

@Controller
public class AcademicChangeReqProcess {
	@Inject
	private AcademicChangeService service;
	
	@RequestMapping("/academicChange/requestProcessPass.do")
	public String acaChangeProcess(
			//jsp에서 받아온 데이터
	@RequestParam(name="what") String acChCd 
	,@RequestParam(name="process") String acChSta
	,@RequestParam(name="who") String stCd
	,@RequestParam(name="div") String div
	,Model model
	,RedirectAttributes redirectAttributes
	)
	{
		String logicalViewName = null;
		// 받아온 학적변동 코드와 jsp에서 받아온 acChsta의 데이터를 업데이트문을 통해 상태값을 변경시킨다.
			boolean result = service.updateAcademicChange(acChCd,acChSta);
			if(result == true) {
				if(acChSta.equals("승인"))
				{
					boolean studentUpdate=service.updateStudentStatus(stCd, div);
					if(studentUpdate==true) {
						logicalViewName = "redirect:/academicChange/acaChangeStaffList.do";
					}
					else {
						model.addAttribute("message", "서버 오류, 잠시 뒤 다시 시도하세요");
						logicalViewName = "/academicChange/acaChangeView.do?what="+acChCd;
					}
				}
			}else {
				model.addAttribute("message", "서버 오류, 잠시 뒤 다시 시도하세요");
				logicalViewName = "/academicChange/acaChangeView.do?what="+acChCd;
			}
		
		
		return logicalViewName;
	}
	
	
	@RequestMapping("/academicChange/requestProcessNoPass.do")
	public String acaChangeProcessNoPass(
			@RequestParam(name="what") String acChCd
			,@RequestParam(name="process") String acChSta
			,Model model
)
	{
		String logicalViewName = null;
		boolean result = service.updateAcademicChange(acChCd,acChSta);
		if(result == true) {
			logicalViewName = "redirect:/academicChange/acaChangeStaffList.do";
		}else {
			model.addAttribute("message", "서버 오류, 잠시 뒤 다시 시도하세요");
			logicalViewName = "acaNoticeView.do?what="+acChCd;
		}
		return logicalViewName;
	}
}
