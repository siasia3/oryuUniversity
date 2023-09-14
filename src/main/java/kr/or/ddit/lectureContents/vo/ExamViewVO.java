package kr.or.ddit.lectureContents.vo;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "evCd")
public class ExamViewVO {
	@NotBlank
	private String evCd;
	@NotBlank
	private String eqCd;
	private String evCont;
}
