package taein.cinema.user.login.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import taein.cinema.user.login.dao.mapper.LoginMapper;
import taein.cinema.user.login.domain.User;

@Repository
public class LoginDaoImpl implements LoginDao{
	@Autowired private LoginMapper userMapper;
	
	public List<User> getUsers(){
		return userMapper.getUsers();
	}
	
	public int addUser(User user){
		return this.userMapper.addUser(user);
	}
}
