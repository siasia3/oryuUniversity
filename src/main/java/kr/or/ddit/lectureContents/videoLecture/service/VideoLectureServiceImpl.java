package kr.or.ddit.lectureContents.videoLecture.service;

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
import kr.or.ddit.lectureContents.videoLecture.dao.VideoLectureDAO;
import kr.or.ddit.lectureContents.vo.VideoLectureVO;
import kr.or.ddit.serviceresult.ServiceResult;

@Service
public class VideoLectureServiceImpl implements VideoLectureService {
	
	@Inject
	VideoLectureDAO dao;
	
	@Inject 
	private AtchFileService atchService;
	@Value("#{appInfo.CommonAtchPath}")
	private Resource atchPath;

	@Override
	public ServiceResult registerVideoLecture(VideoLectureVO videoLec) {
		processAtchFileGroup(videoLec);
		ServiceResult result = dao.insertVideoLecture(videoLec) > 0 ?  ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}

	@Override
	public VideoLectureVO retreiveVideoLectureDetail(String vlsCd) {
		return dao.selectVideoLectureDetail(vlsCd);
	}

	@Override
	public List<VideoLectureVO> retreiveVideoLectureList(String lecCd) {
		return dao.selectVideoLectureList(lecCd);
	}

	@Override
	public ServiceResult modifyVideoLecture(VideoLectureVO videoLec) {
		processAtchFileGroup(videoLec);
		return dao.updateVideoLecture(videoLec) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeVideoLecture(String vlsCd) {
		// TODO Auto-generated method stub
		return null;
	}
	
	private void processAtchFileGroup(VideoLectureVO videoLec) {
		MultipartFile vlFile = videoLec.getVlFile();
		if(vlFile==null || vlFile.getSize() == 0) return;
		List<AtchFileDetailVO> detailList = new ArrayList<>();
		detailList.add(new AtchFileDetailVO(vlFile));
		
		if(detailList.size()>0) {
			AtchFileVO fileGroup = new AtchFileVO();
			fileGroup.setDetailList(detailList);
			try {
				//	1. 첨부파일의 메타 데이터 저장
				//	2. 첨부파일의 2진 데이터 저장
				int atchFileId = atchService.createAtchFileGroup(fileGroup, atchPath);
				videoLec.setAtchFileId(atchFileId);
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
	}

}
