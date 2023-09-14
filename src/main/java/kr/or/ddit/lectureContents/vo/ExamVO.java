package kr.or.ddit.lectureContents.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.validate.DeleteGroup;
import kr.or.ddit.common.validate.InsertGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@EqualsAndHashCode(of = "examCd")
public class ExamVO {
	@NotBlank(groups = {UpdateGroup.class,DeleteGroup.class})
	private String examCd;
	@NotBlank(groups=InsertGroup.class)
	private String lecCd;
	private String examNm;
	private String examCont;
	private String examType;
	private Integer examScore;
	private String examScoreReveal;
	private Integer examTakeTime;
	private String examState;
	private Integer eqNum;
	private List<ExamQuestionVO> examQueList;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime examEndTime;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime examStaTime;
	
	public boolean getTestAvailable() {
		LocalDateTime now = LocalDateTime.now();
		if(examStaTime == null || examEndTime == null) {
			return false;
		}
		return now.isAfter(this.examStaTime) && now.isBefore(this.examEndTime) && !examState.equals("비활성"); 
	}
	
	public String getEndTime() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH시 mm분", Locale.KOREA);
		if(examEndTime == null) {
			return "";
		}
		return examEndTime.format(formatter);
	}
	public String getStartTime() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH시 mm분", Locale.KOREA);
		if(examStaTime == null) {
			return "";
		}
		return examStaTime.format(formatter);
	}
	
}
