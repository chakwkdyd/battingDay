package com.bet.project.service.serviceImpl;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bet.project.dao.MemberDao;
import com.bet.project.model.Member;
import com.bet.project.service.MemberService;




@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao memberDao;
	 
	@Override
	public List<Member> list() {
 		return memberDao.list();
	}

	@Override
	public int checkId(String id) {
		return memberDao.checkId(id);
	}

	@Override
	public Member login(Member model) {
		return memberDao.login(model);
	}

	
	
	@Override
	public int join(Member model) {
		System.out.println(model.toString());
		return memberDao.join(model);
	}

	@Override
	public int checkEmail(String email) {
		return memberDao.checkEmail(email);
	}
	
	
}

