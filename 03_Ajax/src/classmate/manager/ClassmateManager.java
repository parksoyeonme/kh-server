package classmate.manager;

import java.util.ArrayList;
import java.util.List;

public class ClassmateManager {
	private static ClassmateManager instance;
	
	private List<String> classmates = new ArrayList<String>() {
		{
			this.add("강송이");
			this.add("강유정");
			this.add("강준혁");
			this.add("김자경");
			this.add("김지수");
			this.add("김지헌");
			this.add("김지훈");
			this.add("김진하");
			this.add("박소연");
			this.add("사영리");
			this.add("서강석");
			this.add("유리");
			this.add("유영국");
			this.add("이상원");
			this.add("이수연");
			this.add("이원빈");
			this.add("이제환");
			this.add("이효정");
			this.add("정다미");
			this.add("정다빈");
			this.add("정다솜");
			this.add("정인식");
			this.add("주진홍");
			this.add("한광희");
			this.add("황현준");
		}
	};
	
	private ClassmateManager() {
		
	}
	//getter
	public List<String> getClassmates(){
		return this.classmates;
	}
	
	public static ClassmateManager getInstance() {
		if(instance == null)
			instance = new ClassmateManager();
		return instance;
	}
}