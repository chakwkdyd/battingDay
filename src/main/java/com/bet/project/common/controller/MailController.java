package com.bet.project.common.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bet.project.service.MemberService;

@Controller
@RequestMapping("/email")
public class MailController {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	MemberService memberService;

		// mailSending 코드
		@RequestMapping(value = "/mailSending.do")
		public String mailSending(HttpServletRequest request) {
			

			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom("pdb3933@gmail.com"); 		// 보내는사람 생략하면 정상작동을 안함
				messageHelper.setTo("chakwkdyd456@naver.com"); 		// 받는사람 이메일
				messageHelper.setSubject("======임시 비밀번호 ======"); 	// 메일제목은 생략이 가능하다
				messageHelper.setText("1234"); 						// 메일 내용

				mailSender.send(message);
			} catch (Exception e) {
				System.out.println(e);
			}

			return "member/idFind";
		}
		
		
		
		@RequestMapping("/checkEmail.do")
		@ResponseBody
		public boolean checkEmail(@RequestParam String email) {
			boolean result;
			
			// -- 이메일 있으면 --
			if(memberService.checkEmail(email) != 0) {
				result= true;
			}else {
				result= false;
			}
			
			return result;
		}
		
		
		
}
