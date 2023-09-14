package kr.or.ddit.lecture.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.enrollment.vo.EnrollmentVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.subject.vo.SubjectVO;

/**
 * 강의 DAO
 * @author rottw
 *
 */
@Mapper
public interface LectureDAO {

	//페이징처리를 위한 전체 레코드 개수 조회
	public long selectTotalRecord(PaginationInfo paging);
	//전체 강의 조회
	public List<LectureVO> selectLectureList(PaginationInfo paging);
	// 강의 등록(교직원)
	public int insertLecture(LectureVO lecture);
	// 강의 수정(교직원)
	public int updateLecture(LectureVO lecture);
	// 강의 요청(교수)4
	public int requestLecture(LectureVO lecture);
	// 강의 요청 수락(교직원)3 
	public int responseLecture(LectureVO lecture);
	// 강의 요청 거절(교직원) 5
	public int refuseLecture(LectureVO lecture);
	// 수강 등록 완료(교직원) 1
	public int commitEnrollment(LectureVO lecture);
	// 휴강 등록 완료(교직원) 2
	public int standEnrollment(LectureVO lecture);
	// 강의 조회(강의코드)
	public LectureVO selectLecture(String lecCd);
	// 강의 스케쥴조회(강의코드)
	public LectureVO selectLectureSchedule(String lecCd);
	// 교수 현재 학기 본인강의 조회
	public List<LectureVO> selectCurrentLectureList(String professorId);
	// 학생 현재 학기 본인수업 조회
	public List<LectureVO> selectCurrentClassList(String studentId);
	// 강의 상세조회
	public LectureVO selectLectureDetail(String lecCd);
	// 학생 현재학기 시간표 조회
	public List<EnrollmentVO> selectTimeTable(String stCd);
	
	// 학생 현재학기 강의 조회
	public List<EnrollmentVO> selectCurrentLecList(String stCd);
	
	// 교수 현재학기 시간표 조회
	public List<LectureVO> selectPRTimeTable(String prCd);

}
