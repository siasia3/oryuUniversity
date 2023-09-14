package kr.or.ddit.lectureSchedule.service;

import java.util.List;

import kr.or.ddit.lectureSchedule.vo.LectureScheduleVO;
import kr.or.ddit.serviceresult.ServiceResult;

/**
 * 강의스케쥴 service
 * @author rottw
 *
 */
public interface LectureScheduleService {
	
	// 강의 스케쥴 등록
	public int saveLectureSchedule(LectureScheduleVO lectureSchedule);
	
	// 강의 스케쥴 삭제
	public int removeLectureSchedule(LectureScheduleVO lectureSchedule);

	// 강의 스케쥴 검색
	public List<LectureScheduleVO> retrievedLectureSchedule(String clasCd);
	
	// 강의 스케줄 교시조회
	public List<LectureScheduleVO> retrieveLectureScheduleDetail(String lecCd);
	
}
