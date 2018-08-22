package taein.cinema.user.login.domain;

public class Result {
	private boolean is;
	private String overId;
	private String num;
	private String userId;
	private String userPw;
	private String errMsg;
	
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserId() {
		return userId;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public boolean isIs() {
		return is;
	}
	public String getOverId() {
		return overId;
	}
	public void setIs(boolean is) {
		this.is = is;
	}
	public void setOverId(String overId) {
		this.overId = overId;
	}
}
