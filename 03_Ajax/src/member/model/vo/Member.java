package member.model.vo;

public class Member {
	
	private String name;
	private String phone;
	private String profile;			//이미지파일 경로
	
	public Member() {
		super();
	}

	public Member(String name, String phone, String profile) {
		super();
		this.name = name;
		this.phone = phone;
		this.profile = profile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	@Override
	public String toString() {
		return name + "," + phone + "," + profile;
	}
	
	
	
	
	
}