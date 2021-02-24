package ajax.json.simple;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import member.model.vo.Member;

/**
 * json-simple 라이러리를 WebApp Library(/WEB-INF/lib)에 추가할것.
 *
 */
public class JsonSimpleTest {

	JSONObject sinsa = new JSONObject();
	Member m = new Member("신사임당", "01012341234", "sinsa.jpg");
	
	{
		sinsa.put("name", m.getName());
		sinsa.put("phone", m.getPhone());
		sinsa.put("profile", m.getProfile());
	}
	
	public static void main(String[] args) {
		JsonSimpleTest j = new JsonSimpleTest();
		j.test1();
		j.test2();
	}

	/**
	 * JSONArray테스트
	 */
	private void test2() {
		JSONArray arr = new JSONArray();
		arr.add(123);
		arr.add(45.67);
		arr.add("안녕");
		arr.add(true);
		arr.add(sinsa);
		System.out.println(arr);
	}

	/**
	 * JSONObject테스트
	 */
	private void test1() {
		
		
		JSONObject obj = new JSONObject();
		obj.put("abcde", 1234);
		obj.put("name", "홍길동");
		obj.put("member", sinsa);//객체전달시에는 JSONObject타입이 와야 한다.
		obj.put("married", true);
		obj.put("hobby", null);
		System.out.println(obj);
		// {"abcde":1234,"name":"홍길동","member":{"phone":"01012341234","profile":"sinsa.jpg","name":"신사임당"},"married":true,"hobby":null}
	
		
	}

}