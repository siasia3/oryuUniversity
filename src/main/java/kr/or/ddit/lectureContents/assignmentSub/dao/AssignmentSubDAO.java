package kr.or.ddit.lectureContents.assignmentSub.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.lectureContents.vo.AssignmentSubVO;

@Mapper
public interface AssignmentSubDAO {
	//과제 제출 목록 조회
	public List<AssignmentSubVO> selectAssignmentSubList(PaginationInfo paging);
	//과제 제출 상세 조회
	public AssignmentSubVO selectAssignmentSub(String assiCd, String stCd);
	//과제 점수 업데이트
	public int updateAssignmentScore(AssignmentSubVO assignSub);
	//과제 제출 현황 (수강 전체 학생 수)
	public int selectEnrollmentCount(String lecCd);
	//과제 제출 현황 (과제 제출 학생 수)
	public int selectAssignmentCount(AssignmentSubVO assignSub);
	//과제 제출 이름
	public String selectAssiNm(AssignmentSubVO assignSub);
	
	//과제 점수 총합 업데이트
	public int updateGraAssiScore(AssignmentSubVO assignSub);
	
	//학생 과제 제출
	public int insertAssignSubmission(AssignmentSubVO assignSubmission);
	
	//학생 제출과제 상세조회
	public AssignmentSubVO selectAssignSubmissionDetail(AssignmentSubVO assignSubmission);
	
	//학생 과제 재제출(업데이트)
	public int updateAssignSubmission(AssignmentSubVO assignSubmission);
}
