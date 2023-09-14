package kr.or.ddit.club.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.club.vo.ClubVO;
import kr.or.ddit.clubMember.vo.ClubMemberVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.professor.vo.ProfessorVO;

@Mapper
public interface ClubDAO {
	/**
	 * 신규 동아리 개설 신청
	 * @param Club
	 * @return 1
	 * 동아리 상태는 요청상태
	 */
	public boolean insertClub(ClubVO club);
	
	/**
	 * 학생이 요청한 동아리 목록
	 * @param stCd
	 * @return
	 */
	public List<ClubVO> insertSListClub(int Cd);
	
	/**
	 * 교수가 요청받은 동아리 목록
	 * @param stCd
	 * @return
	 */
	public List<ClubVO> insertPListClub(int Cd);
	
	
	/**
	 * 요청된 동아리 상세 정보
	 * @param clubCd
	 * @return
	 */
	public ClubVO insertViewClub(String clubCd);
	
	/**
	 * 동아리 승인 처리
	 */
	public int insertApproval(String clubCd,String clubStatus); 
	
	/**
	 * 동아리 거절 처리
	 * @param club
	 * @return
	 */
	public int insertRefuse(ClubVO club);
	
	/**
	 * 전체 동아리 리스트
	 * @param club
	 * @return
	 */
	public List<ClubVO> RequestListClub();
	
	/**
	 * 동아리 유무
	 * @param stCd
	 * @return
	 */
	public ClubVO checkClub(int Cd);
	
	/**
	 * 동아리 보기(교수)
	 * @param ClubCd
	 * @return
	 */
	public ClubVO myClub(int Cd);
	
	/**
	 * 동아리 보기(학생)
	 * @param club
	 * @return
	 */
	public ClubVO stuMyClub(String club);
	
	/**
	 * 동아리보기
	 * @param clubCd
	 * @return
	 */
	public ClubVO clubDetail(String clubCd);
	
	/**
	 * 입부 가능한 동아리 목록
	 * @param statues
	 * @return
	 */
	public List<ClubVO> clubListView(@Param("paging") PaginationInfo paging,@Param("stCd") String stCd);
	
	/**
	 * 입부 가능한 동아리 수
	 */
	public long clubListViewCount(@Param("paging") PaginationInfo paging,@Param("stCd") String stCd);
	/**
	 * 동아리 수정 승인 (교직원)
	 * @param clubCd
	 * @return
	 */
	public int clubUpdate(ClubVO club);
	
	/**
	 * 동아리 수정 거절 (교직원)
	 * @param club
	 * @return
	 */
	public int clubNoUpdate(ClubVO club);
	
	/**
	 * 동아리 수정 요청(학생, 교수)
	 * @param clubCd
	 * @return
	 */
	public int clubUpdateRequest(ClubVO clubCd);
	
	
	
	/**
	 * 선택 가능한 담당교수 선택
	 */
	public List<ProfessorVO> proChoice(PaginationInfo paging);

	
	/**
	 * 총 교수 수 조회
	 * @param paging
	 * @return
	 */
	public long profTotalRecord(PaginationInfo paging);
	
	/**
	 * 총 동아리 수 조회
	 * @param paging
	 * @return
	 */
	public long clubTotalRecord(PaginationInfo paging);
	
	/**
	 * 동아리 개설시 최종 승인될때 신청한 학생 동아리 맴버에 추가
	 * @param clubCd
	 * @return
	 */
	public int insertApprovalInsertMember(String clubCd);
	
	

	/**
	 * 학생이 속한 동아리 목록
	 * @param paging
	 * @param clubCd
	 * @return
	 */
	public List<ClubVO> myClubList(@Param("paging") PaginationInfo paging,@Param("stCd") String stCd);

	/**
	 * 학생이 속한 동아리 수
	 */
	public long myClubListTotalRecord(String stCd);
	
	/**
	 * 부장 아닌 부원 찾기
	 */
	public List<ClubMemberVO> stuChoice(@Param("paging") PaginationInfo paging,@Param("clubCd") String clubCd);
	
	/**
	 * 부장 아닌 부원 몇명인지 확인
	 */
	public long stuClubMemberTotalRecord(@Param("paging") PaginationInfo paging,@Param("clubCd") String clubCd);

	
	/**
	 * 폐부 처리
	 */
	public int clubClosed(String clubCd);
	
	/**
	 * 폐부 처리 된 동아리 목록
	 * @param paging
	 * @return
	 */
	public List<ClubVO> clubClosedList(PaginationInfo paging);
	
	/**
	 * 폐부 처리된 동아리 수
	 */
	public long clubClosedListCount(PaginationInfo paging);
}
