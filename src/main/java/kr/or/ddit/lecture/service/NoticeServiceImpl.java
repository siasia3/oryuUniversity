package kr.or.ddit.lecture.service;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.atch.service.AtchFileService;
import kr.or.ddit.atch.vo.AtchFileDetailVO;
import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.lecture.dao.LectureDAO;
import kr.or.ddit.lecture.dao.NoticeDAO;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.lecture.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeDAO noticeDAO;
	
	@Inject
	private AtchFileService atchService;
	@Value("#{appInfo.CommonAtchPath}")
	private Resource atchPath;
	
	private void processAtchFileGroup(NoticeVO notice) {
		MultipartFile[] noticeFiles = notice.getNoticeFiles();
		if(noticeFiles==null) return;
		List<AtchFileDetailVO> detailList = new ArrayList<>();
		for(MultipartFile noticeFile : noticeFiles) {
			if(noticeFile.isEmpty()) continue;
			detailList.add(new AtchFileDetailVO(noticeFile));
		}
		if(detailList.size()>0) {
			AtchFileVO fileGroup = new AtchFileVO();
			fileGroup.setDetailList(detailList);
			try {
				int atchFileId = atchService.createAtchFileGroup(fileGroup, atchPath);
				notice.setAtchFileId(atchFileId);
			}catch(IOException e) {
				throw new RuntimeException(e);
			}
		}
	}
	
	@Override
	public List<NoticeVO> retrieveNoticeList(PaginationInfo paging) {
		long totalRecord = noticeDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return noticeDAO.selectNoticeList(paging);
	}

	@Override
	public NoticeVO retrieveNotice(String lnNum) {
		return noticeDAO.selectNotice(lnNum);
	}

	@Override
	public boolean createNotice(NoticeVO lecNotice) {
		processAtchFileGroup(lecNotice);
		boolean result;
		int cnt = noticeDAO.insertNotice(lecNotice);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public boolean modifyNotice(NoticeVO lecNotice) {
		processAtchFileGroup(lecNotice);
		boolean result;
		int cnt = noticeDAO.updateNotice(lecNotice);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public boolean removeNotice(NoticeVO lecNotice) {
		boolean result;
		int cnt = noticeDAO.deleteNotice(lecNotice);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public String retrieveLecName(String lecCd) {
		return noticeDAO.selectLecName(lecCd);
	}

	@Override
	public NoticeVO retrieveProfessorInfo(String lecCd) {
		return noticeDAO.selectProfessorInfo(lecCd);
	}

}
