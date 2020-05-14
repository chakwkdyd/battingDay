package com.bet.project.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.bet.project.member.model.Member;


@Repository
public class MemberDao {
	
	@Autowired
	SqlSession sqlSession;
	
	 public List<Member> list(){
		 return sqlSession.selectList("member.list");
	 }
	 
	// 회원가입
	 public int join(Member model) {
		 return sqlSession.insert("member.join", model);
	 }
	 
	 public int checkId(String id) {
		 return sqlSession.selectOne("member.checkId", id);
	 }
	 
	 // 로그인
	 public Member login(Member model) {
		 return sqlSession.selectOne("member.login", model);
	 }
	 
	 
	 
}

