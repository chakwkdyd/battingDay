package com.bet.project.service;

import java.util.List;

import com.bet.project.model.Member;



public interface MemberService {
	
	public List<Member> list();
	
	public int join(Member model);
	
	public int checkId(String id);
	
	public Member login(Member model);

	public int checkEmail(String email);
}

