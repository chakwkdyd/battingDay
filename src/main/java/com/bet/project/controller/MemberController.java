package com.bet.project.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bet.project.model.Member;
import com.bet.project.service.MemberService;



@Controller
@RequestMapping("/member")
public class MemberController {
	
	
	@Autowired
	MemberService memberService;
	
	Member member = new Member();
	
	@RequestMapping("/login")
	public String login() {
		return "/member/login";
	}
	
	@RequestMapping("/getId.do")
	public String getId() {
		return "/member/idFind";
	}
	
	@RequestMapping("/getPw.do")
	public String getPw() {
		return "/member/pwFind";
	}
	
	@RequestMapping(value = "/join.do", method=RequestMethod.POST)
	public ModelAndView join(@ModelAttribute Member model,ModelAndView mav) {
		
		mav.addObject("joinResult", memberService.join(model));
		mav.setViewName("/member/login");
		return mav;
	}
	
	
	@RequestMapping("/login.do")
	public ModelAndView login(@ModelAttribute Member model, ModelAndView mav) {
		
		member = memberService.login(model);
		//System.out.println("~~~~~~~~~~~~> "+ member.getCount());
		
//		if(member.getCount() == 1) {
//			System.out.println("로그인 성공");	
//			mav.addObject("loginResult", model.getUser_name() );
//			mav.setViewName("/main/main");
//		}else {
//			mav.addObject("loginResult", "아이디 비밀번호를 확인하세요");
//			mav.setViewName("/member/login");
//		}
		
		
		return mav;
	}
	

	
	@RequestMapping("/checkId.do")
	@ResponseBody
	public boolean checkId(@RequestParam String id) {
		boolean result;
		
		if(memberService.checkId(id) == 0) {
			System.out.println("사용불가!! false");
			result= true;
		}else {
			result= false;
			System.out.println("사용 가능!! true");
		}
		
		
		return result;
	}
	
	
	
	
	
}
