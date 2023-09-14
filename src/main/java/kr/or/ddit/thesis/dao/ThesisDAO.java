package kr.or.ddit.thesis.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.serviceresult.ServiceResult;
import kr.or.ddit.thesis.vo.ThesisVO;

@Mapper
public interface ThesisDAO {

//--- paging ---
	
	/**
	 * 논문수 조회
	 * @param paging
	 * @return 검색에 조건에 맞는 논문 수를 조회한다.
	 */
	public long selectTotalRecord(PaginationInfo<ThesisVO> paging);
	
//--- select ---
	
	/**
	 * 등록된 논문 목록 조회
	 * @param thesis
	 * @return
	 */
	public List<ThesisVO> selectThesisList(PaginationInfo<ThesisVO> paging);

	/**
	 * 논문 상세 조회
	 * @param thesCd
	 * @return thesVO
	 */
	public ThesisVO selectThesis(String thesSn);
	
// --- insert ---	
	
	/**
	 * 논문 등록
	 * @param thesis
	 * @return row count > 0 : 성공
	 */
	public int insertThesis(ThesisVO thesisVO);
	
// --- update ---
	
	/**
	 * 논문 수정
	 * @param thesis
	 * @return row count > 0 : 조회 성공
	 */
	public int updateThesis(ThesisVO thesisVO);
	
// ---delete---
	
	/**
	 * 논문 삭제
	 * @param thesCd
	 * @return row count > 0 : 삭제
	 */
	public int deleteThesis(ThesisVO thesisVO);
	

	
	
}
