package kr.or.ddit.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.BuildingVO;
import kr.or.ddit.common.vo.ClassRoomVO;
import kr.or.ddit.common.vo.ClassificationVO;
import kr.or.ddit.common.vo.DaytimeScheduleVO;
import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.professor.vo.ProfessorVO;
import kr.or.ddit.schedule.vo.AcademicScheduleVO;
import kr.or.ddit.staff.vo.StaffVO;
import kr.or.ddit.student.vo.StudentVO;
import kr.or.ddit.subject.vo.SubjectVO;

/**
 * 공통적 DAO
 * @author rottw
 *
 */
@Mapper
public interface CommonDAO {
	// 이수 구분 조회
	public List<ClassificationVO> selectClassificationList();
	// 강의실 조회
	public List<ClassRoomVO> selectClassRoomList();
	// 요일별 교시 조회
	public List<DaytimeScheduleVO> selectDaytimeScheduleList();
	// 건물 조회
	public List<BuildingVO> selectBuildingList();
	// 학생 조회
	public List<StudentVO> selectStudentList();
	// 교수 조회
	public List<ProfessorVO> selectProfessorList();
	// 교직원 조회
	public List<StaffVO> selectStaffList();
	// 학과별 교직원 조회
	public List<ProfessorVO> selectProfList(String dtCd);
	// 교직원 정보 조회
	public DepartmentVO profInfo(String prCd);
	// 학과별 과목 정보 조회
	public List<SubjectVO> subjectList(String dtCd);
	// 수강신청 기간 확인
	public AcademicScheduleVO selectSchedule();
	
}
