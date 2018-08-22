package taein.cinema.user.login.service;

import java.util.List;

import taein.cinema.user.login.domain.User;

public interface LoginService {
	List<User> listUsers();         //사용자 목록 조회
	boolean join(User user);  //사용자 등록
	
	String sendId(String userEmail);   // 메일보내기(아이디 찾기용)
	String sendPw(String userEmail);   // 메일보내기(비밀번호 찾기용)
}
