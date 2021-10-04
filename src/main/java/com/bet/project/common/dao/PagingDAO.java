package com.bet.project.common.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bet.project.common.model.Criteria;
import com.bet.project.model.MoneySave;
import com.bet.project.model.Want;

@Repository
public class PagingDAO {
	
	@Autowired
	SqlSession sqlSession;
	

	public List<Criteria> selectPagingList(Criteria cri) {
		return sqlSession.selectList("paging.selectPagingList", cri);
	}


	public int getTotalCnt() {
		return sqlSession.selectOne("paging.getTotalCnt");
	}


}
