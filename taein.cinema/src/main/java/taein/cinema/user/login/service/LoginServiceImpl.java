package taein.cinema.user.login.service;

import java.util.List;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import taein.cinema.user.login.dao.LoginDao;
import taein.cinema.user.login.domain.User;

@Service
public class LoginServiceImpl implements LoginService{
	@Autowired private LoginDao userDao;
	@Autowired JavaMailSender mailSender;
	
	@Transactional
	public List<User> listUsers(){
		return userDao.getUsers();
	}
	
	@Transactional
	public boolean join(User user){
		return userDao.addUser(user)>0;
	}
	
	@Transactional
	public String sendId(String userEmail){
		MimeMessage message = mailSender.createMimeMessage();

		String txt = "<h3>태인이네 영화관</h3> 아이디찾기 인증번호 : ";
		String num = "";
		for(int i=0; i<6; i++){
			int a = (int)(Math.random()*9)+1;
			num += a+"";
		}
		txt += num;
		
		try{
			message.addRecipient(RecipientType.TO, new InternetAddress(userEmail));
			message.setSubject("태인이네 영화관 아이디찾기 인증번호입니다.");
			message.setText(txt,"utf-8","html");
		}catch(Exception e){}
		mailSender.send(message);
		
		return num;
	}
	
	@Transactional
	public String sendPw(String userEmail){
		MimeMessage message = mailSender.createMimeMessage();

		String txt = "<h3>태인이네 영화관</h3> 비밀번호찾기 인증번호 : ";
		String num = "";
		for(int i=0; i<6; i++){
			int a = (int)(Math.random()*9)+1;
			num += a+"";
		}
		txt += num;
		
		try{
			message.addRecipient(RecipientType.TO, new InternetAddress(userEmail));
			message.setSubject("태인이네 영화관 비밀번호찾기 인증번호입니다.");
			message.setText(txt,"utf-8","html");
		}catch(Exception e){}
		mailSender.send(message);
		
		return num;
	}
}
