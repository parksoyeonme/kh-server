package member.model.vo;

import java.io.Serializable;
import java.sql.Date;

/**
 * 
 * member테이블의 한행에 상응하는 vo클래스
 * (dto, entity, bean)
 *
 */
public class Member implements Serializable {

	private String memberId;	//필수
	private String password;	//필수
	private String memberName;	//필수
	private String memberRole;	//필수
	private String gender;
	private Date birthDay;
	private String email;
	private String phone;		//필수
	private String address;
	private String hobby;
	private Date enrollDate;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Member(String memberId, String password, String memberName, String memberRole, String gender, Date birthDay,
			String email, String phone, String address, String hobby, Date enrollDate) {
		super();
		this.memberId = memberId;
		this.password = password;
		this.memberName = memberName;
		this.memberRole = memberRole;
		this.gender = gender;
		this.birthDay = birthDay;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.hobby = hobby;
		this.enrollDate = enrollDate;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberRole() {
		return memberRole;
	}
	public void setMemberRole(String memberRole) {
		this.memberRole = memberRole;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Date getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public Date getEnrollDate() {
		return enrollDate;
	}
	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}
	
	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", password=" + password + ", memberName=" + memberName
				+ ", memberRole=" + memberRole + ", gender=" + gender + ", birthDay=" + birthDay + ", email=" + email
				+ ", phone=" + phone + ", address=" + address + ", hobby=" + hobby + ", enrollDate=" + enrollDate + "]";
	}
	
	
	
	
}