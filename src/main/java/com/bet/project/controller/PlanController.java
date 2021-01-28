package com.bet.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/plan")
public class PlanController {
	
	
	@RequestMapping("planing.do")
	public ModelAndView planing(ModelAndView mav) {
		
		
		mav.setViewName("/plan/planing");
		
		return mav;
	}

}
