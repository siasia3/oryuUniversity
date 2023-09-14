package kr.or.ddit.enrollment.vo;

import java.time.LocalDate;
import java.util.List;

import javax.validation.constraints.NotBlank;

import kr.or.ddit.common.vo.SimpleCondition;
import kr.or.ddit.lecture.vo.LectureVO;
import kr.or.ddit.lectureContents.vo.AssignmentSubVO;
import kr.or.ddit.lectureSchedule.vo.LectureScheduleVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = { "lecCd", "stCd" })
public class EnrollmentVO {
	@NotBlank
	private String lecCd;
	@NotBlank
	private String stCd;
	private String enroApplStat;
	@NotBlank
	private LocalDate enroApplDate;
	private String graAssiScore;
	private String graAttendScore;
	private String graMidScore;
	private String graFinalScore;
	private String graFinalTotal;

	private String[] lecCds;

	private LectureVO lecture;

	private List<LectureScheduleVO> lectureScheduleList;

	private String stNm;

	private String prNm;
	
	private String subjNm;
	
	private String scheCds;

	private String scheCd;

	private String clasNm;

	private String clasCd;

	private String dtNm;

	private String assiScore;
	private String midScore;
	private String finalScore;

	private long rnum;

	private String graAvgScore;
	private String graRating;
	private String graStatus;
	
	// =========== 학생 정보 ==========
	private String totalLectCred;
	private String currentLectCred;
	private String lecLectTitle;
	private String lecLectCred;
	private String subjComType;
	private String colgeNm;
	private String enrollmentYear;
	private String semester;
	private String stStatus;
	private String subjCd;

	private String avgGrade;
	private String majorAvgGrade;
	
	private SimpleCondition simpleCondition;

}
