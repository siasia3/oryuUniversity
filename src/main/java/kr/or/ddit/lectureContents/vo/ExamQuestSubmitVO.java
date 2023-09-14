package kr.or.ddit.lectureContents.vo;

import java.util.List;

import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "esCd")
public class ExamQuestSubmitVO {
	@NotBlank
	private String esCd;
	@NotBlank
	private String eqCd;
	private String eqsAnswer;
	private Integer eqsScore;
}
