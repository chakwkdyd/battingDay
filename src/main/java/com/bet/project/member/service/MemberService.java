package com.bet.project.member.service;

import java.util.List;
import com.bet.project.member.model.Member;



public interface MemberService {
	
	public List<Member> list();
	
	public int join(Member model);
	
	public int checkId(String id);
	
	public Member login(Member model);
}

