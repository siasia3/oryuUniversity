package kr.or.ddit.student.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.student.vo.StudentVO;

@Mapper
public interface StudentDAO {
	/**
	 * 학생 등록
	 * @param student
	 * @return 등록된 레코드수 > 0 : 성공
	 */
	public int insertStudent(StudentVO student);
	/**
	 * 학생 상세 정보 조회
	 * @param stCd(학번)
	 * @return StudentVO(학생상세정보)
	 */
	public StudentVO selectStudent(String stCd);
	/**
	 * 회원수 조회
	 * @param paging
	 * @return 검색 조건에 맞는 회원 수
	 */
	public long selectTotalRecord(PaginationInfo<StudentVO> paging);
	/**
	 * 학생 목록 조회
	 * @param paging
	 * @return List<StudentVO>(학생목록)
	 */
	public List<StudentVO> selectStudentList(PaginationInfo<StudentVO> paging);
	/**
	 * 학생 목록 조회(ASC)
	 * @param paging
	 * @return List<StudentVO>(학생목록)
	 */
	public List<StudentVO> selectStudentListAsc(PaginationInfo<StudentVO> paging);
	/**
	 * 학생 정보 수정
	 * @param student
	 * @return
	 */
	public int updateStudent(StudentVO student);
	/**
	 * 학생 탈퇴상태로 변경
	 * @param stCd
	 * @return
	 */
	public int deleteStudent(String stCd);
	
	/**
	 * 취업현황 검색
	 * @param paging
	 * @return
	 */
	public List<StudentVO> selectRatioList(PaginationInfo paging);
	
	/**
	 * 조건에 맞는 학과 숫자 검색
	 * @param paging
	 * @return
	 */
	public long selectTotalDepartment(PaginationInfo paging);
	/**
	 * 여러 학생 한번에 등록
	 * @param students
	 * @return
	 */
	public int insertStudents(List<StudentVO> students);
	
	/**
	 * 학생의 취업현황 업데이트
	 * @param student
	 * @return
	 */
	public int updateStatus(StudentVO student);
	
	/**
	 * 차트를 만들기 위한 리스트 생성 
	 * @param studentVO
	 * @return
	 */
	public List<StudentVO> selectChartList(StudentVO studentVO);
}
