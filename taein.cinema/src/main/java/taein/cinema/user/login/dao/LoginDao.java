package taein.cinema.user.login.dao;

import java.util.List;

import taein.cinema.user.login.domain.User;

public interface LoginDao {
	List<User> getUsers();        //사용자 정보 목록
	int addUser(User user); //사용자 정보 추가
}
