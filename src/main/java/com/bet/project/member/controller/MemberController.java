package com.bet.project.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.bet.project.member.model.Member;
import com.bet.project.member.service.MemberService;


// test1 22
@Controller
@RequestMapping("/member")
public class MemberController {
	
	
	@Autowired
	MemberService memberService;
	
	Member member = new Member();
	
	
	@RequestMapping("/join.do")
	public ModelAndView join(@ModelAttribute Member model,ModelAndView mav) {
		
		mav.addObject("joinResult", memberService.join(model));
		mav.setViewName("/member/login");
		return mav;
	}
	
	
	
	@RequestMapping("/login")
	public String login() {
		return "/member/login";
	}
	
	
	@RequestMapping("/login.do")
	public ModelAndView login(@ModelAttribute Member model, ModelAndView mav) {
		
		
		member = memberService.login(model);
		System.out.println("~~~~~~~~~~~~> "+ member.getCount());
		
		if(member.getCount() == 1) {
			System.out.println("濡쒓렇�씤 �꽦怨�");	
			mav.addObject("loginResult", model.getUser_name() );
			mav.setViewName("/main/main");
		}else {
			mav.addObject("loginResult", "�븘�씠�뵒 鍮꾨�踰덊샇瑜� �솗�씤�븯�꽭�슂");
			mav.setViewName("/member/login");
		}
		
		
		return mav;
	}
	

	
	@RequestMapping("/checkId.do")
	@ResponseBody
	public boolean checkId(@RequestParam String id, ModelAndView mav) {
		boolean result;
		
		if(memberService.checkId(id) == 1) {
			System.out.println("�궗�슜遺덇�!! false");
			result= false;
		}else {
			System.out.println("�궗�슜 媛��뒫!! true");
			result= true;
		}
		
		
		return result;
	}
	
	
	
	
}
