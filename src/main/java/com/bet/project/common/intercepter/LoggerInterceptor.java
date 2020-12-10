package com.bet.project.common.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {
	
	// Log 객체를 생성할때는 몇가지 방법이 있는데 여기서는 생성자에 현재 클래스를 입력하였다.
	 protected Log log = LogFactory.getLog(LoggerInterceptor.class);

	
	// preHandler()과 postHandle() 메서드가 전처리기와 후처리기

	
	// preHandler()은 컨트롤러가 호출되기 전에 실행되고
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (log.isDebugEnabled()) {
			log.debug("======================================          START         ======================================");
			log.debug(" Request URI \t:  " + request.getRequestURI());
		}
		return super.preHandle(request, response, handler);
	}
	
	// postHandle()은 컨트롤러가 실행되고 난 후에 호출된다
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		if (log.isDebugEnabled()) {
			log.debug("======================================           END          ======================================\n");
		}
	}
	
}


