package kr.or.ddit.graduation.service;

import java.util.List;

import kr.or.ddit.college.vo.CollegeVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.graduation.vo.GraduationVO;
import kr.or.ddit.serviceresult.ServiceResult;
import kr.or.ddit.student.vo.StudentVO;

public interface GraduationService {

	/**
	 * 학생이 속한 단과의 졸업이수조건종류와 그에대한 최소요구치를 가져옴
	 * @param stCd
	 * @return
	 */
	public List<GraduationVO> retrieveGraduationStudentList(String stCd);
	/**
	 * 학생이 속한 단과와 학과를 가져옴
	 * @param stCd
	 * @return
	 */
	public GraduationVO retrieveGraduationStudentBelong(String stCd);
	/**
	 * 모든 졸업이수조건의 종류를 가져옴
	 * @return
	 */
	public List<GraduationVO> retrieveGraduationTypeList();
	/**
	 * 모든 단대종류를 가져옴
	 * @return
	 */
	public List<CollegeVO> retrieveCollegeTypeList();
	/**
	 * 모든 졸업이수조건종류에 대한 최소요구치를 가져옴
	 * @return
	 */
	public List<GraduationVO> retrieveGraduationConditionList();
	/**
	 * 졸업요건의 종류와 최소조건 생성 시 중복확인을 위함
	 * @param geGradCondType
	 * @param colgeCd
	 * @return
	 */
	public GraduationVO retrieveGraduation(GraduationVO graduation);
	/**
	 * 학생리스트 조회
	 * @return
	 */
	public List<StudentVO> retrieveStudentList(PaginationInfo<StudentVO> paging);
	/**
	 * 졸업조건 수정
	 * @param graduation
	 * @return
	 */
	public boolean modifyGraduation(GraduationVO graduation);
	/**
	 * 졸업조건 등록
	 * @param graduation
	 * @return
	 */
	public boolean createGraduation(GraduationVO graduation);
	/**
	 * 졸업조건 삭제
	 * @param graduation
	 * @return
	 */
	public boolean removeGraduation(String geGradCondType);
	/**
	 * 졸업요건 수정에서 단과선택시 단과에 대한 졸업요건 가져옴
	 * @param colgeCd
	 * @return
	 */
	public List<GraduationVO> changeGraduationCond(String colgeCd);
	/**
	 * 학생 졸업상태로 변경
	 * @param stCd
	 * @return
	 */
	public boolean graduationStudent(String stCd);
	
}
