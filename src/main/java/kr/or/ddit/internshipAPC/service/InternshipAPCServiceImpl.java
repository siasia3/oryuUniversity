package kr.or.ddit.internshipAPC.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.internshipAPC.dao.InternshipAPCDAO;
import kr.or.ddit.internshipAPC.vo.InternshipAPCVO;

@Service
public class InternshipAPCServiceImpl implements InternshipAPCService {
	
	@Inject
	private InternshipAPCDAO internAPCDAO;
	
	@Override
	public boolean internshipAPCInsert(InternshipAPCVO internAPC) {
		boolean result = false;
		int cnt = internAPCDAO.internshipAPCInsert(internAPC);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public List<InternshipAPCVO> stuInternshipAPCList(PaginationInfo paging,String stCd) {
		long totalRecord = internAPCDAO.selectTotalRecord(paging);
		
		paging.setTotalRecord(totalRecord);
		
		return internAPCDAO.stuInternshipAPCList(paging,stCd);
	}
	
	@Override
	public List<InternshipAPCVO> staffInternshipAPCList(PaginationInfo paging) {
		long totalRecord = internAPCDAO.selectTotalRecord(paging);
		
		paging.setTotalRecord(totalRecord);
		
		return internAPCDAO.staffInternshipAPCList(paging);  
	}

	@Override
	public InternshipAPCVO internshipAPCView(String iaCd) {
		return internAPCDAO.internshipAPCView(iaCd);
	}

	@Override
	public boolean internshipAPCUpdate(InternshipAPCVO internAPC) {
		boolean result = false;
		int cnt = internAPCDAO.internshipAPCUpdate(internAPC);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}


	@Override
	public long selectTotalRecord(PaginationInfo paging) {
		
		return internAPCDAO.selectTotalRecord(paging);
	}

	@Override
	public InternshipAPCVO stuInfo(String stCd) {
		return internAPCDAO.stuInfo(stCd);
	}

	@Override
	public int internshipAPCPass(String iaCd,String pass) {
		return internAPCDAO.internshipAPCPass(iaCd, pass);
	}

}
