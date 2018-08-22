package taein.cinema.user.login.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import taein.cinema.user.login.domain.Result;
import taein.cinema.user.login.domain.User;
import taein.cinema.user.login.service.LoginService;

@Controller
@RequestMapping("/")
public class LoginController {
	@Autowired private LoginService userService;
	
	@RequestMapping
	public String now(){
		return "user/login/logIn";
	}
	
	@RequestMapping("/logIn")
	public String logIn(){
		return "user/login/logIn";
	}
	
	@RequestMapping(value="/logIn", method=RequestMethod.POST)
	public String logIn(User user, String remember, Model model, HttpServletResponse response, HttpSession session){
		String userId = user.getUserId();
		String userPw = user.getUserPw();
		List<User> users = userService.listUsers();
		
		for(User usertmp:users){
			if(usertmp.getUserId().equals(userId) && usertmp.getUserPw().equals(userPw)){
				session.setAttribute("userId", userId);
				if(remember != null && remember.equals("Y")){
					Cookie cookie = new Cookie("saveUserId", userId);
					cookie.setMaxAge(60*60*24*7);
					response.addCookie(cookie);
				}
			}else{
				model.addAttribute("msg", "로그인 오류 : 아이디와 비밀번호를 확인하여 주세요.");
			}
		}
		return "user/login/logIn";
	}
	
	@RequestMapping("/logOut")
	public String logOut(HttpSession session){
		session.invalidate();
		return "user/login/logIn";
	}
	
	@RequestMapping("/userAdd")
	public String useradd(){
		return "user/login/userAdd";
	}
	
	@RequestMapping(value="/userAdd", method=RequestMethod.POST)
	@ResponseBody
	public Result useradd(User user, Model model){			
		String mailling = user.getUserMailing();
		if(mailling == null) user.setUserMailing("N");
		String sms = user.getUserSms();
		if(sms == null) user.setUserSms("N");
		
		List<User> users = userService.listUsers();
		boolean is = false;
		for(User usertmp : users){
			if(usertmp.getUserId().equals(user.getUserId())) is = true;
		}
		
		Result result = new Result();
		result.setIs(is);
		
		if(!is){
			userService.join(user);
		}
		return result;
	}
	
	@RequestMapping(value="/overLap", method=RequestMethod.POST)
	@ResponseBody
	public Result overlap(String userId){
		Result result = new Result();
		
		List<User> users = userService.listUsers();
		boolean is = false;
		for(User usertmp : users){
			if(usertmp.getUserId().equals(userId)){	
				is = true;
				result.setOverId("아이디가 중복됩니다. 추천 아이디: "+userId+(int)(Math.random()*1000));
			}
		}
		
		if(userId.equals("") || userId == null){
			is = true;
			result.setOverId("아이디를 입력하세요.");
		}
		
		result.setIs(is);

		return result;
	}
	
	@RequestMapping(value="/userAddResult", method=RequestMethod.GET)
	public String userAddReault(){
		return "user/login/userAddResult";
	}
	
	@RequestMapping(value="/inquiryId", method=RequestMethod.GET)
	public String inquiryId(){
		return "user/login/inquiryId";
	}
	
	@RequestMapping(value="/inquiryId", method=RequestMethod.POST)
	public String inquiryIdMail(User user, Model model, HttpSession session){
		String userName = user.getUserName();
		String userEmail = user.getUserEmail();
		
		List<User> users = userService.listUsers();
		boolean is = false;
		for(User usertmp : users){
			if(usertmp.getUserName().equals(userName) && usertmp.getUserEmail().equals(userEmail)){ 
				is = true;
			}
		}
		
		if(is) {
			String num = userService.sendId(user.getUserEmail());
			session.setAttribute("num", num);
			session.setAttribute("inqUserName", userName);
			session.setAttribute("inqUserEmail", userEmail);
			model.addAttribute("inqNum", "ture");
		}else{
			model.addAttribute("err", "일치하는 아이디가 없습니다. 이름과 이메일을 다시 한 번 확인하세요.");
		}
		return "user/login/inquiryId";
	}
	
	@RequestMapping("/inquiryIdNum")
	public String inquiryIdNum(){
		return "user/login/inquiryIdNum";
	}
	
	@RequestMapping("/inquiryIdOk")
	@ResponseBody
	public Result inquiryId(int confiNum, HttpSession session, Model model){
		Result result = new Result();
		boolean is = false;
		String num = (String)session.getAttribute("num");
		String userName = (String)session.getAttribute("inqUserName");
		String userEmail = (String)session.getAttribute("inqUserEmail");
		String conNum = confiNum+"";
			
		if(num.equals(conNum)) is=true;

		if(is) {				
			List<User> users = userService.listUsers();
			for(User usertmp : users){
				if(usertmp.getUserName().equals(userName)
						&& usertmp.getUserEmail().equals(userEmail)){ 
						result.setUserId(usertmp.getUserId());
						result.setIs(is);
				}
			}
		}else{
			result.setErrMsg("인증번호가 일치하지 않습니다.");
		}
		
		System.out.println(is);
		System.out.println(result.getUserId());
		System.out.println(result.getErrMsg());
		
		return result;
	}

	@RequestMapping(value="/inquiryPw", method=RequestMethod.GET)
	public String inquiryPw(){
		return "user/login/inquiryPw";
	}
	
	@RequestMapping(value="/inquiryPw", method=RequestMethod.POST)
	public String inquiryPwMail(User user, Model model, HttpSession session){
		String userId = user.getUserId();
		String userName = user.getUserName();
		String userEmail = user.getUserEmail();
		
		List<User> users = userService.listUsers();
		boolean is = false;
		for(User usertmp : users){
			if(usertmp.getUserId().equals(userId) && 
				usertmp.getUserName().equals(userName) && 
				usertmp.getUserEmail().equals(userEmail)){ 
				is = true;
			}
		}
		
		if(is) {
			String num = userService.sendPw(user.getUserEmail());
			session.setAttribute("num", num);
			session.setAttribute("inqUserId", userId);
			session.setAttribute("inqUserName", userName);
			session.setAttribute("inqUserEmail", userEmail);
			model.addAttribute("inqNum", "ture");
		}else{
			model.addAttribute("err", "일치하지 않습니다. 아이디와 이름과 이메일을 다시 한 번 확인하세요.");
		}
		
		return "user/login/inquiryPw";
	}
	
	@RequestMapping("/inquiryPwNum")
	public String inquiryPwNum(Model model, HttpSession session){		
		return "user/login/inquiryPwNum";
	}
	
	@RequestMapping("/inquiryPwOk")
	@ResponseBody
	public Result inquiryPw(int confiNum, Model model, HttpSession session){	
		Result result = new Result();
		boolean is = false;
			
		String num = (String)session.getAttribute("num");	
		String userId = (String)session.getAttribute("inqUserId");
		String userName = (String)session.getAttribute("inqUserName");
		String userEmail = (String)session.getAttribute("inqUserEmail");	
		String conNum = confiNum+"";
		
		if(num.equals(conNum)) is=true;

		if(is) {
			List<User> users = userService.listUsers();
			for(User usertmp : users){
				if(usertmp.getUserId().equals(userId)
					&& usertmp.getUserName().equals(userName)
					&& usertmp.getUserEmail().equals(userEmail)) 
					result.setUserPw(usertmp.getUserPw());
					result.setIs(is);
			}
		}else{
			result.setErrMsg("인증번호가 일치하지 않습니다.");
		}
		
		return result;
	}	
}