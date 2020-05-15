package com.bet.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bet.project.model.Member;
import com.bet.project.service.MemberService;


@Controller
@RequestMapping("/board")
public class BetBoardController {
	
	
	@RequestMapping("/insertBoard")
	public String login() {
		return "/board/boardInsert";
	}
	
	/*
	@Autowired
	MemberService memberService;
	
	Member member = new Member();
	${path}/board/insertBoard
	
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
			System.out.println("로그인 성공");	
			mav.addObject("loginResult", model.getUser_name() );
			mav.setViewName("/main/main");
		}else {
			mav.addObject("loginResult", "아이디 비밀번호를 확인하세요");
			mav.setViewName("/member/login");
		}
		
		
		return mav;
	}
	

	
	@RequestMapping("/checkId.do")
	@ResponseBody
	public boolean checkId(@RequestParam String id, ModelAndView mav) {
		boolean result;
		
		if(memberService.checkId(id) == 1) {
			System.out.println("사용불가!! false");
			result= false;
		}else {
			System.out.println("사용 가능!! true");
			result= true;
		}
		
		
		return result;
	}
	*/
	
	
	
}
