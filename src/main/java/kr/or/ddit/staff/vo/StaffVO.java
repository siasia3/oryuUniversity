package kr.or.ddit.staff.vo;

import java.io.Serializable;
import java.util.UUID;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.validate.groups.InsertGroup;
import kr.or.ddit.validate.groups.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "tsCd")
public class StaffVO implements Serializable {
	private long rnum;
	private String tsAddr1;
	private String tsAddr2;
	@NotBlank(groups = InsertGroup.class)
	private String tsReg1;
	@NotBlank(groups = InsertGroup.class)
	private String tsReg2;
	@NotBlank(groups = InsertGroup.class)
	private String tsCd;
	@NotBlank(groups = InsertGroup.class)
	private String tsNm;
	@NotBlank(groups = InsertGroup.class)
	private String tsDep;
	@NotBlank(groups = InsertGroup.class)
	private String tsPh;
	private String tsEmail;
	@NotBlank(groups = {InsertGroup.class, UpdateGroup.class})
	@Size(min = 4, max = 16)
	private String tsPass;
	private String tsFic;
	private String tsRole;
	private String tsStatus;

	private MultipartFile tsImage;
	public void setTsImage(MultipartFile tsImage) {
		if(!tsImage.isEmpty()) {
			this.tsImage = tsImage;
			this.tsFic = UUID.randomUUID().toString();
		}
		
	}
	
}
