package kr.or.ddit.researchJournal.service;

import java.util.List;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.researchJournal.vo.ResearchJournalVO;
import kr.or.ddit.serviceresult.ServiceResult;

public interface ResearchJournalService {

	
	/**
	 * 연구일지 등록
	 * @param researchJournal
	 * @return ok,fail
	 */
	public ServiceResult createResearchJournal(ResearchJournalVO researchJournal);

	/**
	 * 연구일지 상세조회
	 * @param rjsn (저널순번으로 조회)
	 * @return
	 */
	public ResearchJournalVO retrieveResearchJournal(int rjsn);
	
	/**
	 * 연구일지 리스트를 패이징처리하여 조회
	 * @param paging
	 * @return 
	 */
	public List<ResearchJournalVO> retrieveResearchJournalList(PaginationInfo<ResearchJournalVO> paging);

	/**
	 * 연구일지 리스트를 수정
	 * @param researchJournal
	 * @return
	 */
	public ServiceResult modifyResearchJournal(ResearchJournalVO researchJournal);
	
	
	/**
	 * 연구일지를 삭제.
	 * @param researchJournal
	 * @return ok,fail
	 */
	public ServiceResult removeResearchJournal(String rjSn);

	
}
