package kr.or.ddit.job.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.job.dao.JobDAO;
import kr.or.ddit.job.vo.AdVO;
import kr.or.ddit.job.vo.JobVO;
import kr.or.ddit.student.vo.StudentVO;

@Service
public class JobServiceImpl implements JobService {
	
	@Inject
	private JobDAO jobDAO;
	
	// 전체 공고 조회
	@Override
	public List<JobVO> retriveJobList(PaginationInfo paging) {
		// 토탈자료 개수
		long totalRecord = jobDAO.selectTotalRecord(paging);
		// 페이징 객체에 토탈레코드 저장
		paging.setTotalRecord(totalRecord);
		// 페이징 객체를 이용하여 전체과목조회 후 리턴
		return jobDAO.selectJobList(paging);
	}
	// 공고 등록
	@Override
	public int createJobAd(JobVO job) {
		return jobDAO.insertJobAd(job);
	}

	// 광고 등록
	@Override
	public int createAd(AdVO ad) {
		return jobDAO.insertAd(ad);
	}
	
	// 전체 광고 조회
	@Override
	public List<AdVO> retrieveAdList(PaginationInfo paging) {
		
		// 토탈자료 개수
		long totalRecord = jobDAO.selectTotalAd(paging);
		// 페이징 객체에 토탈레코드 저장
		paging.setTotalRecord(totalRecord);
		// 페이징 객체를 이용하여 전체과목조회 후 리턴
		return jobDAO.selectAdList(paging);
	}

	// 학생 리스트 불러오기
	@Override
	public List<StudentVO> retrieveStudentList(PaginationInfo<StudentVO> paging) {
		long totalRecord = jobDAO.selectTotal(paging);
		paging.setTotalRecord(totalRecord);
		return jobDAO.selectStudent(paging);
	}
	// 취업률 계산
	@Override
	public StudentVO retrieveEmpInfo(StudentVO studentVO) {
		return jobDAO.selectEmpInfo(studentVO);
	}
	// 지역별 취업자수
	@Override
	public List<StudentVO> retrieveEmpLoc(StudentVO studentVO) {
		return jobDAO.selectEmpLoc(studentVO);
	}
}
