package taein.cinema.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response,
			Object handler) throws Exception{
		if(!request.getRequestURI().equals("/logIn")){
			String userId = (String)request.getSession().getAttribute("userId");
			if(userId == null) response.sendRedirect("/logIn");
		}
		return true;
	}
}
