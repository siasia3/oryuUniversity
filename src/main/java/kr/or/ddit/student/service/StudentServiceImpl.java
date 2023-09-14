package kr.or.ddit.student.service;

import java.io.File;
import java.io.IOException;
import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.common.vo.PaginationInfo;
import kr.or.ddit.exception.PKNotFoundException;
import kr.or.ddit.serviceresult.ServiceResult;
import kr.or.ddit.student.dao.StudentDAO;
import kr.or.ddit.student.vo.StudentVO;

@Service
public class StudentServiceImpl implements StudentService {
	
	@Inject
	private StudentDAO studentDAO;
	@Inject
	private PasswordEncoder encoder;
	@Value("#{appInfo.ProfileImagePath}")
	private Resource studentSaveRes;
	
	private ServiceResult processStudentImage(StudentVO student) {
		if(student.getStImage()==null) return ServiceResult.OK;
		try {
			File saveFile = new File(studentSaveRes.getFile(), student.getStFic());
			student.getStImage().transferTo(saveFile);
			return ServiceResult.OK;
		}catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	private void encryptMember(StudentVO student) {
		String plain = student.getStPass();
		String encoded = encoder.encode(plain);
		student.setStPass(encoded);
	}
	
	@Override
	public ServiceResult createStudent(StudentVO student) {
		ServiceResult result = null;
		try {
			retrieveStudent(student.getStCd());
			result = ServiceResult.PKDUPLICATE;
		}catch (PKNotFoundException e) {
			encryptMember(student);
			int cnt = studentDAO.insertStudent(student);
			result = cnt > 0 ? processStudentImage(student) : ServiceResult.FAIL;
		}		
		return result;
	}
	
	@Override
	public StudentVO retrieveStudent(String stCd) throws PKNotFoundException {
		StudentVO saved = studentDAO.selectStudent(stCd);
		if(saved==null)
			throw new PKNotFoundException(MessageFormat.format("{0} 해당 사용자 없음.", stCd));
		return saved;
	}

	@Override
	public List<StudentVO> retrieveStudentList(PaginationInfo<StudentVO> paging) {
		long totalRecord = studentDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return studentDAO.selectStudentList(paging);
	}
	
	@Override
	public List<StudentVO> retrieveStudentListAsc(PaginationInfo<StudentVO> paging) {
		long totalRecord = studentDAO.selectTotalRecord(paging);
		paging.setTotalRecord(totalRecord);
		return studentDAO.selectStudentListAsc(paging);
	}

	@Override
	public ServiceResult modifyStudent(StudentVO student) {
		ServiceResult result = null;
		int cnt = studentDAO.updateStudent(student);
		if(cnt > 0) {
			result = processStudentImage(student);
		}else {
			result = ServiceResult.FAIL;
		}
		return result;
	}

	@Override
	public ServiceResult removeStudent(String stCd) {
		ServiceResult result = null;
		int cnt = studentDAO.deleteStudent(stCd);
		result = cnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		return result;
	}
	
	// 학과별 취업현황 확인
	@Override
	public List<StudentVO> retrieveRatioList(PaginationInfo paging) {
		long totalRecord = studentDAO.selectTotalDepartment(paging);
		paging.setTotalRecord(totalRecord);
		return studentDAO.selectRatioList(paging);
	}
	
	// 취업현황 업데이트
	@Override
	public int modifyStatus(StudentVO studentVO) {
		int count = 0;
		count += studentDAO.updateStatus(studentVO);
		return count;
	}
	// 취업현황 업데이트 (파일)
	@Override
	public int modifyStatusFile(List<StudentVO> studentList) {
		int count = 0;
		for (StudentVO student : studentList) {
		count += studentDAO.updateStatus(student);
		}
		return count;
	}
	
	// 취업현황 차트 만들기
	@Override
	public List<StudentVO> retrieveChartList(StudentVO student) {
		return studentDAO.selectChartList(student);
	}


	
	@Override
	public ServiceResult createStudents(List<StudentVO> students) {
		List<StudentVO> studentsToCreate = new ArrayList<>();
		
		for (StudentVO student : students) {
	            StudentVO existingStudent = studentDAO.selectStudent(student.getStCd());
	            if (existingStudent == null) {
	                studentsToCreate.add(student);
	            }else {
	            	return ServiceResult.PKDUPLICATE;
	            }
	    }
		studentDAO.insertStudents(studentsToCreate);
		return ServiceResult.OK;
	}

}
