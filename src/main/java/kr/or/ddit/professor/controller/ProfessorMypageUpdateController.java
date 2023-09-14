package kr.or.ddit.professor.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.professor.service.ProfessorService;
import kr.or.ddit.professor.vo.ProfessorVO;
import kr.or.ddit.serviceresult.ServiceResult;
import kr.or.ddit.student.dao.OthersDAO;
import kr.or.ddit.validate.groups.UpdateGroup;

@Controller
public class ProfessorMypageUpdateController {

	@Inject
	private ProfessorService service;
	@Inject
	private OthersDAO othersDAO;
	@Inject
	private PasswordEncoder encoder;
	
	@ModelAttribute("departmentList")
	public List<DepartmentVO> departmentList() {
		return othersDAO.selectDepartmentList();
	}

	@PostMapping("/mypage/professorUpdateCheck.do")
	public String updateCheck(
		@RequestParam("who") String prCd
		, @RequestParam("password") String password
		, Model model
	){
		ProfessorVO professor = service.retrieveProfessor(prCd);
		String originPass = professor.getPrPass();
		
		model.addAttribute("professor", professor);
		
		if(encoder.matches(password, originPass)) {
			model.addAttribute("result", "일치");
		}else {
			model.addAttribute("result", "불일치");
		}
		return "jsonView";
	}
	
	@GetMapping("/mypage/professorMypageEdit.do")
	public String goProfessorMypageEdit(
		@RequestParam("who") String prCd
		, Model model
	){
		ProfessorVO professor = service.retrieveProfessor(prCd);
		model.addAttribute("professor", professor);
		
		return "professor/professorMypageEdit";
	}
	
	@PostMapping("/mypage/professorUpdate.do")
	public String updateProcess(
		@Validated(UpdateGroup.class) @ModelAttribute("professor") ProfessorVO professor
		, HttpSession session
		, BindingResult errors
		, Model model
	) {
		String plain = professor.getPrPass();
		String encoded = encoder.encode(plain);
		professor.setPrPass(encoded);
		
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyProfessor(professor);
			if(ServiceResult.OK == result) {
				model.addAttribute("result", "수정완료");
				session.removeAttribute("memImage");
				session.setAttribute("memImage", professor.getPrPic());
			}else {
				model.addAttribute("result", "수정실패");
			}
		}else {
			model.addAttribute("result", "수정실패");
		}
		return "jsonView";
	}
	
}
