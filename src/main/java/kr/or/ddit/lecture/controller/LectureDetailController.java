package kr.or.ddit.lecture.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.lecture.service.LectureService;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.lectureSchedule.vo.LectureScheduleVO;

@Controller
@RequestMapping("/lecture/lectureView.do")
public class LectureDetailController {
	
	@Inject
	LectureService service;
	
	@PostMapping
	public String LectureDetail(String lecCd, Model model) {
		LectureVO lecture = service.retrieveLectureDetail(lecCd);
		List<LectureScheduleVO> lectureScheduleList = lecture.getLectureScheduleList();
		String schedule = "";
		for(LectureScheduleVO lectureSchedule : lectureScheduleList) {
			if(lectureSchedule.getScheCd()!=null) {
				schedule += lectureSchedule.getScheCd()+"교시 ";
			}
		}
		model.addAttribute("lecture",lecture);
		model.addAttribute("schedule",schedule);
		
		return "lecture/ajax/modal/modalLectureView";
	}
}
