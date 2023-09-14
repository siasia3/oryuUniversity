package kr.or.ddit.lectureContents.assignmentSub.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.lectureContents.assignmentSub.service.AssignmentSubService;
import kr.or.ddit.lectureContents.vo.AssignmentSubVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/lecture")
public class AssignmentSubRetreiveController {
	
	@Inject
	private AssignmentSubService service;
	
	@RequestMapping("assignSubList.do")
	public String assignSubList(
			Model model
			, @RequestParam Map<String, Object> detailCondition
			, String lecCd
			, String assiCd
			, String stCd
	) {
		PaginationInfo<AssignmentSubVO> paging = new PaginationInfo<>();
		detailCondition.put("lecCd", lecCd);
		detailCondition.put("assiCd", assiCd);
		detailCondition.put("stCd", stCd);
		
		paging.setDetailCondition(detailCondition);
		
		List<AssignmentSubVO> assignSubList = service.retrieveAssignmentSubList(paging);
		paging.setDataList(assignSubList);
		
		model.addAttribute("paging", paging);
		
		return "lecture/homework/ajax/homeworkSubList";
	}
	
	@RequestMapping(value = "assignSubDetail.do", method = RequestMethod.GET)
	@ResponseBody
	public AssignmentSubVO assignSubDetail(
			 String stCd
			, String assiCd
	) {
		AssignmentSubVO assignSub2 = new AssignmentSubVO();
		assignSub2.setAssiCd(assiCd);
		assignSub2.setStCd(stCd);
		AssignmentSubVO assignSub = service.retrieveAssignSubmissionDetail(assignSub2);
		return assignSub;
	}
	
	@RequestMapping(value = "assignSubCount.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> assignSubCount(@RequestBody List<AssignmentSubVO> assiCdList) {
	    Map<String, Object> resultMap = new HashMap<>();

	    if (assiCdList.isEmpty()) {
	        resultMap.put("error", "생성된 과제 없음.");
	    } else {
	        AssignmentSubVO ad = assiCdList.get(0);
	        String lecCd = ad.getLecCd();

	        int enrollmentCount = service.retrieveEnrollmentCount(lecCd);
	        List<Integer> assignmentCounts = service.retrieveAssignmentCount(assiCdList);
	        List<String> assignNms = service.retrieveAssiNm(assiCdList);
	        resultMap.put("enrollmentCount", enrollmentCount);

	        for (int i = 0; i < assignmentCounts.size(); i++) {
	            resultMap.put("assignmentCount" + (i + 1), assignmentCounts.get(i));
	            resultMap.put("assignNm" + (i + 1), assignNms.get(i));
	        }
	    }
	    return resultMap;
	}

}



