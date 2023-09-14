package kr.or.ddit.academic.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.academic.dao.AcademicNoticeDAO;
import kr.or.ddit.academic.vo.AcademicNoticeVO;
import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.common.vo.PaginationInfo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AcademicNoticeServiceImpl implements AcademicNoticeService {
	@Inject
	private AcademicNoticeDAO acaNoticeDAO;
	
	@Inject
	private AtchFileService atchService;
	@Value("#{appInfo.CommonAtchPath}")
	private Resource atchPath;
	
	private void processAtchFileGroup(AcademicNoticeVO acaNotice) {
		MultipartFile[] acaNoticeFiles = acaNotice.getAcaNoticeFiles();
		if(acaNoticeFiles==null) return;
		List<AtchFileDetailVO> detailList = new ArrayList<>();
		for(MultipartFile acaNoticeFile : acaNoticeFiles) {
			if(acaNoticeFile.isEmpty()) continue;
			detailList.add( new AtchFileDetailVO(acaNoticeFile));
		}
		if(detailList.size()>0) {
			AtchFileVO fileGroup = new AtchFileVO();
			fileGroup.setDetailList(detailList);
			try {
				int atchFileId = atchService.createAtchFileGroup(fileGroup, atchPath);
				acaNotice.setAtchFileId(atchFileId);
			}catch(IOException e) {
				throw new RuntimeException(e);
			}
		}
	}
	
	@Override
	public List<AcademicNoticeVO> retrieveAcademicNoticeList(PaginationInfo paging) {
		long totalRecord = acaNoticeDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return acaNoticeDAO.selectAcademicNoticeList(paging);
	}

	@Override
	public AcademicNoticeVO retrieveAcademicNotice(int anNum) {
		return acaNoticeDAO.selectAcademicNotice(anNum);
	}

	@Override
	public boolean createAcademicNotice(AcademicNoticeVO acaNotice) {
		processAtchFileGroup(acaNotice);
		boolean result;
		int cnt = acaNoticeDAO.insertAcademicNotice(acaNotice);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public boolean modifyAcademicNotice(AcademicNoticeVO acaNotice) {
		processAtchFileGroup(acaNotice);
		boolean result;
		int cnt = acaNoticeDAO.updateAcademicNotice(acaNotice);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public boolean removeAcademicNotice(AcademicNoticeVO acaNotice) {
		boolean result;
		int cnt = acaNoticeDAO.deleteAcademicNotice(acaNotice);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public void increaseViews(int anNum) {
		acaNoticeDAO.increaseViews(anNum);
	}

	@Override
	public long getTotalRecordCount(PaginationInfo paging) {
		return acaNoticeDAO.selectTotalRecord(paging);
	}

}
