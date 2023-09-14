package kr.or.ddit.lectureContents.exam.service;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import kr.or.ddit.lectureContents.exam.dao.ExamDAO;
import kr.or.ddit.lectureContents.exam.dao.ExamQuestionDAO;
import kr.or.ddit.lectureContents.exam.dao.ExamViewDAO;
import kr.or.ddit.lectureContents.vo.ExamQuestionVO;
import kr.or.ddit.lectureContents.vo.ExamVO;
import kr.or.ddit.lectureContents.vo.ExamViewVO;
import kr.or.ddit.serviceresult.ServiceResult;

@Service
public class ExamServiceImpl implements ExamService {

	@Inject
	ExamDAO examDAO;
	@Inject
	ExamQuestionDAO examQueDAO;
	@Inject
	ExamViewDAO examViewDAO;
	
	@Override
	public List<ExamVO> retrieveExamList(String lecCd) {
		
		return examDAO.selectExamList(lecCd);
	}

	@Override
	public ServiceResult registerExam(ExamVO exam) {
		return examDAO.insertExam(exam) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult registerExamQue(ExamQuestionVO examQue) {
		int cnt = examQueDAO.insertExamQuestion(examQue);
		return cnt > 0? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyExam(ExamVO exam) {
		return examDAO.updateExam(exam) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyExamQue(ExamQuestionVO examQue) {
		return examQueDAO.updateExamQuestion(examQue) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<ExamQuestionVO> retrieveExamQuestionList(String examCd) {
		return examQueDAO.selectExamQuestionList(examCd);
	}
	
	@Override
	public ExamVO retrieveTakeExam(String examCd) {
		ExamVO exam = examDAO.selectExamDetail(examCd);
		exam.setExamQueList(examQueDAO.selectExamQuestionList(examCd));
		return exam;
	}

	@Override
	public ServiceResult removeExamQuestion(ExamQuestionVO examQue) {
		examDAO.updateExamScore(examQue);
		return examQueDAO.deleteExamQuestion(examQue.getEqCd()) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult reduceExamQuestionNum(ExamQuestionVO examQue) {
		return examQueDAO.reduceExamQueNumber(examQue) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ExamVO retrieveExamDetail(String examCd) {
		return examDAO.selectExamDetail(examCd);
	}

	@Override
	public ServiceResult registerAllExamQue(List<ExamQuestionVO> examQueList) {
		int size = examQueList.size();
		int cnt = 0;
		for(ExamQuestionVO examQue :  examQueList) {
			if(StringUtils.isBlank(examQue.getEqCd())) {
				cnt += examQueDAO.insertExamQuestion(examQue);
			}else {
				cnt += examQueDAO.updateExamQuestion(examQue);
			}
		}
		return size == cnt ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyExamState(ExamVO exam) {
		return examDAO.updateExamState(exam) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
