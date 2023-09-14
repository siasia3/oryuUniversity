package kr.or.ddit.internshipAPC.vo;

import java.time.LocalDate;

import javax.validation.constraints.NotBlank;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

import kr.or.ddit.department.vo.DepartmentVO;
import kr.or.ddit.internship.vo.InternshipVO;
import kr.or.ddit.student.vo.StudentVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="iaCd")
public class InternshipAPCVO {
	@NotBlank 
	private String iaCd;
	@NotBlank 
	private String stCd;
	@NotBlank 
	private String inteCd;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate iaDate;
	private String iaStat;
	private String iaPur;
	private String iaCou;
	private String inteDelete;
	private String inteCompNm;
	
	private StudentVO studentVO;
	private DepartmentVO departmentVO;
	private InternshipVO internshipVO;
}
