package common.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/* 서버에서 운영중인 세션객체의 수를 관리하는 리스너
 * 
 * 
 * */
public class SessionCounterListener implements HttpSessionListener{

	private static int activeSessions;
	
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		activeSessions++;
//		System.out.println("[[ 세션생성! - 현재 세션수 : " + activeSessions+ "]]");
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		if(activeSessions > 0) //가끔 세션 아웃될때 음수를 리턴해서 그경우를 방지하고자
			activeSessions--;
//		System.out.println("[[ 세션반환! - 현재 세션수 : " + activeSessions + "]]");
		
		
	}

}
