package com.bet.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bet.project.model.Member;
import com.bet.project.model.Miracle;


@Repository
public class MiracleDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	
	 
	public List<Miracle> listMiracle() {
		return sqlSession.selectList("miracleMapper.listMiracle");
	}

	public void insertMiracle(Miracle model) {
		// TODO Auto-generated method stub
		
	}

	public void updateMiracle(Miracle model) {
		// TODO Auto-generated method stub
		
	}

	public String fileInfo(int Miracle_id) {
		// TODO Auto-generated method stub
		return null;
	}

	public void deleteMiracle(int Miracle_id) {
		// TODO Auto-generated method stub
		
	}
	 
}

