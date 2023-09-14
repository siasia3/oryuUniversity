package kr.or.ddit.graduation.service;

import java.text.MessageFormat;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.college.vo.CollegeVO;
import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.graduation.dao.GraduationDAO;
import kr.or.ddit.graduation.vo.GraduationVO;
import kr.or.ddit.serviceresult.ServiceResult;
import kr.or.ddit.student.dao.StudentDAO;
import kr.or.ddit.student.vo.StudentVO;

@Service
public class GraduationServiceImpl implements GraduationService {
	
	@Inject
	private GraduationDAO graduationDAO;
	@Inject
	private StudentDAO studentDAO;

	@Override
	public List<GraduationVO> retrieveGraduationStudentList(String stCd) {
		
		return graduationDAO.selectGraduationStudentList(stCd);
	}

	@Override
	public GraduationVO retrieveGraduationStudentBelong(String stCd) {

		return graduationDAO.selectGraduationStudentBelong(stCd);
	}

	@Override
	public List<GraduationVO> retrieveGraduationTypeList() {
		
		return graduationDAO.selectGraduationTypeList();
	}

	@Override
	public List<CollegeVO> retrieveCollegeTypeList() {

		return graduationDAO.selectCollegeTypeList();
	}

	@Override
	public List<GraduationVO> retrieveGraduationConditionList() {

		return graduationDAO.selectGraduationConditionList();
	}

	@Override
	public GraduationVO retrieveGraduation(GraduationVO graduation) throws PKNotFoundException {
		GraduationVO saved = graduationDAO.selectGraduation(graduation);
		if(saved==null)
			throw new PKNotFoundException(MessageFormat.format("{0}, {1}에 해당하는 정보 없음.", graduation.getGeGradCondType(), graduation.getColgeCd()));
		return saved;
	}

	@Override
	public List<StudentVO> retrieveStudentList(PaginationInfo<StudentVO> paging) {
		long totalRecord = studentDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return studentDAO.selectStudentList(paging);
	}

	@Override
	public boolean modifyGraduation(GraduationVO graduation) {
		return graduationDAO.updateGraduation(graduation) > 0;
	}

	@Override
	public boolean createGraduation(GraduationVO graduation) {
		return graduationDAO.insertGraduation(graduation) > 0;
	}

	@Override
	public boolean removeGraduation(String geGradCondType) {
		return graduationDAO.deleteGraduation(geGradCondType) > 0;
	}

	@Override
	public List<GraduationVO> changeGraduationCond(String colgeCd) {
		return graduationDAO.selectGraduationCond(colgeCd);
	}

	@Override
	public boolean graduationStudent(String stCd) {
		return graduationDAO.graduateStudent(stCd) > 0;
	}

}
