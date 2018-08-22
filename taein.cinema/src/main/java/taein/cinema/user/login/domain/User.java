package taein.cinema.user.login.domain;

import java.sql.Date;

public class User {
	private int userNum;  //회원 번호
	private String userId;   //회원 아이디
	private String userPw;   //회원 비밀번호
	private String userName; //회원 이름
	private String userGen;  //회원 성별
	private Date userDate; //회원 생년월일
	private String userPTNum; //회원 핸드폰 통신사 번호
	private int userPFrontNum; //회원 핸드폰 앞번호
	private int userPBackNum;  //회원 핸드폰 뒷번호
	private String userEmail; //회원 이메일
	private int userPoint; //회원 포인트
	private String userMailing; //메일 수신여부
	private String userSms; //sms수신여부
	
	public User(){}
	
	public User(int userNum, String userId, String userPw, String userName, String userGen,
			Date userDate, String userPTNum, int userPFrontNum, int userPBackNum, String userEmail, int userPoint,
			String userMailing, String userSms){
		this.userNum = userNum;  
		this.userId = userId;   
		this.userPw = userPw;   
		this.userName = userName; 
		this.userGen = userGen; 
		this.userDate = userDate; 
		this.userPTNum = userPTNum;
		this.userPFrontNum = userPFrontNum; 
		this.userPBackNum = userPBackNum;
		this.userEmail = userEmail; 
		this.userPoint = userPoint;
		this.userMailing = userMailing;
		this.userSms = userSms;
	}
	
	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserGen() {
		return userGen;
	}

	public void setUserGen(String userGen) {
		this.userGen = userGen;
	}

	public Date getUserDate() {
		return userDate;
	}

	public void setUserDate(Date userDate) {
		this.userDate = userDate;
	}

	public String getUserPTNum() {
		return userPTNum;
	}

	public void setUserPTNum(String userPTNum) {
		this.userPTNum = userPTNum;
	}

	public int getUserPFrontNum() {
		return userPFrontNum;
	}

	public void setUserPFrontNum(int userPFrontNum) {
		this.userPFrontNum = userPFrontNum;
	}

	public int getUserPBackNum() {
		return userPBackNum;
	}

	public void setUserPBackNum(int userPBackNum) {
		this.userPBackNum = userPBackNum;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public int getUserPoint() {
		return userPoint;
	}

	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}
	
	public String getUserMailing() {
		return userMailing;
	}

	public String getUserSms() {
		return userSms;
	}

	public void setUserMailing(String userMailing) {
		this.userMailing = userMailing;
	}

	public void setUserSms(String userSms) {
		this.userSms = userSms;
	}

	@Override
	public String toString(){
		return String.format("%d %s %s %s %s %d %s %d %d %s %d", 
				userNum, userId, userPw, userName, userGen, userDate, userPTNum, 
				userPFrontNum, userPBackNum, userEmail, userPoint);
	}
}
