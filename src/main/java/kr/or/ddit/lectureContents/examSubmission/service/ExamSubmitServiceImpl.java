package kr.or.ddit.lectureContents.examSubmission.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.enrollment.vo.EnrollmentVO;
import kr.or.ddit.lectureContents.exam.dao.ExamDAO;
import kr.or.ddit.lectureContents.exam.dao.ExamQuestionDAO;
import kr.or.ddit.lectureContents.examSubmission.dao.ExamSubmitDAO;
import kr.or.ddit.lectureContents.vo.ExamQuestSubmitVO;
import kr.or.ddit.lectureContents.vo.ExamQuestionVO;
import kr.or.ddit.lectureContents.vo.ExamSubmitVO;
import kr.or.ddit.lectureContents.vo.ExamVO;
import kr.or.ddit.serviceresult.ServiceResult;

@Service
public class ExamSubmitServiceImpl implements ExamSubmitService {
	
	@Inject
	ExamSubmitDAO submitDao;
	@Inject
	ExamQuestionDAO queDao;
	@Inject
	ExamDAO examDao;
	
	/**
	 * 학생 시험제출
	 */
	@Override
	public ServiceResult registerExamSubmit(ExamSubmitVO examSubmit) {
		List<ExamQuestSubmitVO> examQueSubmitList = examSubmit.getExamQueSubmitList();
		int score = 0;
		submitDao.insertExamSubmit(examSubmit);
		for(ExamQuestSubmitVO examQueSubmit : examQueSubmitList) {
			examQueSubmit.setEsCd(examSubmit.getEsCd());
			ExamQuestionVO examQue = queDao.selectExamQueAnswer(examQueSubmit.getEqCd());
			if(examQue.getEqAnsw().equals(examQueSubmit.getEqsAnswer())){
				examQueSubmit.setEqsScore(examQue.getEqScore());
				score += examQue.getEqScore();
			}else {
				examQueSubmit.setEqsScore(0);
			}
			submitDao.insertExamQueSubmit(examQueSubmit);
		}
		examSubmit.setEsScore(score);
		ExamVO exam = examDao.selectExamDetail(examSubmit.getExamCd());
		if(exam.getExamType().equals("중간고사")) {
			submitDao.updateMidtermScore(examSubmit);
		}else if(exam.getExamType().equals("기말고사")) {
			submitDao.updateFinalsScore(examSubmit);
		}
		return submitDao.updateExamSubmitScore(examSubmit) > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<ExamSubmitVO> retrieveExamSubmitList(String examCd) {
		return submitDao.selectExamSubmitList(examCd);
	}

	@Override
	public List<ExamQuestionVO> retrieveExamSubmit(ExamSubmitVO examSubmit) {
		return submitDao.selectExamSubmit(examSubmit);
	}

	@Override
	public ServiceResult modifyExamSubmitScore(ExamSubmitVO examSubmit) {
		ServiceResult result = null;
		int updateCheck = 0;
		ExamVO exam = examDao.selectExamDetail(examSubmit.getExamCd());
		if(exam.getExamType().equals("중간고사")) {
			submitDao.updateMidtermScore(examSubmit);
		}else if(exam.getExamType().equals("기말고사")) {
			submitDao.updateFinalsScore(examSubmit);
		}
		int cnt = submitDao.updateExamSubmitScore(examSubmit);
		if(cnt>0) {
			List<ExamQuestSubmitVO> examQueSubmitList = examSubmit.getExamQueSubmitList();
			int size = examQueSubmitList.size();
			for(ExamQuestSubmitVO examQueSubmit : examQueSubmitList) {
				updateCheck += submitDao.updateExamQueSubmit(examQueSubmit);
			}
			if(updateCheck == size) {
				result = ServiceResult.OK;
			}else {
				result = ServiceResult.FAIL;
			}
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

}
