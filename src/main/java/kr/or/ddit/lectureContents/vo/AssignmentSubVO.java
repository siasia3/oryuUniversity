package kr.or.ddit.lectureContents.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.atch.vo.AtchFileVO;
import kr.or.ddit.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor	
@RequiredArgsConstructor
@EqualsAndHashCode(of = "assuCd")
public class AssignmentSubVO {
	@NotBlank(groups=UpdateGroup.class)
	private String assuCd;
	@NotBlank
	@NonNull
	private String lecCd;
	@NotBlank
	@NonNull
	private String assiCd;
	@NotBlank
	@NonNull
	private String stCd;
	private Integer atchFileId;
	@DateTimeFormat(iso = ISO.DATE_TIME)
	private LocalDateTime submDate;
	private String submStat;
	private Integer assuScore;
	private String assuText;
	
	private MultipartFile[] auFiles;
	
	private AtchFileVO fileGroup;
	
	private List<MultipartFile> uploadFiles;  // 업로드된 첨부파일 목록
	
	private String stNm;
	
	private String assiNm;
	private String assiScore;

	private int enrollmentCount;
	private List<Integer> assignmentCounts;
	private List<String> assigNmList;
	private List<AssignmentSubVO> assiCdList;
	
	public String getSubmitTime() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH시 mm분", Locale.KOREA);
		if(submDate == null) {
			return "";
		}
		return submDate.format(formatter);
	}

}
