package kr.or.ddit.lectureContents.attendance.service;

import java.util.ArrayList;
import java.util.List;


import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.lectureContents.attendance.dao.AttendanceDAO;
import kr.or.ddit.lectureContents.vo.AttendanceStateVO;
import kr.or.ddit.lectureContents.vo.AttendanceVO;
import kr.or.ddit.serviceresult.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AttendanceServiceImpl implements AttendanceService {
	
	@Inject
	AttendanceDAO attDAO;
	
	//출석 조회
	@Override
	public List<AttendanceVO> retrieveAttendanceList(AttendanceVO attendance) {
		return attDAO.selectAttendanceList(attendance);
	}
	
	// 출석 등록
	@Override
	public ServiceResult registerAttendance(List<AttendanceStateVO> attendanceStateList) {
		ServiceResult result = ServiceResult.OK;
		for(AttendanceStateVO attendState :  attendanceStateList) {
			if(!StringUtils.isBlank(attendState.getAttsState())) {
				int attCheck = attDAO.insertAttendanceState(attendState);
				int upCheck = attDAO.upAttendanceDay(attendState);
				if(attCheck + upCheck < 2) {
					result = ServiceResult.FAIL;
				}
			}
		}
		return result;
	}
	
	// 출석 수정
	@Override
	public ServiceResult modifyAttendance(List<AttendanceStateVO> attendanceStateList) {
		ServiceResult result = ServiceResult.OK;
		
		for(AttendanceStateVO attendState :  attendanceStateList) {
			AttendanceStateVO asv = attDAO.selectAttendanceState(attendState.getAttsCd());
			String prevState = asv.getAttsState();
			if(!prevState.equals(attendState.getAttsState())){
				attendState.setPrevAttsState(prevState);
				int attCheck = attDAO.updateAttendanceDay(attendState);
				int asCheck = attDAO.updateAttendanceState(attendState);
				if(attCheck + asCheck < 2) {
					result = ServiceResult.FAIL;
				}
			}
		}
		return result;
	}

	@Override
	public AttendanceVO retrieveStAttendanceList(AttendanceVO attendance) {
		return attDAO.selectStAttendanceList(attendance);
	}

	@Override
	public boolean modifyAttendScore(String lecCd, int absenceValue, int scoreValue) {
		boolean result;
		int cnt = attDAO.updateAttendScore(lecCd, absenceValue, scoreValue);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

	@Override
	public List<AttendanceVO> retrieveAttendScore(String lecCd) {
		return attDAO.selectAttendScore(lecCd);
	}

	@Override
	public boolean modifyFinalAttend(String lecCd, String stCd) {
		boolean result;
		int cnt = attDAO.updateFinalAttend(lecCd, stCd);
		if(cnt > 0) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}

}
