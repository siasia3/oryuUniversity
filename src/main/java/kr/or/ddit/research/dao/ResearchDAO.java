package kr.or.ddit.research.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.research.vo.ResearchVO;

/**
 * 연구 DAO
 */
@Mapper
public interface ResearchDAO {

	//페이징처리를 위한 전체 레코드 개수 조회
	public long selectTotalRecord(PaginationInfo<ResearchVO> paging);
	
    /**
     * 연구목록 조회
     * @param reseCd 조회할 연구 코드
     * @return 연구 & 연구일지의 목록을 담고 있는 리스트
     */
    public List<ResearchVO> selectResearchList(PaginationInfo<ResearchVO> paging);
    
    /**
     * 연구 단일조회
     * @param reseCd 조회할 연구 코드
     * @return 조회된 연구 & 연구일지 정보를 담고 있는 ResearchVO 객체
     */
    public ResearchVO selectResearch(String reseCd);

	
    /**
     * 연구 등록
     * @param research 연구 & 연구일지 VO 객체
     * @return 등록된 연구 & 연구일지의 수 (1이면 성공, 0이면 실패)
     */
    public int insertResearch(ResearchVO researchVO);

    /**
     * 연구 수정
     * @param research 수정할 연구 & 연구일지 VO 객체
     * @return 수정된 연구 & 연구일지의 수 (1이면 성공, 0이면 실패)
     */
    public int updateResearch(ResearchVO researchVO);

    /**
     * 연구 삭제
     * @param thisCd 삭제할 연구 코드
     * @return 삭제된 연구 & 연구일지의 수 (1이면 성공, 0이면 실패)
     */
    public int deleteResearch(ResearchVO researchVO);
    

}
