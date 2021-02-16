package common.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class MvcUtils {

	/**
	 * <pre>
	 * 단방향 암호화 : 복호화가 불가능. 암호화된 값(hash)을 가지고 비교연산
	 * 	- md5 sha1 sha256 sha512등의 알고리즘 지원
	 * 	- MessageDigest
	 * 양방향 암호화 : 암호화/복호화가 가능
	 * 
	 * 암호화절차
	 * 1. 암호화객체생성
	 * 2. 문자열 -> byte[] -> 암호화객체에 전달 및 암호화
	 * 3. 암호화된 byte[] -> 인코더Base64를 통한 문자열변환
	 * 
	 * </pre>
	 * 
	 * @param parameter
	 * @return
	 */
	public static String getEncryptedPassword(String password) {
		String encryptedPassword = null;
		try {
			// 1. 암호화객체생성
			MessageDigest md = MessageDigest.getInstance("SHA-512");

			// 2. 문자열 -> byte[] -> 암호화객체에 전달 및 암호화
			byte[] bytes = password.getBytes("UTF-8");
			md.update(bytes);
			byte[] encryptedBytes = md.digest();
			System.out.println(new String(encryptedBytes));
			// 3. 암호화된 byte[] -> 인코더Base64를 통한 문자열변환
			encryptedPassword = Base64.getEncoder().encodeToString(encryptedBytes);
			System.out.println(encryptedPassword);
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		
		
		return encryptedPassword;
	}

	/**
	 * 
	 * totalPage 전체페이지수     올림(totalContents / numPerPage)
	 * pageBarSize 페이지바의 페이지수 
	 * pageStart ~ pageEnd 페이지바 범위
	 * pageNo 증감변수
	 * 
	 * < 1 2 3 4 5 >  이전버튼 비활성화
	 * < 6 7 8 9 10 >
	 * < 11 12 >	    다음버튼 비활성화
	 * 
	 * 
	 * @param totalContents
	 * @param cpage
	 * @param numPerPage
	 * @param url
	 * @return
	 */
	public static String getPageBar(int totalContents, int cpage, int numPerPage, String url) {
		String pageBar = ""; //html을 만들어 리턴할 최종적인 변수
		int pageBarSize = 5; //페이지 바에 몇개 나올 것인지
		int totalPage = (int)Math.ceil((double)totalContents / numPerPage); 
		//소수점이 나올수도있기 때문에 double로 형변환했다가 다시 int로
		
		// /mvc/admin/memberList?cpage= 이런식으로 나와야함
		// /mvc/admin/memberFinder?searchType =memberId&searchKeyword=a$cpage=
		url = url + (url.indexOf("?") > -1 ? "&" : "?") +"cpage=";
		//일치하는 값 없으면 -1리턴 ,,, "?"가 없으면-1
		
		// 1 2 3 4 5 : pageStart 1 ~ pageEnd 5 
		// 6 7 8 9 10 : pageStart 6 ~ pageEnd 10 
		int pageStart = ((cpage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageStart + pageBarSize - 1;
		
		//증감변수
		int pageNo = pageStart;
		
		//이전 영역
		if(pageNo == 1) {
			
		}
		else {
			// /mvc/admin/memberList?cpage=5
			pageBar += "<a href='" + url + (pageNo - 1) + "'>&lt;</a>\n";
		}
		
		//페이지 No 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			//현재페이지인 경우, 링크비활성화
			if(pageNo == cpage) {
				pageBar += "<span class='cPage'>" + pageNo + "</span>\n";
			}
			else {
				pageBar += "<a href='" + url + pageNo + "'>" + pageNo + "</a>\n";
			}
			pageNo++;
		}
		//다음 영역
		if(pageNo > totalPage) {
			
		}
		else {
			pageBar += "<a href='" + url + pageNo + "'>&gt;</a>\n";
		}
		return pageBar;
	}

}