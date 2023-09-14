package kr.or.ddit.tuition.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.tuition.vo.TuitionVO;

@Mapper
public interface TuitionDAO {

	public long selectTotalRecord(PaginationInfo<TuitionVO> paging);
	public long selectScholarshipTotalRecord(PaginationInfo<TuitionVO> paging);
	/**
	 * 전체학생의 장학금정보 조회
	 * @param paging
	 * @return
	 */
	public List<TuitionVO> selectStaffTuitionList(PaginationInfo<TuitionVO> paging);
	/**
	 * 학생이 신청한 자신의 장학금정보 조회
	 * @param tuition
	 * @return
	 */
	public List<TuitionVO> selectStudentApplyScholarship(String stCd);
	/**
	 * 장학금 신청(등록금 테이블 업데이트)
	 * @param tuition
	 * @return
	 */
	public int submitScholarship(TuitionVO tuition);
	/**
	 * 학생이 신청한 장학금 리스트 조회
	 * @return
	 */
	public List<TuitionVO> selectStaffApplyScholarship(PaginationInfo<TuitionVO> paging);
	/**
	 * 학생이 신청한 장학금 상세 조회
	 * @param semesterCd
	 * @param stCd
	 * @return
	 */
	public TuitionVO selectScholarship(TuitionVO tuition);
	/**
	 * 장학 신청 승인
	 * @param tuition
	 * @return
	 */
	public int approveScholarship(TuitionVO tuition);
	/**
	 * 장학 신청 반려
	 * @param tuition
	 * @return
	 */
	public int rejectScholarship(TuitionVO tuition);
	/**
	 * 장학금 등록 완료
	 * @param tuition
	 * @return
	 */
	public int approveTuition(TuitionVO tuition);
	/**
	 * 학생의 한학기 등록금 조회
	 * @param tuition
	 * @return
	 */
	public TuitionVO selectTuition(TuitionVO tuition);
	/**
	 * 학생이 신청한 자신의 장학금정보 조회
	 * @param stCd
	 * @return
	 */
	public List<TuitionVO> selectStudentTuition(String stCd);
	
}
