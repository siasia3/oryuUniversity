package kr.or.ddit.lecture.vo;

import java.time.LocalDate;

import javax.validation.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.atch.vo.AtchFileVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "lnNum")
public class NoticeVO {
	
	private long rnum;
	
	@NotBlank
	private String lnNum;
	@NotBlank
	private String lecCd;
	private Integer atchFileId;
	private String lnTitle;
	private String lnCont;
	private LocalDate lnPostDate;
	
	private MultipartFile[] noticeFiles;
	
	private AtchFileVO fileGroup;
	
	private String lecLectTitle;
	
	private LectureVO gradeRate;
	
	private String prNm;
	private String prPh;
	private String prEmail;
}
