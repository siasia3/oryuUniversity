package kr.or.ddit.lectureContents.videoLecture.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.lectureContents.videoLecture.service.VideoLectureService;
import kr.or.ddit.lectureContents.vo.VideoLectureVO;

@Controller
@RequestMapping("/lecture/videoLectureDetail.do")
public class VideoLecDetailController {
	
	@Inject
	VideoLectureService service;
	
	@GetMapping
	public String videoLecture(String vlsCd,Model model) {
		VideoLectureVO videoLecture = service.retreiveVideoLectureDetail(vlsCd);
		model.addAttribute("videoLecture", videoLecture);
		return "lecture/videoLecture/videoLectureView";
	}
	
}
