package taein.cinema.user.login.dao.mapper;

import java.util.List;

import taein.cinema.user.login.domain.User;

public interface LoginMapper {
	List<User> getUsers();        //사용자 정보 목록
	int addUser(User user);		 //사용자 정보 추가
	
	
}
