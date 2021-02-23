package member.manager;

import java.util.ArrayList;
import java.util.List;

import member.model.vo.Member;

/*
 * singleton객체
 * 1. 생성자를 private를 지정해서 클래스밖에서 객체 생성 방지
 * 2. getInstance static메소드를 통해서 특정조건일때만 객체를 생성 > 아니먄 해당메소드를 재사용하게댐
 * */
public class MemberManager {
	//단하나의 객체를 관리하기 위한 static 필드
	private static MemberManager instance;
	
	private List<Member> list;
	
	//이렇게 생성하면 밖에서 new로 객체생성불가
	private MemberManager() {
		list = new ArrayList<>();
		list.add(new Member("박보검", "01012341234", "parkBogum.jpg"));
		list.add(new Member("쥴리아 로버츠", "01033334444", "juliaRoberts.jpg"));
		list.add(new Member("맷 데이먼", "01056785678", "mattDamon.jpg"));
	}
	
	public List<Member> getList(){
		return this.list;
	}
	/*
	 * 객체를 생성하거나, 생성된 객체를 리턴
	 * */
	public static MemberManager getInstance() {
		if(instance == null)
			instance = new MemberManager(); 
		return instance;
	}
		

}
