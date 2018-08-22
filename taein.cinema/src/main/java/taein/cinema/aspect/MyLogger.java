package taein.cinema.aspect;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class MyLogger {
	private Logger logger;
	
	public MyLogger(){
		logger = LogManager.getLogger(MyLogger.class);
	}
	
	@AfterThrowing(
			pointcut="@annotation(org.springframework.transaction.annotation.Transactional)"
			, throwing="e")
	public void advice2(JoinPoint jp, Throwable e){
		logger.error(jp.toShortString()+"에러:\n"+e);
	}
}

