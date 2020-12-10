package com.bet.project.common.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bet.project.common.intercepter.LoggerInterceptor;

@Controller
public class SampleController {
    
protected Log log = LogFactory.getLog(this.getClass());
    
   @RequestMapping(value="/sample/openSampleList.do")
   public ModelAndView interceptorTest() throws Exception{
       System.out.println("##########");
       ModelAndView mv = new ModelAndView("");
       log.debug("인터셉터 테스트입니다!");
        
       return mv;
   }
    
}


