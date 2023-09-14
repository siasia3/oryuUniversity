package kr.or.ddit.professor.service;

import java.io.File;
import java.io.IOException;
import java.text.MessageFormat;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.professor.dao.ProfessorDAO;
import kr.or.ddit.professor.vo.ProfessorVO;
import kr.or.ddit.serviceresult.ServiceResult;

@Service
public class ProfessorServiceImpl implements ProfessorService{
	
	@Inject
	private ProfessorDAO professorDAO;
	@Inject
	private PasswordEncoder encoder;
	@Value("#{appInfo.ProfileImagePath}")
	private Resource professorSaveRes;
	
	private ServiceResult processProfessorImage(ProfessorVO professor) {
		if(professor.getPrImage()==null) return ServiceResult.OK;
		try {
			File saveFile = new File(professorSaveRes.getFile(), professor.getPrPic());
			professor.getPrImage().transferTo(saveFile);;
			return ServiceResult.OK;
		}catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	private void encryptMember(ProfessorVO professor) {
		String plain = professor.getPrPass();
		String encoded = encoder.encode(plain);
		professor.setPrPass(encoded);
	}

	@Override
	public ServiceResult createProfessor(ProfessorVO professor) {
		ServiceResult result = null;
		try {
			retrieveProfessor(professor.getPrCd());
			result = ServiceResult.PKDUPLICATE;
		}catch (PKNotFoundException e) {
			encryptMember(professor);
			int cnt = professorDAO.insertProfessor(professor);
			result = cnt > 0 ? processProfessorImage(professor) : ServiceResult.FAIL;
		}		
		return result;
	}

	@Override
	public ProfessorVO retrieveProfessor(String prCd) throws PKNotFoundException {
		ProfessorVO saved = professorDAO.selectProfessor(prCd);
		if(saved==null)
			throw new PKNotFoundException(MessageFormat.format("{0} 해당 사용자 없음.", prCd));
		return saved;
	}

	@Override
	public List<ProfessorVO> retrieveProfessorList(PaginationInfo<ProfessorVO> paging) {
		long totalRecord = professorDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return professorDAO.selectProfessorList(paging);
	}

	@Override
	public ServiceResult modifyProfessor(ProfessorVO professor) {
		ServiceResult result = null;
		int cnt = professorDAO.updateProfessor(professor);
		if(cnt > 0) {
			result = processProfessorImage(professor);
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult removeProfessor(String prCd) {
		ServiceResult result = null;
		int cnt = professorDAO.deleteProfessor(prCd);
		result = cnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}
	
}
